<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>

<%@page import="com.gp.user.Validation"%>
<%@page import="com.gp.user.Clinic"%>
<%@page import="com.gp.user.Appointment"%>
<%@page import="com.gp.user.ClinicDao"%>
<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>
<%@page import="com.gp.user.PersonDao"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
int clinicId = (Integer)request.getAttribute("clinicId");

Clinic clinic = ClinicDao.getClinicById(clinicId);

String title = clinic.getClinicName(); 
%>
<%@include  file="../includes/header.jsp" %>
<% 

Calendar calendar = Calendar.getInstance();
Date today = Calendar.getInstance().getTime();

SimpleDateFormat tableFormat = new SimpleDateFormat("E d/M");
String todayInTableFormat = tableFormat.format(today);

SimpleDateFormat todayFormat = new SimpleDateFormat ("yyyy-MM-dd");
String todayInMyFormat = todayFormat.format(today);

HashMap<String,Appointment> apps = ClinicDao.getAppointmentOfClinic(clinicId);

String[] days		 = new String[7];
String[] daySelect	 = new String[7];
DateFormat dayFormat = new SimpleDateFormat("E");
days[0]				 = dayFormat.format(today);
daySelect[0]		 = tableFormat.format(today);
boolean showForm = false;
String username = (String)session.getAttribute("username");
User user = new User();
if(username != null){
	user = UserDao.getUserByUsername(username);
	if(PersonDao.canPersonBook(user.getId())){
		request.setAttribute("limitExceed", " ");
	}else{
		request.setAttribute("limitExceed", "<p class=\"wrong-input wrong-input-register-page-1\">" + t.write("Sorry you have reached the maximum number of bookings per day(3)") + "</p>");
	}
	if(user.getType().equalsIgnoreCase("person")){
		showForm = true;
	}
}
%>
    <!-- Preloader -->
    <div id="preloader">
        <div class="medilife-load"></div>
    </div>
    
    <input type="hidden" id="clinicId" value="<%= clinic.getClinicId() %>">
    <input type="hidden" id="userId" value="<%= user.getId() %>">
    <section class="breadcumb-area bg-img gradient-background-overlay" style="background-image: url(/user/layout/images/profiles/bg-img/breadcumb2.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="breadcumb-content">
                        <h3 class="breadcumb-title"><%= t.write(clinic.getClinicName()) %></h3>
                        <p class="breadcumb-intro"><%= t.write(clinic.getIntro()) %></p>
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
                    <div class="col-sm-12 alert alert-info text-center booking-alert"><%= t.write("to book please") %> <a href="/HealthTrack/login" target="_blank">Login</a> First or <a href="/HealthTrack/signup">Register</a></div>
                     <% } %>
                <div class="col-12">
                    <div class="appointment-form-content">
                        <div class="row no-gutters align-items-center">
                            <div class="col-12 col-lg-9 col-md-6">
                             <div class="my-table text-center my-table-clinic">
                             <div class="unbooked-slots pull-left"></div><span><%= t.write("available session") %></span>
                            <table class="table table-bordered">
                    
                        <thead>
                            <tr class="table-head">
                            	<th><%= t.write("date") %></th>
                                <th><%= todayInTableFormat %></th>
                                <% for(int i=1; i<7; i++){
                                		calendar.add(Calendar.DAY_OF_MONTH, 1);
                                		Date d = calendar.getTime();
                                		String nextDay = tableFormat.format(d);
                                		days[i] = dayFormat.format(d);                                		
                                 %>
                                	<th class="${booked}"><%= nextDay %></th>
                               <% }
                                request.setAttribute("days", days);
                                %>
                            </tr>
                          </thead>
                        <tbody>
                            <tr>
                              <td class="another-table-head"><%= t.write("from") %></td>
                              <c:forEach var="day" items="${days}">
                              <% String singleDay = (String)pageContext.getAttribute("day");
                              	 Appointment A = apps.get(singleDay.toLowerCase());
                              	if(A.getBookedSessions() >= clinic.getNumOfSessions()){
                        			request.setAttribute("booked", "booked");
                        		}else{
                        			request.setAttribute("booked", "");
                        		}
                              	 if(A.getAppFrom() != null){
                              	 %>
                              	 <td class="${booked}"><%= A.getAppFrom().toLocalTime() %></td>
                              	 <% }else{ %>
                              	 	<td class="booked"></td>
                              	 <% } %>
                              </c:forEach>
                          </tr>
                          <tr>
                             <td class="another-table-head"><%= t.write("to") %>To</td>
                              <c:forEach var="day" items="${days}">
                              <% String singleDay = (String)pageContext.getAttribute("day");
                              	 Appointment A = apps.get(singleDay.toLowerCase());
                              	if(A.getBookedSessions() >= clinic.getNumOfSessions()){
                        			request.setAttribute("booked", "booked");
                        		}else{
                        			request.setAttribute("booked", "");
                        		}
                              	 if(A.getAppFrom() != null){
                              	 %>
                              	 <td class="${booked}"><%= A.getAppTo().toLocalTime() %></td>
                              	 <% }else{ %>
                              	 	<td class="booked"></td>
                              	 <% } %>
                              </c:forEach>
                          </tr>                           
                        </tbody>
                    </table>
                    </div>
                                <div class="medilife-appointment-form medilife-appointment-form-clinic">
                                ${invalidName} ${invalidPhone} ${invalidmsg} ${invalidEmail} ${limitExceed}
                                    <form action="/HealthTrack/clinic/<%= clinicId %>/BookingClinic/Submit" method="post">
                                    	<input type="hidden" value="<%= user.getId() %>" name="userId">
                                        <div class="row align-items-end">
                                            <div class="col-12 col-md-3">
                                                <div class="form-group">
                                                    <input type="text" class="form-control border-top-0 border-right-0 border-left-0" name="firstName" id="name" placeholder="<%= t.write("first name") %>" value="${oldFirstName}" required="required">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-3">
                                                <div class="form-group">
                                                    <input type="text" class="form-control border-top-0 border-right-0 border-left-0" name="lastName" id="name" placeholder="<%= t.write("last name") %>"value="${oldLastName}" required="required">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-3">
                                                <div class="form-group">
                                                    <input type="number" max = "120" class="form-control" name="age" placeholder="<%= t.write("age") %>" min="0" maxlength="2" value="${oldAge}" required="required">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-3">
                                                <div class="form-group">
                                                	<select class="form-control" name="sex">
                                                		<option value="male"><%= t.write("male") %></option>
                                                		<option value="female"><%= t.write("female") %></option>
                                                	</select>
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-4">
                                                <div class="form-group">
                                                    <select name="date" class="form-control" required="required">                                                    
                                                    	<c:forEach var="day" items="${days}">
                                                    		<% 
                                                    			String singleDay = (String)pageContext.getAttribute("day");
                                                         	 	Appointment A = apps.get(singleDay.toLowerCase());
                                                         	 	String finalFormat = tableFormat.format(A.getDayDate());
                                                         	 	if(A.getAvailable()==1 && A.getBookedSessions() < clinic.getNumOfSessions()){
                                                    		%>
                                                    			<option value="<%= A.getDayDate() %>"><%= finalFormat %></option>
                                                    		<% } %>
                                                    	</c:forEach>                                                    
                                                   	</select>
                                                </div>
                                            </div>
                                            
                                            <div class="col-12 col-md-4">
                                                <div class="form-group">
                                                    <input type="text" class="form-control border-top-0 border-right-0 border-left-0" name="phone" placeholder="<%= t.write("phone") %>" value="${oldPhone}" required="required">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-4">
                                                <div class="form-group">
                                                    <input type="email" class="form-control border-top-0 border-right-0 border-left-0" name="email" id="email" placeholder="<%= t.write("email") %>" value="${oldEmail}" required="required">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-12">
                                                <div class="form-group mb-0">
                                                    <textarea name="msg" class="form-control mb-0 border-top-0 border-right-0 border-left-0" cols="30" rows="10" placeholder="<%= t.write("message") %>">${oldmsg}</textarea>
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-4 mb-0">
                                                <div class="form-group mb-0">
                                                    <button type="submit" class="btn medilife-btn medilife-btn-appointment"><%= t.write("make an appointment") %><span>+</span></button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div class="col-12 col-lg-3">
                                <div class="medilife-contact-info medilife-contact-info-clinic">
                                    <!-- Single Contact Info -->
                                    <div class="single-contact-info mb-30">
                                        <div class="single-contact-info-icon"><i class="fas fa-user-md fa-3x"></i></div>
                                        <p><%= t.write(clinic.getClinicName()) %></p>                                        
                                    </div>
                                    <div class="single-contact-info mb-30">
                                    	<div class="single-contact-info-icon"><i class="fa fa-phone fa-3x"></i></div>
                                        <p><%= clinic.getPhone() %></p>
                                    </div>
                                    <div class="single-contact-info">
                                        <div class="single-contact-info-icon"><i class="fas fa-globe fa-3x"></i></div>
                                        <p> <%= t.write(clinic.getAddress()) %></p>
                                    </div><br><br>
                                    <div class="single-contact-info">
                                        <div class="single-contact-info-icon"><i class="fas fa-money-bill-alt fa-3x"></i></div>
                                        <p><%= clinic.getFees() %></p>
                                    </div><br><br>
                                    <div class="single-contact-info">
                                        <div class="single-contact-info-icon"><i class="far fa-star fa-3x"></i></div>
                                        <p><%= Math.round(clinic.getReview()*10.0)/10.0 %></p>
                                    </div>                                   
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="review clinic-review">            
	            <div class="overlay">
	           		<h2 class="text-center"><%= t.write("rate this service") %></h2>
	           		<div class="row">
	           			<div class="col-sm-offset-2 col-sm-4 rateYo">
	           				<div id="rateYo"></div>	
	           				<div id="reviewSucceeded" class="reviewSucceeded "><%= t.write("thanks for your opinion") %> <i class="fas fa-smile"></i></div>           				
	           				<div id="reviewFailed" class="reviewFailed"><%= t.write("please login first") %> <i class="fas fa-frown"></i></div>           				
	           				
	           			</div>
	           			<form class="review-form" method="post" action="/healthTrack/clinic/review/<%= clinic.getClinicId() %>/<%= user.getId() %>/comment">
	           						<div class="col-sm-offset-2 col-sm-8 col-xs-12">
	           							<div class="form-group">
	           								<textarea class="form-control mb-0 border-top-0 border-right-0 border-left-0" rows="10" name="comment" placeholder="<%= t.write("write comments") %>" maxlength="500"></textarea>
	           								${invalidComment} ${commentsLimitExceeded} ${commentLoginFirst}
	           						<div class="">
	           							<div class="form-group">
	           								<button type="submit" class="btn btn-success form-group col-xs-12"> <i class="fas fa-location-arrow"></i> <%= t.write("submit your comment") %></button>
	           							</div>
	           						</div>
	           							</div>
	           						</div>
	           				</form>
	           		</div>
	            </div>    
            </div>
        </div>
    </div>
    <!-- ***** Book An Appoinment Area End ***** -->

<div id="map" class="hospital-map"></div>

	<script>
      function hospitalMarker() {
        var uluru = {lat: <%= clinic.getLat() %>, lng: <%= clinic.getLang() %>};
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
    <%@include  file="../includes/footer.jsp" %>