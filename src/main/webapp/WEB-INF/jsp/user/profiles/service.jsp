<%@page import="com.gp.user.Department"%>
<%@page import="com.gp.user.Service"%>
<%@page import="com.gp.user.ServiceDao"%>
<%@page import="com.gp.user.HospitalDao"%>
<%@page import="com.gp.user.Hospital"%>
<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>
<%@page import="com.gp.user.Booking"%>
<%@page import="com.gp.user.BookingDao"%>
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
	
	Service S = ServiceDao.getServiceById(serviceId);
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
	
%>
<%@include  file="../includes/header.jsp" %>

<div class="hospital-body">
        	<input type="hidden" class="booking-date" required  value="<%= todayInMyFormat %>">
            <div class="container">

                <div class="row service-img">

                    <div class="thumbnail col-sm-4">

                        <img class="img-responsive" src="/user/layout/images/icu.jpg">

                    </div>

                    <div class="col-sm-8  col-xs-12">
                         <div class="hospital-info">
                            <h4 class="about-title">Service: </h4><p class="about-detail"><%= S.getServiceName() %></p>
                        </div>
                         <div class="hospital-info">
                            <h4 class="about-title">Department: </h4><p class="about-detail"><%= S.getDeptName() %></p>
                        </div>
                         <div class="hospital-info">
                            <h4 class="about-title">Hospital: </h4><p class="about-detail"><%= S.getHospitalName() %></p>
                        </div>
                         <div class="hospital-info">
                            <h4 class="about-title">Fees: </h4><p class="about-detail"><%= S.getFees() %></p>
                        </div>
                        <div class="hospital-info">
                            <h4 class="about-title">Address: </h4><p class="about-detail"><%= S.getAddress()%></p>
                        </div>
                        <div class="hospital-info">
                        	<h4 class="about-title">Location: </h4><p class="about-detail"><a href="<%= S.getGoogleMapsUrl() %>">find <%= S.getServiceName() %> in google maps</a></p>
                    	</div>
                        <div class="hospital-info">
                            <h4 class="about-title">Review: </h4><p class="about-detail"><%= S.getServiceReview() %></p>
                        </div>
                    </div>

                </div>
                
                <% if(showForm){ %>                
                
                <div class="col-sm-12 hospital-depts service-booking">
                    <h3 class="text-center">Book <%= S.getServiceName() %></h3>
                    <form method="post" action="/HealthTrack/Service/<%=S.getServiceId() %>/Booking/Submit">
                        
                        <input type="hidden" value="<%= user.getId() %>" name="userId">
                        
                        <div class="col-sm-6 personal-info">
                    
                            <div class="form-group name">
                                    <input type="text" required maxlength="15" class="form-control input-sm" name="firstName" placeholder="Patient First Name" > 

                                    <input type="text" required maxlength="15" class="form-control input-sm" name="lastName" placeholder="Patient Last Name" > 
                            </div>
                            ${invalidName}
                            <div class="form-group">
                                    <input type="number" required min="0" max = "120" class="form-control input-sm" name="age" placeholder="Patient Age" > 
                            </div>
                          
                            <div class="form-group">
                                    <input type="text" required maxlength="11" class="form-control input-sm" name="phone" placeholder="Phone Number" required> 
                            </div>
                        	${invalidPhone}                          
                            <div>
                                <h4 class="about-title">Book From: </h4>
                                <input type="date" required class="booking-date" name="bookFrom"  min="<%= todayInMyFormat %>" value="<%= todayInMyFormat %>">
                            </div>  
                            <div>
                                <h4 class="about-title">To: </h4>
                                <input type="date" required class="booking-date" name="bookTo" min="<%= todayInMyFormat %>" value="<%= bookToInMyFormat %>">
                            </div>
                            ${invalidDate}
                        </div>
                        <div class="col-sm-6 calendar" id='calendar'></div>

                        <div class="form-group">
                            <input type="submit" class="form-control input-sm  btn btn-primary"> 
                        </div>
                    </form>
                    
                </div>
                
                <% } else if(user.getId()== S.getAdminId()){
                
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

               <% }else{ %>
            	   
            	   <div> if you want to book this service please <a href="/HealthTrack/login">Login</a> or <a href="/HealthTrack/signup">Signup</a></div>
           <%    }
                	%>
                

            </div>
        </div>
        	 
<%@include  file="../includes/footer.jsp" %>
<%

List<Booking> bookings = BookingDao.getVerifiedBookingsByServiceId(serviceId);

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