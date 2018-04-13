<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.gp.user.Clinic"%>
<%@page import="com.gp.user.ClinicDao"%>
<%@page import="com.gp.user.Service"%>
<%@page import="com.gp.user.ServiceDao"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	
<% 		
	String action = (String)request.getAttribute("action");

%>



<%if(action.equalsIgnoreCase("add")){
	String title = "Add New Clinic";
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
                            <li><a href="/HealthTrack/admin/<%= admin.getUsername()%>/hospitals">Clinics</a></li>
                            <li>Add New Clinic</li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
        
        <form class="col-lg-12" action="/HealthTrack/admin/clinic/insert" method="post">
                    <div class="card">
                      <div class="card-header"><strong>Clinic</strong><small> Form</small></div>
                      <div class="card-body card-block">
                        <div class="form-group"><label class=" form-control-label">Clinic name</label><input type="text" placeholder="Enter Clinic name" class="form-control" name="name" required="required" value="${oldName}" maxlength="50"></div>
                        ${invalidName}
                        ${nameExist}
                       <div class="form-group"><label class=" form-control-label">Doctor Name</label><input type="text" placeholder="Doctor Name" class="form-control" name="doctorName" required="required" value="${oldDoctorName}"></div> 
                         ${invalidName}
                        ${nameExist}
                       
                        <div class="form-group"><label class=" form-control-label">Intro</label><textarea maxlength="254" placeholder="Say something about the Clinic" class="form-control" name="intro" required="required">${oldIntro}</textarea></div>
                        ${invalidIntro}
                         ${shortIntro}
                        <div class="form-group"><label class=" form-control-label">Google Maps URL</label><input type="text" placeholder="Enter the link of the location of google maps" class="form-control" name="url" required="required" value="${oldUrl}"></div>
                        ${invalidUrl}
                        <div class="row form-group">
                          <div class="col-12">
                            <div class="form-group"><label class=" form-control-label">phone</label><input maxlength="11" type="text" placeholder="Phone Number" class="form-control" name="phone" required="required" value="${oldPhone}"></div>
                            ${invalidPhone}
                          </div>
                          <div class="col-12">
                            <div class="form-group"><label class=" form-control-label">Website</label><input type="text" placeholder="Website url" class="form-control"  required="required" name="website" value="${oldWebsite}"></div>
                            ${invalidWebsite}
                          </div>
                          <div class="col-12">
                          <div class="form-group"><label class=" form-control-label">Address</label><input maxlength="50" type="text" placeholder="Address" class="form-control" name="address" required="required" value="${oldAddress}"></div>
                        	${invalidAddress}
                     	 <div class="form-group"><label class=" form-control-label">Speciality</label><input type="text" placeholder="Speciality" class="form-control" name="specialty" required="required" value="${oldSpecialty}"></div> 
                         ${invalidName}
                        ${nameExist}
                     
                        	</div>
                        	
                        </div>
                                             
                      	<div class="form-group">
                      		  <label class=" form-control-label">Choose the Admin</label>
                              <select name="Admin" class="form-control">
                                <option value="0">Please select</option>
                                <%
                                	List<User> CenterUsers = UserDao.getUsers("clinic");
                                	request.setAttribute("users", CenterUsers);
                                %>
                                <c:forEach var="user" items="${users}">
                                	<option value="${user.id}">${user.username}</option>
                                </c:forEach>
                              </select>
                              ${invalidAdmin}
                            </div>
                             
                          
                            <button type="submit" class="btn btn-primary col-sm-12"><i class="fa fa-send"></i> Submit</button>
                      </div>
                    </div>
                  </form>
                  
                  <% }else if(action.equalsIgnoreCase("edit")){
                	  		String title = "Edit New Clinic";
	                		String username = (String)session.getAttribute("username");
	                		User admin = UserDao.getUserByUsername(username);
		                	int clinicAdminId = (int)request.getAttribute("AdminId");
		                	Clinic clinic = ClinicDao.getClinicById(clinicAdminId);
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
                            <li><a href="/HealthTrack/admin/<%= admin.getUsername()%>/clinics">Clinics</a></li>
                            <li>Edit clinic</li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
        
        <form class="col-lg-12" action="/HealthTrack/admin/clinic/<%= clinic.getAdminId() %>/update" method="post">
        	<input type="hidden" name="clinicId" value="<%= clinic.getClinicId() %>">
                    <div class="card">
                      <div class="card-header"><strong>Clinic</strong><small> Form</small></div>
                      <div class="card-body card-block">
                        <div class="form-group"><label class=" form-control-label"> Clinic Name</label><input type="text" placeholder="Enter clinic name" class="form-control" name="name" required="required" value="<%=clinic.getClinicName()%>" maxlength="50"></div>
                        ${invalidName}
                        ${nameExist}
                        ${shortName}

                     <div class="form-group"><label class=" form-control-label">Doctor Clinic Name</label><input type="text" placeholder="Doctor Name" class="form-control" name="doctorName" required="required" value="<%= clinic.getDoctorName()%>"></div>
                        ${invalidName}
                        ${nameExist}
                        ${shortName}
                    
                         <div class="form-group"><label class=" form-control-label">Intro</label><textarea placeholder="say something about Clinic" class="form-control" name="intro" required="required" maxlength="254"><%= clinic.getIntro() %></textarea></div>
                        ${invalidIntro} ${shortIntro}
                      

                     <div class="form-group"><label class=" form-control-label">doctor_clinic_name</label><input type="text" placeholder="Doctor Name" class="form-control" name="doctorName" required="required" value=<%= clinic.getDoctorName() %>></div>
                        ${invalidName}
                        ${nameExist}
                        ${shortName}     
                         <div class="form-group"><label class=" form-control-label">intro</label><textarea placeholder="say something about Clinic" class="form-control" name="intro" required="required" maxlength="254"><%= clinic.getIntro() %></textarea></div>
                        ${invalidIntro}
                         ${shortIntro}       

                        <div class="form-group"><label class=" form-control-label">Google Maps URL</label><input type="text" placeholder="Enter the link of the location of google maps" class="form-control" name="url" required="required" value="<%=clinic.getGoogle_maps_url()%>"></div>
                        ${invalidUrl}
                        <div class="row form-group">
                          <div class="col-12">
                            <div class="form-group"><label class=" form-control-label">phone</label><input type="text" placeholder="Phone Number" class="form-control" name="phone" required="required" value="<%=clinic.getPhone() %>" maxlength="11"></div>
                            ${invalidPhone}
                          </div>
                          <div class="col-12">
                         <div class="form-group"><label class=" form-control-label">Specialty</label><input type="text" placeholder="Doctor speciality" class="form-control"  required="required" name="specialty" value="<%= clinic.getSpecialty() %>"></div>    
                       
                        <div class="form-group"><label class=" form-control-label">Website</label><input type="text" placeholder="website" class="form-control"  required="required" name="website" value="<%= clinic.getWebsite() %>"></div> 
                            ${invalidWebsite}
                          </div>
                          <div class="col-12">
                          <div class="form-group"><label class=" form-control-label">Address</label><input type="text" placeholder="Address" class="form-control" name="address" required="required" value="<%= clinic.getAddress() %>" maxlength="50"></div>
                        	${invalidAddress}
                        	</div>
                        </div>
                                             
                      	<div class="form-group">
                      		  <label class=" form-control-label">Choose the Admin</label>
                              <select name="Admin" class="form-control">
                                <option value="0">Please select</option>
                                <%
                                	List<User> clinicUsers = UserDao.getUsers("clinic");
                                	request.setAttribute("users", clinicUsers);
                                %>
                                <c:forEach var="user" items="${users}">
                                	<option value="${user.id}">${user.username}</option>
                                </c:forEach>
                              </select>
                              ${invalidAdmin}
                            </div>
                            
                            
   
                            <button type="submit" class="btn btn-primary col-sm-12"><i class="fa fa-send"></i> Submit</button>
                      </div>
                    </div>
                  </form>
	<% } %>
<%@include  file="includes/footer.jsp" %>