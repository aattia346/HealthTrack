<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@page import="com.gp.user.Service"%>
<%@page import="com.gp.user.ServiceDao"%>
<%@page import="com.gp.user.CenterDao"%>
<%@page import="com.gp.user.Center"%>
<%@page import="com.gp.user.Validation"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
int centerId = (Integer)request.getAttribute("centerId");
Center center = CenterDao.getCenterById(centerId);

List<Service> services = new ArrayList<Service>();
services = ServiceDao.getServicesOfCenter(centerId);
request.setAttribute("services", services);

Date today = Calendar.getInstance().getTime();

String title = center.getCenterName();
%>
<%@include  file="../includes/header.jsp" %>
<style>
	@media (max-width: 636px){
		.single-blog-area{
			margin-bottom: 60px !important;
		}
	}
</style>
    <!-- Preloader -->
    <div id="preloader">
        <div class="medilife-load"></div>
    </div>
    
    <section class="breadcumb-area bg-img gradient-background-overlay" style="background-image: url(/user/layout/images/profiles/bg-img/breadcumb2.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="breadcumb-content">
                        <h3 class="breadcumb-title text-capitalize"> <%= t.write(center.getCenterName(),lang) %> </h3>
                        <p><%= t.write(center.getIntro(),lang) %></p>
                    </div>
                    <div class="hospital-review">
                    	<i class="far fa-star fa-3x"></i> <span><%= Math.round(center.getReview()*10.0)/10.0 %></span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    	<!-- ***** Department Area Start ***** -->
    <div class="medilife-services-area section-padding-100-20">
        <div class="container">
            <div class="row">
                <!-- Single Service Area -->
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="single-service-area d-flex">
                        
                        <div class="service-content">
                            <h5 class="text-capitalize"><%= t.write("our services",lang) %></h5>
                            <p><%= t.write(center.getIntro(),lang) %></p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-8">
                
                    <div class="row">
                    
                    <c:forEach var="service" items="${services}">
                    <a href="/HealthTrack/profile/service/center/${service.getServiceId()}">
                   <div class="col-md-6 col-lg-3">
                    <div class="single-blog-area mb-100">
                        <!-- Post Thumbnail -->
                        <div class="blog-post-thumbnail">
                            <img src="/user/layout/images/profiles/blog-img/Delivery.png">
                            <!-- Post Date -->
                            <div class="post-date">
                            <%	Service service = (Service)pageContext.getAttribute("service");
					            Calendar calendar = Calendar.getInstance();
			                	calendar.setTime(today);
			                	calendar.add(Calendar.DAY_OF_MONTH, -1);
	                         	if(Validation.validateBookDate(service.getServiceId(), calendar.getTime())){ %>
                                <a class="text-capitalize" href="#"><%= t.write("available today",lang) %></a>
                                <% } %>
                            </div>
                        </div>
                        <!-- Post Content -->
                        <div class="post-content">
                            <a href="/HealthTrack/profile/service/center/${service.getServiceId()}" class="headline text-capitalize"><%= t.write(service.getServiceName(),lang) %></a>
                            <a href="/HealthTrack/profile/service/center/${service.getServiceId()}#myCarousel" class="comments"><%= ServiceDao.getNumerOfComments(service.getServiceId()) %> <%= t.write("comments",lang) %></a>
                        </div>
                    </div>
                </div>
                </a>
                    
                    </c:forEach>
                
                    </div>
                    
                </div>
                                          
            </div>
        </div>
    </div>
    <!-- ***** Services Area End ***** -->
    	  
<div id="map" class="hospital-map"></div>

	
	<script>
      function hospitalMarker() {
        var uluru = {lat: <%= center.getLat() %>, lng: <%= center.getLang() %>};
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 11,
          center: uluru
        });
        var marker = new google.maps.Marker({
          position: uluru,
          map: map
        });
      }
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCF4-LBT961bTAMeLJr6Pt1-b9FOjljREg&callback=hospitalMarker">
    </script>
    <%@include  file="../includes/footer.jsp" %>