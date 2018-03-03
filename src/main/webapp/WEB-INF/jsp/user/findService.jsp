<% String title="Find Service"; %>
<%@include  file="includes/header.jsp" %>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@page import="com.gp.user.Service"%>
<%@page import="com.gp.user.HospitalDao"%>
<%@page import="com.gp.user.Hospital"%>
<%@page import="com.gp.user.Location"%>
<%@page import="com.gp.user.Center"%>
<%@page import="com.gp.user.CenterDao"%>
<%@page import="com.gp.user.ServiceDao"%>
<%@page import="com.gp.user.Location"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%

List<Float> 	lats  = new ArrayList<Float>();
List<Float> 	langs = new ArrayList<Float>();
List<String> 	names = new ArrayList<String>();
List<String> 	types = new ArrayList<String>();
List<String> 	urls  = new ArrayList<String>();
List<Location> 	locations = new ArrayList<Location>();

List<Center> centers = CenterDao.getAllCenters();
for(Center center : centers){
	Location location = new Location(center.getLat(), center.getLang(), center.getCenterName(), "center", center.getWebsite());
}

List<Hospital> hospitals = HospitalDao.getAllHospitals();
for(Hospital hospital : hospitals){
	Location location = new Location(hospital.getLat(), hospital.getLang(), hospital.getHospitalName(), "hospital", hospital.getWebsite());
}

List<Service> servicesOfHospital = ServiceDao.getAllServicesOfHospitals();
for(Service service : servicesOfHospital){
	Location location = new Location(service.getLat(), service.getLang(), service.getServiceName(), service.getServiceName(), service.getWebsite());
}

List<Service> servicesOfCenters = ServiceDao.getAllServicesOfCenters();
for(Service service : servicesOfCenters){
	Location location = new Location(service.getLat(), service.getLang(), service.getServiceName(), service.getServiceName(), service.getWebsite());
}

%>
<div class="container find-servcie-container">
        
            <h3>Find A Service : </h3>
            <div class="row">
                
                <div class="col-sm-3 choose-service">
                    
                    <div class="panel panel-default service-options">
                      <div class="panel-heading">
                        <h3 class="panel-title text-center">Services</h3>
                      </div>
                      <div class="panel-body">
                          <input type="radio" name="service" value="all" checked> All<br>
                          <input type="radio" name="service" value="clinic"> Clinics<br>
                          <input type="radio" name="service" value="hospital"> Hospitals<br>
                          <input type="radio" name="service" value="center"> Centers<br>
                          <input type="radio" name="service" value="pharmacy"> Pharmacies<br>
                      </div>
                    </div>
                    <button class="btn btn-primary find-me" id="findme">locate me</button>
                    
                </div>
                
                <div class="col-sm-8">
                
                    <input id="origin-input" class="controls" type="text" placeholder="Enter an origin location">

                    <input id="destination-input" class="controls" type="text" placeholder="Enter a destination location">

                    <div id="mode-selector" class="controls">
                      <input type="radio" name="type" id="changemode-walking" checked="checked">
                      <label for="changemode-walking">Walking</label>

                      <input type="radio" name="type" id="changemode-transit">
                      <label for="changemode-transit">Transit</label>

                      <input type="radio" name="type" id="changemode-driving">
                      <label for="changemode-driving">Driving</label>
                    </div>

                    <div id="map"></div>
                    
                </div>
                
                </div>
            
                <div id="infowindow-content">
                  <img src="" width="16" height="16" id="place-icon">
                  <span id="place-name"  class="title"></span><br>
                  <span id="place-address"></span>
                </div>
                <div class="row">
                    
                <div class="services-information-panels">   
                
                <div class="col-sm-6 services-information">
                    
                    <div class="panel panel-default ">
                      <div class="panel-heading">
                        <h3 class="panel-title text-center">Service Location Summary</h3>
                      </div>
                      <div class="panel-body">
                          
                      </div>
                    </div>
                </div>
                
                <div class="col-sm-6 services-information">
                    
                    <div class="panel panel-default ">
                      <div class="panel-heading">
                        <h3 class="panel-title text-center">Services Information</h3>
                      </div>
                      <div class="panel-body">
                          
                      </div>
                    </div>
                </div>
                </div> 
            
            </div>
        
        </div>

