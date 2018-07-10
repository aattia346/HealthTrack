<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% 	String title = "Users";
	String username = (String)session.getAttribute("username");
	User admin = UserDao.getUserByUsername(username);
	List<User> users = new ArrayList<User>();
	users = UserDao.getAllUsers();
	request.setAttribute("users", users);

%>
<%@include  file="includes/header.jsp" %>

        <div class="breadcrumbs">
            <div class="col-sm-4">
                <div class="page-header float-left">
                    <div class="page-title">
                        <h1><%= t.write("Dashboard") %></h1>
                    </div>
                </div>
            </div>
            <div class="col-sm-8">
                <div class="page-header float-right">
                    <div class="page-title">
                        <ol class="breadcrumb text-right">
                            <li><a href="/HealthTrack/admin/dashboard"><%= t.write("Dashboard") %></a></li>
                            <li><%= t.write("All Users") %></li>
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
                            <strong class="card-title"><%= t.write("Data Table") %></strong>
                        </div>
                        <div class="card-body">
                  <table id="bootstrap-data-table" class="table table-striped table-bordered">
                    <thead>
                      <tr>
                      	<th><%= t.write("User ID") %></th>
                        <th><%= t.write("User Name") %></th>
                        <th><%= t.write("Type") %></th>                        
                        <th><%= t.write("Action") %></th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="user" items="${users}">
                      	
                      	<% 
                      		User user 		= (User)pageContext.getAttribute("user");                     		
                      	%>
                      	
                      	<tr>
                        
                        <td><a href="/HealthTrack/profile/user/${user.id}" target="_blank">${user.id}</a></td>
                        <td><%= t.write(user.getUsername()) %></td>
                        <td><%= t.write(user.getType()) %></td>
                        <td>
                        <div>
                        <a class="dashboard-btn" href="/HealthTrack/admin/<%= admin.getUsername() %>/user/<%= user.getId() %>/edit" title="<%= t.write("Edit this User") %> "><i class="fa fa-edit"></i></a>
                        <a class="dashboard-btn confirm-delete-hospital" href="/HealthTrack/admin/<%= admin.getUsername() %>/user/delete/<%=user.getId() %>" title="<%= t.write("Delete this User") %> "><i class="fa fa-close"></i></a>
                        <%if(user.getBan()==1){ %>
                       <a href="/HealthTrack/user/unban/<%= admin.getId() %>/${user.id}" class="confirm-unBan-user" title="<%= t.write("unBan") %>"><i class="fa fa-unlock-alt"></i></a>
                       
                        <%}else{ %>
                        <a href="/HealthTrack/user/ban/<%= admin.getId() %>/${user.id}" class="confirm-Ban-user" title="<%= t.write("Ban") %>"><i class="fa fa-ban"></i></a>
                       
                        <%} %>
                       
                        </div>
                        </td>
                      </tr>
                      
                      </c:forEach>
                    
                    </tbody>
                  </table>
                        </div>
                    </div>
                    <a href="/HealthTrack/admin/<%= admin.getUsername() %>/User/add" class="btn btn-primary"><i class="fa fa-plus"></i><%= t.write("Add New User") %></a>
                </div>

                </div>
            </div><!-- .animated -->
        </div><!-- .content -->
    <!-- Right Panel -->

<%@include  file="includes/footer.jsp" %>