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
<%@page import="java.util.HashMap"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.sql.Time"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	HttpSession hospitalSession = request.getSession();
	int serviceId = (Integer)request.getAttribute("serviceId");
	String place = (String)request.getAttribute("place");
	Service S = ServiceDao.getServiceById(serviceId, place);
	String title=S.getServiceName(); %>

<%@include  file="../includes/header.jsp" %>

<% 	boolean showComment =false ;
	boolean showForm = false;
	User user = new User();
	String usernameSession = (String)hospitalSession.getAttribute("username");
	if(usernameSession != null){
		user = UserDao.getUserByUsername(usernameSession);
		if(user.getType().equalsIgnoreCase("person")){
			showForm = true;
		}
		if((user.getType().equalsIgnoreCase("hospital")) || (user.getType().equalsIgnoreCase("center"))){
			showComment=true ;
		}
		if(PersonDao.canPersonBook(user.getId())){
			request.setAttribute("limitExceed", " ");
		}else{
			request.setAttribute("limitExceed", "<p class=\"wrong-input wrong-input-register-page-1\">" + t.write("Sorry you have reached the maximum number of bookings per day(3)") + "</p>");
		}
	}
	
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
		request.setAttribute("hideCalendar", "");
	}else if(S.getSlotType() == 2){
		request.setAttribute("hideCalendar", "hidden");
		request.setAttribute("hideTable", "");
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
	HashMap<String, String> daysAsHashMap = new HashMap<String, String>();
	String[] days = new String[7];
	HashMap<String , List<String>> times = new HashMap<String , List<String>>();
	times.put("Sat",  new ArrayList<String>());
	times.put("Sun",  new ArrayList<String>());
	times.put("Mon",  new ArrayList<String>());
	times.put("Tue",  new ArrayList<String>());
	times.put("Wed",  new ArrayList<String>());
	times.put("Thu",  new ArrayList<String>());
	times.put("Fri",  new ArrayList<String>());
	DateFormat dayFormat = new SimpleDateFormat("E");
	DateFormat weekDateFormat = new SimpleDateFormat("d/M");
	days[0] = dayFormat.format(today);
	daysAsHashMap.put(days[0], weekDateFormat.format(today));
	DateFormat midNightFormat = new SimpleDateFormat("HH:mm");
	Time midNight = new Time(midNightFormat.parse("00:00").getTime());
	LocalTime localMidNight = midNight.toLocalTime();

%>

<input type="hidden" id="serviceId" value="<%= S.getServiceId() %>">
<%
	if(place.equalsIgnoreCase("hospital")){ %>
		<input type="hidden" id="placeId" value="<%= S.getHospitalId() %>">
		<input type="hidden" id="place" value="hospital">
	 <% }else{ %>
	 		<input type="hidden" id="placeId" value="<%= S.getCenterId() %>">
	 		<input type="hidden" id="place" value="center">
	 <% } %>

<!-- Preloader -->
    <div id="preloader">
        <div class="medilife-load"></div>
    </div>
    
    <section class="breadcumb-area bg-img gradient-background-overlay" style="background-image: url(/user/layout/images/profiles/bg-img/breadcumb2.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="breadcumb-content">
                        <h3 class="breadcumb-title text-capitalize"><%= t.write(S.getServiceName()) %></h3>
                        <p class="breadcumb-intro"><%= t.write(S.getIntro()) %></p>
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
                    <div class="col-sm-12 alert alert-info text-center booking-alert text-capitalize"><%= t.write("to book please") %> <a href="/HealthTrack/login" target="_blank"><%= t.write("login") %></a><%= t.write("first or") %> <a href="/HealthTrack/signup"><%= t.write("register") %></a></div>
                     <% } %>
                     <div class="col-12">
                    <div class="appointment-form-content">
                        <div class="row no-gutters align-items-center">
                            <div class="col-12 col-lg-9 col-md-6">
                             <div class="my-table text-center ${hideTable}">
                             <div class="unbooked-slots pull-left"></div><span><%= t.write("available session") %></span>
                            <table class="table table-bordered">
                            <thead>
                            <tr class="table-head  text-capitalize">
                                <th><%= t.write(todayInTableFormat) %></th>
                                <% for(int i=1; i<7; i++){
                                		tableCalendar.add(Calendar.DAY_OF_MONTH, 1);
                                		Date d = tableCalendar.getTime();
                                		String nextDay = tableFormat.format(d);
                                		days[i] = dayFormat.format(d);
                                		daysAsHashMap.put(days[i], weekDateFormat.format(d));
                                 %>
                                	<th><%= t.write(nextDay) %></th>
                               <% }  %>
                                                    
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
                        	
                        	Time newTimeFrom = Time.valueOf(localTimeFrom);
                        	
                        	LocalTime localTimeTo = ap.getAppTo().toLocalTime();
                        	
                        	int thisYear		= Calendar.getInstance().get(Calendar.YEAR);
                    		String day		 	= daysAsHashMap.get(days[j])+"/"+thisYear;
                    		day 				= day.replace("/", "-");
                    		
                    		String[] explodedDay = day.split("-");
                    		if(explodedDay[0].length()<2){
                    			explodedDay[0] = 0 + explodedDay[0];
                    		}
                    		if(explodedDay[1].length()<2){
                    			explodedDay[1] = 0 + explodedDay[1];
                    		}
                    		day = explodedDay[2]+"-"+explodedDay[1]+"-"+explodedDay[0];  
                           	if(localTimeFrom.isAfter(localTimeTo) || localTimeFrom.equals(localTimeTo) || localTimeFrom.equals(localMidNight) ||  ap.getAvailable() == 0 ){
                           		finalFormat = " ";           
                           		request.setAttribute("booked", "booked");
                           	}else if(ServiceDao.checkTimeBooking(serviceId, day, newTimeFrom)){
                           		request.setAttribute("booked", "booked");
                           		finalFormat = localTimeFrom.toString();                        		
                           	}else{
                           		finalFormat = localTimeFrom.toString();
                        		List<String> tempTimes = new ArrayList<String>();
                        		tempTimes = times.get(days[j]);
                        		tempTimes.add(finalFormat);
                        		times.replace(days[j], tempTimes);
                           		request.setAttribute("booked", " ");
                           	}                         	                           	                 	                           	
                        	%>              		 
                        	<td class="${booked}"><%= t.write(finalFormat) %></td>                       		
                        <% 
                        }                                               
                        %>
                        		</tr>
                        <% }
                           request.setAttribute("times", times);
                           %>
                                                 
                        </tbody>
                    </table> 
                   
                    </div>
                    <div class=" ${hideCalendar}"><div class="calendar " id='calendar'></div></div>
                                <div class="medilife-appointment-form">
                                ${invalidName} ${invalidPhone} ${invalidDate} ${invalidmsg} ${invalidEmail} ${invalidTime} ${limitExceed}
                                    <form class="${hideCalendar}" method="post" action="/HealthTrack/<%= place %>/Service/<%=S.getServiceId() %>/BookingDay/Submit">
                                    <input type="hidden" value="<%= user.getId() %>" name="userId" id="userId">
                                        <div class="row align-items-end">
                                            <div class="col-12 col-md-3">
                                                <div class="form-group">
                                                    <input type="text" class="form-control border-top-0 border-right-0 border-left-0" required maxlength="15" name="firstName" id="name" placeholder="<%= t.write("first name") %>" value="${oldFirstName}">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-3">
                                                <div class="form-group">
                                                    <input type="text" class="form-control border-top-0 border-right-0 border-left-0" required maxlength="15" name="lastName" id="name" placeholder="<%= t.write("last name") %>" value="${oldLastName}">
                                                </div>
                                            </div>
                                           
                                            <div class="col-12 col-md-3">
                                                <div class="form-group">
                                                    <input type="number" class="form-control border-top-0 border-right-0 border-left-0" required name="age" placeholder="<%= t.write("age") %>"  required min="0" max = "120" value="${oldAge}">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-3">
                                                <div class="form-group">
                                                    <select class="form-control border-top-0 border-right-0 border-left-0" required name="sex">
                                                    	
                                                    	<option value="male"><%= t.write("male") %></option>
                                                    	<option value="female"><%= t.write("female") %></option>
                                                    
                                                    </select>
                                                </div>
                                            </div>
                                                                                        
                                            <div class="col-12 col-md-6">
                                                <div class="form-group">
                                                    <input type="text" class="form-control border-top-0 border-right-0 border-left-0" name="phone" required maxlength="11" id="number" placeholder="<%= t.write("phone") %>" value="${oldPhone}">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <div class="form-group">
                                                    <input type="email" class="form-control border-top-0 border-right-0 border-left-0" name="email" id="email" placeholder="<%= t.write("email") %>" value="${oldEmail}">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-6 booking-form-label">
                                                <div class="form-group">
                                                	<label><%= t.write("from:") %></label> 
                                                </div>
                                             </div>
                                             <div class="col-12 col-md-6 booking-form-label">
                                                <div class="form-group">
                                                	<label><%= t.write("to:") %></label> 
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <div class="form-group">
                                                    <input type="date" class="form-control" required name="bookFrom" id="date" placeholder="<%= t.write("date") %>" min="<%= todayInMyFormat %>" value="<%= todayInMyFormat %>">
                                                </div>
                                            </div>
                                           
                                            <div class="col-12 col-md-6">
                                                <div class="form-group">
                                                    <input type="date" class="form-control" required name="bookTo" id="date" placeholder="<%= t.write("date") %>" min="<%= todayInMyFormat %>" value="<%= todayInMyFormat %>">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-12">
                                                <div class="form-group mb-0">
                                                    <textarea name="msg" class="form-control mb-0 border-top-0 border-right-0 border-left-0" id="message" cols="30" rows="10" placeholder="<%= t.write("message") %>" maxlength="500">${oldmsg}</textarea>
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-4 mb-0">
                                                <div class="form-group mb-0">
                                                    <button type="submit" class="btn medilife-btn medilife-btn-appointment text-capitalize"><%= t.write("make an appointment") %><span>+</span></button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                    <form class="${hideTable}" method="post" action="/HealthTrack/<%= place %>/Service/<%=S.getServiceId() %>/BookingTime/Submit">
                                    <input type="hidden" value="<%= user.getId() %>" name="userId">
                                        <div class="row align-items-end">
                                            <div class="col-12 col-md-3">
                                                <div class="form-group">
                                                    <input type="text" class="form-control border-top-0 border-right-0 border-left-0" required maxlength="15" name="firstName" id="name" placeholder="<%= t.write("first name") %>" value="${oldFirstName}">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-3">
                                                <div class="form-group">
                                                    <input type="text" class="form-control border-top-0 border-right-0 border-left-0" required maxlength="15" name="lastName" id="name" placeholder="<%= t.write("last name") %>" value="${oldLastName}">
                                                </div>
                                            </div>
                                           
                                            <div class="col-12 col-md-3">
                                                <div class="form-group">
                                                    <input type="number" class="form-control border-top-0 border-right-0 border-left-0" required name="age" placeholder="<%= t.write("age") %>"  required min="0" max = "120" value="${oldAge}">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-3">
                                                <div class="form-group">
                                                    <select class="form-control border-top-0 border-right-0 border-left-0 text-capitalize" required name="sex">
                                                    	
                                                    	<option value="male"><%= t.write("male") %></option>
                                                    	<option value="female"><%= t.write("female") %></option>
                                                    
                                                    </select>
                                                </div>
                                            </div>
                                                                                        
                                            <div class="col-12 col-md-6">
                                                <div class="form-group">
                                                    <input type="text" class="form-control border-top-0 border-right-0 border-left-0" name="phone" required maxlength="11" id="number" placeholder="<%= t.write("phone") %>" value="${oldPhone}">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <div class="form-group">
                                                    <input type="email" class="form-control border-top-0 border-right-0 border-left-0" name="email" id="email" placeholder="<%= t.write("email") %>" value="${oldEmail}">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-6 booking-form-label text-capitalize">
                                                <div class="form-group">
                                                	<label><%= t.write("day:") %></label> 
                                                </div>
                                             </div>
                                             <div class="col-12 col-md-6 booking-form-label text-capitalize">
                                                <div class="form-group">
                                                	<label><%= t.write("time:") %></label> 
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <div class="form-group">
                                                	<select required id="day-select" name="day" class="form-control">
                                                			<option id="Sat" value="<%=  daysAsHashMap.get("Sat") %>" <% if(days[0].equalsIgnoreCase("Sat")){%> selected <% } %>><%= t.write("sat") %> &ensp; <%=  daysAsHashMap.get("Sat") %></option>
                                                			<option id="Sun" value="<%=  daysAsHashMap.get("Sun") %>" <% if(days[0].equalsIgnoreCase("Sun")){%> selected <% } %>><%= t.write("sun") %> &ensp; <%=  daysAsHashMap.get("Sun") %></option>
                                                			<option id="Mon" value="<%=  daysAsHashMap.get("Mon") %>" <% if(days[0].equalsIgnoreCase("Mon")){%> selected <% } %>><%= t.write("mon") %> &ensp; <%=  daysAsHashMap.get("Mon") %></option>
                                                			<option id="Tue" value="<%=  daysAsHashMap.get("Tue") %>" <% if(days[0].equalsIgnoreCase("Tue")){%> selected <% } %>><%= t.write("tue") %> &ensp; <%=  daysAsHashMap.get("Tue") %></option>
                                                			<option id="Wed" value="<%=  daysAsHashMap.get("Wed") %>" <% if(days[0].equalsIgnoreCase("Wed")){%> selected <% } %>><%= t.write("wed") %> &ensp; <%=  daysAsHashMap.get("Wed") %></option>
                                                			<option id="Thu" value="<%=  daysAsHashMap.get("Thu") %>" <% if(days[0].equalsIgnoreCase("Thu")){%> selected <% } %>><%= t.write("thu") %> &ensp; <%=  daysAsHashMap.get("Thu") %></option>
                                                			<option id="Fri" value="<%=  daysAsHashMap.get("Fri") %>" <% if(days[0].equalsIgnoreCase("Fri")){%> selected <% } %>><%= t.write("fri") %> &ensp; <%=  daysAsHashMap.get("Fri") %></option>
                                                	</select>
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <div class="form-group">
                                                	<select required id="time-select" name="time" class="form-control">
                                                		<option value="0" class="text-capitalize"><%= t.write("choose time") %></option>
                                                	<c:forEach var="time" items="${times}">
                                                    	<c:forEach var="list" items="${time.value}">                                                    	
                                                    		<option class="${time.key} hidden" value="${list}">${list}</option>
                                                		</c:forEach>
                                                	</c:forEach>
                                                	</select>
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-12">
                                                <div class="form-group mb-0">
                                                    <textarea name="msg" class="form-control mb-0 border-top-0 border-right-0 border-left-0" id="message" cols="30" rows="10" placeholder="Message" maxlength="500">${oldmsg}</textarea>
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-4 mb-0">
                                                <div class="form-group mb-0">
                                                    <button type="submit" class="btn medilife-btn medilife-btn-appointment"><%= t.write("make an appointment") %> <span>+</span></button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <% 
                                        if(S.getHospitalName() == null){
                                        	request.setAttribute("placeName", S.getCenterName());
                                        }else{
                                        	request.setAttribute("placeName", S.getHospitalName());
                                        }
                                        %>
                            <div class="col-12 col-lg-3">
                                <div class="medilife-contact-info">
                                    <!-- Single Contact Info -->
                                     <div class="single-contact-info mb-30">
                                     <div class="single-contact-info-icon"><i class="fas fa-h-square fa-3x"></i></div>
                                        <p><%= t.write(request.getAttribute("placeName").toString()) %></p>
                                    </div>
                                    <!-- Single Contact Info -->
                                    <div class="single-contact-info mb-30">
                                    	<div class="single-contact-info-icon"><i class="fa fa-phone fa-3x"></i></div>
                                        <p><%= S.getPhone() %></p>
                                    </div>
                                    <!-- Single Contact Info -->
                                    <div class="single-contact-info">
                                        <div class="single-contact-info-icon"><i class="fas fa-globe fa-3x"></i></div>
                                        <p> <%= t.write(S.getAddress()) %></p>
                                    </div>
                                    <!-- Single Contact Info -->
                                    <div class="single-contact-info">
                                        <div class="single-contact-info-icon"><i class="fas fa-money-bill-alt fa-3x"></i></div>
                                        <p><%= S.getFees() %></p>
                                    </div><br><br>
                                    <!-- Single Contact Info -->
                                    <div class="single-contact-info">
                                        <div class="single-contact-info-icon text-capitalize"><i class="fas fa-map-marker-alt fa-3x"></i></div>
                                        <p><%= t.write("find the location google maps")%></p>
                                    </div>
                                    <!-- Single Contact Info -->
                                    <div class="single-contact-info">
                                        <div class="single-contact-info-icon"><i class="far fa-star fa-3x"></i></div>
                                        <p><%= Math.round(S.getServiceReview()*10.0)/10.0 %></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
                        
            <div class="review service-review">            
	            <div class="overlay">
	           		<h2 class="text-center text-capitalize"><%= t.write("rate this service") %></h2>
	           		<div class="row">
	           			<div class="col-sm-offset-2 col-sm-4 rateYo">
	           				<div id="rateYo"></div>	
	           				<div id="reviewSucceeded" class="reviewSucceeded "><%= t.write("thanks for your opinion") %> <i class="fas fa-smile"></i></div>           				
	           				<div id="reviewFailed" class="reviewFailed"><%= t.write("please login first") %> <i class="fas fa-frown"></i></div>           				
	           				
	           			</div>
	           			<form class="review-form" method="post" action="/healthTrack/Service/<%= place %>/review/<%= S.getServiceId() %>/<%= user.getId() %>/comment">
	           						<div class="col-sm-offset-2 col-sm-8 col-xs-12">
	           							<div class="form-group">
	           								<textarea class="form-control mb-0 border-top-0 border-right-0 border-left-0" rows="10" name="comment" placeholder="<%= t.write("write comments") %>...." maxlength="500"></textarea>
	           								${invalidComment} ${commentsLimitExceeded} ${commentLoginFirst}
	           						<div class="">
	           							<div class="form-group">
	           								<button type="submit" class="btn btn-success form-group col-xs-12"> <i class="fas fa-location-arrow"></i><%= t.write("submit your comment") %></button>
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
    <%  if(showComment){%>
  
     <a href="/HealthTrack/admin/<%=usernameSession%>/<%=S.getServiceId()%>/<%=place%>/showComments" class="btn btn-primary"><i class="fa fa-plus"></i> Show Comments</a>
     <a href="/HealthTrack/admin/<%=usernameSession%>/<%=S.getServiceId()%>/<%=place%>/showBookings" class="btn btn-primary"><i class="fa fa-plus"></i> Show Bookings</a>
   <% }%>
    <!-- ***** Book An Appoinment Area End ***** -->
    
    <div id="map" class="hospital-map"></div>

                <% if(user.getId()== S.getAdminId()){
                
                	List<Booking> bookings = BookingDao.getBookingsByServiceId(serviceId);
                	
                	request.setAttribute("bookings", bookings);
                
                %>
                	

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

    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCF4-LBT961bTAMeLJr6Pt1-b9FOjljREg&callback=hospitalMarker">
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