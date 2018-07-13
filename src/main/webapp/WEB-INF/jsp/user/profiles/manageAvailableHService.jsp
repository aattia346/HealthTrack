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
    String action = (String)request.getAttribute("action");
    int serviceId = (Integer)(request.getAttribute("serviceId"));
	String lang = (String)request.getAttribute("lang");
	Translator t = new Translator();

	if(action.equalsIgnoreCase("add")){
		String title = "Add New Service";
		String username = (String)session.getAttribute("username");
		User admin = UserDao.getUserByUsername(username);
		
		
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
		
%>

<!DOCTYPE html>
<html>
    <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
  
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
		.comment-th{
			width: 46%;
		}
	</style>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800' rel='stylesheet' type='text/css'>
    </head>    
<body>
    <div class="translation">
    	<img title="<%= t.write("english",lang) %>" id="en" class="translate text-capitalize" src="/user/layout/images/england.png">
    	<img id="ar" class="translate" title="<%= t.write("arabic",lang) %>" src="/user/layout/images/egypt.svg">
    </div>
    




	<div class="container">
        <div class="breadcrumbs">
            <div class="col-sm-6">
                <div class="page-header float-left">
                    <div class="page-title">

                      
                    </div>
                </div>
            </div>
              <%
                                	
                                   Service service = ServiceDao.getServiceById(serviceId);
                                   String serviceName = service.getServiceName() ; 
                                	
                                %>
              <form class="col-lg-12" action="/HealthTrack/admin/service/insert" method="post">
                    <div class="card">
                      <div class="card-header"><strong><%= serviceName%></strong><small> Form</small></div>
                      <div class="card-body card-block">
                      
                         	
                              
                              
                            
                                            
                           
                            
                            
                            <div class="form-group">
                      		  <label class=" form-control-label">Choose the Hospital</label>
                              <select name="hospitalId" class="form-control">
                                <option value="0">Please select</option>
                                <%
                                	List<Hospital> hospitals = new ArrayList<Hospital>();
                                    hospitals = HospitalDao.getAllHospitals();
                                	request.setAttribute("hospitals", hospitals);
                                %>
                           
                            <c:forEach var="hospital" items="${hospitals}">
                           <%      
                          Hospital h = (Hospital)pageContext.getAttribute("hospital");
                           %>
                             <option value="${hospital.hospitalId}">${hospital.hospitalName}</option>
                                </c:forEach>
                              </select>                                                          
                            </div>  
                            
                                                     
                            
                       
                         
                          <div class="form-group">
                      		  <label class=" form-control-label">Choose Type of Service</label>
                              <select name="type" class="form-control">
                                <option value="0">Please select</option>
                                
                             <option value=1>Day Service</option>
                             <option value=2>Time Service</option>                             
                              </select>                                                          
                            </div>

                            
                            <button type="submit" class="btn btn-primary col-sm-12"><i class="fa fa-send"></i> Submit</button>
                      </div>
                    </div>
                  </form>
                  
                  
	<% } %>
            </div><!-- .animated -->
        </div><!-- .content -->	
       
   <!-- /#right-panel -->

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
    <script src="/user/layout/js/src.js"></script>
    </body>
</html>
