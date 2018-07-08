<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>
<%@page import="com.gp.user.Person"%>
<%@page import="com.gp.user.PersonDao"%>
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
                        <h1><%=t.write("Dashboard",lang) %></h1>
                    </div>
                </div>
            </div>
            <div class="col-sm-8">
                <div class="page-header float-right">
                    <div class="page-title">
                        <ol class="breadcrumb text-right">
                            <li><a href="/HealthTrack/admin/dashboard"><%=t.write("Dashboard",lang) %></a></li>
                            <li><a href="/HealthTrack/admin/<%= admin.getUsername()%>/users"><%=t.write("Users",lang) %></a></li>
                            <li><%=t.write("Add New User",lang) %></li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
        
        <form class="col-lg-12" action="/HealthTrack/admin/user/insert" method="post">
                    <div class="card">
                      <div class="card-header"><strong><%=t.write("User",lang) %></strong><small><%=t.write("Form",lang) %></small></div>
                      <div class="card-body card-block">
                      			
					     <div class="row form-group">
                          <div class="col-12">
                            <div class="form-group"><label class=" form-control-label"><%=t.write("First Name",lang) %></label> <input type="text" placeholder="<%=t.write("Enter First Name",lang) %>" class="form-control" name="firstName" required="required" value="${oldFirstName}" maxlength="50">
					             ${invalidFirstName}
                       			 ${shortFirstName}
                          </div>
                          </div>
                          
                          
                          
                          <div class="col-12">
                            <div class="form-group"><label class=" form-control-label"><%=t.write("Last Name",lang) %></label> <input type="text" placeholder="<%=t.write("Enter First Name",lang) %>" class="form-control" name="firstName" required="required" value="${oldLastName}" maxlength="50">
					             ${invalidLastName}
                       			 ${shortLastName}
                          </div> 
                          </div>
                          
                          <div class="col-12">
                            <div class="form-group"><label class=" form-control-label"><%=t.write("UserName",lang) %></label><input type="text" placeholder="<%=t.write("Enter User Name",lang) %>" class="form-control" name="userName" required="required" value="${oldUserName}" maxlength="50">
					             ${invalidUserName}
		                         ${UsernameExist}
		                         ${shortUserName}
                          </div>                        
                          </div> 
                              <div class="col-12">                       
                            <div class="form-group">
                      		  <label class=" form-control-label"><%=t.write("Choose user type",lang) %></label>
                              <select id=slct2 name="userType" class="form-control">
                                <option value="0"><%=t.write("Please select",lang) %></option>
                               <option value="center"><%=t.write("Center",lang) %></option>
                               <option value="clinic"><%=t.write("Clinic",lang) %></option>
                               <option value="pharmacy"><%=t.write("Pharmacy",lang) %></option>
                               <option value="person"><%=t.write("Person",lang) %></option> 
                               <option value="hospital"><%=t.write("Hospital",lang) %></option>                               
                              </select>                                                          
                            </div> 
                            </div> 
					                  
                          <div class="col-12">
                            <div class="form-group"><label class=" form-control-label"><%=t.write("phone",lang) %></label><input maxlength="11" type="text" placeholder="<%=t.write("Phone Number",lang) %>" class="form-control" name="phone" required="required" value="${oldPhone}"></div>
                            ${invalidPhone}
                          </div>
                          <div class="col-12">
                            <div class="form-group"><label class=" form-control-label"><%=t.write("Email",lang) %></label><input type="text" placeholder="<%=t.write("Enter email",lang) %>" class="form-control"  required="required" name="email" value="${oldEmail}"></div>
                            ${invalidEmail}
                          </div>
                           <div class="col-12">
                           <div class="form-group"><label class=" form-control-label"><%=t.write("Password",lang) %></label>
                                <input type="password" class="form-control" name="password" placeholder="<%=t.write("Password",lang) %>" required maxlength="20"></div>
                            	${invalidPassword}
                            </div>
                             <div class="col-12">
                              <div class="form-group"><label class=" form-control-label"><%=t.write("ConfirmPassword",lang) %></label>
                                <input type="password" class="form-control" name="confirmPassword" placeholder="<%=t.write("Confirm Your Password",lang) %>" required></div>
                            	${passwordNotMatch}
                            </div>
                          
                       </div>
                            
                            <button type="submit" class="btn btn-primary col-sm-12"><i class="fa fa-send"></i><%=t.write("Submit",lang) %></button>
                      </div>
                    </div>
                  </form>
                  
                 

	<% }else if(action.equalsIgnoreCase("edit")){
                	  		String title = "Edit New User";
	                		String username = (String)session.getAttribute("username");
	                		User admin = UserDao.getUserByUsername(username);
		                	int userId = (int)request.getAttribute("userId");
		                	User user = UserDao.getUserById(userId);
		                	String Type = user.getType();
		                	
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
                            <li><a href="/HealthTrack/admin/<%= admin.getUsername()%>/users"><%=t.write("Users",lang) %></a></li>
                            <li><%=t.write("Add New User",lang) %></li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
        <% 
        	Person person =PersonDao.getPersonByUserID(userId);
        	%>
        <form class="col-lg-12" action="/HealthTrack/admin/user/<%= userId %>/update" method="post">
        	<input type="hidden" name="userId" value="<%=userId%>">
                     <div class="card">
                      <div class="card-header"><strong><%=t.write("User",lang) %></strong><small><%=t.write("Form",lang) %></small></div>
                      <div class="card-body card-block">
                      
              <div class="row form-group">
                          <div class="col-12">
                            <div class="form-group"><label class=" form-control-label"><%=t.write("First Name",lang) %></label> <input type="text" placeholder="<%=t.write("Enter First Name",lang) %>" class="form-control" name="firstName" required="required" value="<%=person.getFirstName()%>" maxlength="50">
					             ${invalidFirstName}
                       			 ${shortFirstName}
                          </div>
                          </div>
                          
                          
                          
                          <div class="col-12">
                            <div class="form-group"><label class=" form-control-label"><%=t.write("Last Name",lang) %></label> <input type="text" placeholder="<%=t.write("Enter First Name",lang) %>" class="form-control" name="firstName" required="required" value="<%=person.getLastName() %>" maxlength="50">
					             ${invalidLastName}
                       			 ${shortLastName}
                          </div> 
                          </div>
                          
                          <div class="col-12">
                            <div class="form-group"><label class=" form-control-label"><%=t.write("UserName",lang) %></label><input type="text" placeholder="<%=t.write("Enter User Name",lang) %>" class="form-control" name="userName" required="required" value="<%=user.getUsername() %>" maxlength="50">
					             ${invalidUserName}
		                         ${UsernameExist}
		                         ${shortUserName}
                          </div>
                          
                          </div>
                         <div class="col-12">                       
                            <div class="form-group">
                      		  <label class=" form-control-label"><%=t.write("Choose user type",lang) %></label>
                              <select id=slct2 name="userType" class="form-control">
                                <option value="0"><%=t.write(user.getType(),lang) %></option>
                               <option value="center"><%=t.write("Center",lang) %></option>
                               <option value="clinic"><%=t.write("Clinic",lang) %></option>
                               <option value="pharmacy"><%=t.write("Pharmacy",lang) %></option>
                               <option value="person"><%=t.write("Person",lang) %></option> 
                                <option value="hospital"><%=t.write("Hospital",lang) %></option>                                
                              </select>                                                          
                            </div> 
                            </div> 
					    
					                   
                          <div class="col-12">
                            <div class="form-group"><label class=" form-control-label"><%=t.write("phone",lang) %></label><input maxlength="11" type="text" placeholder="<%=t.write("Phone Number",lang) %>" class="form-control" name="phone" required="required" value="<%=person.getPhone() %>"></div>
                            ${invalidPhone}
                          </div>
                          <div class="col-12">
                            <div class="form-group"><label class=" form-control-label"><%=t.write("Email",lang) %></label><input type="text" placeholder="<%=t.write("Enter email",lang) %>" class="form-control"  required="required" name="email" value="<%=person.getEmail() %>"></div>
                            ${invalidEmail}
                          </div>
                           <div class="col-12">
                           <div class="form-group"><label class=" form-control-label"><%=t.write("Password",lang) %></label>
                                <input type="password" class="form-control" name="password" placeholder="<%=t.write("Password",lang) %>" required maxlength="20"></div>
                            	${invalidPassword}
                            </div>
                             <div class="col-12">
                              <div class="form-group"><label class=" form-control-label"><%=t.write("ConfirmPassword",lang) %></label>
                                <input type="password" class="form-control" name="confirmPassword" placeholder="<%=t.write("Confirm Your Password",lang) %>" required></div>
                            	${passwordNotMatch}
                            </div>
                          
                        </div>  
                            
                            <button type="submit" class="btn btn-primary col-sm-12"><i class="fa fa-send"></i><%=t.write("Submit",lang) %></button>
                      </div>
                    </div>
                  </form>
	
	<%} %>

	
<%@include  file="includes/footer.jsp" %>