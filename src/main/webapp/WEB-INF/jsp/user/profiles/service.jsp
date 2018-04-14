<%@page import="com.gp.user.Department"%>
<%@page import="com.gp.user.Service"%>
<%@page import="com.gp.user.ServiceDao"%>
<%@page import="com.gp.user.HospitalDao"%>
<%@page import="com.gp.user.Hospital"%>
<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>
<%@page import="com.gp.user.Booking"%>
<%@page import="com.gp.user.BookingDao"%>
<%@page import="com.gp.user.PersonDao"%>
<%@page import="com.gp.user.Person"%>

<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% 	
	HttpSession hospitalSession = request.getSession();
	int serviceId = (Integer)request.getAttribute("serviceId");
	boolean showForm = false;
	User user = new User();
	String usernameSession = (String)hospitalSession.getAttribute("username");
	if(usernameSession != null){
		user = UserDao.getUserByUsername(usernameSession);
		if(user.getType().equalsIgnoreCase("person")){
			showForm = true;
		}
	}
	String place = (String)request.getAttribute("place");
	Service S = ServiceDao.getServiceById(serviceId, place);
	String title=S.getServiceName(); 
	Calendar calendar = Calendar.getInstance();
	Date today = Calendar.getInstance().getTime();
	calendar.setTime(today);
	calendar.add(Calendar.DAY_OF_MONTH, 2);	

	SimpleDateFormat todayFormat = new SimpleDateFormat ("yyyy-MM-dd");
	String todayInMyFormat = todayFormat.format(today);
	
	calendar.add(Calendar.DAY_OF_MONTH, 1);
	Date bookTo = calendar.getTime();
	String bookToInMyFormat = todayFormat.format(bookTo);
	
	if(S.getSlotType() == 1){
		request.setAttribute("hideTable", "hidden");
	}else if(S.getSlotType() == 2){
		request.setAttribute("hideCalendar", "hidden");
	}
	
%>
<%@include  file="../includes/header.jsp" %>

