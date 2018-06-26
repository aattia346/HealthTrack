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
	String title = "Add New Hospital";
	String username = (String)session.getAttribute("username");
	User admin = UserDao.getUserByUsername(username);
	%>
<%@include  file="includes/header.jsp" %>
<div class="breadcrumbs">
            <div class="col-sm-4">
                <div class="page-header float-left">
                    <div class="page-title">
                        <h1><%=t.write("Dashboard") %></h1>
                    </div>
                </div>
            </div>
            <div class="col-sm-8">
                <div class="page-header float-right">
                    <div class="page-title">
                        <ol class="breadcrumb text-right">
                            <li><a href="/HealthTrack/admin/dashboard"><%=t.write("Dashboard") %></a></li>
                            <li><a href="/HealthTrack/admin/<%= admin.getUsername()%>/hospitals"><%=t.write("Hospitals") %></a></li>
                            <li><%=t.write("Add New Hospital") %></li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
        
        <form class="col-lg-12" action="/HealthTrack/admin/hospital/insert" method="post">
                    <div class="card">
                      <div class="card-header"><strong><%=t.write("Hospital") %></strong><small><%=t.write("Form") %> </small></div>
                      <div class="card-body card-block">
                      
                       <div class="container">
                
					    <div class="row">
					        <div class="form-group name1 col-md-6">
					            <label for="exampleInputEmail1" class="formText"><%=t.write(" Hospital Name") %></label>
					            <input type="text" placeholder="<%=t.write("Enter Hospital Name") %>" class="form-control" name="name" required="required" value="${oldName}" maxlength="50">
					             ${invalidName}
					             ${nameExist}
					             ${shortName}
					        </div>
					
					        <div class="form-group name2 col-md-6">
					            <label for="exampleInputEmail1## Heading ##" class="formText"><%=t.write(" Hospital Name in Arabic") %></label>
					            <input type="text" placeholder="<%=t.write("Enter Hospital Name in Arabic") %>" class="form-control" name="ARname" required="required" value="${oldARName}" maxlength="50">
					         ${invalidARName}					            
					         ${shortARName}
					        </div>
					    </div>
					    
					    <div class="row">
					        <div class="form-group name1 col-md-6">
					            <label for="exampleInputEmail1" class="formText"><%=t.write("Intro") %></label>
					           <textarea maxlength="254" placeholder="<%=t.write("Say something about the Hospital" ) %>" class="form-control" name="intro" required="required">${oldIntro}</textarea>
					         ${invalidIntro}
					         ${shortIntro}
					        </div>
					
					        <div class="form-group name2 col-md-6">
					            <label for="exampleInputEmail1## Heading ##" class="formText"><%=t.write("Intro in Arabic") %></label>
					            <textarea maxlength="254" placeholder="<%=t.write("Say something about the Hospital in Arabic" ) %>" class="form-control" name="ARintro" required="required">${oldARIntro}</textarea>
					             ${invalidARIntro}
					         	 ${shortARIntro}
					        </div>
					    </div>
					    
					    
					    <div class="row">
					        <div class="form-group name1 col-md-6">
					            <label for="exampleInputEmail1" class="formText"><%=t.write("Address") %></label>
					           <input maxlength="50" type="text" placeholder="<%=t.write("Address") %>" class="form-control" name="address" required="required" value="${oldAddress}">
					        ${invalidAddress}
					        </div>
					
					        <div class="form-group name2 col-md-6">
					            <label for="exampleInputEmail1## Heading ##" class="formText"><%=t.write("Address in Arabic") %></label>
					            <input maxlength="50" type="text" placeholder="<%=t.write("Address in Arabic") %>" class="form-control" name="ARaddress" required="required" value="${oldARaddress}">
					        	${invalidARaddress}
					        </div>
					    </div>
                     </div>
                    
                       
                        <div class="form-group"><label class=" form-control-label"><%=t.write("Google Maps URL") %></label><input type="text" placeholder="<%=t.write("Enter the link of the location of google maps") %>" class="form-control" name="url" required="required" value="${oldUrl}"></div>
                        ${invalidUrl}
                        <div class="row form-group">
                          <div class="col-12">
                            <div class="form-group"><label class=" form-control-label"><%=t.write("phone") %></label><input maxlength="11" type="text" placeholder="<%=t.write("Phone Number") %>" class="form-control" name="phone" required="required" value="${oldPhone}"></div>
                            ${invalidPhone}
                          </div>
                          <div class="col-12">
                            <div class="form-group"><label class=" form-control-label"><%=t.write("Website") %></label><input type="text" placeholder="<%=t.write("Website url") %>" class="form-control"  required="required" name="website" value="${oldWebsite}"></div>
                            ${invalidWebsite}
                          </div>
                         
                        </div>
                                             
                      	<div class="form-group">
                      		  <label class=" form-control-label"><%=t.write("Choose the Admin") %></label>
                              <select name="Admin" class="form-control">
                                <option value="0"><%=t.write("Please select") %></option>
                                <%
                                	List<User> hospitalUsers = new ArrayList<User>();
                                	hospitalUsers = UserDao.getUsers("hospital");
                                	request.setAttribute("users", hospitalUsers);
                                %>
                                <c:forEach var="user" items="${users}">
                           <%      
                           User u = (User)pageContext.getAttribute("user");
                           if(!Validation.checkIfTheUserAlreadyAdmin(u.getId(), "hospital")){%>
                             <option value="${user.id}"><%= t.write(u.getUsername()) %></option>
                             <%	} %>
                                </c:forEach>
                              </select>
                              ${invalidAdmin}
                            </div>
                            
                            <div class="form-group">
                              <%
                                	List<String> depts = HospitalDao.getDepts();
                                	request.setAttribute("depts", depts);
                                %>
                      		  <label class=" form-control-label"><%=t.write("Please select the Departments of the new Hospital") %></label>
                      		   
                               <div class="row">
					        <div class="form-group name1 col-md-6">
					            <select name="depts" class="form-control" multiple="multiple">
                              
                                <c:forEach var="dept" items="${depts}">
                                 <%
				                    String  List 		= (String)pageContext.getAttribute("dept");
				                 %>
                                	<option value="${dept}"><%=t.write(List)%></option>
                                </c:forEach>
                              </select>
					        </div>
					
					        <div class="form-group name2 col-md-6">
					            <label for="exampleInputEmail1" class="formText"><%=t.write("Department Name in Arabic") %></label>
					           <input maxlength="50" type="text" placeholder="<%=t.write("Enter Department Name in Arabic") %>" class="form-control" name="ARdepts" required="required" value="${oldAddress}">
					      
					        </div>
					    </div>
                              
                              
                            </div>
                            
                            <button type="submit" class="btn btn-primary col-sm-12"><i class="fa fa-send"></i> <%=t.write("Submit") %></button>
                      </div>
                    </div>
                  </form>
                  
                  <% }else if(action.equalsIgnoreCase("edit")){
                	  		String title = "Edit New Hospital";
	                		String username = (String)session.getAttribute("username");
	                		User admin = UserDao.getUserByUsername(username);
		                	int hospitalAdminId = (int)request.getAttribute("AdminId");
		                	Hospital hospital = HospitalDao.getHospitalById(hospitalAdminId);
                	  %>
<%@include  file="includes/header.jsp" %>
<div class="breadcrumbs">
            <div class="col-sm-4">
                <div class="page-header float-left">
                    <div class="page-title">
                        <h1><%=t.write("Dashboard") %></h1>
                    </div>
                </div>
            </div>
            <div class="col-sm-8">
                <div class="page-header float-right">
                    <div class="page-title">
                        <ol class="breadcrumb text-right">
                            <li><a href="/HealthTrack/admin/dashboard"><%=t.write("Dashboard") %></a></li>
                            <li><a href="/HealthTrack/admin/<%= admin.getUsername()%>/hospitals"><%=t.write("Hospitals") %></a></li>
                            <li><%=t.write("Edit Hospital") %></li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
        
        <form class="col-lg-12" action="/HealthTrack/admin/hospital/<%= hospital.getAdminId() %>/update" method="post">
        	<input type="hidden" name="hospitalId" value="<%= hospital.getHospitalId() %>">
                     <div class="card">
                      <div class="card-header"><strong><%=t.write("Hospital") %></strong><small><%=t.write("Form") %> </small></div>
                      <div class="card-body card-block">
                      
                       <div class="container">
                
					    <div class="row">
					        <div class="form-group name1 col-md-6">
					            <label for="exampleInputEmail1" class="formText"><%=t.write(" Hospital Name") %></label>
					            <input type="text" placeholder="<%=t.write("Enter Hospital Name") %>" class="form-control" name="name" required="required" value="<%=hospital.getHospitalName() %>" maxlength="50">
					             ${invalidName}
					             ${nameExist}
					             ${shortName}
					        </div>
					
					        <div class="form-group name2 col-md-6">
					            <label for="exampleInputEmail1## Heading ##" class="formText"><%=t.write(" Hospital Name in Arabic") %></label>
					            <input type="text" placeholder="<%=t.write("Enter Hospital Name in Arabic") %>" class="form-control" name="ARname" required="required" value="${oldARName}" maxlength="50">
					         ${invalidARName}					            
					         ${shortARName}
					        </div>
					    </div>
					    
					    <div class="row">
					        <div class="form-group name1 col-md-6">
					            <label for="exampleInputEmail1" class="formText"><%=t.write("Intro") %></label>
					           <textarea maxlength="254" placeholder="<%=t.write("Say something about the Hospital" ) %>" class="form-control" name="intro" required="required"><%=hospital.getIntro() %></textarea>
					         ${invalidIntro}
					         ${shortIntro}
					        </div>
					
					        <div class="form-group name2 col-md-6">
					            <label for="exampleInputEmail1## Heading ##" class="formText"><%=t.write("Intro in Arabic") %></label>
					            <textarea maxlength="254" placeholder="<%=t.write("Say something about the Hospital in Arabic" ) %>" class="form-control" name="ARintro" required="required">${oldARIntro}</textarea>
					             ${invalidARIntro}
					         	 ${shortARIntro}
					        </div>
					    </div>
					    
					    
					    <div class="row">
					        <div class="form-group name1 col-md-6">
					            <label for="exampleInputEmail1" class="formText"><%=t.write("Address") %></label>
					           <input maxlength="50" type="text" placeholder="<%=t.write("Address") %>" class="form-control" name="address" required="required" value="<%=hospital.getAddress()%>">
					        ${invalidAddress}
					        </div>
					
					        <div class="form-group name2 col-md-6">
					            <label for="exampleInputEmail1## Heading ##" class="formText"><%=t.write("Address in Arabic") %></label>
					            <input maxlength="50" type="text" placeholder="<%=t.write("Address in Arabic") %>" class="form-control" name="ARaddress" required="required" value="${oldARaddress}">
					        	${invalidARaddress}
					        </div>
					    </div>
                     </div>
                    
                       
                        <div class="form-group"><label class=" form-control-label"><%=t.write("Google Maps URL") %></label><input type="text" placeholder="<%=t.write("Enter the link of the location of google maps") %>" class="form-control" name="url" required="required" value="<%=hospital.getGoogleMapsUrl()%>"></div>
                        ${invalidUrl}
                        <div class="row form-group">
                          <div class="col-12">
                            <div class="form-group"><label class=" form-control-label"><%=t.write("phone") %></label><input maxlength="11" type="text" placeholder="<%=t.write("Phone Number") %>" class="form-control" name="phone" required="required" value="<%=hospital.getPhone() %>"></div>
                            ${invalidPhone}
                          </div>
                          <div class="col-12">
                            <div class="form-group"><label class=" form-control-label"><%=t.write("Website") %></label><input type="text" placeholder="<%=t.write("Website url") %>" class="form-control"  required="required" name="website" value="<%=hospital.getWebsite() %>"></div>
                            ${invalidWebsite}
                          </div>
                         
                        </div>
                                             
                      	<div class="form-group">
                      		  <label class=" form-control-label"><%=t.write("Choose the Admin") %></label>
                              <select name="Admin" class="form-control">
                                <option value="0"><%=t.write("Please select") %></option>
                                <%
                                	List<User> hospitalUsers = new ArrayList<User>();
                                	hospitalUsers = UserDao.getUsers("hospital");
                                	request.setAttribute("users", hospitalUsers);
                                %>
                                <c:forEach var="user" items="${users}">
                           <%      
                           User u = (User)pageContext.getAttribute("user");
                           if(!Validation.checkIfTheUserAlreadyAdmin(u.getId(), "hospital")){%>
                             <option value="${user.id}"><%= t.write(u.getUsername()) %></option>
                             <%	} %>
                                </c:forEach>
                              </select>
                              ${invalidAdmin}
                            </div>
                            
                            <div class="form-group">
                              <%
                                	List<String> depts = HospitalDao.getDepts();
                                	request.setAttribute("depts", depts);
                                %>
                      		  <label class=" form-control-label"><%=t.write("Please select the Departments of the new Hospital") %></label>
                      		   
                               <div class="row">
					        <div class="form-group name1 col-md-6">
					            <select name="depts" class="form-control" multiple="multiple">
                              
                                <c:forEach var="dept" items="${depts}">
                                 <%
				                    String  List 		= (String)pageContext.getAttribute("dept");
				                 %>
                                	<option value="${dept}"><%=t.write(List)%></option>
                                </c:forEach>
                              </select>
					        </div>
					
					        <div class="form-group name2 col-md-6">
					            <label for="exampleInputEmail1" class="formText"><%=t.write("Department Name in Arabic") %></label>
					           <input maxlength="50" type="text" placeholder="<%=t.write("Enter Department Name in Arabic") %>" class="form-control" name="ARdepts" required="required" value="${oldAddress}">
					      
					        </div>
					    </div>
                              
                              
                            </div>
                            
                            <button type="submit" class="btn btn-primary col-sm-12"><i class="fa fa-send"></i> <%=t.write("Submit") %></button>
                      </div>
                    </div>
                  </form>
	<% } %>
<%@include  file="includes/footer.jsp" %>