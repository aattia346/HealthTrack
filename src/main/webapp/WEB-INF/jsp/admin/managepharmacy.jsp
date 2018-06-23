<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>
<%@page import="com.gp.user.Pharmacy"%>
<%@page import="com.gp.user.PharmacyDao"%>
<%@page import="com.gp.user.Validation"%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	
<% 		
	String action = (String)request.getAttribute("action");

%>



<%if(action.equalsIgnoreCase("add")){
	String title = "Add New Pharmacy";
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
                            <li><a href="/HealthTrack/admin/<%= admin.getUsername()%>/pharmacies"><%=t.write("Pharmacies") %></a></li>
                            <li><%=t.write("Add New Pharmacy") %></li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
        
        <form class="col-lg-12" action="/HealthTrack/admin/pharmacy/insert" method="post">
                    <div class="card">
                      <div class="card-header"><strong><%=t.write("Pharmacy") %></strong><small><%=t.write("Form") %></small></div>
                      <div class="card-body card-block">
                        <div class="form-group"><label class=" form-control-label"><%=t.write("Name") %></label><input type="text" placeholder="<%=t.write("Enter pharmacy name") %>" class="form-control" name="name" required="required" value="${oldName}" maxlength="50"></div>
                        ${invalidName}
                        ${nameExist}
                         ${shortName}
                        <div class="form-group"><label class=" form-control-label"><%=t.write("Intro") %></label><textarea maxlength="254" placeholder="<%=t.write("Say something about the pharmacy") %>" class="form-control" name="intro" required="required">${oldIntro}</textarea></div>
                        ${invalidIntro}
                         ${shortIntro}
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
                          <div class="form-group"><label class=" form-control-label"><%=t.write("Address") %></label><input maxlength="50" type="text" placeholder="<%=t.write("Address") %>" class="form-control" name="address" required="required" value="${oldAddress}"></div>
                        	${invalidAddress}
                        	</div>
                        </div>
                                             
                      	<div class="form-group">
                      		  <label class=" form-control-label"><%=t.write("Choose the Admin") %></label>
                              <select name="Admin" class="form-control">
                                <option value="0"><%=t.write("Please select") %></option>
                                <%
                                	List<User> clinicUsers = UserDao.getUsers("pharmacy");
                                	request.setAttribute("users", clinicUsers);
                                %>
                                <c:forEach var="user" items="${users}">
                                	 <%      
                           User u = (User)pageContext.getAttribute("user");
                           if(!Validation.checkIfTheUserAlreadyAdmin(u.getId(), "pharmacy")){%>
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
                	  		String title = "Edit New Pharmacy";
	                		String username = (String)session.getAttribute("username");
	                		User admin = UserDao.getUserByUsername(username);
		                	int pharmacyAdminId = (int)request.getAttribute("AdminId");
		                	Pharmacy pharmacy = PharmacyDao.getPharmacyById(pharmacyAdminId);
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
                            <li><a href="/HealthTrack/admin/<%= admin.getUsername()%>/pharmacies"><%=t.write("Pharmacy") %></a></li>
                            <li><%=t.write("Edit Pharmacy") %></li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
        
        <form class="col-lg-12" action="/HealthTrack/admin/pharmacy/<%=pharmacy.getAdminId() %>/update" method="post">
        	<input type="hidden" name="pharmacyId" value="<%= pharmacy.getPharmacyId() %>">
                    <div class="card">
                      <div class="card-header"><strong><%=t.write("Pharmacy") %></strong><small> <%=t.write("Form") %></small></div>
                      <div class="card-body card-block">
                        <div class="form-group"><label class=" form-control-label"><%=t.write("Name") %></label><input type="text" placeholder="<%=t.write("Enter pharmacy name") %>" class="form-control" name="name" required="required" value="<%=pharmacy.getPharmacyName() %>" maxlength="50"></div>
                        ${invalidName}
                        ${nameExist}
                        ${shortName}
                        <div class="form-group"><label class=" form-control-label"><%=t.write("Intro") %></label><textarea placeholder="<%=t.write("Say something about the pharmacy") %>" class="form-control" name="intro" required="required" maxlength="254"><%= pharmacy.getIntro() %></textarea></div>
                        ${invalidIntro} ${shortIntro}
                      
                        <div class="form-group"><label class=" form-control-label"><%=t.write("Google Maps URL") %></label><input type="text" placeholder="<%=t.write("Enter the link of the location of google maps") %>" class="form-control" name="url" required="required" value="<%= pharmacy.getGoogle_maps_url() %>"></div>
                        ${invalidUrl}
                        <div class="row form-group">
                          <div class="col-12">
                            <div class="form-group"><label class=" form-control-label"><%=t.write("phone") %></label><input type="text" placeholder="<%=t.write("Phone Number") %>" class="form-control" name="phone" required="required" value="<%= pharmacy.getPhone() %>" maxlength="11"></div>
                            ${invalidPhone}
                          </div>
                          <div class="col-12">
                            <div class="form-group"><label class=" form-control-label"><%=t.write("Website") %></label><input type="text" placeholder="<%=t.write("Website url") %>" class="form-control"  required="required" name="website" value="<%= pharmacy.getWebsite() %>"></div>
                            ${invalidWebsite}
                          </div>
                          <div class="col-12">
                          <div class="form-group"><label class=" form-control-label"><%=t.write("Address") %></label><input type="text" placeholder="<%=t.write("Address") %>" class="form-control" name="address" required="required" value="<%= pharmacy.getAddress() %>" maxlength="50"></div>
                        	${invalidAddress}
                        	</div>
                        </div>
                                             
                      	<div class="form-group">
                      		  <label class=" form-control-label"><%=t.write("Choose the Admin") %></label>
                              <select name="Admin" class="form-control">
                                <option value="0"><%=t.write("Please select") %></option>
                                <%
                                	List<User> hospitalUsers = UserDao.getUsers("pharmacy");
                                	request.setAttribute("users", hospitalUsers);
                                %>
                                <c:forEach var="user" items="${users}">
                                	<%      
                           User u = (User)pageContext.getAttribute("user");
                           if(!Validation.checkIfTheUserAlreadyAdmin(u.getId(), "pharmacy")){%>
                             <option value="${user.id}"><%= t.write(u.getUsername()) %></option>
                             <%	} %>
                                </c:forEach>
                              </select>
                              ${invalidAdmin}
                            </div>
   
                            <button type="submit" class="btn btn-primary col-sm-12"><i class="fa fa-send"></i><%=t.write("Submit") %></button>
                      </div>
                    </div>
                  </form>
	<% } %>
<%@include  file="includes/footer.jsp" %>