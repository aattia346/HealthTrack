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
<%@page import="com.gp.user.Translator"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% 

	String lang = (String)request.getAttribute("lang");
	Translator t = new Translator(lang);
	
	String username = (String)session.getAttribute("username");
	
	int clinicId = (Integer)(request.getAttribute("clinicId"));
	
	Clinic clinic = ClinicDao.getClinicById(clinicId);

    
    List<Booking> bookings = BookingDao.getBookingsByClinicId(clinicId);
	request.setAttribute("bookings", bookings);
	
	User user = UserDao.getUserByUsername(username);
%>

<!DOCTYPE html>
<html>
    <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><%= t.write(clinic.getClinicName()) + " " + t.write("Bookings") %></title>
    <meta name="description" content="Sufee Admin - HTML5 Admin Template">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="apple-touch-icon" href="apple-icon.png">
    <link rel="shortcut icon" href="favicon.ico">

    <link rel="stylesheet" href="/admin/assets/css/normalize.css">
    <link rel="stylesheet" href="/admin/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="/admin/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="/admin/assets/css/themify-icons.css">
    <link rel="stylesheet" href="/admin/assets/css/flag-icon.min.css">
    <link rel="stylesheet" href="/admin/assets/css/cs-skin-elastic.css">
    <link rel="stylesheet" href="/admin/assets/css/lib/datatable/dataTables.bootstrap.min.css">
    <!-- <link rel="stylesheet" href="assets/css/bootstrap-select.less"> -->
    <link rel="stylesheet" href="/admin/assets/scss/style.css">
	<style>
		.container{
			margin-top: 50px;
		}
		.breadcrumbs .col-sm-8, .breadcrumbs .col-sm-4{
			background: #fff !important;
			padding: 20px 0;
		}
		.breadcrumbs{
			margin-left: 15px;
    		margin-right: 15px;
		}
		.breadcrumbs .col-sm-8{
			padding-left: 20px;
		}
		.translation img:first-of-type{
			width: 35px;
		    height: 28px;
		    margin: 20px;
		    position: absolute;
		    top: -9px;
		    right: 10px;
		    cursor: pointer;
		}
		.translation img:nth-of-type(2){
			width: 53px;
		    height: 44px;
		    margin: 20px;
		    margin-right: -7px;
		    position: absolute;
		    top: -15px;
		    right: 75px;
		    cursor: pointer;
		}
	</style>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800' rel='stylesheet' type='text/css'>
    </head>    
<body>
    <div class="translation">
    	<img title="<%= t.write("english") %>" id="en" class="translate text-capitalize" src="/user/layout/images/england.png">
    	<img id="ar" class="translate" title="<%= t.write("arabic") %>" src="/user/layout/images/egypt.svg">
    </div>
	<div class="container">
        <div class="breadcrumbs">
            <div class="col-sm-6">
                <div class="page-header float-left">
                    <div class="page-title">
                       <h4><a href="/HealthTrack/profile/clinic/<%= user.getId() %>"><i class="fa fa-arrow-left"></i><%= t.write("Back To Clinic Page") %></a></h4>
                    </div>
                </div>
            </div>
             <div class="col-sm-6">
                <div class="page-header float-left">
                    <div class="page-title">
                        <h4><%= t.write(clinic.getClinicName()) + t.write("/") + t.write("Bookings") %></h4>
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
                            <strong class="card-title"><%=t.write("Bookings' detials") %></strong>
                        </div>
                        <div class="card-body">
                  <table id="bootstrap-data-table" class="table table-striped table-bordered">
                    <thead>
                      <tr>
                      	<th><%=t.write("Booking ID") %></th>
                        <th><%=t.write("Patient Name") %></th>
                        <th><%=t.write("Age") %></th>
                        <th><%=t.write("Day") %></th>
                        <th><%=t.write("Time Of Booking") %></th>
                        <th><%=t.write("Phone") %></th>
                        <th><%=t.write("action") %></th>
                      </tr>
                    </thead>
                    <tbody>
                    
                    <c:forEach var="booking" items="${bookings}">
                      	<tr>
                        <td>${booking.bookingId}</td>
                        <td>${booking.firstName} ${booking.lastName}</td>
                        <td>${booking.age}</td>
                        <td>${booking.dayOfBooking}</td>
                        <td>${booking.timeOfBooking}</td>
                        <td>${booking.bookingPhone}</td>
                        <td>
	                        <div>
		                    	<% Booking b = (Booking)pageContext.getAttribute("booking"); %>
		                    	<% if(b.getStatus()==0){ %><a class="confirm-verify-booking dashboard-btn" href="/healthTrack/Clinic/VerifyBooking/<%= clinic.getClinicId() %>/${booking.bookingId}" title="<%=t.write("Confirm This Booking") %>"><i class="fa fa-check-circle"></i></a><% }else{ %>
		                     	<a class="confirm-unverify-booking dashboard-btn" href="/healthTrack/Clinic/UnverifyBooking/<%= clinic.getClinicId() %>/${booking.bookingId}" title="<%=t.write("Unconfirm This Booking") %>"><i class="fa fa-close"></i></a><% } %>
	                         	<a class="dashboard-btn confirm-delete-booking" href="/healthTrack/Clinic/DeleteBooking/<%= clinic.getClinicId() %>/${booking.bookingId}" title="<%=t.write("Delete This Booking") %>"><i class="fa fa-trash"></i></a> 	
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
    
    <footer>
        </footer>
    <script src="/admin/assets/js/vendor/jquery-2.1.4.min.js"></script>
    <script src="/admin/assets/js/popper.min.js"></script>
    <script src="/admin/assets/js/plugins.js"></script>
    <script src="/admin/assets/js/main.js"></script>


    <script src="/admin/assets/js/lib/data-table/datatables.min.js"></script>
    <script src="/admin/assets/js/lib/data-table/dataTables.bootstrap.min.js"></script>
    <script src="/admin/assets/js/lib/data-table/dataTables.buttons.min.js"></script>
    <script src="/admin/assets/js/lib/data-table/buttons.bootstrap.min.js"></script>
    <script src="/admin/assets/js/lib/data-table/jszip.min.js"></script>
    <script src="/admin/assets/js/lib/data-table/pdfmake.min.js"></script>
    <script src="/admin/assets/js/lib/data-table/vfs_fonts.js"></script>
    <script src="/admin/assets/js/lib/data-table/buttons.html5.min.js"></script>
    <script src="/admin/assets/js/lib/data-table/buttons.print.min.js"></script>
    <script src="/admin/assets/js/lib/data-table/buttons.colVis.min.js"></script>
    <script src="/admin/assets/js/lib/data-table/datatables-init.js"></script>


    <script type="text/javascript">
        $(document).ready(function() {
          $('#bootstrap-data-table-export').DataTable();
        });
    </script>
    <script src="/admin/assets/js/src.js"></script>
    </body>
</html>