<%@include  file="includes/footer.jsp" %>
<script>

var map;
var chosenLocations = "all";
var Center = Center = {lat:30.030759, lng : 31.112288};
var colors = [];
colors["hospital"]  = "ff0";
colors["clinic"]    = "00f";
colors["center"]    = "0ff";
$("input[type='radio'][name='service']").change(function(){
    chosenLocations = $(this).val();
    initMapWithMarkers(chosenLocations);
    });
var locations = [
                    [30.030759 , 31.229189 , "El-kasr El-3ene" , "f00" , "hospital" , ""],
                    [30.048872 , 31.242359 , "El-Helal Hospital" , "00f" , "clinic" , ""],
                    [30.030216 , 31.231368 , "Elkasr El-faransawy" , "f00" , "hospital" , ""],
                    [30.181248 , 31.106173 , "Mubarak Center" , "00f" , "clinic" , "https://www.google.com.eg"],
                             ];

var finalLocations=[[]];
var finalLocationIndex = 0;
if(chosenLocations=="all"){
    finalLocations = locations;
}else{
    for(i=0; i<locations.length; i++){
        if(locations[i][4]==chosenLocations){
            finalLocations[finalLocationIndex][0] = locations[i][0];
            finalLocations[finalLocationIndex][1] = locations[i][1];
            finalLocations[finalLocationIndex][2] = locations[i][2];
            finalLocations[finalLocationIndex][3] = locations[i][3];
            finalLocations[finalLocationIndex][4] = locations[i][4];
            finalLocations[finalLocationIndex][5] = locations[i][5];
            finalLocationIndex++;
        }
    }
}
function initMapWithMarkers() {
        
        map = new google.maps.Map(document.getElementById('map'), {
                  zoom: 6,
                  center: Center
                });
            
        for (i = 0; i < locations.length; i++) {  
                if(locations[i][4]==chosenLocations){

                var pinIcon = new google.maps.MarkerImage(
                "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|".concat(locations[i][3]), 
                null, /* size is determined at runtime */
                null, /* origin is 0,0 */
                null, /* anchor is bottom center of the scaled image */
                new google.maps.Size(20, 34)
                );  
              marker = new google.maps.Marker({
                position: new google.maps.LatLng(locations[i][0], locations[i][1]),
                map: map,
                title: locations[i][2],
                icon: pinIcon,
                url: locations[i][5]
              });                      
            google.maps.event.addListener(marker, 'click', function() {
                window.open(this.url , '_blank');
            });
              google.maps.event.addListener(marker, 'click', (function(marker, i) {
                return function() {
                  infowindow.setContent(locations[i][0]);
                  infowindow.open(map, marker);
                }
              })(marker, i));
                  }
            }
                new AutocompleteDirectionsHandler(map);

        }

function initMap(chosenLocation) {
        map = new google.maps.Map(document.getElementById('map'), {
          center: {lat: 30.0169184, lng: 31.259684},
          zoom: 6
});  
    
       for (i = 0; i < finalLocations.length; i++) {  

                var pinIcon = new google.maps.MarkerImage(
                "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|".concat(finalLocations[i][3]), 
                null, /* size is determined at runtime */
                null, /* origin is 0,0 */
                null, /* anchor is bottom center of the scaled image */
                new google.maps.Size(20, 34)
                );  
              marker = new google.maps.Marker({
                position: new google.maps.LatLng(finalLocations[i][0], finalLocations[i][1]),
                map: map,
                title: finalLocations[i][2],
                icon: pinIcon,
                url: finalLocations[i][5]
              });                      
            google.maps.event.addListener(marker, 'click', function() {
                window.open(this.url , '_blank');
            });
              google.maps.event.addListener(marker, 'click', (function(marker, i) {
                return function() {
                  infowindow.setContent(finalLocations[i][0]);
                  infowindow.open(map, marker);
                }
              })(marker, i));
            }
       function handleLocationError(browserHasGeolocation, infoWindow, pos) {
        infoWindow.setPosition(pos);
        infoWindow.setContent(browserHasGeolocation ?
                              'Error: The Geolocation service failed.' :
                              'Error: Your browser doesn\'t support geolocation.');
        infoWindow.open(map);
      }
    new AutocompleteDirectionsHandler(map);
      }

