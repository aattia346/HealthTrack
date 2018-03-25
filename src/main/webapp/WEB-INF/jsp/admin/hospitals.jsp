<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>
<%@page import="com.gp.user.Hospital"%>
<%@page import="com.gp.user.HospitalDao"%>
<%@page import="com.gp.user.Department"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% 	String title = "Hospitals";
	String username = (String)session.getAttribute("username");
	User admin = UserDao.getUserByUsername(username);
	List<Hospital> hospitals = new ArrayList<Hospital>();
	hospitals = HospitalDao.getAllHospitals();
	request.setAttribute("hospitals", hospitals);

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
                            <li>Hospitals</li>
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
                        <th>Departments</th>
                        <th>Review</th>
                        <th>Action</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="hospital" items="${hospitals}">
                      	
                      	<% 
                      		Hospital hospital 		= (Hospital)pageContext.getAttribute("hospital");
                      		List<Department> depts  = HospitalDao.getDeptsByHospitalID(hospital.getHospitalId());
                      		request.setAttribute("depts", depts);
                      	%>
                      	<tr>
                        <td>${hospital.hospitalId}</td>
                        <td><a href="/HealthTrack/profile/hospital/${hospital.adminId}" target="_blank">${hospital.hospitalName}</a></td>
                        <td>${hospital.adminId}</td>
                        <td><c:forEach var="dept" items="${depts}">
                        	
                        	<a href="/HealthTrack/admin/<%= admin.getUsername()%>/departments#dept-${dept.deptId}" class="dept-in-hospital-table">${dept.deptName}</a>
                        
                        </c:forEach></td>
                        <td>${hospital.review}</td>
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
                    <a href="/HealthTrack/admin/<%= admin.getUsername() %>/hospital/add" class="btn btn-primary"><i class="fa fa-plus"></i> Add New Hospital</a>
                </div>

                </div>
            </div><!-- .animated -->
        </div><!-- .content -->

    </div><!-- /#right-panel -->

    <!-- Right Panel -->

<%@include  file="includes/footer.jsp" %>