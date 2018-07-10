<% String title="Forget Your Password"; %>
<%@include  file="includes/header.jsp" %>
<div class="container">

<div class="col-sm-4 col-sm-offset-4 waiting-form insert admin-login">
	<form method="post" action="/HealthTrack/forgetmypassword/submit">
		<h4 class="waiting-header text-center"><%= t.write("change your password") %></h4>
		<div class="form-group">
			<label class="write-email">
	        	<%= t.write("please insert your email and we will send to you the instructions to set a new password") %>
        	</label>
		</div>
        <div class="form-group">
        	<input type="email" name="email" class="form-control" placeholder="<%= t.write("email") %>" required="required">
            <div class="waiting-icon"><i class="fa fa-envelope fa-2x"></i></div>
        </div>
        ${invalidEmail}
	    ${wrongeEmail} 
        <div class="form-group">
        	<input type="submit" value="<%= t.write("submit") %>" class="form-control btn btn-primary">
            <div class="waiting-icon submit-icon"><i class="fab fa-telegram-plane fa-2x"></i></div>
        </div>
	</form>
	</div>
</div>
<%@include  file="includes/footer.jsp" %>