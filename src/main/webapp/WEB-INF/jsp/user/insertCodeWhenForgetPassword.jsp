<% String title="Recover your Password"; %>
<%@include  file="includes/header.jsp" %>

<div class="container">
	<div class="col-sm-4 col-sm-offset-4 waiting-form insert admin-login">
		<form method="post" action="/HealthTrack/login/recovermypassword/submit">
			<h4 class="waiting-header text-center"><%= t.write("remember your passwored") %></h4>
			<div class="form-group">
				<label class="write-email">
		        	<%= t.write("please insert the code that we sent to your email") %>
	        	</label>
			</div>
	        <div class="form-group">
	        	<input type="text" name="code" class="form-control" placeholder="<%= t.write("example: 1234") %>" required="required">
	            <div class="waiting-icon"><i class="fa fa-lock-open fa-2x"></i></div>
	        </div>
	        ${wrongeCode} 
	        
	        <a href="/HealthTrack/forgetpassword/resendCode"><%= t.write("resend the code?") %></a>
	        
	        <div class="form-group">
	        	<input type="submit" value="<%= t.write("submit") %>" class="form-control btn btn-primary">
	            <div class="waiting-icon submit-icon"><i class="fab fa-telegram-plane fa-2x"></i></div>
	        </div>
		</form>
	</div>
</div>

<%@include  file="includes/footer.jsp" %>