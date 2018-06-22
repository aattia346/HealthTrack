<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.gp.user.Hospital"%>
<%@page import="com.gp.user.HospitalDao"%>
<%@page import="com.gp.user.Department"%>
<%@page import="com.gp.user.Service"%>
<%@page import="com.gp.user.ServiceDao"%>

<% 	String title = "Departments"; 
	String username = (String)session.getAttribute("username");
	User admin = UserDao.getUserByUsername(username);
	List<Department> depts = new ArrayList<Department>();
	depts = HospitalDao.getAllDepts();
	request.setAttribute("depts", depts);
%>

<%@include  file="includes/header.jsp" %>

<div class="breadcrumbs">
            <div class="col-sm-4">
                <div class="page-header float-left">
                    <div class="page-title">
                        <h1> <%=t.write("Dashboard") %></h1>
                    </div>
                </div>
            </div>
            <div class="col-sm-8">
                <div class="page-header float-right">
                    <div class="page-title">
                        <ol class="breadcrumb text-right">
                            <li><a href="/HealthTrack/admin/dashboard"><%=t.write("Dashboard") %></a></li>
                            <li><%=t.write("Department") %></li>
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
                      	<th><%=t.write("ID") %></th>
                        <th><%=t.write("Name") %></th>
                        <th><%=t.write("Hospital") %></th>
                        <th><%=t.write("Admin") %></th>
                        <th><%=t.write("Services") %></th>
                        <th><%=t.write("Action") %></th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="dept" items="${depts}">
                      
                      <%
                      	Department D = (Department)pageContext.getAttribute("dept");
                      	List<Service> services = ServiceDao.getServicesByDeptID(D.getDeptId());
                      	request.setAttribute("services", services);
                      %>
                      	<tr id="dept-${D.deptId}">
                        <td>${dept.deptId}</td>
                        <td>${dept.deptName}</td>
                        <td><a href="/HealthTrack/profile/hospital/${dept.adminId}" target="_blank">${dept.hospitalName}</a></td>
                        <td>${dept.adminId}</td>
                        <td>
                        	<c:forEach var="service" items="${services}">
                        		<a href="/HealthTrack/admin/<%= admin.getUsername()%>/services#service-${service.serviceId}" class="dept-in-hospital-table">${service.serviceName}</a>
                        	</c:forEach>
                        </td>
                        <td>
                        <a class="btn btn-danger dashboard-btn dashboard-btn-delete-dept confirm-delete-dept" href="/HealthTrack/admin/<%= admin.getUsername() %>/hospital/deleteDepartment/${dept.deptId}"><i class="fa fa-close"></i><%=t.write("Delete") %> </a>
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