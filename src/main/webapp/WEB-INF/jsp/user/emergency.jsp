<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@page import="com.gp.user.Service"%>
<%@page import="com.gp.user.HospitalDao"%>
<%@page import="com.gp.user.Hospital"%>
<%@page import="com.gp.user.Location"%>
<%@page import="com.gp.user.Center"%>
<%@page import="com.gp.user.CenterDao"%>
<%@page import="com.gp.user.ServiceDao"%>
<%@page import="com.gp.user.Location"%>
<%@page import="com.gp.user.Validation"%>
<%@page import="com.gp.user.Clinic"%>
<%@page import="com.gp.user.ClinicDao"%>
<%@page import="com.gp.user.Pharmacy"%>
<%@page import="com.gp.user.PharmacyDao"%>
<% 
String title="Emergency"; 
List<Float> 	lats  = new ArrayList<Float>();
List<Float> 	langs = new ArrayList<Float>();
List<String> 	names = new ArrayList<String>();
List<String> 	types = new ArrayList<String>();
List<String> 	urls  = new ArrayList<String>();
List<Location> 	locations = new ArrayList<Location>();

String servicePinColor = null;
Date today = Calendar.getInstance().getTime();
String serviceUrl = null;
Calendar calendar = Calendar.getInstance();
List<Center> centers = CenterDao.getAllCenters();
for(Center center : centers){
	serviceUrl = "/HealthTrack/profile/center/"+center.getAdminId();
	Location location = new Location(center.getLat(), center.getLang(), center.getCenterName(), "center", serviceUrl, "71e486");
	locations.add(location);
}
List<Pharmacy> pharmacies = PharmacyDao.getAllPharmacies();
for(Pharmacy pharmacy : pharmacies){
	serviceUrl = "/HealthTrack/profile/pharmacy/"+pharmacy.getAdminId();
	Location location = new Location(pharmacy.getLat(), pharmacy.getLang(), pharmacy.getPharmacyName(), "pharmacy", serviceUrl, "C35ED4");
	locations.add(location);
}
List<Clinic> clinics = ClinicDao.getAllClinics();
for(Clinic clinic : clinics){
	serviceUrl = "/HealthTrack/profile/clinic/"+clinic.getAdminId();
	Location location = new Location(clinic.getLat(), clinic.getLang(), clinic.getClinicName(), "clinic", serviceUrl, "4089C7");
	locations.add(location);
}

List<Hospital> hospitals = HospitalDao.getAllHospitals();
for(Hospital hospital : hospitals){
	serviceUrl = "/HealthTrack/profile/hospital/"+hospital.getAdminId();
	Location location = new Location(hospital.getLat(), hospital.getLang(), "hospital", hospital.getHospitalName(), serviceUrl, "ff6e6e");
	locations.add(location);
}

SimpleDateFormat formatter = new SimpleDateFormat("E");  
List<Service> servicesOfHospital = ServiceDao.getAllServicesOfHospitals();
for(Service service : servicesOfHospital){
	serviceUrl = "/HealthTrack/profile/service/hospital/"+service.getServiceId();	
	calendar.setTime(today);
	//calendar.add(Calendar.DAY_OF_MONTH, -1);
	if(service.getSlotType()==1){
		if(Validation.validateBookDate(service.getServiceId(), calendar.getTime())){
			Location location = new Location(service.getLat(), service.getLang(), service.getServiceName(), service.getServiceName(), serviceUrl, servicePinColor);
			locations.add(location);		}
		
	} else if(service.getSlotType()==2){
		if(Validation.validateBookTime(service.getServiceId(), formatter.format(calendar.getTime()), "hospital")){
			Location location = new Location(service.getLat(), service.getLang(), service.getServiceName(), service.getServiceName(), serviceUrl, servicePinColor);
			locations.add(location);
		}
	}
}

List<Service> servicesOfCenters = ServiceDao.getAllServicesOfCenters();
for(Service service : servicesOfCenters){
	serviceUrl = "/HealthTrack/profile/service/center/"+service.getServiceId();
	calendar.setTime(today);
	//calendar.add(Calendar.DAY_OF_MONTH, -1);
	if(Validation.validateBookDate(service.getServiceId(), calendar.getTime())){
		Location location = new Location(service.getLat(), service.getLang(), service.getServiceName(), service.getServiceName(), serviceUrl, servicePinColor);
		locations.add(location);
	}
}
%>
<%@include  file="includes/header.jsp" %>

