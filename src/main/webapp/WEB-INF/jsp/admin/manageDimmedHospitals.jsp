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
	String title = "Add New Dimmed Hospital";
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
                            <li><a href="/HealthTrack/admin/<%= admin.getUsername()%>/hospitals"><%=t.write("Hospitals",lang) %></a></li>
                            <li><%=t.write("Add New Dimmed Hospital",lang) %></li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
        
        <form class="col-lg-12" action="/HealthTrack/admin/dimmed/hospital/<%= admin.getUsername() %>/insert" method="post">
                    <div class="card">
                      <div class="card-header"><strong><%=t.write("Dimmed Hospital",lang) %></strong><small><%=t.write("Form",lang) %> </small></div>
                      <div class="card-body card-block">
                      
                       <div class="container">
                
					    <div class="row">
					        <div class="form-group name1 col-md-6">
					            <label for="exampleInputEmail1" class="formText"><%=t.write(" Hospital Name",lang) %></label>
					            <input type="text" placeholder="<%=t.write("Enter Hospital Name",lang) %>" class="form-control" name="name" required="required" value="${oldName}" maxlength="50">
					             ${invalidName}
					             ${nameExist}
					             ${shortName}
					        </div>
					
					        <div class="form-group name2 col-md-6">
					            <label for="exampleInputEmail1## Heading ##" class="formText"><%=t.write(" Hospital Name in Arabic",lang) %></label>
					            <input type="text" placeholder="<%=t.write("Enter Hospital Name in Arabic",lang) %>" class="form-control" name="ARname" required="required" value="${oldARName}" maxlength="50">
					         ${invalidARName}					            
					         ${shortARName}
					        </div>
					    </div>
                        <div class="form-group"><label class=" form-control-label"><%=t.write("Google Maps URL",lang) %></label><input type="text" placeholder="<%=t.write("Enter the link of the location of google maps",lang) %>" class="form-control" name="url" required="required" value="${oldUrl}"></div>
                        ${invalidUrl}
                            <button type="submit" class="btn btn-primary col-sm-12"><i class="fa fa-send"></i> <%=t.write("Submit",lang) %></button>
                      </div>
                    </div>
                  </form>
                  
                  <% }else if(action.equalsIgnoreCase("edit")){
                	  		String title = "Edit New Hospital";
	                		String username = (String)session.getAttribute("username");
	                		User admin = UserDao.getUserByUsername(username);
		                	int hospitalId = (int)request.getAttribute("hospitalId");
		                	Hospital hospital = HospitalDao.getHospitalById(hospitalId);
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
                            <li><a href="/HealthTrack/admin/<%= admin.getUsername()%>/hospitals"><%=t.write("Hospitals",lang) %></a></li>
                            <li><%=t.write("Edit Hospital",lang) %></li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
        
        <form class="col-lg-12" action="/HealthTrack/admin/dimmed/hospital/<%= admin.getUsername() %>/update/<%= hospital.getHospitalId() %>" method="post">
        	<input type="hidden" name="hospitalId" value="<%= hospital.getHospitalId() %>">
                     <div class="card">
                      <div class="card-header"><strong><%=t.write("Hospital",lang) %></strong><small><%=t.write("Form",lang) %> </small></div>
                      <div class="card-body card-block">
                      
                       <div class="container">
                
					    <div class="row">
					        <div class="form-group name1 col-md-6">
					            <label for="exampleInputEmail1" class="formText"><%=t.write(" Hospital Name",lang) %></label>
					            <input type="text" placeholder="<%=t.write("Enter Hospital Name",lang) %>" class="form-control" name="name" required="required" value="<%=hospital.getHospitalName() %>" maxlength="50">
					             ${invalidName}
					             ${nameExist}
					             ${shortName}
					        </div>
					
					        <div class="form-group name2 col-md-6">
					            <label for="exampleInputEmail1## Heading ##" class="formText"><%=t.write(" Hospital Name in Arabic",lang) %></label>
					            <input type="text" placeholder="<%=t.write("Enter Hospital Name in Arabic",lang) %>" class="form-control" name="ARname" required="required" value="${oldARName}" maxlength="50">
					         ${invalidARName}					            
					         ${shortARName}
					        </div>
					    </div>
                     </div>
                    
                       
                        <div class="form-group"><label class=" form-control-label"><%=t.write("Google Maps URL",lang) %></label><input type="text" placeholder="<%=t.write("Enter the link of the location of google maps",lang) %>" class="form-control" name="url" required="required" value="<%=hospital.getGoogleMapsUrl()%>"></div>
                        ${invalidUrl}
                                   
                        <button type="submit" class="btn btn-primary col-sm-12"><i class="fa fa-send"></i> <%=t.write("Submit",lang) %></button>
                      </div>
                    </div>
                  </form>
	<% } %>
<%@include  file="includes/footer.jsp" %>