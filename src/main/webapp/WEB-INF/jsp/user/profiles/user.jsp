<% String title="Profile"; %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="../includes/header.jsp" %>

<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.Person"%>
<%@page import="com.gp.user.PersonDao"%>
<%@page import="com.gp.user.UserDao"%>
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

%>
<div class="user-profile-body">
<div class="container">

<div class="row">
                <div class="col-sm-5">
                    <div class="personal-data">
                        <div class="personal-data-head">
                            <h3>Your Information</h3>
                        </div>
                        <div class="personal-data-details">
                            <fieldset>
                                <legend>Personal Info.</legend>
                                <div class="single-personal-info">
                                    <label class="col-sm-5"><%= t.write("Name") %></label>
                                    <p class="col-sm-7"><%= person.getFirstName() + " " + person.getLastName() %></p>
                                </div>
                                <div class="single-personal-info">
                                    <label class="col-sm-5">Email</label>
                                    <p class="col-sm-7"><%= person.getEmail() %></p>
                                </div>
                                <div class="single-personal-info">
                                    <label class="col-sm-5"><%= t.write("username") %></label>
                                    <p class="col-sm-7"><%= user.getUsername() %></p>
                                </div>
                                <div class="single-personal-info">
                                    <label class="col-sm-5">Phone</label>
                                    <p class="col-sm-7"><%= person.getPhone() %></p>
                                </div>
                                <div class="single-personal-info">
                                    <label class="col-sm-5">Today's bookings</label>
                                    <p class="col-sm-7"><%= person.getBookingsPerDay() %> (only 3 are permitted per day)</p>
                                </div>
                                <div class="single-personal-info">
                                    <label class="col-sm-5">All bookings</label>
                                    <p class="col-sm-7"><a href="#allBookings"><%= PersonDao.countUserBookings(user.getId()) %></a></p>
                                </div>
                            </fieldset>
                        </div>
                    </div>
                </div>
                <div class="col-sm-7">
                    <div class="personal-data">
                        <div class="personal-data-head">
                            <h3>Today's Bookings</h3>
                        </div>
                        <div class="bookings-details">
                            <div class="booking-info col-sm-4">
                               <div class="booking-card">
                                   <div class="card-head">
                                       <p>Booking No. <strong>15</strong></p>
                                   </div>
                                   <div class="card-body">
                                        <div class="single-booking-info">
                                            <label class="col-sm-4">Name</label>
                                            <p class="col-sm-8">Mahmoud Fathy</p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4">Phone</label>
                                            <p class="col-sm-8">01236547898</p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4">Booking</label>
                                            <p class="col-sm-8">MRI</p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4">In</label>
                                            <p class="col-sm-8">2018-02-28</p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4">Status</label>
                                            <p class="col-sm-8 confirmed">Confirmed</p>
                                        </div>
                                   </div>
                               </div>
                            </div>
                            <div class="booking-info col-sm-4">
                               <div class="booking-card">
                                   <div class="card-head">
                                       <p>Booking No. <strong>15</strong></p>
                                   </div>
                                   <div class="card-body">
                                        <div class="single-booking-info">
                                            <label class="col-sm-4">Name</label>
                                            <p class="col-sm-8">Mahmoud Fathy</p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4">Phone</label>
                                            <p class="col-sm-8">01236547898</p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4">Booking</label>
                                            <p class="col-sm-8">MRI</p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4">In</label>
                                            <p class="col-sm-8">2018-02-28</p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4">Status</label>
                                            <p class="col-sm-8 confirmed">Confirmed</p>
                                        </div>
                                   </div>
                               </div>
                            </div>
                            <div class="booking-info col-sm-4">
                               <div class="booking-card">
                                   <div class="card-head">
                                       <p>Booking No. <strong>15</strong></p>
                                   </div>
                                   <div class="card-body">
                                        <div class="single-booking-info">
                                            <label class="col-sm-4">Name</label>
                                            <p class="col-sm-8">Mahmoud Fathy</p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4">Phone</label>
                                            <p class="col-sm-8">01236547898</p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4">Booking</label>
                                            <p class="col-sm-8">MRI</p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4">In</label>
                                            <p class="col-sm-8">2018-02-28</p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4">Status</label>
                                            <p class="col-sm-8 cancelled">Cancelled</p>
                                        </div>
                                   </div>
                               </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-12" id="allBookings">
                    <div class="personal-data" style="margin-top:50px;">
                        <div class="personal-data-head">
                            <h3>All Bookings</h3>
                        </div>
                        <div class="bookings-details all-bookings">
                            <div class="booking-info col-sm-4">
                               <div class="booking-card">
                                   <div class="card-head">
                                       <p>Booking No. <strong>15</strong></p>
                                   </div>
                                   <div class="card-body">
                                        <div class="single-booking-info">
                                            <label class="col-sm-4">Name</label>
                                            <p class="col-sm-8">Mahmoud Fathy</p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4">Phone</label>
                                            <p class="col-sm-8">01236547898</p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4">Booking</label>
                                            <p class="col-sm-8">MRI</p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4">In</label>
                                            <p class="col-sm-8">2018-02-28</p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4">Status</label>
                                            <p class="col-sm-8 confirmed">Confirmed</p>
                                        </div>
                                   </div>
                               </div>
                            </div>
                            <div class="booking-info col-sm-4">
                               <div class="booking-card">
                                   <div class="card-head">
                                       <p>Booking No. <strong>15</strong></p>
                                   </div>
                                   <div class="card-body">
                                        <div class="single-booking-info">
                                            <label class="col-sm-4">Name</label>
                                            <p class="col-sm-8">Mahmoud Fathy</p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4">Phone</label>
                                            <p class="col-sm-8">01236547898</p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4">Booking</label>
                                            <p class="col-sm-8">MRI</p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4">In</label>
                                            <p class="col-sm-8">2018-02-28</p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4">Status</label>
                                            <p class="col-sm-8 confirmed">Confirmed</p>
                                        </div>
                                   </div>
                               </div>
                            </div>
                            <div class="booking-info col-sm-4">
                               <div class="booking-card">
                                   <div class="card-head">
                                       <p>Booking No. <strong>15</strong></p>
                                   </div>
                                   <div class="card-body">
                                        <div class="single-booking-info">
                                            <label class="col-sm-4">Name</label>
                                            <p class="col-sm-8">Mahmoud Fathy</p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4">Phone</label>
                                            <p class="col-sm-8">01236547898</p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4">Booking</label>
                                            <p class="col-sm-8">MRI</p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4">In</label>
                                            <p class="col-sm-8">2018-02-28</p>
                                        </div>
                                        <div class="single-booking-info">
                                            <label class="col-sm-4">Status</label>
                                            <p class="col-sm-8 cancelled">Cancelled</p>
                                        </div>
                                   </div>
                               </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

	<c:forEach  var="booking" items="${bookings}">
		<div>
			
			<h2>Booking ID: ${booking.bookingId}</h2>
			<label> Service:  </label><p>${booking.serviceName}</p>
			<label> First Name:  </label><p>${booking.firstName}</p>
			<label> Last Name:  </label><p>${booking.lastName}</p>
			<label> Age:  </label><p>${booking.age}</p>
			<label> From:  </label><p>${booking.dateFrom}</p>
			<label> To:  </label><p>${booking.dateTo}</p>
			<label> Booked At:  </label><p>${booking.timeOfBooking}</p>
			<label> Status:  </label>
			<p>
				<% 
				Booking B = (Booking) pageContext.getAttribute("booking");
				if(B.getStatus()==0){ %>
					unverified
			<%	}else{ %>
					verified
		<%		}
				%>
			</p>
		<a href="/HealthTrack/profile/booking/delete/${booking.userId}/${booking.bookingId}" class="confirm-delete-booking btn btn-danger">Delete</a>		
		</div>					   
	</c:forEach> 
	<div class="col-sm-6 calendar" id='calendar'></div>
</div>
</div>
<%@include  file="../includes/footer.jsp" %>