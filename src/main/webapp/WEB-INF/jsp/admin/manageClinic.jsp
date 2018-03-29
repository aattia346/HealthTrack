<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>
<%@page import="com.gp.user.Hospital"%>
<%@page import="com.gp.user.HospitalDao"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	
<% 	
	String title = "Add New Hospital";
	String action = (String)request.getAttribute("action");
	String username = (String)session.getAttribute("username");
	User admin = UserDao.getUserByUsername(username);	
	
%>

<%@include  file="includes/header.jsp" %>

<%if(action.equalsIgnoreCase("add")){ %>

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
                            <li><a href="/HealthTrack/admin/<%= admin.getUsername()%>/hospitals">Hospitals</a></li>
                            <li>Add New Hospital</li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
        
        <form class="col-lg-12" action="/HealthTrack/admin/hospital/insert" method="post">
                    <div class="card">
                      <div class="card-header"><strong>Hospital</strong><small> Form</small></div>
                      <div class="card-body card-block">
                        <div class="form-group"><label class=" form-control-label">Name</label><input type="text" placeholder="Enter hospital name" class="form-control" name="name" required="required" value="${oldName}"></div>
                        ${invalidName}
                        ${nameExist}
                        <div class="form-group"><label class=" form-control-label">Intro</label><textarea placeholder="Say something about the hospital" class="form-control" name="intro" required="required">${oldIntro}</textarea></div>
                        ${invalidIntro}
                        <div class="form-group"><label class=" form-control-label">Google Maps URL</label><input type="text" placeholder="Enter the link of the location of google maps" class="form-control" name="url" required="required" value="${oldUrl}"></div>
                        ${invalidUrl}
                        <div class="row form-group">
                          <div class="col-12">
                            <div class="form-group"><label class=" form-control-label">phone</label><input type="text" placeholder="Phone Number" class="form-control" name="phone" required="required" value="${oldPhone}"></div>
                            ${invalidPhone}
                          </div>
                          <div class="col-12">
                            <div class="form-group"><label class=" form-control-label">Website</label><input type="text" placeholder="Website url" class="form-control"  required="required" name="website" value="${oldWebsite}"></div>
                            ${invalidWebsite}
                          </div>
                          <div class="col-12">
                          <div class="form-group"><label class=" form-control-label">Address</label><input type="text" placeholder="Address" class="form-control" name="address" required="required" value="${oldAddress}"></div>
                        	${invalidAddress}
                        	</div>
                        </div>
                        
                        
                      	<div class="form-group">
                      		  <label class=" form-control-label">Choose the Admin</label>
                              <select name="hospitalAdmin" class="form-control">
                                <option value="0">Please select</option>
                                <%
                                	List<User> hospitalUsers = UserDao.getUsers("hospital");
                                	request.setAttribute("users", hospitalUsers);
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