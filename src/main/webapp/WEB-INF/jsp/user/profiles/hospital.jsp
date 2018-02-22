<%@page import="java.util.List"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.gp.user.Department"%>
<%@page import="com.gp.user.HospitalDao"%>
<%@page import="com.gp.user.Hospital"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% String title="Hospital";

HttpSession hospitalSession = request.getSession();

int hospitalId = (Integer)hospitalSession.getAttribute("hospitalId");
Hospital H = HospitalDao.getHospitalById(hospitalId);
List<Department> depts = HospitalDao.getDeptsByHospitalID(H.getId());
request.setAttribute("depts", depts);
PrintWriter pw = new PrintWriter(System.out);
%>
<%@include  file="../includes/header.jsp" %>
	 <div class="overlay">
        
            <div class="hospital">

                <div class="hospital-head">
                    <h2 class="hospital-title"><%= H.getHospitalName() %></h2>

                    <p class="hospital-desc lead"><%= H.getIntro() %></p>
                </div>
                <img src="/user/layout/images/dar_elfo2ad.jpg" class="hospital-img">
                </div>
        </div>

        <div class="hospital-body">
        
            <div class="container">

                <div class="col-sm-12 hospital-depts">
                    <div class="hospital-info">
                        <h4 class="about-title">Name: </h4><p class="about-detail"><%= H.getHospitalName() %></p>
                    </div>
                    <div class="hospital-info">
                        <h4 class="about-title">Address: </h4><p class="about-detail"><%= H.getAddress() %></p>
                    </div>
                    <div class="hospital-info">
                        <h4 class="about-title">Location: </h4><p class="about-detail"><a href="#">find <%= H.getHospitalName() %> in google maps</a></p>
                    </div>
                    <div class="hospital-info">
                        <h4 class="about-title">Website: </h4><p class="about-detail"><a target="_blank" href="<%= H.getWebsite()%>"><%= H.getWebsite()%></a></p>
                    </div>
                    <div class="hospital-info">
                        <h4 class="about-title">Phone Number: </h4><p class="about-detail"><%= H.getPhone()%></p>
                    </div>
                    <div class="hospital-info">
                        <h4 class="about-title">Review </h4><p class="about-detail"><%= H.getReview() %></p>
                    </div>
                </div>
                
                <div class="col-sm-3 hospital-depts">
                    <h4 class="text-center">Hospital Department</h4>
                    <ul class="list-unstyled">
                    	
                    	<c:forEach  var="dept" items="${depts}">
					       <li id="dep${dept.id}" class="text-center">${dept.name}</li>
                         </c:forEach>
                  
                    </ul>
                </div>

                <div class="col-sm-7 hospital-depts">
                    <h4 class="text-center services-available">Services Available</h4>
                    <a href="#" class="dep1 hidden">
                    <div class="thumbnail hospital-service col-sm-4">             
                        <div class="caption">
                            <img src="/user/layout/images/dar_elfo2ad.jpg">
                            <p class="lead">Service Name 1</p>
                        </div>
                    </div>
                    </a>
                    
                    <a href="#" class="dep2 hidden">
                    <div class="thumbnail hospital-service col-sm-4">             
                        <div class="caption">
                            <img src="/user/layout/images/dar_elfo2ad.jpg">
                            <p class="lead">Service Name 2 </p>
                        </div>
                    </div>
                    </a>
                    
                    <a href="#" class="dep3 hidden">
                    <div class="thumbnail hospital-service col-sm-4">             
                        <div class="caption">
                            <img src="/user/layout/images/dar_elfo2ad.jpg">
                            <p class="lead">Service Name 3</p>
                        </div>
                    </div>
                    </a>
                    
                    <a href="#" class="dep4 hidden">
                    <div class="thumbnail hospital-service col-sm-4">             
                        <div class="caption">
                            <img src="/user/layout/images/dar_elfo2ad.jpg">
                            <p class="lead">Service Name 4</p>
                        </div>
                    </div>
                    </a>
                    
<<<<<<< HEAD
                    <% for(Department d:depts){           
							List<Service> services = HospitalDao.getServicessByDeptID(d.getId());                    
                    		request.setAttribute("services", services); %>
	                    		<c:forEach  var="service" items="${services}">
					       			<a href="/HealthTrack/profile/service/${service.id}" class="department${service.getDeptId()} hidden">
					                    <div class="thumbnail hospital-service col-sm-4">             
					                        <div class="caption">
					                            <img src="/user/layout/images/dar_elfo2ad.jpg">
					                            <p class="lead">${service.name}</p>
					                        </div>
					                    </div>
				                    </a>
	                    		</c:forEach>                    	
                <%    }
                    	%>
=======
>>>>>>> refs/remotes/origin/master
                </div>

            </div>
        </div>
	  <%@include  file="../includes/footer.jsp" %>