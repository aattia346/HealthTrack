<%@page import="com.gp.user.Translator"%>

<%

String lang = (String)request.getAttribute("lang");
Translator t = new Translator();
String title=t.write("Admin Login",lang);
%>

<!DOCTYPE html>
<html>
    <head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="/user/layout/css/bootstrap.min.css">
    <link rel="stylesheet" href="/user/layout/css/font-awesome.min.css">
    <link rel="stylesheet" href="/user/layout/css/stylesheet.css">

    </head>    
<body class="login-body">

<div class="col-sm-4 col-sm-offset-4 waiting-form insert admin-login">
	<form method="post" action="/HealthTrack/admin/login/submit">
		<h4 class="waiting-header text-center"><%= t.write("Admin Login",lang) %></h4>
        <div class="form-group">
        	<input type="text" name="username" class="form-control" placeholder="<%=t.write("Username",lang) %>" required="required">
            <div class="waiting-icon"><i class="fa fa-user fa-2x"></i></div>
        </div>
        ${invalidUsername}
        <div class="form-group">
        	<input type="password" name="password" class="form-control" placeholder="<%=t.write("Password" ,lang) %>" required="required">
            <div class="waiting-icon"><i class="fa fa-phone fa-2x"></i></div>
        </div>
        ${notAuthenticated}
        <div class="form-group">
        	<input type="submit" value="<%= t.write("submit" , lang) %>" class="form-control btn btn-primary">
            <div class="waiting-icon submit-icon"><i class="fa fa-send fa-2x"></i></div>
        </div>
	</form>
</div>

<script src="/user/layout/js/jquery-3.2.1.min.js"></script>
<script src="/user/layout/js/bootstrap.min.js"></script>
	</body>
</html>
