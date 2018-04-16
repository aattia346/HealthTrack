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
<%@page import="com.gp.user.Appointment"%>

<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.sql.Time"%>

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
	
	
	SimpleDateFormat tableFormat = new SimpleDateFormat("E d/M");
	String todayInTableFormat = tableFormat.format(today);
	
	Calendar tableCalendar = Calendar.getInstance();
	tableCalendar.setTime(today);
	
	calendar.add(Calendar.DAY_OF_MONTH, 1);
	Date bookTo = calendar.getTime();
	String bookToInMyFormat = todayFormat.format(bookTo);
	
	if(S.getSlotType() == 1){
		request.setAttribute("hideTable", "hidden");
	}else if(S.getSlotType() == 2){
		request.setAttribute("hideCalendar", "hidden");
	}
	
	List<Appointment> apps = ServiceDao.getAppointmentsOfService(serviceId);
	int diff = 0;
	for(Appointment app: apps){
		Time appFrom = app.getAppFrom();
		Time appTo = app.getAppTo();
		int minutesDiff = (int)(appTo.getTime() - appFrom.getTime())/(1000*60);
		if(minutesDiff >= diff){
			diff = minutesDiff;
		}
	}
	float numberOfTableRows = diff/S.getSlot();
	String[] days = new String[7];
	DateFormat dayFormat = new SimpleDateFormat("E");
	days[0] = dayFormat.format(today);
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
                ${checkYourBooking} ${loginFirst}
            </div>
        </div>
    </section>

        <!-- ***** Book An Appoinment Area Start ***** -->
    <div class="medilife-book-an-appoinment-area">
        <div class="container">
            <div class="row">
            <% if(!showForm){ %>
                    <div class="col-sm-12 alert alert-info text-center booking-alert">To book Please <a href="/HealthTrack/login">Login</a> First or <a href="/HealthTrack/signup">Register</a></div>
                     <% } %>
                     <div class="col-12">
                    <div class="appointment-form-content">
                        <div class="row no-gutters align-items-center">
                            <div class="col-12 col-lg-9 col-md-6">
                             <div class="my-table text-center ${hideTable}">
                             <div class="unbooked-slots pull-left"></div><span>Available session</span>
                            <table class="table table-bordered">
                            <thead>
                            <tr class="table-head">
                                <th><%= todayInTableFormat %></th>
                                <% for(int i=1; i<7; i++){
                                		tableCalendar.add(Calendar.DAY_OF_MONTH, 1);
                                		Date d = tableCalendar.getTime();
                                		String nextDay = tableFormat.format(d);
                                		days[i] = dayFormat.format(d);
                                 %>
                                	<th><%= nextDay %></th>
                               <% } %>
                                                    
                            </tr>
                          </thead>
                        <tbody>
                        
                        <% 
                           String finalFormat = null;
                           for(int i=0; i<numberOfTableRows; i++){%>
                        		<tr>
                        <% for(int j=0; j<7; j++){
                        	Appointment ap = ServiceDao.getAppointmentOfService(serviceId, days[j]);
                        	LocalTime localTimeFrom = ap.getAppFrom().toLocalTime();
                        	localTimeFrom = localTimeFrom.plusMinutes( i * S.getSlot());
                        	
                        	LocalTime localTimeTo = ap.getAppTo().toLocalTime();
                        	
                        	if(localTimeFrom.isAfter(localTimeTo) || localTimeFrom.equals(localTimeTo) || ap.getAvailable() == 0){
                        		finalFormat = " ";
                        		request.setAttribute("booked", "booked");
                        	}else{
                        		finalFormat = localTimeFrom.toString();
                        		request.setAttribute("booked", "");
                        	}
                        	%>              		 
                        	<td class="${booked}"><%= finalFormat %></td>                       		
                        <% } %>
                        		</tr>
                        <% } %>
                                                 
                        </tbody>
                    </table> 
                   
                    </div>
                    <div class=" ${hideCalendar}"><div class="calendar " id='calendar'></div></div>
                                <div class="medilife-appointment-form">
                                ${invalidName} ${invalidPhone} ${invalidDate} ${invalidmsg} ${invalidEmail}
                                    <form method="post" action="/HealthTrack/<%= place %>/Service/<%=S.getServiceId() %>/Booking/Submit">
                                    <input type="hidden" value="<%= user.getId() %>" name="userId">
                                        <div class="row align-items-end">
                                            <div class="col-12 col-md-3">
                                                <div class="form-group">
                                                    <input type="text" class="form-control border-top-0 border-right-0 border-left-0" required maxlength="15" name="firstName" id="name" placeholder="First Name" value="${oldFirstName}">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-3">
                                                <div class="form-group">
                                                    <input type="text" class="form-control border-top-0 border-right-0 border-left-0" required maxlength="15" name="lastName" id="name" placeholder="Last Name" value="${oldLastName}">
                                                </div>
                                            </div>
                                           
                                            <div class="col-12 col-md-3">
                                                <div class="form-group">
                                                    <input type="number" class="form-control border-top-0 border-right-0 border-left-0" required name="age" placeholder="Age"  required min="0" max = "120" value="${oldAge}">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-3">
                                                <div class="form-group">
                                                    <select class="form-control border-top-0 border-right-0 border-left-0" required name="sex">
                                                    	
                                                    	<option value="male">Male</option>
                                                    	<option value="female">Female</option>
                                                    
                                                    </select>
                                                </div>
                                            </div>
                                                                                        
                                            <div class="col-12 col-md-6">
                                                <div class="form-group">
                                                    <input type="text" class="form-control border-top-0 border-right-0 border-left-0" name="phone" required maxlength="11" id="number" placeholder="Phone" value="${oldPhone}">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <div class="form-group">
                                                    <input type="email" class="form-control border-top-0 border-right-0 border-left-0" name="email" id="email" placeholder="E-mail" value="${oldEmail}">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-6 booking-form-label">
                                                <div class="form-group">
                                                	<label>From:</label> 
                                                </div>
                                             </div>
                                             <div class="col-12 col-md-6 booking-form-label">
                                                <div class="form-group">
                                                	<label>To:</label> 
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <div class="form-group">
                                                    <input type="date" class="form-control" required name="bookFrom" id="date" placeholder="Date" min="<%= todayInMyFormat %>" value="<%= todayInMyFormat %>">
                                                </div>
                                            </div>
                                           
                                            <div class="col-12 col-md-6">
                                                <div class="form-group">
                                                    <input type="date" class="form-control" required name="bookTo" id="date" placeholder="Date" min="<%= todayInMyFormat %>" value="<%= todayInMyFormat %>">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-12">
                                                <div class="form-group mb-0">
                                                    <textarea name="msg" class="form-control mb-0 border-top-0 border-right-0 border-left-0" id="message" cols="30" rows="10" placeholder="Message" maxlength="500">${oldmsg}</textarea>
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
                                     <div class="single-contact-info-icon"><i class="fas fa-h-square fa-3x"></i></div>
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