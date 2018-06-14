<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>

<% String title="Change Password "; %>
<%@include  file="includes/header.jsp" %>

<% 
	String username = (String) session.getAttribute("username");
	
	User user = UserDao.getUserByUsername(username); 

%>

<div class="login-body">
	<div class="container login-container">
	    	<div class="row">
	                    
	        	<div class="login-header col-sm-4 col-sm-offset-4">
	        		<h3 class="text-center"> Set New Password</h3>
	            </div>
	                    
	            <div class="col-sm-4 col-sm-offset-4 col-xs-12 login-form">
	
	            	<form method="post" action="/HealthTrack/recoverPassword/submit">
	                            
	                	<div class="form-group">
	                        <input type="password" class="form-control" name="password" placeholder="new password" required>
	                        ${invalidPassword}
	                        <input type="password" class="form-control" name="confirmPassword" placeholder="Re-enter password" required>                          
	                    	${passwordNotMatch}
	                    </div>
	                            
	                    <div class="form-group">
	              	      <input type="submit" class="form-control btn btn-info" value="Submit">
	                    </div>
	 
	             	</form>
	       
	        	</div>
	
	     	</div>
	    </div>
</div>

<%@include  file="includes/footer.jsp" %>