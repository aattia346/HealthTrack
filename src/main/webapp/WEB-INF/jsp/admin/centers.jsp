<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.gp.user.Center"%>
<%@page import="com.gp.user.CenterDao"%>
<%@page import="com.gp.user.Service"%>
<%@page import="com.gp.user.ServiceDao"%>

<% 	String title = "Centers"; 
	String username = (String)session.getAttribute("username");
	User admin = UserDao.getUserByUsername(username);
	List<Center> centers = new ArrayList<Center>();
	centers = CenterDao.getAllCenters();
	request.setAttribute("centers", centers);
	
%>

<%@include  file="includes/header.jsp" %>

<div class="breadcrumbs">
            <div class="col-sm-4">
                <div class="page-header float-left">
                    <div class="page-title">
                        <h1>Dashboard</h1>
                    </div>
                </div>
            </div>
            <div class="col-sm-8">
                <div class="page-header float-right">
                    <div class="page-title">
                        <ol class="breadcrumb text-right">
                            <li><a href="/HealthTrack/admin/dashboard">Dashboard</a></li>
                            <li>Centers</li>
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
                      	<th>ID</th>
                        <th>Name</th>
                        <th>Admin</th>
                        <th>Services</th>
                        <th>Review</th>
                        <th>Action</th>
                      </tr>
                    </thead>
                    <tbody>
                    
                      <c:forEach var="center" items="${centers}">
                    
                      	
                      	<%
                      	Center C = (Center)pageContext.getAttribute("center");
                      	List<Service> services = ServiceDao.getServicesOfCenter(C.getCenterId());
                      	request.setAttribute("services", services);
                      %>
                    
                      
                      	<tr>
                        <td>${center.centerId}</td>
                        <td><a href="/HealthTrack/profile/center/${center.adminId}" target="_blank">${center.centerName}</a></td>
                        <td>${center.adminId}</td>
                        <td><c:forEach var="service" items="${services}">
                        		<a href="/HealthTrack/admin/<%= admin.getUsername()%>/services#service-${service.serviceId}" class="dept-in-hospital-table">${service.serviceName}</a>
                        		
                        </c:forEach></td>
                        <td>${center.review}</td>
                        <td>
                        <div>
                      <a class="dashboard-btn" href="/HealthTrack/admin/<%= admin.getUsername() %>/center/<%= C.getAdminId() %>/edit" title="Edit this center"><i class="fa fa-edit"></i></a>
                        <a class="dashboard-btn confirm-delete-hospital" href="/HealthTrack/admin/<%= admin.getUsername() %>/center/delete/<%= C.getCenterId() %>" title="Delete this center"><i class="fa fa-close"></i></a>
                         </div>
                        </td>
                      </tr>
                      
                      </c:forEach>
                    
                    </tbody>
                  </table>
                        </div>
                    </div>
                     <a href="/HealthTrack/admin/<%= admin.getUsername() %>/center/add" class="btn btn-primary"><i class="fa fa-plus"></i> Add New Center</a>
                </div>


                </div>
            </div><!-- .animated -->
        </div><!-- .content -->

<%@include  file="includes/footer.jsp" %>