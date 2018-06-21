<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>
<%@page import="com.gp.user.Hospital"%>
<%@page import="com.gp.user.HospitalDao"%>
<%@page import="com.gp.user.Service"%>
<%@page import="com.gp.user.ServiceDao"%>
<%@page import="com.gp.user.Center"%>
<%@page import="com.gp.user.CenterDao"%>
<%@page import="com.gp.user.Clinic"%>
<%@page import="com.gp.user.ClinicDao"%>
<%@page import="com.gp.user.Pharmacy"%>
<%@page import="com.gp.user.PharmacyDao"%>
<%@page import="com.gp.user.Booking"%>
<%@page import="com.gp.user.BookingDao"%>
<%@page import="com.gp.user.Department"%>
<%@page import="com.gp.user.Review"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% // HttpSession hospitalSession = request.getSession();
	int ServiceId = (Integer)(request.getAttribute("serviceId"));
	String place = (String)request.getAttribute("place");
    Service S = ServiceDao.getServiceById(ServiceId, place);
	String title=S.getServiceName()+" comments";
/*
String title = "comments";
    int ServiceId=(Integer)request.getAttribute("serviceId"); 
    String place =(String)request.getAttribute("place");
    Service service = ServiceDao.getServiceById(ServiceId, place);
    */
    //service =ServiceDao.getServiceById(ServiceId);
    request.setAttribute("service", S);
   
	String username = (String)session.getAttribute("username");
	
	String placeName = "" ;
	String placeType ="";
	int placeId;
	
	if(username != null){
		User user = UserDao.getUserByUsername(username);
		int userId= user.getId();
		
		if(user.getType().equalsIgnoreCase("center")){
			
			placeType ="center";
			Center center  = new Center();
			center         = CenterDao.getCenterById(userId);
			placeId        = center.getCenterId();
			placeName      = center.getCenterName();
		//	services       =ServiceDao.getServicesOfCenter(placeId);
			
		}else if (user.getType().equalsIgnoreCase("hospital")){
			placeType          ="hospital";
			Hospital hospital  =new Hospital();
			hospital           = HospitalDao.getHospitalById(userId);
			placeId            = hospital.getHospitalId();
			placeName          =hospital.getHospitalName();	
			//services           =ServiceDao.getServicesOfHospital(placeId);

		}
	
		request.setAttribute("userId", userId);
		request.setAttribute("placeType",placeType);
		request.setAttribute("placeName", placeName);
			
		}
%>

<%@include  file="../includes/header.jsp" %>

        <div class="breadcrumbs">
            <div class="col-sm-4">
                <div class="page-header float-left">
                    <div class="page-title">
                        
                    </div>
                </div>
            </div>
            <div class="col-sm-8">
                <div class="page-header float-right">
                    <div class="page-title">
                        <ol class="breadcrumb text-right">
                           
                            <li>Comments</li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>

        <div class="content mt-3">
            <div class="animated fadeIn">
                <div class="row">

                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <strong class="card-title">Data Table</strong>
                        </div>
                        <div class="card-body">
                  <table id="bootstrap-data-table" class="table table-striped table-bordered">
                    <thead>
                      <tr>
                      	
                        <th>Service Name</th>
    
                      </tr>
                    </thead>
                    <tbody>
                        
                      	<tr>
                        <td><a href="/HealthTrack/profile/service/${placeType}/<%=S.getServiceId() %>" target="_blank"><%=S.getServiceName() %></a></td>
                       <td>
                       <div class="dept-in-hospital-table">
                        <table id="bootstrap-data-table" class="table table-striped table-bordered">
                        <thead>
                        <tr>
                        <th>Patient Name</th>
                        <th>Date</th>
                        <th>time of Booking</th>
                        <th>Patient phone</th>
                        <th>Action</th>
                        <th>Delete</kth>
                        </tr>
                        </thead>
                        
                        <tbody>
                          <%
                        List<Booking> bookings =new ArrayList<Booking>();
                        bookings=BookingDao.getBookingsByServiceId(S.getServiceId());
                        request.setAttribute("bookings",bookings);
                        %>
                        <c:forEach var="booking" items="${bookings}">
                        <tr>
                      
                        <td><a href="/HealthTrack/profile/user/${booking.userId}" target="_blank">${booking.firstName} ${booking.lastName}</a></td>
                         <td class="depts-td">From:${booking.dateFrom} ${booking.timeFrom}>>>
                          To:${booking.dateTo}</td>
                          <td>${booking.timeOfBooking}</td>
                          <td>${booking.bookingPhone}</td>
                          <% 
                      	    Booking booking = (Booking)pageContext.getAttribute("booking");
            
                      	%>
                          <td>
                           
                         
                         <%if(booking.getStatus()==0){ %>
                       <a href="/HealthTrack/booking/confirm/${userId}/${booking.bookingId}/<%=S.getServiceId()%>/${placeType}/showBookings" class="btn btn-success confirm-verify-booking">Confirm</a>
                       
                        <%}else{ %>
                        <a href="/HealthTrack/booking/unconfirm/${userId}/${booking.bookingId}/<%=S.getServiceId()%>/${placeType}/showBookings" class="btn btn-warning confirm-unverify-booking">UnConfirm</a>
                       
                        <%} %>
                          </td>
                          <td><a class="dashboard-btn confirm-delete-hospital" href="/HealthTrack/admin/<%=username %>/<%=S.getServiceId() %>/${placeType}/booking/delete/${booking.bookingId}/showBookings" title="Delete this booking"><i class="fa fa-close"></i></a></td>
                      
                        </tr>
                        </c:forEach>
                        </tbody>
                        </table>
                        </div>
                       <td>
                      </tr>                  
                    </tbody>
                  </table>
                        </div>
                    </div>
                    
                </div>

                </div>
            </div><!-- .animated -->
        </div><!-- .content -->

    </div><!-- /#right-panel -->

    <!-- Right Panel -->


    <%@include  file="../includes/footer.jsp" %>