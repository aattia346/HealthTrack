<% String title="User"; %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="../includes/header.jsp" %>

<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>
<%@page import="com.gp.user.Booking"%>
<%@page import="com.gp.user.ServiceDao"%>
<%@page import="com.gp.user.BookingDao"%>

<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<% 

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
		User user = UserDao.getUserByUsername(username);
		List<Booking> userBookings = BookingDao.getBookingsByUserId(user.getId());
		request.setAttribute("bookings", userBookings);
		
	}

%>

<div class="container">

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
<%@include  file="../includes/footer.jsp" %>