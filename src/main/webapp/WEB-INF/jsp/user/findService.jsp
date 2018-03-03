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
	Location location = new Location(center.getLat(), center.getLang(), center.getCenterName(), "center", center.getWebsite(), "ff0");
	locations.add(location);
	//change the url to the page of the service
}

List<Hospital> hospitals = HospitalDao.getAllHospitals();
for(Hospital hospital : hospitals){
	Location location = new Location(hospital.getLat(), hospital.getLang(), hospital.getHospitalName(), "hospital", hospital.getWebsite(), "f00");
	locations.add(location);
	//change the url to the page of the service
}

List<Service> servicesOfHospital = ServiceDao.getAllServicesOfHospitals();
for(Service service : servicesOfHospital){
	Location location = new Location(service.getLat(), service.getLang(), service.getServiceName(), service.getServiceName(), service.getWebsite(), "fff");
	locations.add(location);
	//change the url to the page of the service
}

List<Service> servicesOfCenters = ServiceDao.getAllServicesOfCenters();
for(Service service : servicesOfCenters){
	Location location = new Location(service.getLat(), service.getLang(), service.getServiceName(), service.getServiceName(), service.getWebsite(), "fff");
	locations.add(location);
	//change the url to the page of the service
}

%>

 <div class="container find-service-container">
        
            <h3 class="text-center">Find A Service : </h3>
            <div class="row">
                
                <div class="enter-address col-sm-11 col-sm-offset-1">
                    
                    <h4 class="col-sm-3">Enter An Address</h4>
                        <div class="col-sm-4">
                            <input id="pac-input" type="text" class="input-sm form-control" placeholder="Search By Place">
                    	</div>
            </div>
                <div class="col-sm-offset-1 col-sm-3 choose-service">
                    
                    <div class="panel panel-primary ">
                      <div class="panel-heading">
                        <h3 class="panel-title text-center">Services</h3>
                      </div>
                      <div class="panel-body">
                          <input type="radio" name="service" value="all" checked> All<br>
                          <input type="radio" name="service" value="clinic"> Clinics<br>
                          <input type="radio" name="service" value="hospital"> Hospitals<br>
                          <input type="radio" name="service" value="center"> Centers<br>
                          <input type="radio" name="service" value="pharmacy"> Pharmacies<br>
                          <input type="radio" name="service" value="icu"> ICU<br>
                      </div>
                    </div>
                    <button class="btn btn-primary find-me" id="findme">locate me</button>
                    
                </div>
                
                <div class="col-sm-8" id="map"></div>
            
            </div>
        
        </div>

<%@include  file="includes/footer.jsp" %>
<script>
var selectedService = "all";
Center = {lat:30.181724, lng : 31.112288};

$("input[type='radio'][name='service']").change(function(){
        
    selectedService = $(this).val();
    
    initAutocomplete();
    });
function initAutocomplete() {
    var map = new google.maps.Map(document.getElementById('map'), {
      center: Center,
      zoom: 12,
      mapTypeId: 'roadmap'
    });
var locations = [
	<% for(Location loc : locations){ %>
	
		[<%= loc.getLat() %>, <%= loc.getLang() %>, "<%= loc.getName() %>" ,"<%= loc.getPinColor() %>", "<%= loc.getType() %>", "<%= loc.getUrl() %>"],
		
	<% }%>
                         ];

          var infowindow = new google.maps.InfoWindow();

          for (i = 0; i < locations.length; i++) {  
              
              if(locations[i][4].toUpperCase()==selectedService.toUpperCase() || selectedService.toLowerCase()=="all"){

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
    // Create the search box and link it to the UI element.
    var input = document.getElementById('pac-input');
    var searchBox = new google.maps.places.SearchBox(input);
   // map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

    // Bias the SearchBox results towards current map's viewport.
    map.addListener('bounds_changed', function() {
      searchBox.setBounds(map.getBounds());
    });

    var markers = [];
    // Listen for the event fired when the user selects a prediction and retrieve
    // more details for that place.
    searchBox.addListener('places_changed', function() {
      var places = searchBox.getPlaces();

      if (places.length == 0) {
        return;
      }
        
      //markers = [];

      // For each place, get the icon, name and location.
      var bounds = new google.maps.LatLngBounds();
      places.forEach(function(place) {
        if (!place.geometry) {
          console.log("Returned place contains no geometry");
          return;
        }
        var icon = {
          url: place.icon,
          size: new google.maps.Size(71, 71),
          origin: new google.maps.Point(0, 0),
          anchor: new google.maps.Point(17, 34),
          scaledSize: new google.maps.Size(25, 25)
        };

        // Create a marker for each place.
        markers.push(new google.maps.Marker({
          map: map,
          icon: icon,
          title: place.name,
          position: place.geometry.location
        }));

        if (place.geometry.viewport) {
          // Only geocodes have viewport.
          bounds.union(place.geometry.viewport);
        } else {
          bounds.extend(place.geometry.location);
        }
      });
      map.fitBounds(bounds);
    });
    infoWindow = new google.maps.InfoWindow;
      var btn = document.getElementById("findme");
  btn.onclick = function(){
            // Try HTML5 geolocation.
            if (navigator.geolocation) {
              navigator.geolocation.getCurrentPosition(function(position) {
                var pos = {
                  lat: position.coords.latitude,
                  lng: position.coords.longitude
                };
                Center=pos;
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
      function handleLocationError(browserHasGeolocation, infoWindow, pos) {
            infoWindow.setPosition(pos);
            infoWindow.setContent(browserHasGeolocation ?
                                  'Error: The Geolocation service failed.' :
                                  'Error: Your browser doesn\'t support geolocation.');
            infoWindow.open(map);
              
          }
      
          }
  }

</script>
<script
 src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCF4-LBT961bTAMeLJr6Pt1-b9FOjljREg&libraries=places&callback=initAutocomplete"
         async defer></script>