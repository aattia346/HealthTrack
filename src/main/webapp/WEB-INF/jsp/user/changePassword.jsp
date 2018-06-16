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
	        		<h3 class="text-center"> <%= t.write("set a new password") %></h3>
	            </div>
	                    
	            <div class="col-sm-4 col-sm-offset-4 col-xs-12 login-form">
	
	            	<form method="post" action="/HealthTrack/changePassword/submit">
	                            
	                	<div class="form-group">
	                    	<input type="text" class="form-control" name="oldPassword" placeholder="<%= t.write("old password") %>" required>
	                        ${wrongPassword}
	                        <input type="password" class="form-control" name="password" placeholder="<%= t.write("new password") %>" required>
	                        ${invalidPassword}
	                        <input type="password" class="form-control" name="confirmPassword" placeholder="<%= t.write("re-enter the password") %>" required>                          
	                    	${passwordNotMatch}
	                    </div>
	                            
	                    <div class="form-group">
	              	      <input type="submit" class="form-control btn btn-info" value=" <%= t.write("submit") %>">
	                    </div>
	 
	             	</form>
	       
	        	</div>
	
	     	</div>
	    </div>
</div>

<%@include  file="includes/footer.jsp" %>