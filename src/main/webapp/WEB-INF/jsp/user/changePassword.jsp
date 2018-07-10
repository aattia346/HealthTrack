<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>

<% String title="Change Password "; %>
<%@include  file="includes/header.jsp" %>

<% 
	String username = (String) session.getAttribute("username");
	
	User user = UserDao.getUserByUsername(username); 

%>

<div class="container">
	<div class="col-sm-4 col-sm-offset-4 waiting-form insert admin-login">
	<form method="post" action="/HealthTrack/changePassword/submit">
		<h4 class="waiting-header text-center"><%= t.write("set a new password") %></h4>
        <div class="form-group">
        	<input type="text" name="oldPassword" class="form-control" placeholder="<%= t.write("old password") %>" required="required">
            <div class="waiting-icon"><i class="fa fa-key fa-2x"></i></div>
        </div>
        ${wrongPassword}
        <div class="form-group">
        	<input type="password" name="password" class="form-control" placeholder="<%=t.write("new password") %>" required="required">
            <div class="waiting-icon"><i class="fa fa-unlock-alt fa-2x"></i></div>
        </div>
        ${invalidPassword}
        <div class="form-group">
        	<input type="password" name="confirmPassword" class="form-control" placeholder="<%=t.write("re-enter the password") %>" required="required">
            <div class="waiting-icon"><i class="fa fa-unlock-alt fa-2x"></i></div>
        </div>
        ${passwordNotMatch}
        <div class="form-group">
        	<input type="submit" value="<%= t.write("submit") %>" class="form-control btn btn-primary">
            <div class="waiting-icon submit-icon"><i class="fab fa-telegram-plane fa-2x"></i></div>
        </div>
	</form>
	</div>
</div>

<%@include  file="includes/footer.jsp" %>