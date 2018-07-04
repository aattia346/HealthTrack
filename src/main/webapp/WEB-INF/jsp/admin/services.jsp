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
                        <h1><%=t.write("Dashboard",lang) %></h1>
                    </div>
                </div>
            </div>
            <div class="col-sm-8">
                <div class="page-header float-right">
                    <div class="page-title">
                        <ol class="breadcrumb text-right">
                            <li><a href="/HealthTrack/admin/dashboard"><%=t.write("Dashboard",lang) %></a></li>
                            <li><%=t.write("Services",lang) %></li>
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
                      	<th><%=t.write("ID",lang) %></th>
                        <th><%=t.write("Name",lang) %></th>
                        <th><%=t.write("Hospital or Center",lang) %></th>
                        <th><%=t.write("Review",lang) %></th>
                        <th>Action</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="service" items="${services}">
                      <%Service s = (Service)pageContext.getAttribute("service"); %>
                      	<tr id="service-${service.serviceId}">
                        <td>${service.serviceId}</td>
                        <td><a href="/HealthTrack/profile/service/${service.serviceId}" target="_blank"><%= t.write(s.getServiceName(),lang) %></a></td>
                        
                        <%
                        	
                        	String placeType;
                        	if(s.getCenterId() == 0){
                        		placeType = "hospital";
                        	}else{
                        		placeType = "center";
                        	}
                        %>
                        
                        <td><a href="/HealthTrack/profile/<%= placeType %>/${service.adminId}" target="_blank"><%= t.write(s.getHospitalName(),lang) %> <%= t.write(s.getCenterName(),lang) %></a></td>
                        <td>${service.serviceReview}</td>
                        <td>
                       <a class="dashboard-btn" href="/HealthTrack/admin/<%= admin.getUsername() %>/service/${service.serviceId}/edit" title="<%=t.write("Edit this Service",lang) %>"><i class="fa fa-edit"></i></a>
                        <a class="dashboard-btn confirm-delete-service" href="/HealthTrack/admin/<%= admin.getUsername() %>/service/delete/${service.serviceId}" title="<%=t.write("Delete this Service",lang) %>"><i class="fa fa-close"></i></a>
                        </td>
                      </tr>
                      
                      </c:forEach>
                    
                    </tbody>
                  </table>
                        </div>
                    </div>
                     <a href="/HealthTrack/admin/<%= admin.getUsername() %>/Service2/add" class="btn btn-primary"><i class="fa fa-plus"></i><%=t.write("Add New Service",lang) %> </a>
                </div>


                </div>
            </div><!-- .animated -->
        </div><!-- .content -->

<%@include  file="includes/footer.jsp" %>