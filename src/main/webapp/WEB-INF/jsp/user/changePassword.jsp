<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>

<% String title="Change Password "; %>
<%@include  file="includes/header.jsp" %>

<% 
	String username = (String) session.getAttribute("username");
	
	User user = UserDao.getUserByUsername(username); 

%>

<<<<<<< HEAD
<div class="login-body">

=======
<div class="container">
>>>>>>> fd4ffbeb8a30a0c6b1dbd8c4a02ff2817631c8d1
	<div class="col-sm-4 col-sm-offset-4 waiting-form insert admin-login">
	<form method="post" action="/HealthTrack/changePassword/submit">
		<h4 class="waiting-header text-center"><%= t.write("set a new password",lang) %></h4>
        <div class="form-group">
        	<input type="text" name="oldPassword" class="form-control" placeholder="<%= t.write("old password",lang) %>" required="required">
            <div class="waiting-icon"><i class="fa fa-key fa-2x"></i></div>
        </div>
        ${wrongPassword}
        <div class="form-group">
        	<input type="password" name="password" class="form-control" placeholder="<%=t.write("new password",lang) %>" required="required">
            <div class="waiting-icon"><i class="fa fa-unlock-alt fa-2x"></i></div>
        </div>
        ${invalidPassword}
        <div class="form-group">
        	<input type="password" name="confirmPassword" class="form-control" placeholder="<%=t.write("re-enter the password",lang) %>" required="required">
            <div class="waiting-icon"><i class="fa fa-unlock-alt fa-2x"></i></div>
        </div>
        ${passwordNotMatch}
        <div class="form-group">
        	<input type="submit" value="<%= t.write("submit",lang) %>" class="form-control btn btn-primary">
            <div class="waiting-icon submit-icon"><i class="fab fa-telegram-plane fa-2x"></i></div>
        </div>
	</form>
	</div>

</div>

<%@include  file="includes/footer.jsp" %>