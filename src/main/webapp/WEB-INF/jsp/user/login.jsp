<%@page import="javax.servlet.http.Cookie" %> 
<% String title="Login";%>

<%@include  file="includes/header.jsp" %>
<div class="login-body">
	
	<div class="col-sm-4 col-sm-offset-4 waiting-form insert admin-login">
		<form method="post" action="/HealthTrack/login/submit">
			<h4 class="waiting-header text-center"><%= t.write("login") %></h4>
	        <div class="form-group">
	        	<input type="text" name="username" class="form-control" placeholder="<%=t.write("Username") %>" required="required" value="${oldUsername}">
	            <div class="waiting-icon"><i class="fa fa-user fa-2x"></i></div>
	        </div>
	        ${invalidUsername}
	        <div class="form-group">
	        	<input type="password" name="password" class="form-control" placeholder="<%=t.write("Password") %>" required="required">
	            <div class="waiting-icon"><i class="fa fa-lock fa-2x"></i></div>
	        </div>
	        ${notAuthenticated}
	        <div class="form-group">
	        	<input type="submit" value="<%= t.write("submit") %>" class="form-control btn btn-primary">
	            <div class="waiting-icon submit-icon"><i class="fab fa-telegram-plane fa-2x"></i></div>
	        </div>
		</form>
		
		<div class="form-group">
			<a class="text-center" href="/HealthTrack/login/forgetmypassword"><%= t.write("forget your password?") %></a>
	    </div>
	    
	    <div class="form-group register-in-login-page">
	    	<a href="/HealthTrack/signup" class="btn btn-danger form-control">
	    		<%= t.write("create new account") %>
	       	</a>
	       	<div class="register-icon-login-page"><i class="fa fa-plus fa-2x"></i> </div>
	    </div>
	</div>
</div>
<%@include  file="includes/footer.jsp" %>