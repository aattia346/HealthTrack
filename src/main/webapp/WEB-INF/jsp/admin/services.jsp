<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.gp.user.Service"%>
<%@page import="com.gp.user.ServiceDao"%>

<% 	String title = "Services"; 
	String username = (String)session.getAttribute("username");
	User admin = UserDao.getUserByUsername(username);
	
	List<Service> servicesOfHospitals = new ArrayList<Service>();
	servicesOfHospitals = ServiceDao.getAllServicesOfHospitals();
	
	List<Service> servicesOfCenters = new ArrayList<Service>();
	servicesOfCenters = ServiceDao.getAllServicesOfCenters();
	
	List<Service> services = new ArrayList<Service>();
	services.addAll(servicesOfHospitals);
	services.addAll(servicesOfCenters);
	
	request.setAttribute("services", services);
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
                            <li>Services</li>
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
                        <th>Hospital or Center</th>
                        <th>Review</th>
                        <th>Action</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="service" items="${services}">
                      
                      	<tr id="service-${service.serviceId}">
                        <td>${service.serviceId}</td>
                        <td><a href="/HealthTrack/profile/service/${service.serviceId}" target="_blank">${service.serviceName}</a></td>
                        
                        <%
                        	Service s = (Service)pageContext.getAttribute("service");
                        	String placeType;
                        	if(s.getCenterId() == 0){
                        		placeType = "hospital";
                        	}else{
                        		placeType = "center";
                        	}
                        %>
                        
                        <td><a href="/HealthTrack/profile/<%= placeType %>/${service.adminId}" target="_blank">${service.hospitalName}${service.centerName}</a></td>
                        <td>${service.serviceReview}</td>
                        <td>
                       <a class="dashboard-btn" href="/HealthTrack/admin/<%= admin.getUsername() %>/service/${service.serviceId}/edit" title="Edit this Service"><i class="fa fa-edit"></i></a>
                        <a class="dashboard-btn confirm-delete-service" href="/HealthTrack/admin/<%= admin.getUsername() %>/service/delete/${service.serviceId}" title="Delete this Service"><i class="fa fa-close"></i></a>
                        </td>
                      </tr>
                      
                      </c:forEach>
                    
                    </tbody>
                  </table>
                        </div>
                    </div>
                     <a href="/HealthTrack/admin/<%= admin.getUsername() %>/Services/add" class="btn btn-primary"><i class="fa fa-plus"></i> Add New Service</a>
                </div>


                </div>
            </div><!-- .animated -->
        </div><!-- .content -->

<%@include  file="includes/footer.jsp" %>