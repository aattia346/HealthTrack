<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.gp.user.Department"%>

<%@page import="com.gp.user.Service"%>
<%@page import="com.gp.user.HospitalDao"%>
<%@page import="com.gp.user.Hospital"%>
<%@page import="com.gp.user.Validation"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% String title="Hospital";

int hospitalId = (Integer)request.getAttribute("hospitalId");
Hospital H = HospitalDao.getHospitalById(hospitalId);

List<Department> depts = HospitalDao.getDeptsByHospitalID(H.getHospitalId());

request.setAttribute("depts", depts);

Date today = Calendar.getInstance().getTime();
%>

<%@include  file="../includes/header.jsp" %>
	 <div class="overlay">
        
            <div class="hospital">

                <div class="hospital-head">
                    <h2 class="hospital-title"><%= H.getHospitalName() %></h2>

                    <p class="hospital-desc lead"><%= H.getIntro() %></p>
                </div>
                <img src="/user/layout/images/hospital.jpg" class="hospital-img">
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
					       <li id="dep${dept.deptId}" class="text-center">${dept.deptName}</li>
                         </c:forEach>
                  
                    </ul>
                </div>

                <div class="col-sm-7 hospital-depts">
                    <h4 class="text-center services-available">Services Available</h4>          
                    <% for(Department d:depts){ 
							List<Service> services = HospitalDao.getServicesByDeptID(d.getDeptId());                    
                    		request.setAttribute("services", services); %>
	                    		<c:forEach  var="service" items="${services}">
					       			<a href="/HealthTrack/profile/service/${service.getServiceId()}" class="dep${service.getDeptId()} hidden">
					                    <div class="thumbnail hospital-service col-sm-4">             
					                        <div class="caption">
					                            <img src="/user/layout/images/hospital.jpg">
					                            <p class="lead">${service.serviceName}</p> 
					                            <%	Service service = (Service)pageContext.getAttribute("service");
					                            	Calendar calendar = Calendar.getInstance();
					                            	calendar.setTime(today);
					                            	calendar.add(Calendar.DAY_OF_MONTH, -1);
						                         	if(Validation.validateBookDate(service.getServiceId(), calendar.getTime())){ %>
						                         		<p class="lead">Available today</p> 
						                        <% 	}
					                            
					                            %>
					                        </div>
					                    </div>
				                    </a>
	                    		</c:forEach>                    	
                <%    }
                    	%>
                </div>

            </div>
        </div>
	  <%@include  file="../includes/footer.jsp" %>