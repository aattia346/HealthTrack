<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.gp.user.Department"%>

<%@page import="com.gp.user.Service"%>
<%@page import="com.gp.user.HospitalDao"%>
<%@page import="com.gp.user.ServiceDao"%>
<%@page import="com.gp.user.Hospital"%>
<%@page import="com.gp.user.Validation"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
int hospitalId = (Integer)request.getAttribute("hospitalId");
Hospital H = HospitalDao.getHospitalById(hospitalId);
String title = H.getHospitalName(); 
List<Department> depts = HospitalDao.getDeptsByHospitalID(H.getHospitalId());

request.setAttribute("depts", depts);

Date today = Calendar.getInstance().getTime();

%>
<%@include  file="../includes/header.jsp" %>
    <!-- Preloader -->
    <div id="preloader">
        <div class="medilife-load"></div>
    </div>
    
    <section class="breadcumb-area bg-img gradient-background-overlay" style="background-image: url(/user/layout/images/profiles/bg-img/breadcumb2.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="breadcumb-content">
                        <h3 class="breadcumb-title"><%= H.getHospitalName() %></h3>
                        <p><%= H.getIntro() %></p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    
    <%
    for(Department d:depts){ 
    	List<Service> services = ServiceDao.getServicesByDeptID(d.getDeptId());                    
		request.setAttribute("services", services);
    %>
    	
    	<!-- ***** Department Area Start ***** -->
    <div class="medilife-services-area section-padding-100-20">
        <div class="container">
            <div class="row">
                <!-- Single Service Area -->
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="single-service-area d-flex">
                        
                        <div class="service-content">
                            <h5><%= d.getDeptName() %></h5>
                            <p>Lorem ipsum dolor sit amet, consecte tuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-8">
                
                    <div class="row">
                    
                    <c:forEach var="service" items="${services}">
                    
                   <div class="col-12 col-md-6 col-lg-3">
                    <div class="single-blog-area mb-100">
                        <!-- Post Thumbnail -->
                        <div class="blog-post-thumbnail">
                            <img src="/user/layout/images/profiles/blog-img/1.jpg" alt="">
                            <!-- Post Date -->
                            <div class="post-date">
                            <%	Service service = (Service)pageContext.getAttribute("service");
					            Calendar calendar = Calendar.getInstance();
			                	calendar.setTime(today);
			                	calendar.add(Calendar.DAY_OF_MONTH, -1);
	                         	if(Validation.validateBookDate(service.getServiceId(), calendar.getTime())){ %>
                                <a href="#">Available today</a>
                                <% } %>
                            </div>
                        </div>
                        <!-- Post Content -->
                        <div class="post-content">
                            <a href="/HealthTrack/profile/service/${service.getServiceId()}" class="headline">${service.serviceName}</a>
                            <a href="#" class="comments">3 Comments</a>
                        </div>
                    </div>
                </div>
                    
                    </c:forEach>
                
                    </div>
                    
                </div>
                                          
            </div>
        </div>
    </div>
    <!-- ***** Services Area End ***** -->
    	
  <%   } %>

    <%@include  file="../includes/footer.jsp" %>