<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>
<%@page import="com.gp.user.Hospital"%>
<%@page import="com.gp.user.HospitalDao"%>
<%@page import="com.gp.user.Validation"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	
<% 		
	String action = (String)request.getAttribute("action");

%>



<%if(action.equalsIgnoreCase("add")){
	String title = "Add New User";
	String username = (String)session.getAttribute("username");
	User admin = UserDao.getUserByUsername(username);
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
                            <li><a href="/HealthTrack/admin/<%= admin.getUsername()%>/users">Users</a></li>
                            <li>Add New User</li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
        
        <form class="col-lg-12" action="/HealthTrack/admin/user/insert" method="post">
                    <div class="card">
                      <div class="card-header"><strong>User</strong><small> Form</small></div>
                      <div class="card-body card-block">
                        <div class="form-group"><label class=" form-control-label">First Name</label><input type="text" placeholder="Enter first name" class="form-control" name="firstName" required="required" value="${oldFirstName}" maxlength="50"></div>
                        ${invalidFirstName}
                         ${shortFirstName}
                          <div class="form-group"><label class=" form-control-label">Last Name</label><input type="text" placeholder="Enter Last name" class="form-control" name="lastName" required="required" value="${oldLastName}" maxlength="50"></div>
                        ${invalidLastName}
                         ${shortLastName}
                          <div class="form-group"><label class=" form-control-label"> UserName</label><input type="text" placeholder="Enter user name" class="form-control" name="userName" required="required" value="${oldUserName}" maxlength="50"></div>
                        ${invalidUserName}
                        ${UsernameExist}
                         ${shortUserName}
                        <div class="row form-group">
                          <div class="col-12">
                            <div class="form-group"><label class=" form-control-label">phone</label><input maxlength="11" type="text" placeholder="Phone Number" class="form-control" name="phone" required="required" value="${oldPhone}"></div>
                            ${invalidPhone}
                          </div>
                          <div class="col-12">
                            <div class="form-group"><label class=" form-control-label">Email</label><input type="text" placeholder="Enter email" class="form-control"  required="required" name="email" value="${oldEmail}"></div>
                            ${invalidEmail}
                          </div>
                           <div class="col-12">
                           <div class="form-group"><label class=" form-control-label">Password</label>
                                <input type="password" class="form-control" name="password" placeholder="Password" required maxlength="20"></div>
                            	${invalidPassword}
                            </div>
                             <div class="col-12">
                              <div class="form-group"><label class=" form-control-label">ConfirmPassword</label>
                                <input type="password" class="form-control" name="confirmPassword" placeholder="Confirm Your Password" required></div>
                            	${passwordNotMatch}
                            </div>
                          <div class="col-12">
                          <div class="form-group"><label class=" form-control-label">Type</label><input maxlength="50" type="text" placeholder="Enter user Type" class="form-control" name="type" required="required" value="${oldType}"></div>
                        	${invalidType}
                        	${shortType}
                        	</div>
                        </div>
                                             
                      	
                            
                           
                            
                            <button type="submit" class="btn btn-primary col-sm-12"><i class="fa fa-send"></i> Submit</button>
                      </div>
                    </div>
                  </form>
                  
                 
	
	<%} %>
 
	
<%@include  file="includes/footer.jsp" %>