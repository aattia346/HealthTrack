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
                            <h3><%= t.write("Your Information") %></h3>
                        </div>
                        <div class="personal-data-details">
                            <fieldset>
                                <legend><%= t.write("Personal Info.") %></legend>
                                <div class="single-personal-info">
                                    <label class="col-sm-5"><%= t.write("Name") %></label>
                                    <p class="col-sm-7"><%= person.getFirstName() + " " + person.getLastName() %></p>
                                </div>
                                <div class="single-personal-info">
                                    <label class="col-sm-5"><%= t.write("email") %></label>
                                    <p class="col-sm-7"><%= person.getEmail() %></p>
                                </div>
                                <div class="single-personal-info">
                                    <label class="col-sm-5"><%= t.write("username") %></label>
                                    <p class="col-sm-7"><%= user.getUsername() %></p>
                                </div>
                                <div class="single-personal-info">
                                    <label class="col-sm-5"><%= t.write("phone") %></label>
                                    <p class="col-sm-7"><%= person.getPhone() %></p>
                                </div>
                                <div class="single-personal-info">
                                    <label class="col-sm-5"><%= t.write("Today's bookings") %></label>
                                    <p class="col-sm-7"><%= person.getBookingsPerDay() + " " + t.write("(only 3 are permitted per day)")%></p>
                                </div>
                                <div class="single-personal-info">
                                    <label class="col-sm-5"><%= t.write("All bookings") %></label>
                                    <p class="col-sm-7"><a href="#allBookings"><%= PersonDao.countUserBookings(user.getId()) %></a></p>
                                </div>
                            </fieldset>
                        </div>
                    </div>
                </div>
                <div class="col-sm-7">
                    <div class="personal-data">
                        <div class="personal-data-head">
                            <h3><%= t.write("Today's Bookings") %></h3>
                        </div>
                        <div class="bookings-details">
                        
                        <c:forEach var="booking" items="${todaysBookings}">
                        <% Booking booking = (Booking)pageContext.getAttribute("booking"); %>
                        	<div class="booking-info col-sm-4">
                               <div class="booking-card">
                                   <div class="card-head">
                                       <p><%= t.write("Booking No.") %> <strong>${booking.bookingId}</strong></p>
                                       <a href="/HealthTrack/profile/user/booking/delete/<%= user.getId() %>/<%= booking.getBookingId() %>" title="<%= t.write("Cancel the booking") %>" class="delete-booking-icon confirm-user-delete-booking">
                                       		<i class="far fa-times-circle"></i>
                                       </a>
                                   </div>
                                   <div class="card-body">
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("Name") %></label>
                                            <p class="col-sm-8">${booking.firstName} ${booking.lastName}</p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("phone") %></label>
                                            <p class="col-sm-8">${booking.bookingPhone}</p>
                                        </div>
                                        <% 
                                        Booking b = (Booking)pageContext.getAttribute("booking");
										if(b.getClinicId() != 0){ 
                                       		Clinic clinic = ClinicDao.getClinicById(b.getClinicId());
                                       	%>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("Clinic") %></label>
                                            <p class="col-sm-8"><%= clinic.getClinicName() %></p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("Address") %></label>
                                            <p class="col-sm-8"><%= clinic.getAddress() %></p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("in") %></label>
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
                                            <label class="col-sm-4"><%= t.write("service") %></label>
                                            <p class="col-sm-8"><%= t.write(service.getServiceName()) %></p>
                                        </div>  
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><% if(service.getCenterId() != 0){ %> <%= t.write("center") %> <% }else{ %> <%= t.write("hospital") %> <% } %></label>
                                            <p class="col-sm-8"><% if(service.getCenterId() != 0){ %> <%= t.write(servicePlace.getCenterName()) %> <% }else{ %> <%= t.write(servicePlace.getHospitalName()) %> <% } %></p>
                                        </div>
                                        <% if(service.getSlotType() == 1){ %>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("from") %></label>
                                            <p class="col-sm-8"><%= b.getDateFrom() %> 	&ensp; <strong><%= t.write("to") %> </strong>&ensp; <%= b.getDateTo() %></p>
                                        </div>
                                        <% }else { %>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("Appointment") %></label>
                                            <p class="col-sm-8"><strong><%=  t.write("on") %></strong> &ensp; <%= b.getDayOfBooking() %> &ensp; <strong><%= t.write("at") %></strong> &ensp; <%= b.getTimeFrom() %></p>
                                        </div>
                                        <% } 
                                        } %>
                                   
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("Status") %></label>
                                            <% if(b.getStatus() == 1){ %>
                                             <p class="col-sm-8 confirmed"><%= t.write("Confirmed") %> </p><% }else{ %>
                                             	<p class="col-sm-8 unconfirmed"><%= t.write("Unconfirmed") %> </p>
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
                            <h3><%= t.write("All Bookings") %></h3>
                        </div>
                        <div class="bookings-details all-bookings">
  						<c:forEach var="booking" items="${allBookings}">
  						<% Booking booking = (Booking)pageContext.getAttribute("booking"); %>
                        	<div class="booking-info col-sm-3">
                               <div class="booking-card">
                                   <div class="card-head">
                                       <p><%= t.write("Booking No.") %><strong>${booking.bookingId}</strong></p>
                                   	   <% if(booking.getClinicId() != 0){ %>
                                       	<a href="/HealthTrack/profile/clinic/delete/booking/<%= user.getId() %>/<%= booking.getBookingId() %>" title="<%= t.write("Cancel the booking") %>" class="delete-booking-icon confirm-user-delete-booking">
                                       		<i class="far fa-times-circle"></i>
                                       </a>
                                       <% }else if(booking.getCenterId()!=0){ %>
                                             <a href="/healthTrack/profile/Center/booking/delete/<%= user.getId() %>/<%= booking.getBookingId() %>" title="<%= t.write("Cancel the booking") %>" class="delete-booking-icon confirm-user-delete-booking">
                                       		<i class="far fa-times-circle"></i>
                                       </a>                                 
                                       <% } else{ %>
                                       	<a href="/HealthTrack/profile/booking/delete/<%= user.getId() %>/<%= booking.getBookingId() %>" title="<%= t.write("Cancel the booking") %>" class="delete-booking-icon confirm-user-delete-booking">
                                       		<i class="far fa-times-circle"></i>
                                       </a>
                                       
                                       <% } %>
                                   </div>
                                   <div class="card-body">
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("Name") %></label>
                                            <p class="col-sm-8">${booking.firstName} ${booking.lastName}</p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("phone") %></label>
                                            <p class="col-sm-8">${booking.bookingPhone}</p>
                                        </div>
                                        <% 
                                        Booking b = (Booking)pageContext.getAttribute("booking");
										if(b.getClinicId() != 0){
                                       		Clinic clinic = ClinicDao.getClinicById(b.getClinicId());
                                       	%>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("Clinic") %></label>
                                            <p class="col-sm-8"><%= t.write(clinic.getClinicName()) %></p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("Address") %></label>
                                            <p class="col-sm-8"><%= t.write(clinic.getAddress()) %></p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("in") %></label>
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
                                            <label class="col-sm-4"><%= t.write("service") %></label>
                                            <p class="col-sm-8"><%= t.write(service.getServiceName()) %></p>
                                        </div>  
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><% if(service.getCenterId() != 0){ %> <%= t.write("center") %> <% }else{ %> <%= t.write("hospital") %> <% } %></label>
                                            <p class="col-sm-8"><% if(service.getCenterId() != 0){ %> <%= t.write(servicePlace.getCenterName()) %> <% }else{ %> <%= t.write(servicePlace.getHospitalName()) %> <% } %></p>
                                        </div>
                                        <% if(service.getSlotType() == 1){ %>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("from") %></label>
                                            <p class="col-sm-8"><%= b.getDateFrom() %> 	&ensp; <strong><%= t.write("to") %> </strong>&ensp; <%= b.getDateTo() %></p>
                                        </div>
                                        <% }else { %>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("Appointment") %></label>
                                            <p class="col-sm-8"><strong><%=  t.write("on") %></strong> &ensp; <%= b.getDayOfBooking() %> &ensp; <strong><%= t.write("at") %></strong> &ensp; <%= b.getTimeFrom() %></p>
                                        </div>
                                        <% } 
                                        } %>
                                   
                                        <div class="single-booking-info">
                                            <label class="col-sm-4"><%= t.write("Status") %></label>
                                            <% if(b.getStatus() == 1){ %>
                                             <p class="col-sm-8 confirmed"><%= t.write("Confirmed") %> </p><% }else{ %>
                                             	<p class="col-sm-8 unconfirmed"><%= t.write("Unconfirmed") %> </p>
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
$(".all-bookings").css("height" , $("body").height()- 1100);
</script>