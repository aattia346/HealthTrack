<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>
<%@page import="com.gp.user.Booking"%>
<%@page import="com.gp.user.BookingDao"%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% 	String title = "daySlotBooking";
	String username = (String)session.getAttribute("username");
	User admin = UserDao.getUserByUsername(username);
	List<Booking> bookings = new ArrayList<Booking>();
	bookings=BookingDao.getBookingTimeOrDaySlot(1);	
	request.setAttribute("bookings", bookings);

%>
<%@include  file="includes/header.jsp" %>

        <div class="breadcrumbs">
            <div class="col-sm-4">
                <div class="page-header float-left">
                    <div class="page-title">
                        <h1><%=t.write("Dashboard") %></h1>
                    </div>
                </div>
            </div>
            <div class="col-sm-8">
                <div class="page-header float-right">
                    <div class="page-title">
                        <ol class="breadcrumb text-right">
                            <li><a href="/HealthTrack/admin/dashboard"><%=t.write("Dashboard") %></a></li>
                            <li><%=t.write("Day slot Booking") %></li>
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
                            <strong class="card-title"><%=t.write("Data Table") %></strong>
                        </div>
                        <div class="card-body">
                  <table id="bootstrap-data-table" class="table table-striped table-bordered">
                    <thead>
                      <tr>
                      	<th><%=t.write("Booking Id") %></th>
                        <th><%=t.write("User Id") %></th>
                        <th><%=t.write("Service Id") %></th>
                        <th><%=t.write("from") %></th>
                        <th><%=t.write("to") %></th>
                        <th><%=t.write("Manage") %></th>
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
                     
                        <td>${booking.dateFrom} ${booking.timeFrom}</td> 
                        <td>${booking.dateTo}</td>                  
                        <td>
                        <div>
                      <!--  <a class="btn btn-danger dashboard-btn dashboard-btn-delete-dept confirm-delete-dept" href="/HealthTrack/admin/<%= admin.getUsername() %>/hospital/deleteDepartment/${dept.deptId}"><i class="fa fa-close"></i> Delete</a>  --> 
                        <a class="dashboard-btn confirm-delete-booking" href="/HealthTrack/admin/<%= admin.getUsername() %>/booking/delete/<%= booking.getBookingId() %>" title=<%=t.write("Delete this booking") %>><i class="fa fa-trash"></i></a>
                         <%if(booking.getStatus()==0){ %>
                       <a href="/HealthTrack/booking/confirm/<%= admin.getId() %>/${booking.bookingId}" class="confirm-verify-booking" title=<%=t.write("confirm") %>><i class="fa fa-check-circle"></i></a>
                       
                        <%}else{ %>
                        <a href="/HealthTrack/booking/unconfirm/<%= admin.getId() %>/${booking.bookingId}" class="confirm-unverify-booking" title=<%=t.write("unConfirm") %>><i class="fa fa-close"></i></a>
                       
                        <%} %>
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

    </div><!-- /#right-panel -->

    <!-- Right Panel -->

<%@include  file="includes/footer.jsp" %>