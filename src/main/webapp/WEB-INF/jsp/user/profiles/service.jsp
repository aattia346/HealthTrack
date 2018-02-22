<%@page import="com.gp.user.Department"%>
<%@page import="com.gp.user.Service"%>
<%@page import="com.gp.user.ServiceDao"%>
<%@page import="com.gp.user.HospitalDao"%>
<%@page import="com.gp.user.Hospital"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<% 	
	String title="Service"; 

	HttpSession hospitalSession = request.getSession();
	int serviceId = (Integer)hospitalSession.getAttribute("serviceId");
	
	Service S = ServiceDao.getServiceById(serviceId);
	
	Calendar calendar = Calendar.getInstance();
	calendar.setTime(S.getBookedTill());
	calendar.add(Calendar.DAY_OF_MONTH, 2);	
	Date bookFrom = calendar.getTime();
	
	SimpleDateFormat bookFromFormat = new SimpleDateFormat ("yyyy-MM-dd");
	String bookFromInMyFormat = bookFromFormat.format(bookFrom);
	
	calendar.add(Calendar.DAY_OF_MONTH, 1);
	Date bookTo = calendar.getTime();
	String bookToInMyFormat = bookFromFormat.format(bookTo);
	
	SimpleDateFormat bookedTillFormat = new SimpleDateFormat ("E yyyy-MM-dd");
	String bookedTillInMyFormat = bookedTillFormat.format(bookFrom);

%>
<%@include  file="../includes/header.jsp" %>

<div class="hospital-body">
        	<input type="hidden" class="booking-date" required  value="<%= bookFromInMyFormat %>">
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
                
                <div class="col-sm-12 hospital-depts service-booking">
                    <h3 class="text-center">Book ICU</h3>
                    <form method="post" action="#">
                        
                        <div class="col-sm-6 personal-info">
                    
                            <div class="form-group name">
                                    <input type="text" class="form-control input-sm" name="firstName" placeholder="First Name" required> 

                                    <input type="text" class="form-control input-sm" name="lastName" placeholder="Last Name" required> 
                            </div>
                            <div class="form-group">
                                    <input type="number" class="form-control input-sm" name="age" placeholder="Age" required> 
                            </div>
                            <div class="form-group">
                                    <input type="email" class="form-control input-sm" name="email" placeholder="Enter Valid Email" required> 
                            </div>
                            <div class="form-group">
                                    <input type="text" class="form-control input-sm" name="phone" placeholder="Phone Number(optional)"> 
                            </div>
                        
                            <div class="hospital-info">
                                <h4 class="about-title">Booked Till: </h4><p class="about-detail"><%= bookedTillInMyFormat %></p><p class="last-updated pull-right">last updated: 10/1/2018</p>
                            </div>
                            <div>
                                <h4 class="about-title">Book From: </h4>
                                <input type="date" class="booking-date" required  min="<%= bookFromInMyFormat %>" value="<%= bookFromInMyFormat %>">
                            </div>  
                            <div>
                                <h4 class="about-title">To: </h4>
                                <input type="date" class="booking-date" required min="<%= bookFromInMyFormat %>" value="<%= bookToInMyFormat %>">
                            </div>
                        </div>
                        <div class="col-sm-6 calendar" id='calendar'></div>

                        <div class="form-group">
                            <input type="submit" class="form-control input-sm  btn btn-primary"> 
                        </div>
                    </form>
                    
                </div>

            </div>
        </div>
        
	 
<%@include  file="../includes/footer.jsp" %>