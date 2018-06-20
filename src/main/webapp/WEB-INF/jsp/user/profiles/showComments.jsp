<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>
<%@page import="com.gp.user.Hospital"%>
<%@page import="com.gp.user.HospitalDao"%>
<%@page import="com.gp.user.Service"%>
<%@page import="com.gp.user.ServiceDao"%>
<%@page import="com.gp.user.Center"%>
<%@page import="com.gp.user.CenterDao"%>
<%@page import="com.gp.user.Clinic"%>
<%@page import="com.gp.user.ClinicDao"%>
<%@page import="com.gp.user.Pharmacy"%>
<%@page import="com.gp.user.PharmacyDao"%>
<%@page import="com.gp.user.Department"%>
<%@page import="com.gp.user.Review"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% 	String title = "comments";
    User user = new User();
	String username = (String)session.getAttribute("username");
	List<Service> services =new ArrayList<Service>();
	String placeName = "" ;
	String placeType ="";
	int placeId;
	int serviceId=0 ;
	if(username != null){
		user = UserDao.getUserByUsername(username);
		int userId= user.getId();
		
		if(user.getType().equalsIgnoreCase("center")){
			
			placeType ="center";
			Center center  = new Center();
			center         = CenterDao.getCenterById(userId);
			placeId        = center.getCenterId();
			placeName      = center.getCenterName();
			serviceId      =ServiceDao.getSrviceIdByCenterId(placeId);
			services       =ServiceDao.getServicesOfCenter(placeId);
			
			
		}else if (user.getType().equalsIgnoreCase("hospital")){
			placeType ="hospital";
			Hospital hospital =new Hospital();
			hospital = HospitalDao.getHospitalById(userId);
			placeId= hospital.getHospitalId();
			placeName =hospital.getHospitalName();	
			serviceId =ServiceDao.getSrviceIdByHospitalId(placeId);
			services=ServiceDao.getServicesOfHospital(placeId);
		//Department department = new Department();
			

		}
		List<Review> reviews= new ArrayList<Review>();		
		reviews=ServiceDao.getServiceReview(serviceId);
		request.setAttribute("reviews",reviews);
		
		//request.setAttribute("serviceId", serviceId);
		request.setAttribute("services", services);
		request.setAttribute("placeType",placeType);
		request.setAttribute("placeName", placeName);
			
		}
	
	

%>
<%@include  file="../includes/header.jsp" %>

        <div class="breadcrumbs">
            <div class="col-sm-4">
                <div class="page-header float-left">
                    <div class="page-title">
                        
                    </div>
                </div>
            </div>
            <div class="col-sm-8">
                <div class="page-header float-right">
                    <div class="page-title">
                        <ol class="breadcrumb text-right">
                           
                            <li>Comments</li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>

        <div class="content mt-3">
            <div class="animated fadeIn">
                <div class="row">

                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <strong class="card-title">Data Table</strong>
                        </div>
                        <div class="card-body">
                  <table id="bootstrap-data-table" class="table table-striped table-bordered">
                    <thead>
                      <tr>
                      	
                        <th>Service Id</th>
                        <th>PlaceName</th>
                        <th>service_review</th>
                        <th>Comment</th>
                        <th>Action</th>
                        
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="service" items="${services}">
                      	
                      	<% 
                      		Service service 	    = (Service)pageContext.getAttribute("service");                      	
                      	%>
                      	<tr>
                        <td><a href="/HealthTrack/profile/service/${placeType}/${service.serviceId}" target="_blank">${service.serviceId}</a></td>
                        <td><a href="/HealthTrack/profile/${placeType}/${service.serviceId}" target="_blank">${placeName}</a></td>
                        <% %>
                        
                        <td class="depts-td">
                        <c:forEach var="review" items="${reviews}">
                        	<div class="dept-in-hospital-table">
	                        	${review.review},
	                        	
	                        	
	                        	
                        	</div>
                        </c:forEach>
                      </td>
                        <td>
                        <c:forEach var="review" items="${reviews}">
                        	<div class="dept-in-hospital-table">
	                        	${review.comment},	
                        	</div>
                        </c:forEach></td>
                        <td>
                        <div>
                        <a class="dashboard-btn" href="/HealthTrack/admin/hospital/edit" title="Edit this hospital"><i class="fa fa-edit"></i></a>
                        <a class="dashboard-btn confirm-delete-hospital" href="/HealthTrack/admin" title="Delete this hospital"><i class="fa fa-close"></i></a>
                        </div>
                        </td>
                      </tr>
                      
                      </c:forEach>
                    
                    </tbody>
                  </table>
                        </div>
                    </div>
                    
                </div>

                </div>
            </div><!-- .animated -->
        </div><!-- .content -->

    </div><!-- /#right-panel -->

    <!-- Right Panel -->


    <%@include  file="../includes/footer.jsp" %>