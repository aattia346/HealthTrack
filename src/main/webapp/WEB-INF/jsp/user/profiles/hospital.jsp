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
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
int hospitalId = (Integer)request.getAttribute("hospitalId");
Hospital H = HospitalDao.getHospitalById(hospitalId);
String title = H.getHospitalName(); 
List<Department> depts = HospitalDao.getDeptsByHospitalID(H.getHospitalId());

request.setAttribute("depts", depts);

Date today = Calendar.getInstance().getTime();
DateFormat dayFormat = new SimpleDateFormat("E");
String dayName = dayFormat.format(today);

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
                        <h3 class="breadcumb-title text-capitalize"><%= t.write(H.getHospitalName(),lang) %></h3>
                        <p><%= t.write(H.getIntro(),lang) %></p>
                    </div>
                    <div class="hospital-review">
                    	<i class="far fa-star fa-3x"></i> <span><%= Math.round(H.getReview()*10.0)/10.0 %></span>
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
    <div class="medilife-services-area section-padding-100-20 edit-padding">
        <div class="container">
            <div class="row">
                <!-- Single Service Area -->
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="single-service-area d-flex">
                        
                        <div class="service-content">
                            <h5 class="text-capitalize"><%= t.write(d.getDeptName(),lang) %></h5>
                            <p><%= t.write("Lorem ipsum dolor sit amet, consecte tuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut.",lang) %></p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-8">
                
                    <div class="row dept-row">
                    
                    <c:forEach var="service" items="${services}">
                    
                    <a href="/HealthTrack/profile/service/hospital/${service.getServiceId()}">
                   <div class="col-md-6 col-lg-3">
                    <div class="single-blog-area mb-100">
                        <!-- Post Thumbnail -->
                        <div class="blog-post-thumbnail">
                            <img src="/user/layout/images/profiles/blog-img/${service.getServiceName()}.png">
                            <!-- Post Date -->
                            <div class="post-date text-capitalize">
                            <%	Service service = (Service)pageContext.getAttribute("service");
					            Calendar calendar = Calendar.getInstance();
			                	calendar.setTime(today);
			                	//calendar.add(Calendar.DAY_OF_MONTH, -1);
			                	if(service.getSlotType()== 1){
	                         	if(Validation.validateBookDate(service.getServiceId(), calendar.getTime())){ %>
                                <a href="/HealthTrack/profile/service/hospital/${service.getServiceId()}"> <%= t.write("available today",lang) %></a>
                                <% } 
                                }else if(Validation.validateBookTime(service.getServiceId(), dayName , "hospital")){ %>
                                	<a href="/HealthTrack/profile/service/hospital/${service.getServiceId()}"><%= t.write("available today",lang) %></a>
                                <% }%>
                            </div>
                        </div>
                        <!-- Post Content -->
                        <div class="post-content">
                            <a href="/HealthTrack/profile/service/hospital/${service.getServiceId()}" class="headline text-capitalize"><%= t.write(service.getServiceName(),lang) %></a>
							<a href="/HealthTrack/profile/service/hospital/${service.getServiceId()}#myCarousel" class="comments"><%= ServiceDao.getNumerOfComments(service.getServiceId()) %> <%= t.write("comments",lang) %></a>                        </div>
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
    	
  <%   } %>
  
<div id="map" class="hospital-map"></div>

	
	<script>
      function hospitalMarker() {
        var uluru = {lat: <%= H.getLat() %>, lng: <%= H.getLang() %>};
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