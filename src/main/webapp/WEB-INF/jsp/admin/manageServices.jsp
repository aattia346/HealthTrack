<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>
<%@page import="com.gp.user.Service"%>
<%@page import="com.gp.user.ServiceDao"%>
<%@page import="com.gp.user.Center"%>
<%@page import="com.gp.user.CenterDao"%>
<%@page import="com.gp.user.Hospital"%>
<%@page import="com.gp.user.Department"%>
<%@page import="com.gp.user.HospitalDao"%>
<%@page import="com.gp.user.Validation"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	
<% 		
	String action = (String)request.getAttribute("action");

%>



<%if(action.equalsIgnoreCase("add")){
	String title = "Add New Service";
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
                            <li><a href="/HealthTrack/admin/<%= admin.getUsername()%>/services">Services</a></li>
                            <li>Add New Service</li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
        
        <form class="col-lg-12" action="/HealthTrack/admin/service/insert" method="post">
                    <div class="card">
                      <div class="card-header"><strong>Service</strong><small> Form</small></div>
                      <div class="card-body card-block">
                      
                         	<div class="form-group">
                      		  <label class=" form-control-label">Choose the Service Name</label>
                              <select name="serviceName" class="form-control">
                                <option value="0">Please select</option>
                                <%
                                	List<String> services = new ArrayList<String>();
                                    services = ServiceDao.getServices();
                                	request.setAttribute("services", services);
                                %>
                                <c:forEach var="service" items="${services}">
                           <%      
                          String s = (String)pageContext.getAttribute("service");
                           %>
                             <option value="${service}">${service}</option>

                                </c:forEach>
                              </select>
                               ${invalidName}
                        ${nameExist}
                         ${shortName}                            
                            </div>
                            
                            
                            <div class="form-group">
                      		  <label class=" form-control-label">Choose add on center or hospital</label>
                              <select name="place" class="form-control">
                                <option value="0">Please select</option>
                                
                             <option value=1>Hospital</option>
                             <option value=2>Center</option>                             
                              </select>                                                          
                            </div>                     
                            <div class="form-group">
                      		  <label class=" form-control-label">Choose the Center</label>
                              <select name="centerId" class="form-control">
                                <option value="0">Please select</option>
                                <%
                                	List<Center> centers = new ArrayList<Center>();
                                    centers = CenterDao.getAllCenters();
                                	request.setAttribute("centers", centers);
                                %>
                                <c:forEach var="center" items="${centers}">
                           <%      
                          Center c = (Center)pageContext.getAttribute("center");
                           %>
                             <option value="${center.centerId}">${center.centerName}</option>

                                </c:forEach>
                              </select>                                                          
                            </div>
                            
                            
                            <div class="form-group">
                      		  <label class=" form-control-label">Choose the Hospital</label>
                              <select name="hospitalId" class="form-control">
                                <option value="0">Please select</option>
                                <%
                                	List<Hospital> hospitals = new ArrayList<Hospital>();
                                    hospitals = HospitalDao.getAllHospitals();
                                	request.setAttribute("hospitals", hospitals);
                                %>
                           
                            <c:forEach var="hospital" items="${hospitals}">
                           <%      
                          Hospital h = (Hospital)pageContext.getAttribute("hospital");
                           %>
                             <option value="${hospital.hospitalId}">${hospital.hospitalName}</option>
                             
                               <div class="form-group">
                      		  <label class=" form-control-label">Choose the Department</label>
                              <select name="deptId" class="form-control">
                                <option value="0">Please select</option>
                              <%
                                 List<Department> departments = new ArrayList<Department>();
                                 departments = HospitalDao.getDeptsByHospitalID(h.getHospitalId());
                                 request.setAttribute("departments", departments);
                           %>
                             
                                <c:forEach var="department" items="${departments}">
                           <%      
                         Department d = (Department)pageContext.getAttribute("department");
                           %>
                             <option value="${d.deptId}">${d.deptName}</option>

                                </c:forEach>
                                
                              </select>                                                          
                         
                                                                            
                              </div>
                                </c:forEach>
                              </select>                                                          
                            </div>  
                            
                                                     
                            
                        <div class="form-group"><label class=" form-control-label">Fees</label><input type="text" placeholder="Enter Fees" class="form-control" name="fees" required="required" value="${oldFees}" maxlength="50"></div>
                        ${invalidIntro}
                         ${shortIntro}
                         
                          <div class="form-group">
                      		  <label class=" form-control-label">Choose Type of Service</label>
                              <select name="type" class="form-control">
                                <option value="0">Please select</option>
                                
                             <option value=1>Day Service</option>
                             <option value=2>Time Service</option>                             
                              </select>                                                          
                            </div>

                            
                            <button type="submit" class="btn btn-primary col-sm-12"><i class="fa fa-send"></i> Submit</button>
                      </div>
                    </div>
                  </form>
                  
                  
	<% } %>
<%@include  file="includes/footer.jsp" %>