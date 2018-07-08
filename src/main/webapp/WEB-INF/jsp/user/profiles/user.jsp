<% String title="Profile"; %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="../includes/header.jsp" %>

<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.Person"%>
<%@page import="com.gp.user.PersonDao"%>
<%@page import="com.gp.user.Clinic"%>
<%@page import="com.gp.user.ClinicDao"%>
<%@page import="com.gp.user.UserDao"%>
<%@page import="com.gp.user.Service"%>
<%@page import="com.gp.user.Booking"%>
<%@page import="com.gp.user.ServiceDao"%>
<%@page import="com.gp.user.BookingDao"%>

<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<% 
	User user = null; 
	Person person = null;
	String username = (String) session.getAttribute("username");

	Calendar calendar = Calendar.getInstance();
	Date today = Calendar.getInstance().getTime();
	calendar.setTime(today);
	calendar.add(Calendar.DAY_OF_MONTH, 2);	
	SimpleDateFormat todayFormat = new SimpleDateFormat ("yyyy-MM-dd");
	String todayInMyFormat = todayFormat.format(today);
	calendar.add(Calendar.DAY_OF_MONTH, 1);
	Date bookTo = calendar.getTime();
	String bookToInMyFormat = todayFormat.format(bookTo);
	
	
	if(!username.equalsIgnoreCase(null)){
		user = UserDao.getUserByUsername(username);
		person = PersonDao.getAllInfoAboutUserByUsername(username);
		List<Booking> userBookings = BookingDao.getBookingsByUserId(user.getId());
		request.setAttribute("bookings", userBookings);
		
	}
	
	List<Booking> todaysBookings = BookingDao.getTodaysBookings(user.getId());
	request.setAttribute("todaysBookings", todaysBookings);
	
	List<Booking> allBookings = BookingDao.getBookingsByUserId(user.getId());
	request.setAttribute("allBookings", allBookings);

%>
<div class="user-profile-body">
<div class="container">

