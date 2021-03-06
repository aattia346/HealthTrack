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
                        <h1><%=t.write("Dashboard",lang) %></h1>
                    </div>
                </div>
            </div>
            <div class="col-sm-8">
                <div class="page-header float-right">
                    <div class="page-title">
                        <ol class="breadcrumb text-right">
                            <li><a href="/HealthTrack/admin/dashboard"><%=t.write("Dashboard",lang) %></a></li>
                            <li><%=t.write("Hospitals",lang) %></li>
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
                       <th class="td-hide-centers"><%=t.write("Departments",lang) %></th>
                        <th><%=t.write("Review",lang) %></th>
                        <th><%=t.write("Action",lang) %></th>

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
                        <td><a href="/HealthTrack/profile/hospital/${hospital.adminId}" target="_blank"><%= t.write(hospital.getHospitalName(),lang) %></a></td>
                        <td>${hospital.adminId}</td>
                        <td class="depts-td td-hide-centers">
                        <c:forEach var="dept" items="${depts}">
                        <%
                        Department D 		= (Department)pageContext.getAttribute("dept");
                        %>
                        	<div class="dept-in-hospital-table">

	                            <a href="/HealthTrack/admin/<%= admin.getUsername()%>/departments#dept-${dept.deptId}"><%= t.write(D.getDeptName(),lang) %></a>  
	                        	<a href="/HealthTrack/admin/<%= admin.getUsername() %>/hospital/deleteDepartment/${dept.deptId}" class="confirm-delete-dept"><i class="fa fa-close" title=<%=t.write("Delete this department",lang) %>> </i> </a>

                        	</div>
                        </c:forEach>
                        <a class="btn add-dept-in-hospital-table" id="add-dept-<%= hospital.getHospitalId() %>" title=<%=t.write("Add new department",lang) %>><i class="fa fa-plus"></i></a>
                        <form method="post" action="/HealthTrack/admin/<%= admin.getUsername() %>/hospital/addNewDepartment" class="add-dept hidden add-dept-<%= hospital.getHospitalId() %>">
	                        	<input type="hidden" value="<%= hospital.getHospitalId()%>" name="hospitalId">
	                        	<select name="dept" class="form-control select-new-dept">
                                <%
                                	List<String> allDepts 			= HospitalDao.getDepts();
                                	List<Department> hospitalDepts 	= HospitalDao.getDeptsByHospitalID(hospital.getHospitalId());
                                	List<String> deptsNames			= new ArrayList<String>();
                                	List<String> deptsList			= new ArrayList<String>();

                                	for(Department D : hospitalDepts){
                                		deptsNames.add(D.getDeptName());
                                	}
                                	for(String D : allDepts){
                                		if(!deptsNames.contains(D)){
                                			deptsList.add(D);
                                		}
                                	}
                                	request.setAttribute("departs", deptsList); %>
                               		<option value="0"><%= t.write("select a department",lang) %></option>
                           			<c:forEach var="depart" items="${departs}">  
                           			  <%
				                       String  List 		= (String)pageContext.getAttribute("depart");
				                       %>
			                       		<option value="${depart}"><%=t.write(List,lang)%></option>
		                           </c:forEach>
                                	<%	
                                %>
                                </select>
                                <button class="btn submit-dept btn-success btn-sm" type="submit"><i class="fa fa-send"></i></button>
	                      </form>
                        
                        </td>
                        <td><%= Math.round(hospital.getReview()*10.0)/10.0 %></td>
                        <td>
                        <div>
                        <% if(hospital.getDimmed()== 0){ %>
                        <a class="dashboard-btn" href="/HealthTrack/admin/<%= admin.getUsername() %>/hospital/<%= hospital.getAdminId() %>/edit" title=<%=t.write("Edit this hospital",lang) %>><i class="fa fa-edit"></i></a>
                       	<% } %>
                        <a class="dashboard-btn confirm-delete-hospital" href="/HealthTrack/admin/<%= admin.getUsername() %>/hospital/delete/<%= hospital.getHospitalId() %>" title=<%=t.write("Delete this hospital",lang) %>><i class="fa fa-close"></i></a>
                        </div>
                        </td>
                      </tr>
                      
                      </c:forEach>
                    
                    </tbody>
                  </table>
                        </div>
                    </div>

                    <a href="/HealthTrack/admin/<%= admin.getUsername() %>/hospital/add" class="btn btn-primary"><i class="fa fa-plus"></i><%=t.write("Add New Hospital",lang) %> </a>
                	<a href="/HealthTrack/admin/<%= admin.getUsername() %>/DimmedHospitals/add" class="btn btn-dimmed"><i class="fa fa-plus"></i><%=t.write("Add Dimmed Hospital",lang) %> </a>

                </div>

                </div>
            </div><!-- .animated -->
        </div><!-- .content -->

    </div><!-- /#right-panel -->

    <!-- Right Panel -->

<%@include  file="includes/footer.jsp" %>