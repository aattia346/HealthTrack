<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>
<%@page import="com.gp.user.Service"%>
<%@page import="com.gp.user.ServiceDao"%>
<%@page import="com.gp.user.Review"%>
<%@page import="com.gp.user.Hospital"%>
<%@page import="com.gp.user.HospitalDao"%>
<%@page import="com.gp.user.Department"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% 	String title = "Comments";

String username = (String)session.getAttribute("username");
User admin = UserDao.getUserByUsername(username);

List<Review> reviews = ServiceDao.getAllComments();
request.setAttribute("reviews", reviews);

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
                            <li><%=t.write("Comments",lang) %></li>
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
                            <strong class="card-title"><%=t.write("Data Table",lang) %></strong>
                        </div>
                        <div class="card-body">
                  <table id="bootstrap-data-table" class="table table-striped table-bordered">
                    <thead>
                      <tr>

                      	 <th><%=t.write("Review ID",lang) %></th>
                        <th><%=t.write("Name",lang) %></th>
                        <th class="comment-th"><%=t.write("Comment",lang) %></th>
                        <th><%=t.write("At",lang) %></th>
                        <th><%=t.write("Action",lang) %></th>


                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="review" items="${reviews}">
                      	<tr>

                        <td>${review.getReviewId()}</td>
                        <td>${review.userFirstName} ${booking.userLastName}</td>
                        <td>${review.comment}</td>
                        <td>${review.time}</td>
                        <td>
	                        <div>
	                        	<% Review r = (Review)pageContext.getAttribute("review");%>
		                    	<% if(r.getShowComment()==0){ %><a class="confirm-show-comment dashboard-btn" href="/HealthTrack/Service/ShowComment/<%= username %>/${review.reviewId}" title="<%=t.write("Show this comment",lang) %>"><i class="fa fa-check-circle"></i></a> <% }else{ %>
		                     	<a class="confirm-hide-comment dashboard-btn" href="/HealthTrack/Service/HideComment/<%= username %>/${review.reviewId}" title="<%=t.write("Hide this comment",lang) %>"><i class="fa fa-close"></i></a> <% } %>
	                         	<a class="confirm-delete-comment dashboard-btn" href="/HealthTrack/Service/DeleteComment/<%= username %>/${review.reviewId}" title="<%=t.write("Delete This comment",lang) %>"><i class="fa fa-trash"></i></a> 	
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

<%@include  file="includes/footer.jsp" %>