<div class="row">
                <div class="col-sm-5">
                    <div class="personal-data">
                        <div class="personal-data-head">
                            <h3><%= t.write("Your Information",lang) %></h3>
                        </div>
                        <div class="personal-data-details">
                            <fieldset>
                                <legend><%= t.write("Personal Info.",lang) %></legend>
                                <div class="single-personal-info">
                                    <label class="col-sm-5"><%= t.write("Name",lang) %></label>
                                    <p class="col-sm-7"><%= person.getFirstName() + " " + person.getLastName() %></p>
                                </div>
                                <div class="single-personal-info">
                                    <label class="col-sm-5"><%= t.write("email",lang) %></label>
                                    <p class="col-sm-7"><%= person.getEmail() %></p>
                                </div>
                                <div class="single-personal-info">
                                    <label class="col-sm-5"><%= t.write("username",lang) %></label>
                                    <p class="col-sm-7"><%= user.getUsername() %></p>
                                </div>
                                <div class="single-personal-info">
                                    <label class="col-sm-5"><%= t.write("phone",lang) %></label>
                                    <p class="col-sm-7"><%= person.getPhone() %></p>
                                </div>
                                <div class="single-personal-info">
                                    <label class="col-sm-5"><%= t.write("Today's bookings",lang) %></label>
                                    <p class="col-sm-7"><%= person.getBookingsPerDay() + " " + t.write("(only 3 are permitted per day)",lang)%></p>
                                </div>
                                <div class="single-personal-info">
                                    <label class="col-sm-5"><%= t.write("All bookings",lang) %></label>
                                    <p class="col-sm-7"><a href="#allBookings"><%= PersonDao.countUserBookings(user.getId()) %></a></p>
                                </div>
                            </fieldset>
                        </div>
                    </div>
                </div>
                <div class="col-sm-7">
                    <div class="personal-data">
                        <div class="personal-data-head">
                            <h3><%= t.write("Today's Bookings",lang) %></h3>
                        </div>
                        <div class="bookings-details">
                        
                        <c:forEach var="booking" items="${todaysBookings}">
                        	<div class="booking-info col-sm-4">
                               <div class="booking-card">
                                   <div class="card-head">
                                       <p><%= t.write("Booking No.",lang) %> <strong>${booking.bookingId}</strong></p>
                                   </div>
                                   <div class="card-body">
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("Name",lang) %></label>
                                            <p class="col-sm-8">${booking.firstName} ${booking.lastName}</p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("phone",lang) %></label>
                                            <p class="col-sm-8">${booking.bookingPhone}</p>
                                        </div>
                                        <% 
                                        Booking b = (Booking)pageContext.getAttribute("booking");
										if(b.getClinicId() != 0){ 
                                       		Clinic clinic = ClinicDao.getClinicById(b.getClinicId());
                                       	%>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("Clinic",lang) %></label>
                                            <p class="col-sm-8"><%= clinic.getClinicName() %></p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("Address",lang) %></label>
                                            <p class="col-sm-8"><%= clinic.getAddress() %></p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("in",lang) %></label>
                                            <p class="col-sm-8"><%= b.getDayOfBooking() %></p>
                                        </div>
                                        <% }else if(b.getServiceId() != 0){ 
                                        	Service service = ServiceDao.getServiceById(b.getServiceId());
                                        	Service servicePlace = null;
                                        	if(service.getCenterId() != 0){
                                        		servicePlace = ServiceDao.getServiceById(b.getServiceId(), "center");
                                        		
                                        	}else if(service.getDeptId() != 0){
                                        		servicePlace = ServiceDao.getServiceById(b.getServiceId(), "hospital");
                                        	}
                                        %>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("service",lang) %></label>
                                            <p class="col-sm-8"><%= t.write(service.getServiceName(),lang) %></p>
                                        </div>  
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><% if(service.getCenterId() != 0){ %> <%= t.write("center",lang) %> <% }else{ %> <%= t.write("hospital",lang) %> <% } %></label>
                                            <p class="col-sm-8"><% if(service.getCenterId() != 0){ %> <%= t.write(servicePlace.getCenterName(),lang) %> <% }else{ %> <%= t.write(servicePlace.getHospitalName(),lang) %> <% } %></p>
                                        </div>
                                        <% if(service.getSlotType() == 1){ %>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("from",lang) %></label>
                                            <p class="col-sm-8"><%= b.getDateFrom() %> 	&ensp; <strong><%= t.write("to",lang) %> </strong>&ensp; <%= b.getDateTo() %></p>
                                        </div>
                                        <% }else { %>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("Appointment",lang) %></label>
                                            <p class="col-sm-8"><strong><%=  t.write("on",lang) %></strong> &ensp; <%= b.getDayOfBooking() %> &ensp; <strong><%= t.write("at",lang) %></strong> &ensp; <%= b.getTimeFrom() %></p>
                                        </div>
                                        <% } 
                                        } %>
                                   
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("Status",lang) %></label>
                                            <% if(b.getStatus() == 1){ %>
                                             <p class="col-sm-8 confirmed"><%= t.write("Confirmed",lang) %> </p><% }else{ %>
                                             	<p class="col-sm-8 unconfirmed"><%= t.write("Unconfirmed",lang) %> </p>
                                             <% } %>
                                        </div>
                                   </div>
                               </div>
                            </div>
                        </c:forEach>                           
                        </div>
                    </div>
                </div>
                <div class="col-sm-12" id="allBookings">
                    <div class="personal-data" style="margin-top:50px;">
                        <div class="personal-data-head">
                            <h3><%= t.write("All Bookings",lang) %></h3>
                        </div>
                        <div class="bookings-details all-bookings">
  						<c:forEach var="booking" items="${allBookings}">
                        	<div class="booking-info col-sm-3">
                               <div class="booking-card">
                                   <div class="card-head">
                                       <p><%= t.write("Booking No.",lang) %><strong>${booking.bookingId}</strong></p>
                                   </div>
                                   <div class="card-body">
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("Name",lang) %></label>
                                            <p class="col-sm-8">${booking.firstName} ${booking.lastName}</p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("phone",lang) %></label>
                                            <p class="col-sm-8">${booking.bookingPhone}</p>
                                        </div>
                                        <% 
                                        Booking b = (Booking)pageContext.getAttribute("booking");
										if(b.getClinicId() != 0){
                                       		Clinic clinic = ClinicDao.getClinicById(b.getClinicId());
                                       	%>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("Clinic",lang) %></label>
                                            <p class="col-sm-8"><%= t.write(clinic.getClinicName(),lang) %></p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("Address",lang) %></label>
                                            <p class="col-sm-8"><%= t.write(clinic.getAddress(),lang) %></p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("in",lang) %></label>
                                            <p class="col-sm-8"><%= b.getDayOfBooking() %></p>
                                        </div>
                                        <% }else if(b.getServiceId() != 0){ 
                                        	Service service = ServiceDao.getServiceById(b.getServiceId());
                                        	Service servicePlace = null;
                                        	if(service.getCenterId() != 0){
                                        		servicePlace = ServiceDao.getServiceById(b.getServiceId(), "center");
                                        		
                                        	}else if(service.getDeptId() != 0){
                                        		servicePlace = ServiceDao.getServiceById(b.getServiceId(), "hospital");
                                        	}
                                        %>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("service",lang) %></label>
                                            <p class="col-sm-8"><%= t.write(service.getServiceName(),lang) %></p>
                                        </div>  
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><% if(service.getCenterId() != 0){ %> <%= t.write("center",lang) %> <% }else{ %> <%= t.write("hospital",lang) %> <% } %></label>
                                            <p class="col-sm-8"><% if(service.getCenterId() != 0){ %> <%= t.write(servicePlace.getCenterName(),lang) %> <% }else{ %> <%= t.write(servicePlace.getHospitalName(),lang) %> <% } %></p>
                                        </div>
                                        <% if(service.getSlotType() == 1){ %>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("from",lang) %></label>
                                            <p class="col-sm-8"><%= b.getDateFrom() %> 	&ensp; <strong><%= t.write("to",lang) %> </strong>&ensp; <%= b.getDateTo() %></p>
                                        </div>
                                        <% }else { %>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("Appointment",lang) %></label>
                                            <p class="col-sm-8"><strong><%=  t.write("on",lang) %></strong> &ensp; <%= b.getDayOfBooking() %> &ensp; <strong><%= t.write("at",lang) %></strong> &ensp; <%= b.getTimeFrom() %></p>
                                        </div>
                                        <% } 
                                        } %>
                                   
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("Status",lang) %></label>
                                            <% if(b.getStatus() == 1){ %>
                                             <p class="col-sm-8 confirmed"><%= t.write("Confirmed",lang) %> </p><% }else{ %>
                                             	<p class="col-sm-8 unconfirmed"><%= t.write("Unconfirmed",lang) %> </p>
                                             <% } %>
                                        </div>
                                   </div>
                               </div>
                            </div>
                        </c:forEach>                                                    
                        </div>
                    </div>
                </div>
            </div>	
	</div>
</div>
<%@include  file="../includes/footer.jsp" %>
<script>
console.log($("body").height()- 630);
$(".all-bookings").css("height" , $("body").height()- 630);
</script>