function AutocompleteDirectionsHandler(map) {
        this.map = map;
        this.originPlaceId = null;
        this.destinationPlaceId = null;
        this.travelMode = 'WALKING';
        var originInput = document.getElementById('origin-input');
        var destinationInput = document.getElementById('destination-input');
        var modeSelector = document.getElementById('mode-selector');
        this.directionsService = new google.maps.DirectionsService;
        this.directionsDisplay = new google.maps.DirectionsRenderer;
        this.directionsDisplay.setMap(map);

        var originAutocomplete = new google.maps.places.Autocomplete(
            originInput, {placeIdOnly: true});
        var destinationAutocomplete = new google.maps.places.Autocomplete(
            destinationInput, {placeIdOnly: true});

        this.setupClickListener('changemode-walking', 'WALKING');
        this.setupClickListener('changemode-transit', 'TRANSIT');
        this.setupClickListener('changemode-driving', 'DRIVING');

        this.setupPlaceChangedListener(originAutocomplete, 'ORIG');
        this.setupPlaceChangedListener(destinationAutocomplete, 'DEST');

        this.map.controls[google.maps.ControlPosition.TOP_LEFT].push(originInput);
        this.map.controls[google.maps.ControlPosition.TOP_LEFT].push(destinationInput);
        this.map.controls[google.maps.ControlPosition.TOP_LEFT].push(modeSelector);
      }

      // Sets a listener on a radio button to change the filter type on Places
      // Autocomplete.
      AutocompleteDirectionsHandler.prototype.setupClickListener = function(id, mode) {
        var radioButton = document.getElementById(id);
        var me = this;
        radioButton.addEventListener('click', function() {
          me.travelMode = mode;
          me.route();
        });
      };

      AutocompleteDirectionsHandler.prototype.setupPlaceChangedListener = function(autocomplete, mode) {
        var me = this;
        autocomplete.bindTo('bounds', this.map);
        autocomplete.addListener('place_changed', function() {
          var place = autocomplete.getPlace();
          if (!place.place_id) {
            window.alert("Please select an option from the dropdown list.");
            return;
          }
          if (mode === 'ORIG') {
            me.originPlaceId = place.place_id;
          } else {
            me.destinationPlaceId = place.place_id;
          }
          me.route();
        });

      };

      AutocompleteDirectionsHandler.prototype.route = function() {
        if (!this.originPlaceId || !this.destinationPlaceId) {
          return;
        }
        var me = this;

        this.directionsService.route({
          origin: {'placeId': this.originPlaceId},
          destination: {'placeId': this.destinationPlaceId},
          travelMode: this.travelMode
        }, function(response, status) {
          if (status === 'OK') {
            me.directionsDisplay.setDirections(response);
          } else {
            window.alert('Directions request failed due to ' + status);
          }
        });
      };

$("#findme").click(function(){
    findMe();
});
function findMe(){
    infoWindow = new google.maps.InfoWindow;
        // Try HTML5 geolocation.
        if (navigator.geolocation) {
          navigator.geolocation.getCurrentPosition(function(position) {
            var pos = {
              lat: position.coords.latitude,
              lng: position.coords.longitude
            };
            Center = pos;
            infoWindow.setPosition(pos);
            infoWindow.setContent('Location found.');
            infoWindow.open(map);
            map.setCenter(pos);
          }, function() {
            handleLocationError(true, infoWindow, map.getCenter());
          });
        } else {
          // Browser doesn't support Geolocation
          handleLocationError(false, infoWindow, map.getCenter());
        }
}

</script>