<div class="emergency-body">
	<h1 class="text-center emergency-header"> <%= t.write("you are looking for") %> </h1>
	        <div class="container">
	            <section class="emergency-parts">
	                <div class="row">
	                        <div class="emergency-part col-sm-4">
	                            <a href="#" id="INCUBATOR">
	                                <div class="inner-emergency-part">
	                                    <p class="text-center"><%= t.write("Incubator") %></p>
	                                </div>
	                            </a>
	                        </div>
	                    <div class="emergency-part col-sm-4">
	                        <a href="#" id="ICU">
	                            <div class="inner-emergency-part">
	                                <p class="text-center"><%= t.write("ICU") %></p>
	                            </div>
	                        </a>
	                    </div>
	                    <div class="emergency-part col-sm-4">
	                        <a href="#" id="AMB">
	                            <div class="inner-emergency-part">
	                                <p class="text-center"><%= t.write("Ambulance") %></p>
	                            </div>
	                        </a>
	                    </div>
	                    <div class="emergency-part col-sm-4">
	                        <a href="#" id="MRI">
	                            <div class="inner-emergency-part">
	                                <p class="text-center"><%= t.write("mri") %></p>
	                            </div>
	                        </a>
	                    </div>
	                    <div class="emergency-part col-sm-4">
	                        <a href="#" id="Delivery">
	                            <div class="inner-emergency-part">
	                                <p class="text-center"><%= t.write("Delivery") %></p>
	                            </div>
	                        </a>
	                    </div>
	                    <div class="emergency-part col-sm-4">
	                        <a href="#" id="hospital">
	                            <div class="inner-emergency-part">
	                                <p class="text-center"><%= t.write("hospital") %></p>
	                            </div>
	                        </a>
	                    </div>
	                </div>
	            </section>
	            <div class="col-xs-12 alert hidden text-center alert-success" id="emergencyResult"></div>
	                <div id="map"></div>
	
	        </div>
</div>

<%@include  file="includes/footer.jsp" %>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCF4-LBT961bTAMeLJr6Pt1-b9FOjljREg&libraries=places,geometry&callback=initMap"
         async defer></script>
<script>
var serviceName;
$(".emergency-part a").click(function(){
	$('html, body').animate({
        scrollTop: $("#map").offset().top
    }, 500);
	serviceName = $(this).attr("id");
	initMap();
});

var locations = [
	<% for(Location loc : locations){ %>
	
		[<%= loc.getLat() %>, <%= loc.getLang() %>, "<%= loc.getName() %>" ,"<%= loc.getPinColor() %>", "<%= loc.getType() %>", "<%= loc.getUrl() %>"],
		
	<% }%>
           ];
            
</script>
<script>

	var map;
	var pos;
	var destLat, destLng;
	function initMap() {
    map = new google.maps.Map(document.getElementById('map'), {
      center: {lat: 26.8447054, lng: 35.3738288},
      zoom: 6
    });
    infoWindow = new google.maps.InfoWindow;

    // Try HTML5 geolocation.
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
        pos = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        };
        infoWindow.setPosition(pos);
        infoWindow.setContent('Location found.');
        infoWindow.open(map);
        map.setCenter(pos);

        /*****************************************the desired code*********************************************/
        
        var shortestDistance = 999999999;
    	for(i=0; i<locations.length; i++){
    		if(locations[i][2] == serviceName){
				$("#emergencyResult").html(" <%= t.write("We Found the nearest service you need ") %> " + "<a href='" +locations[i][5] +"'>" + " <%= t.write("Here") %> " + "</a>").addClass("alert-success").removeClass("hidden").removeClass("alert-danger");
    			var point_a = new google.maps.LatLng( pos.lat, pos.lng );
	    	    var point_b = new google.maps.LatLng( locations[i][0], locations[i][1] );
	    	    var directionsService = new google.maps.DirectionsService();
				
	    	    var request = {
	    	      origin      : point_a, // a city, full address, landmark etc
	    	      destination : point_b,
	    	      travelMode  : google.maps.DirectionsTravelMode.DRIVING
	    	      };
	    	   directionsService.route(request, function(response, status) {
	      	      if ( status == google.maps.DirectionsStatus.OK ) {
	      	    	  console.log(response.routes[0].legs[0].distance.value/1000);
	      	    	  if(response.routes[0].legs[0].distance.value/1000 <= shortestDistance){
	      	    		  shortestDistance = response.routes[0].legs[0].distance.value/1000;	
					console.log("short : " + shortestDistance);  
					var directionsService = new google.maps.DirectionsService;
	      	        var directionsDisplay = new google.maps.DirectionsRenderer;
	      	        directionsDisplay.setMap(map);
	      	      	calculateAndDisplayRoute(directionsService, directionsDisplay);
	      	          function calculateAndDisplayRoute(directionsService, directionsDisplay) {
	      	               directionsService.route({
	      	                  origin: {lat: pos.lat, lng: pos.lng},
	      	                  destination: request.destination,
	      	                  travelMode: 'DRIVING'
	      	                }, function(response, status) {
	      	                  if (status === 'OK') {
	      	                    directionsDisplay.setDirections(response);
	      	                  } else {
	      	                    window.alert('Directions request failed due to ' + status);
	      	                  }
	      	                });
	      	               
	      	       }
	      	    	  }
	      	      }
	      	    });
    		}
    	}
    	
    	
    	/*******************************************************************************************************/

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
    
    if($("#emergencyResult").hasClass("alert-success")){
		$("#emergencyResult").html(" <%= t.write("sorry we didn't find what you are looking for you can put yourself in the")%> " + "<a href='/HealthTrack/WaitingList'>" + " <%= t.write("waiting list") %> " + "</a>").removeClass("hidden").addClass("alert-danger").removeClass("alert-success");	
    }
    
  }		
	
	//$("#emergencyResult").hide();

</script>