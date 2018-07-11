<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>
<%@page import="com.gp.user.Booking"%>
<%@page import="com.gp.user.BookingDao"%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% 	String title = "TimeSlotBooking";
	String username = (String)session.getAttribute("username");
	User admin = UserDao.getUserByUsername(username);
	List<Booking> bookings = new ArrayList<Booking>();
	bookings=BookingDao.getBookingTimeOrDaySlot(2);	
	request.setAttribute("bookings", bookings);

%>
<%@include  file="includes/header.jsp" %>

        <div class="breadcrumbs">
            <div class="col-sm-4">
                <div class="page-header float-left">
                    <div class="page-title">
                        <h1><%=t.write("Dashboard",lang) %></h1>
                    </div>
                </div>
            </div>
            <div class="col-sm-8">
                <div class="page-header float-right">
                    <div class="page-title">
                        <ol class="breadcrumb text-right">
                            <li><a href="/HealthTrack/admin/dashboard"><%=t.write("Dashboard",lang) %></a></li>
                            <li><%=t.write("Time slot Booking",lang) %></li>
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
                            <strong class="card-title"><%=t.write("Data Table",lang) %></strong>
                        </div>
                        <div class="card-body">
                  <table id="bootstrap-data-table" class="table table-striped table-bordered">
                    <thead>
                      <tr>

                      	<th><%=t.write("Booking Id",lang) %></th>
                        <th><%=t.write("User Id",lang) %></th>
                        <th><%=t.write("Service Id",lang) %></th>
                        <th><%=t.write("Time From",lang) %></th>
                        <th><%=t.write("Action",lang) %></th>

                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="booking" items="${bookings}">
                      	
                      	<% 
                      	    Booking booking = (Booking)pageContext.getAttribute("booking");
            
                      	%>
                      	<tr>
                        <td>${booking.bookingId}</td>
                        <td><a href="/HealthTrack/profile/user/${booking.userId}" target="_blank">${booking.userId}</a></td>
                        <td><a href="/HealthTrack/profile/service/${booking.serviceId}" target="_blank">${booking.serviceId}</a></td>
                     
                        <td> ${booking.timeFrom}</td>                  
                        <td>
                        <div>
                      <!--  <a class="btn btn-danger dashboard-btn dashboard-btn-delete-dept confirm-delete-dept" href="/HealthTrack/admin/<%= admin.getUsername() %>/hospital/deleteDepartment/${dept.deptId}"><i class="fa fa-close"></i> Delete</a>  --> 

                        <a class="dashboard-btn confirm-delete-booking" href="/HealthTrack/admin/<%= admin.getUsername() %>/booking/timeSlotBooking/delete/<%= booking.getBookingId() %>" title="<%=t.write("Delete this booking",lang) %>"><i class="fa fa-close"></i></a>
                        

                        </div>
                        </td>
                      </tr>
                      
                      </c:forEach>
                    
                    </tbody>
                  </table>
                        </div>
                    </div>
                   
                </div>

                </div>
            </div><!-- .animated -->
        </div><!-- .content -->
    <!-- Right Panel -->

<%@include  file="includes/footer.jsp" %>