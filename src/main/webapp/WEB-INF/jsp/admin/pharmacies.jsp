<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.gp.user.Pharmacy"%>
<%@page import="com.gp.user.PharmacyDao"%>

<% 	String title = "Pharmacies"; 
	String username = (String)session.getAttribute("username");
	User admin = UserDao.getUserByUsername(username);
	List<Pharmacy> pharmacies = new ArrayList<Pharmacy>();
	pharmacies = PharmacyDao.getAllPharmacies();
	request.setAttribute("pharmacies", pharmacies);
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
                            <li><%=t.write("Pharmacies",lang) %></li>
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
                        <th><%=t.write("Admin",lang) %></th>
                        
                        <th><%=t.write("Review",lang) %></th>
                        <th><%=t.write("Action",lang) %></th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="pharmacy" items="${pharmacies}">
                      	
                      	<% 
                      		Pharmacy pharmacy 		= (Pharmacy)pageContext.getAttribute("pharmacy");
                      		
                      	%>
                      	<tr>
                        <td>${pharmacy.pharmacyId}</td>
                        <td><a href="/HealthTrack/profile/pharmacy/<%= pharmacy.getAdminId() %>" target="_blank"><%= t.write(pharmacy.getPharmacyName(),lang) %></a></td>
                        <td><%= pharmacy.getAdminId() %></td>
                       
                        <td>${pharmacy.review}</td>
                        <td>
                        <div>
                        <%
                        System.out.println("pharmacy   wejfnwefkmwe:" + pharmacy.getAdminId());%>
                        <a class="dashboard-btn" href="/HealthTrack/admin/<%= admin.getUsername() %>/pharmacy/<%=pharmacy.getAdminId()%>/edit" title="<%=t.write("Edit this pharmacy",lang) %>"><i class="fa fa-edit"></i></a>
                        <a class="dashboard-btn confirm-delete-pharmacy" href="/HealthTrack/admin/<%= admin.getUsername() %>/pharmacy/delete/<%= pharmacy.getPharmacyId()%>" title="<%=t.write("Delete this pharmacy",lang)%>"><i class="fa fa-close"></i></a>
                        </div>
                        </td>
                      </tr>
                      
                      </c:forEach>
                    
                    </tbody>
                  </table>
                        </div>
                    </div>
                    
                    <a href="/HealthTrack/admin/<%= admin.getUsername() %>/pharmacy/add" class="btn btn-primary"><i class="fa fa-plus"></i><%=t.write("Add New Pharmacy",lang) %> </a>
                    <a href="/HealthTrack/admin/<%= admin.getUsername() %>/DimmedPharmacy/add" class="btn btn-dimmed"><i class="fa fa-plus"></i><%=t.write("Add Dimmed Pharmacy",lang) %> </a>
                </div>

                </div>
            </div><!-- .animated -->
        </div><!-- .content -->

    <!-- /#right-panel -->

    <!-- Right Panel -->

<%@include  file="includes/footer.jsp" %>