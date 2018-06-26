<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.gp.user.Clinic"%>
<%@page import="com.gp.user.ClinicDao"%>
<%@page import="com.gp.user.Service"%>
<%@page import="com.gp.user.ServiceDao"%>
<%@page import="com.gp.user.Validation"%>


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
                        <h1><%=t.write("Dashboard") %></h1>
                    </div>
                </div>
            </div>
            <div class="col-sm-8">
                <div class="page-header float-right">
                    <div class="page-title">
                        <ol class="breadcrumb text-right">
                            <li><a href="/HealthTrack/admin/dashboard"><%=t.write("Dashboard") %></a></li>
                            <li><a href="/HealthTrack/admin/<%= admin.getUsername()%>/clinics"><%=t.write("Clinics") %></a></li>
                            <li><%=t.write("Add New Clinic") %></li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
        
        <form class="col-lg-12" action="/HealthTrack/admin/clinic/insert" method="post">
                    <div class="card">
                      <div class="card-header"><strong><%=t.write("Clinic") %></strong><small><%=t.write("Form") %> </small></div>
                      
                       <div class="container">
                          <div class="row">
					        <div class="form-group name1 col-md-6">
					            <label for="exampleInputEmail1" class="formText"><%=t.write("Clinic name") %></label>
					          <input type="text" placeholder="<%=t.write("Enter Clinic name") %>" class="form-control" name="name" required="required" value="${oldName}" maxlength="50">
					        ${invalidName}
                        	${nameExist}
					        </div>
					
					        <div class="form-group name2 col-md-6">
					            <label for="exampleInputEmail1## Heading ##" class="formText"><%=t.write("Clinic name in Arabic") %></label>
					            <input type="text" placeholder="<%=t.write("Enter Clinic name in Arabic") %>" class="form-control" name="ARname" required="required" value="${oldName}" maxlength="50">
					        	${invalidARName}
					        </div>
					    </div>
					    
					    
					    <div class="row">
					        <div class="form-group name1 col-md-6">
					            <label for="exampleInputEmail1" class="formText"><%=t.write("Doctor Name") %></label>
					          <input type="text" placeholder="<%=t.write("Doctor Name") %>" class="form-control" name="doctorName" required="required" value="${oldDoctorName}">
					         ${invalidDoctorName}
                            
					        </div>
					
					        <div class="form-group name2 col-md-6">
					            <label for="exampleInputEmail1## Heading ##" class="formText"><%=t.write("Doctor Name in Arabic") %></label>
					            <input type="text" placeholder="<%=t.write("Doctor Name in Arabic") %>" class="form-control" name="ARdoctorName" required="required" value="${oldDoctorName}">
					        	${invalidARDoctorName}
					        </div>
					    </div>
					   
					    
					    <div class="row">
					        <div class="form-group name1 col-md-6">
					            <label for="exampleInputEmail1" class="formText"><%=t.write("Intro") %></label>
					           <textarea maxlength="254" placeholder="<%=t.write("Say something about the center" ) %>" class="form-control" name="intro" required="required">${oldIntro}</textarea>
					         ${invalidIntro}
					         ${shortIntro}
					        </div>
					
					        <div class="form-group name2 col-md-6">
					            <label for="exampleInputEmail1## Heading ##" class="formText"><%=t.write("Intro in Arabic") %></label>
					            <textarea maxlength="254" placeholder="<%=t.write("Say something about the center in Arabic" ) %>" class="form-control" name="ARintro" required="required">${oldARIntro}</textarea>
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
					    
					     
					    
					    <div class="row">
					        <div class="form-group name1 col-md-6">
					            <label for="exampleInputEmail1" class="formText"><%=t.write("Speciality") %></label>
					          <input type="text" placeholder="<%=t.write("Speciality") %>" class="form-control" name="specialty" required="required" value="${oldSpecialty}">
					         ${invalidSpeciality}
                       		 ${shortSpecialityName}
					        </div>
					
					        <div class="form-group name2 col-md-6">
					            <label for="exampleInputEmail1## Heading ##" class="formText"><%=t.write("Speciality in Arabic ") %></label>
					            <input type="text" placeholder="<%=t.write("Speciality in Arabic") %>" class="form-control" name="ARspecialty" required="required" value="${oldSpecialty}">
					        	 ${invalidARSpeciality}
                       			 ${shortARSpecialityName}
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
                          
                        	<div class="col-12">
                        	<div class="form-group"><label class=" form-control-label"><%=t.write("Fees") %></label><input maxlength="10" type="text" placeholder="<%=t.write("fees") %>" class="form-control" name="fees" required="required" value="${oldFees}"></div>
                        	${invalidFees} 
                        	  </div>
                        	 
                        	
                        </div>
                                             
                      	<div class="form-group">
                      		  <label class=" form-control-label"><%=t.write("Choose the Admin") %></label>
                              <select name="Admin" class="form-control">
                                <option value="0"><%=t.write("Please select") %></option>
                                <%
                                	List<User> CenterUsers = UserDao.getUsers("clinic");
                                	request.setAttribute("users", CenterUsers);
                                %>
                                <c:forEach var="user" items="${users}">
                                	<%
                                User u = (User)pageContext.getAttribute("user");
                                if(!Validation.checkIfTheUserAlreadyAdmin(u.getId() , "clinic")){ %>
		                             <option value="${user.id}"><%= t.write(u.getUsername()) %></option>
		                             <%	} %>
                                </c:forEach>
                              </select>
                              ${invalidAdmin}
                            </div>
                             
                          
                            <button type="submit" class="btn btn-primary col-sm-12"><i class="fa fa-send"></i><%=t.write("Submit") %> </button>
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
                        <h1><%=t.write("Dashboard") %></h1>
                    </div>
                </div>
            </div>
            <div class="col-sm-8">
                <div class="page-header float-right">
                    <div class="page-title">
                        <ol class="breadcrumb text-right">
                            <li><a href="/HealthTrack/admin/dashboard"><%=t.write("Dashboard") %></a></li>
                            <li><a href="/HealthTrack/admin/<%= admin.getUsername()%>/clinics"><%=t.write("Clinics") %></a></li>
                            <li><%=t.write("Edit clinic") %></li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
        
        <form class="col-lg-12" action="/HealthTrack/admin/clinic/<%= clinic.getAdminId() %>/update" method="post">
        	<input type="hidden" name="clinicId" value="<%= clinic.getClinicId() %>">
                    <div class="card">
                      <div class="card-header"><strong><%=t.write("Clinic") %></strong><small><%=t.write("Form") %> </small></div>
                      <div class="card-body card-block">
                       <div class="container">
                          <div class="row">
					        <div class="form-group name1 col-md-6">
					            <label for="exampleInputEmail1" class="formText"><%=t.write("Clinic name") %></label>
					          <input type="text" placeholder="<%=t.write("Enter Clinic name") %>" class="form-control" name="name" required="required" value="<%= clinic.getClinicName()%>" maxlength="50">
					        ${invalidName}
                        	${nameExist}
					        </div>
					
					        <div class="form-group name2 col-md-6">
					            <label for="exampleInputEmail1## Heading ##" class="formText"><%=t.write("Clinic name in Arabic") %></label>
					            <input type="text" placeholder="<%=t.write("Enter Clinic name in Arabic") %>" class="form-control" name="ARname" required="required" value="${oldName}" maxlength="50">
					        	${invalidARName}
					        </div>
					    </div>
					    
					    
					    <div class="row">
					        <div class="form-group name1 col-md-6">
					            <label for="exampleInputEmail1" class="formText"><%=t.write("Doctor Name") %></label>
					          <input type="text" placeholder="<%=t.write("Doctor Name") %>" class="form-control" name="doctorName" required="required" value="<%= clinic.getDoctorName()%>">
					         ${invalidDoctorName}
                            
					        </div>
					
					        <div class="form-group name2 col-md-6">
					            <label for="exampleInputEmail1## Heading ##" class="formText"><%=t.write("Doctor Name in Arabic") %></label>
					            <input type="text" placeholder="<%=t.write("Doctor Name in Arabic") %>" class="form-control" name="ARdoctorName" required="required" value="${oldDoctorName}">
					        	${invalidARDoctorName}
					        </div>
					    </div>
					   
					    
					    <div class="row">
					        <div class="form-group name1 col-md-6">
					            <label for="exampleInputEmail1" class="formText"><%=t.write("Intro") %></label>
					           <textarea maxlength="254" placeholder="<%=t.write("Say something about the center" ) %>" class="form-control" name="intro" required="required"><%= clinic.getIntro()%></textarea>
					         ${invalidIntro}
					         ${shortIntro}
					        </div>
					
					        <div class="form-group name2 col-md-6">
					            <label for="exampleInputEmail1## Heading ##" class="formText"><%=t.write("Intro in Arabic") %></label>
					            <textarea maxlength="254" placeholder="<%=t.write("Say something about the center in Arabic" ) %>" class="form-control" name="ARintro" required="required">${oldARIntro}</textarea>
					             ${invalidARIntro}
					         	 ${shortARIntro}
					        </div>
					    </div>
					    
					    
					    <div class="row">
					        <div class="form-group name1 col-md-6">
					            <label for="exampleInputEmail1" class="formText"><%=t.write("Address") %></label>
					           <input maxlength="50" type="text" placeholder="<%=t.write("Address") %>" class="form-control" name="address" required="required" value="<%= clinic.getAddress()%>">
					        ${invalidAddress}
					        </div>
					
					        <div class="form-group name2 col-md-6">
					            <label for="exampleInputEmail1## Heading ##" class="formText"><%=t.write("Address in Arabic") %></label>
					            <input maxlength="50" type="text" placeholder="<%=t.write("Address in Arabic") %>" class="form-control" name="ARaddress" required="required" value="${oldARaddress}">
					        	${invalidARaddress}
					        </div>
					    </div>
					    
					     
					    
					    <div class="row">
					        <div class="form-group name1 col-md-6">
					            <label for="exampleInputEmail1" class="formText"><%=t.write("Speciality") %></label>
					          <input type="text" placeholder="<%=t.write("Speciality") %>" class="form-control" name="specialty" required="required" value="<%= clinic.getSpecialty()%>">
					         ${invalidSpeciality}
                       		 ${shortSpecialityName}
					        </div>
					
					        <div class="form-group name2 col-md-6">
					            <label for="exampleInputEmail1## Heading ##" class="formText"><%=t.write("Speciality in Arabic ") %></label>
					            <input type="text" placeholder="<%=t.write("Speciality in Arabic") %>" class="form-control" name="ARspecialty" required="required" value="${oldSpecialty}">
					        	 ${invalidARSpeciality}
                       			 ${shortARSpecialityName}
					        </div>
					    </div>
					    
                     </div>
              
                        <div class="form-group"><label class=" form-control-label"><%=t.write("Google Maps URL") %></label><input type="text" placeholder="<%=t.write("Enter the link of the location of google maps") %>" class="form-control" name="url" required="required" value="<%= clinic.getGoogle_maps_url()%>"></div>
                        ${invalidUrl}
                        <div class="row form-group">
                          <div class="col-12">
                            <div class="form-group"><label class=" form-control-label"><%=t.write("phone") %></label><input maxlength="11" type="text" placeholder="<%=t.write("Phone Number") %>" class="form-control" name="phone" required="required" value="<%= clinic.getPhone()%>"></div>
                            ${invalidPhone}
                          </div>
                          <div class="col-12">
                            <div class="form-group"><label class=" form-control-label"><%=t.write("Website") %></label><input type="text" placeholder="<%=t.write("Website url") %>" class="form-control"  required="required" name="website" value="<%= clinic.getWebsite()%>"></div>
                            ${invalidWebsite}
                          </div>
                          
                        	<div class="col-12">
                        	<div class="form-group"><label class=" form-control-label"><%=t.write("Fees") %></label><input maxlength="10" type="text" placeholder="<%=t.write("fees") %>" class="form-control" name="fees" required="required" value="<%= clinic.getFees()%>"></div>
                        	${invalidFees} 
                        	  </div>
                        	 
                        	
                        </div>
                                             
                      	<div class="form-group">
                      		  <label class=" form-control-label"><%=t.write("Choose the Admin") %></label>
                              <select name="Admin" class="form-control">
                                <option value="0"><%=t.write("Please select") %></option>
                                <%
                                	List<User> clinicUsers = UserDao.getUsers("clinic");
                                	request.setAttribute("users", clinicUsers);
                                %>
                                <c:forEach var="user" items="${users}">
                                	<%
                                User u = (User)pageContext.getAttribute("user");
                                if(!Validation.checkIfTheUserAlreadyAdmin(u.getId() , "clinic")){ %>
		                             <option value="${user.id}"><%= t.write(u.getUsername()) %></option>
		                             <%	} %>
                                </c:forEach>
                              </select>
                              ${invalidAdmin}
                            </div>
                            
                            
   
                            <button type="submit" class="btn btn-primary col-sm-12"><i class="fa fa-send"></i><%=t.write("Submit") %> </button>
                      </div>
                
                    
                  </form>
	<% } %>
<%@include  file="includes/footer.jsp" %>