<!-- Preloader -->
    <div id="preloader">
        <div class="medilife-load"></div>
    </div>
    
    <section class="breadcumb-area bg-img gradient-background-overlay" style="background-image: url(/user/layout/images/profiles/bg-img/breadcumb2.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="breadcumb-content">
                        <h3 class="breadcumb-title"><%= S.getServiceName() %></h3>
                        <p class="breadcumb-intro"><%= S.getIntro() %></p>
                    </div>
                </div>
            </div>
        </div>
    </section>

        <!-- ***** Book An Appoinment Area Start ***** -->
    <div class="medilife-book-an-appoinment-area">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="appointment-form-content">
                        <div class="row no-gutters align-items-center">
                            <div class="col-12 col-lg-9 col-md-6">
                             <div class="my-table text-center ${hideTable}">
                            <table class="table table-bordered">
                            <thead>
                            <tr class="table-head">
                                <th>thu 12/4</th>
                                <th>Fri 13/4</th>
                                <th>Sat 14/4</th>
                                <th>Sun 15/4</th>
                                <th>mon 16/4</th>
                                <th>tue 17/4</th>
                                <th>wed 18/4</th>
                            </tr>
                          </thead>
                        <tbody>
                            <tr>
                              <td>12:00</td>
                              <td>01:00</td>
                              <td class="booked">02:00</td>
                              <td class="booked">02:00</td>
                              <td>02:00</td>
                              <td>02:00</td>
                              <td>03:30</td>
                          </tr>
                          <tr>
                              <td>12:00</td>
                              <td class="booked">01:00</td>
                              <td>02:00</td>
                              <td>02:00</td>
                              <td class="booked">02:00</td>
                              <td>02:00</td>
                              <td class="booked">03:30</td>
                          </tr>
                            <tr>
                              <td class="booked">12:00</td>
                              <td class="booked">01:00</td>
                              <td>02:00</td>
                              <td class="booked">02:00</td>
                              <td>02:00</td>
                              <td class="booked">02:00</td>
                              <td>03:30</td>
                          </tr>
                        </tbody>
                    </table> 
                                                           
                    </div>
                    <div class=" ${hideCalendar}"><div class="calendar " id='calendar'></div></div>
                                <div class="medilife-appointment-form">
                                    <form action="#" method="post">
                                        <div class="row align-items-end">
                                            <div class="col-12 col-md-3">
                                                <div class="form-group">
                                                    <input type="text" class="form-control border-top-0 border-right-0 border-left-0" name="firstName" id="name" placeholder="First Name">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-3">
                                                <div class="form-group">
                                                    <input type="text" class="form-control border-top-0 border-right-0 border-left-0" name="lastName" id="name" placeholder="Last Name">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-3">
                                                <div class="form-group">
                                                    <input type="date" class="form-control" name="date" id="date" placeholder="Date" min="<%= todayInMyFormat %>" value="<%= todayInMyFormat %>">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-3">
                                                <div class="form-group">
                                                    <input type="time" class="form-control" name="time" id="time" placeholder="Time">
                                                </div>
                                            </div>
                                            
                                            <div class="col-12 col-md-6">
                                                <div class="form-group">
                                                    <input type="text" class="form-control border-top-0 border-right-0 border-left-0" name="number" id="number" placeholder="Phone">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <div class="form-group">
                                                    <input type="email" class="form-control border-top-0 border-right-0 border-left-0" name="email" id="email" placeholder="E-mail">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-12">
                                                <div class="form-group mb-0">
                                                    <textarea name="message" class="form-control mb-0 border-top-0 border-right-0 border-left-0" id="message" cols="30" rows="10" placeholder="Message"></textarea>
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-4 mb-0">
                                                <div class="form-group mb-0">
                                                    <button type="submit" class="btn medilife-btn medilife-btn-appointment">Make an Appointment <span>+</span></button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div class="col-12 col-lg-3">
                                <div class="medilife-contact-info">
                                    <!-- Single Contact Info -->
                                     <div class="single-contact-info mb-30">
                                        <p><%= S.getHospitalName() %></p>
                                    </div>
                                    <!-- Single Contact Info -->
                                    <div class="single-contact-info mb-30">
                                    	<div class="single-contact-info-icon"><i class="fa fa-phone fa-3x"></i></div>
                                        <p><%= S.getPhone() %></p>
                                    </div>
                                    <!-- Single Contact Info -->
                                    <div class="single-contact-info">
                                        <div class="single-contact-info-icon"><i class="fas fa-globe fa-3x"></i></div>
                                        <p> <%= S.getAddress() %></p>
                                    </div>
                                    <!-- Single Contact Info -->
                                    <div class="single-contact-info">
                                        <div class="single-contact-info-icon"><i class="fas fa-money-bill-alt fa-3x"></i></div>
                                        <p><%= S.getFees() %></p>
                                    </div><br><br>
                                    <!-- Single Contact Info -->
                                    <div class="single-contact-info">
                                        <div class="single-contact-info-icon"><i class="fas fa-map-marker-alt fa-3x"></i></div>
                                        <p>Find the location google maps</p>
                                    </div>
                                    <!-- Single Contact Info -->
                                    <div class="single-contact-info">
                                        <div class="single-contact-info-icon"><i class="far fa-star fa-3x"></i></div>
                                        <p><%= S.getServiceReview() %></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ***** Book An Appoinment Area End ***** -->
    
    <div id="map" class="hospital-map"></div>

                <% if(user.getId()== S.getAdminId()){
                
                	List<Booking> bookings = BookingDao.getBookingsByServiceId(serviceId);
                	
                	request.setAttribute("bookings", bookings);
                
                %>
                	<h2> Bookings </h2>
                	<c:forEach var="booking" items="${bookings}">
                		<div>
                			<p>${booking.bookingId}</p>
                			<p>${booking.firstName}</p>
                			<p>${booking.lastName}</p>
                			<p>${booking.age}</p>
                			<p>${booking.dateFrom}</p>
                			<p>${booking.dateTo}</p>
                			<p>${booking.timeFrom}</p>
                			<p>${booking.timeTo}</p>
                			<a href="/healthTrack/Service/DeleteBooking/<%= S.getServiceId() %>/${booking.bookingId}" class="btn btn-danger confirm-delete-booking">Delete</a>
                			<c:if test="${booking.status==0}">
                				<a href="/healthTrack/Service/VerifyBooking/<%= S.getServiceId() %>/${booking.bookingId}" class="btn btn-success confirm-verify-booking">Confirm</a>
							</c:if>
							<c:if test="${booking.status==1}">
                				<a href="/healthTrack/Service/UnverifyBooking/<%= S.getServiceId() %>/${booking.bookingId}" class="btn btn-warning confirm-unverify-booking">Unconfirm</a>
							</c:if>
                			
                		</div>
                		<hr>
                	</c:forEach>

               <% } %>

<%@include  file="../includes/footer.jsp" %>
<%

List<Booking> bookings = BookingDao.getBookingsByServiceId(serviceId);

%>
<script>
var d = new Date();
var theCurrentYear = d.getFullYear() + "-1-1";

var bookFrom="2018-1-1";
bookFrom = $(".hospital-body input[type='hidden']").val();
$('#calendar').fullCalendar({
    defaultView: 'month',
    validRange: {
    start: theCurrentYear
    },
    events: [
    	<% for(Booking B : bookings){
    		
    	Date dateTo = new Date();
    	Calendar c = Calendar.getInstance(); 
    	c.setTime(B.getDateTo());
    	c.add(Calendar.DAY_OF_MONTH , 1);
    	dateTo = c.getTime();
    	String dateToInMyFormat = todayFormat.format(dateTo);
 
    	%>
    		{
    			title: "Booked",
    			start: "<%= B.getDateFrom()%>",
    			end: "<%= dateToInMyFormat %>"
    			
    		},
    	
    <%	} %>
    ]
    
});
</script>

	<script>
      function hospitalMarker() {
        var uluru = {lat: <%= S.getLat() %>, lng: <%= S.getLang() %>};
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 11,
          center: uluru
        });
        var marker = new google.maps.Marker({
          position: uluru,
          map: map
        });
      }
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCF4-LBT961bTAMeLJr6Pt1-b9FOjljREg&callback=hospitalMarker">
    </script>