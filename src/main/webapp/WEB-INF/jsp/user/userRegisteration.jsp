<% String title="Register"; %>
<%@include  file="includes/header.jsp" %>

<div class="login-body">
	<div class="col-sm-4 col-sm-offset-4 waiting-form insert admin-login">
		<form method="post" action="/HealthTrack/signup/submit">
			<h4 class="waiting-header text-center"><%= t.write("signup") %></h4>
			
			<div class="form-group register-name">
	        	<input type="text" name="firstName" class="form-control" placeholder="<%=t.write("first name") %>" required="required" maxlength="15" value="${oldFirstName}">
	            <input type="text" name="lastName" class="form-control" placeholder="<%=t.write("last name") %>" required="required" maxlength="15" value="${oldLastName}">
	        </div>
			${invalidFirstName}
            ${invalidLastName}
	        <div class="form-group">
	        	<input type="text" name="username" class="form-control" placeholder="<%=t.write("Username") %>" required="required" value="${oldUsername}" maxlength="15">
	            <div class="waiting-icon"><i class="fa fa-user fa-2x"></i></div>
	        </div>
	        ${invalidUsername}
            ${usernameAlreadyExists}
	        <div class="form-group">
	        	<input type="password" name="password" class="form-control" placeholder="<%=t.write("Password") %>" required="required" maxlength="20">
	            <div class="waiting-icon"><i class="fa fa-lock fa-2x"></i></div>
	        </div>
	        ${invalidPassword}
	         <div class="form-group">
	        	<input type="password" name="confirmPassword" class="form-control" placeholder="<%=t.write("confirm your password") %>" required="required">
	            <div class="waiting-icon"><i class="fa fa-check-square fa-2x"></i></div>
	        </div>
	        ${passwordNotMatch}
	        <div class="form-group">
	        	<input type="text" name="phone" class="form-control" placeholder="<%= t.write("your phone number") +"  "+ t.write("(optional)") %>" value="${oldPhone}">
	            <div class="waiting-icon"><i class="fa fa-phone fa-2x"></i></div>
	        </div>
	        ${invalidPhone}
	        <div class="form-group">
	        	<input type="email" name="email" class="form-control" placeholder="<%= t.write("email") %>" required value="${oldEmail}">
	            <div class="waiting-icon"><i class="fa fa-envelope-open fa-2x"></i></div>
	        </div>
	        ${invalidEmail}
            ${emailAlreadyExists}
            ${bannedEmail}
	        <div class="form-group">
	        	<input type="submit" value="<%= t.write("submit") %>" class="form-control btn btn-primary">
	            <div class="waiting-icon submit-icon"><i class="fab fa-telegram-plane fa-2x"></i></div>
	        </div>
		</form>
	</div>

</div>

<%@include  file="includes/footer.jsp" %>