<% String title="Emenrgency"; %>
<%@include  file="includes/header.jsp" %>

<div class="emergency-body">
	<h1 class="text-center emergency-header"> you are looking for </h1>
	        <div class="container">
	            <section class="emergency-parts">
	                <div class="row">
	                        <div class="emergency-part col-sm-4">
	                            <a href="#" id="inc">
	                                <div class="inner-emergency-part">
	                                    <p class="text-center">Incubator</p>
	                                </div>
	                            </a>
	                        </div>
	                    <div class="emergency-part col-sm-4">
	                        <a href="#" id="icu">
	                            <div class="inner-emergency-part">
	                                <p class="text-center">ICU</p>
	                            </div>
	                        </a>
	                    </div>
	                    <div class="emergency-part col-sm-4">
	                        <a href="#" id="amb">
	                            <div class="inner-emergency-part">
	                                <p class="text-center">Ambulance</p>
	                            </div>
	                        </a>
	                    </div>
	                    <div class="emergency-part col-sm-4">
	                        <a href="#" id="inc">
	                            <div class="inner-emergency-part">
	                                <p class="text-center">Incubator</p>
	                            </div>
	                        </a>
	                    </div>
	                    <div class="emergency-part col-sm-4">
	                        <a href="#" id="inc">
	                            <div class="inner-emergency-part">
	                                <p class="text-center">Incubator</p>
	                            </div>
	                        </a>
	                    </div>
	                    <div class="emergency-part col-sm-4">
	                        <a href="#" id="inc">
	                            <div class="inner-emergency-part">
	                                <p class="text-center">Incubator</p>
	                            </div>
	                        </a>
	                    </div>
	                </div>
	            </section>
	                <div id="map"></div>
	
	        </div>
</div>

<%@include  file="includes/footer.jsp" %>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCF4-LBT961bTAMeLJr6Pt1-b9FOjljREg&libraries=places,geometry&sensor=false&v=3&callback=initMap"
         async defer></script>
<script>
	var map;
	var pos;
	function initMap() {
    map = new google.maps.Map(document.getElementById('map'), {
      center: {lat: -34.397, lng: 150.644},
      zoom: 12
    });

    infoWindow = new google.maps.InfoWindow;

    // Try HTML5 geolocation.
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
        pos = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        };
        console.log(typeof pos);
        infoWindow.setPosition(pos);
        infoWindow.setContent('Location found.');
        infoWindow.open(map);
        map.setCenter(pos);
        var directionsService = new google.maps.DirectionsService;
        var directionsDisplay = new google.maps.DirectionsRenderer;
        directionsDisplay.setMap(map);
        calculateAndDisplayRoute(directionsService, directionsDisplay);
        function calculateAndDisplayRoute(directionsService, directionsDisplay) {
        	console.log("drawing");
              directionsService.route({
                origin: {lat: pos.lat, lng: pos.lng},
                destination: {lat: 30.35372, lng: 31.2108064},
                travelMode: 'DRIVING'
              }, function(response, status) {
                if (status === 'OK') {
                  directionsDisplay.setDirections(response);
                } else {
                  window.alert('Directions request failed due to ' + status);
                }
              });
     }
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
    /*****************************************the desired code*********************************************/
   
    var point_a = new google.maps.LatLng( 30.1638861, 31.1133844 );
    var point_b = new google.maps.LatLng( 30.0227692, 31.2095088 );

    var directionsService = new google.maps.DirectionsService();

    var request = {
      origin      : point_a, // a city, full address, landmark etc
      destination : point_b,
      travelMode  : google.maps.DirectionsTravelMode.DRIVING
    };

    directionsService.route(request, function(response, status) {
      if ( status == google.maps.DirectionsStatus.OK ) {
        console.log( "d = " + response.routes[0].legs[0].distance.value/1000 + " km" );
      }
    });
    /*******************************************************************************************************/
      
  }
		
 
</script>