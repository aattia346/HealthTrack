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
                        <h1>Dashboard</h1>
                    </div>
                </div>
            </div>
            <div class="col-sm-8">
                <div class="page-header float-right">
                    <div class="page-title">
                        <ol class="breadcrumb text-right">
                            <li><a href="/HealthTrack/admin/dashboard">Dashboard</a></li>
                            <li>Pharmacies</li>
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
                        <th>Review</th>
                        <th>Action</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="pharmacy" items="${pharmacies}">
                      
                      	<tr>
                        <td>${pharmacy.pharmacyId}</td>
                        <td><a href="/HealthTrack/profile/pharmacy/${pharmacy.adminId}" target="_blank">${pharmacy.pharmacyName}</a></td>
                        <td>${pharmacy.adminId}</td>
                        <td>${pharmacy.review}</td>
                        <td>
                        <a class="btn btn-warning dashboard-btn" href="#"><i class="fa fa-edit"></i> Edit</a>
                        <a class="btn btn-danger dashboard-btn" href="#"><i class="fa fa-close"></i> Delete</a>
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

<%@include  file="includes/footer.jsp" %>