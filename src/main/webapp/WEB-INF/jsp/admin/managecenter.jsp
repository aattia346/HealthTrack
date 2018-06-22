<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.gp.user.Center"%>
<%@page import="com.gp.user.CenterDao"%>
<%@page import="com.gp.user.Service"%>
<%@page import="com.gp.user.ServiceDao"%>
<%@page import="com.gp.user.Validation"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	
<% 		
	String action = (String)request.getAttribute("action");

%>



<%if(action.equalsIgnoreCase("add")){
	String title = "Add New Center";
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
                            <li><a href="/HealthTrack/admin/<%= admin.getUsername()%>/centers"><%=t.write("Centers") %></a></li>
                            <li><%=t.write("Add New Center") %></li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
        
        <form class="col-lg-12" action="/HealthTrack/admin/center/insert" method="post">
                    <div class="card">
                      <div class="card-header"><strong><%=t.write("Center") %></strong><small> <%=t.write("Form") %></small></div>
                      <div class="card-body card-block">
                        <div class="form-group"><label class=" form-control-label"><%=t.write("Center name") %></label><input type="text" placeholder="<%=t.write("Enter Center Name") %>" class="form-control" name="name" required="required" value="${oldName}" maxlength="50"></div>
                        ${invalidName}
                        ${nameExist}
                         ${shortName}
                        <div class="form-group"><label class=" form-control-label"><%=t.write("Intro") %></label><textarea maxlength="254" placeholder="<%=t.write("Say something about the center" ) %>" class="form-control" name="intro" required="required">${oldIntro}</textarea></div>
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
                                	List<User> CenterUsers = UserDao.getUsers("center");
                                	request.setAttribute("users", CenterUsers);
                                %>
                                <c:forEach var="user" items="${users}">
                                <%
                                User u = (User)pageContext.getAttribute("user");
                                if(!Validation.checkIfTheUserAlreadyAdmin(u.getId() , "center")){ %>
		                             <option value="${user.id}">${user.username}</option>
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
                	  		String title = "Edit New Center";
	                		String username = (String)session.getAttribute("username");
	                		User admin = UserDao.getUserByUsername(username);
		                	int centerAdminId = (int)request.getAttribute("AdminId");
		                	Center center = CenterDao.getCenterById(centerAdminId);
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
                            <li><a href="/HealthTrack/admin/<%= admin.getUsername()%>/centers"><%=t.write("Centers") %></a></li>
                            <li><%=t.write("Edit center") %></li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
        
        <form class="col-lg-12" action="/HealthTrack/admin/hospital/<%= center.getAdminId() %>/update" method="post">
        	<input type="hidden" name="centerId" value="<%= center.getCenterId() %>">
                    <div class="card">
                      <div class="card-header"><strong><%=t.write("Center") %></strong><small><%=t.write("Form") %> </small></div>
                      <div class="card-body card-block">
                        <div class="form-group"><label class=" form-control-label"><%=t.write("Name") %></label><input type="text" placeholder="<%=t.write("Enter Center name")%>" class="form-control" name="name" required="required" value="<%= center.getCenterName()%>" maxlength="50"></div>
                        ${invalidName}
                        ${nameExist}
                        ${shortName}
                        <div class="form-group"><label class=" form-control-label"><%=t.write("Intro") %></label><textarea placeholder="<%=t.write("Say something about the Center") %>" class="form-control" name="intro" required="required" maxlength="254"><%= center.getIntro() %></textarea></div>
                        ${invalidIntro} ${shortIntro}
                      
                        <div class="form-group"><label class=" form-control-label"><%=t.write("Google Maps URL") %></label><input type="text" placeholder="<%=t.write("Enter the link of the location of google maps")%>" class="form-control" name="url" required="required" value="<%=center.getGoogleMapsUrl() %>"></div>
                        ${invalidUrl}
                        <div class="row form-group">
                          <div class="col-12">
                            <div class="form-group"><label class=" form-control-label"><%=t.write("phone") %></label><input type="text" placeholder="<%=t.write("Phone Number") %>" class="form-control" name="phone" required="required" value="<%=center.getPhone() %>" maxlength="11"></div>
                            ${invalidPhone}
                          </div>
                          <div class="col-12">
                            <div class="form-group"><label class=" form-control-label"><%=t.write("Website") %></label><input type="text" placeholder="<%=t.write("Website url") %>" class="form-control"  required="required" name="website" value="<%= center.getWebsite() %>"></div>
                            ${invalidWebsite}
                          </div>
                          <div class="col-12">
                          <div class="form-group"><label class=" form-control-label"><%=t.write("Address") %></label><input type="text" placeholder="<%=t.write("Address") %>" class="form-control" name="address" required="required" value="<%= center.getAddress() %>" maxlength="50"></div>
                        	${invalidAddress}
                        	</div>
                        </div>
                                             
                      	<div class="form-group">
                      		  <label class=" form-control-label"><%=t.write("Choose the Admin") %></label>
                              <select name="Admin" class="form-control">
                                <option value="0"><%=t.write("Please select") %></option>
                                <%
                                	List<User> centerUsers = UserDao.getUsers("center");
                                	request.setAttribute("users", centerUsers);
                                %>
                                <c:forEach var="user" items="${users}">
                                	<%
                                User u = (User)pageContext.getAttribute("user");
                                if(!Validation.checkIfTheUserAlreadyAdmin(u.getId() , "center")){ %>
		                             <option value="${user.id}">${user.username}</option>
		                             <%	} %>
                                </c:forEach>
                              </select>
                              ${invalidAdmin}
                            </div>
                            
                            
   
                            <button type="submit" class="btn btn-primary col-sm-12"><i class="fa fa-send"></i> <%=t.write("Submit") %></button>
                      </div>
                    </div>
                  </form>
	<% } %>
<%@include  file="includes/footer.jsp" %>