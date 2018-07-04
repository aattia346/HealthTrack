<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>
<%@page import="com.gp.user.Clinic"%>
<%@page import="com.gp.user.ClinicDao"%>
<%@page import="com.gp.user.Department"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% 	String title = "Clinics";
	String username = (String)session.getAttribute("username");
	User admin = UserDao.getUserByUsername(username);
	List<Clinic> clinics = new ArrayList<Clinic>();
	clinics = ClinicDao.getAllClinics();
	request.setAttribute("clinics", clinics);

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
                            <li><%=t.write("Clinics",lang) %></li>
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
                      <c:forEach var="clinic" items="${clinics}">
                      	
                      	<% 
                      	     Clinic clinic 		= (Clinic)pageContext.getAttribute("clinic");
                      		
                      	%>
                      	<tr>
                        <td>${clinic.clinicId}</td>
                        <td><a href="/HealthTrack/profile/clinic/${clinic.adminId}" target="_blank"><%= t.write(clinic.getClinicName(),lang) %></a></td>
                        <td>${clinic.adminId}</td>
                       
                        <td>${clinic.review}</td>
                        <td>
                        <div>
                        <a class="dashboard-btn" href="/HealthTrack/admin/<%= admin.getUsername() %>/clinic/<%= clinic.getAdminId() %>/edit" title="Edit this clinic"><i class="fa fa-edit"></i></a>
                        <a class="dashboard-btn confirm-delete-hospital" href="/HealthTrack/admin/<%= admin.getUsername() %>/clinic/delete/<%= clinic.getClinicId() %>" title="Delete this hospital"><i class="fa fa-close"></i></a>
                        </div>
                        </td>
                      </tr>
                      
                      </c:forEach>
                    
                    </tbody>
                  </table>
                        </div>
                    </div>
                    <a href="/HealthTrack/admin/<%= admin.getUsername() %>/clinic/add" class="btn btn-primary"><i class="fa fa-plus"></i><%=t.write("Add New Clinic",lang) %> </a>
                </div>

                </div>
            </div><!-- .animated -->
        </div><!-- .content -->

    </div><!-- /#right-panel -->

    <!-- Right Panel -->

<%@include  file="includes/footer.jsp" %>