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
            	<h1><%=t.write("Dashboard",lang) %></h1>
          	</div>
       </div>
   	</div>
    <div class="col-sm-8">
    	<div class="page-header float-right">
        	<div class="page-title">
            	<ol class="breadcrumb text-right">
                	<li><a href="/HealthTrack/admin/dashboard"><%=t.write("Dashboard",lang) %></a></li>
                    <li><%=t.write("Centers",lang) %></li>
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
                        <th><%=t.write("Services",lang) %></th>
                        <th><%=t.write("Review",lang) %></th>
                        <th><%=t.write("Action",lang) %></th>
                      </tr>
                    </thead>
                    <tbody>
                    
                    <c:forEach var="center" items="${centers}">
                    
                      	
                      	<%
                      //	Center c = (Center)pageContext.getAttribute("center");
                      	
                      	Center C = (Center)pageContext.getAttribute("center");
                      	List<Service> services = ServiceDao.getServicesOfCenter(C.getCenterId());
                      	request.setAttribute("services", services);
                      %>
                    
                      
                      	<tr>
                        <td ><%=C.getCenterId()%></td>
                        <td><a href="/HealthTrack/profile/center/${center.adminId}" target="_blank"><%=t.write(C.getCenterName(),lang) %></a></td>
                        <td>${center.adminId}</td>
                        
                        <td class="depts-td">
                        <c:forEach var="service" items="${services}">
                        <%
                        Service S=(Service)pageContext.getAttribute("service");
                        %>
                        	<div class="dept-in-hospital-table">
	                        	<a href="/HealthTrack/admin/<%= admin.getUsername()%>/services#service-${service.serviceId}" class="dept-in-hospital-table"><%= t.write(S.getServiceName(),lang) %></a>
                        		
	                        	<a href="/HealthTrack/admin/<%= admin.getUsername() %>/service/delete/${service.serviceId}" class="confirm-delete-service"><i class="fa fa-close" title=<%=t.write("Delete this Service",lang) %>> </i> </a>
                        	</div>
                        </c:forEach>
                        <a class="btn add-dept-in-hospital-table" id="add-dept-<%=C.getCenterId() %>" title=<%=t.write("Add new Service",lang) %>><i class="fa fa-plus"></i></a>
                        <form method="post" action="/HealthTrack/admin/<%= admin.getUsername() %>/service/add" class="add-dept hidden add-dept-<%=C.getCenterId() %>">
	                        	<input type="hidden" value="<%=C.getCenterId()%>" name="centerId">
	                        	<select name="service" class="form-control select-new-dept">
                                <%
                                	List<String> allServices 			= ServiceDao.getServices();
                                	
                                	List<String> servicesNames			= new ArrayList<String>();
                                	List<String> servicesList			= new ArrayList<String>();

                                	for(Service s : services){
                                		servicesNames.add(s.getServiceName());
                                		;
                                	}
                                	for(String s : allServices){
                                		if(!servicesNames.contains(s)){
                                			servicesList.add(s);
                                		}
                                	}
                                	request.setAttribute("serv", servicesList); %>
                                	<%
                                	String L =(String)pageContext.getAttribute("serv");
                                	%>
                               		<option value="0"><%=t.write("select a Service",lang) %></option>
                           			<c:forEach var="service" items="${serv}">  
			                       		<option value="${service}">${service} </option>
		                           </c:forEach>
                                	<%	
                                %>
                                </select>
                                <button class="btn submit-dept btn-success btn-sm" type="submit"><i class="fa fa-send"></i></button>
	                      </form>
                        
                        </td>
                        <td>${center.review}</td>
                        <td>
                        <div>
                      <a class="dashboard-btn" href="/HealthTrack/admin/<%= admin.getUsername() %>/center/<%= C.getAdminId() %>/edit" title="<%=t.write("Edit this center",lang) %>"><i class="fa fa-edit"></i></a>
                        <a class="dashboard-btn confirm-delete-center" href="/HealthTrack/admin/<%= admin.getUsername() %>/center/delete/<%= C.getCenterId() %>" title="<%=t.write("Delete this center",lang) %>"><i class="fa fa-close"></i></a>
                         </div>
                        </td>
                      </tr>
                      
                      </c:forEach>
                    
                    </tbody>
                  </table>
                        </div>
                    </div>
                     <a href="/HealthTrack/admin/<%= admin.getUsername() %>/center/add" class="btn btn-primary"><i class="fa fa-plus"></i> <%=t.write("Add New Center",lang) %></a>
                </div>


                </div>
            </div><!-- .animated -->
        </div><!-- .content -->

<%@include  file="includes/footer.jsp" %>