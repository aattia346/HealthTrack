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
                        <h1> <%=t.write("Dashboard",lang) %></h1>
                    </div>
                </div>
            </div>
            <div class="col-sm-8">
                <div class="page-header float-right">
                    <div class="page-title">
                        <ol class="breadcrumb text-right">
                            <li><a href="/HealthTrack/admin/dashboard"><%=t.write("Dashboard",lang) %></a></li>
                            <li><%=t.write("Department",lang) %></li>
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
                        <th><%=t.write("Hospital",lang) %></th>
                        <th><%=t.write("Admin",lang) %></th>
                        <th class="td-hide-centers"><%=t.write("Services",lang) %></th>
                        <th><%=t.write("Action",lang) %></th>

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

                        <td><%= t.write(D.getDeptName(),lang) %></td>
                        <td><a href="/HealthTrack/profile/hospital/${dept.adminId}" target="_blank"><%= t.write(D.getHospitalName(),lang) %></a></td>

                        <td>${dept.adminId}</td>
                        <td class="td-hide-centers">
                        	<c:forEach var="service" items="${services}">
                        	<%
                        	Service S = (Service)pageContext.getAttribute("service");
                        	%>

                        	<div class="dept-in-hospital-table">
	                        	<a href="/HealthTrack/admin/<%= admin.getUsername()%>/services#service-${service.serviceId}"><%= t.write(S.getServiceName(),lang) %></a>
	                        	<a href="/HealthTrack/admin/<%= admin.getUsername() %>/delete/service/${service.serviceId}" class="confirm-delete-service"><i class="fa fa-close" title=<%=t.write("Delete this department",lang) %>> </i> </a>
                        	</div>                        	
                        	</c:forEach>
                        </td>
                        <td>
                        <a title="<%=t.write("Delete",lang) %>" class="dashboard-btn dashboard-btn-delete-dept confirm-delete-dept" href="/HealthTrack/admin/<%= admin.getUsername() %>/hospital/deleteDepartment/${dept.deptId}"><i class="fa fa-close"></i></a>

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