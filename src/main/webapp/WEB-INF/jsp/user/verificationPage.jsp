<% String title="Verify Your Account"; %>
<%@include  file="includes/header.jsp" %>

<div class="container">

	<div class="col-sm-4 col-sm-offset-4 waiting-form insert admin-login">
		<form method="post" action="/HealthTrack/login/verifymyaccount/submit">
			<h4 class="waiting-header text-center"><%= t.write("verify your account",lang) %></h4>
			<div class="form-group">
				<label class="write-email">
		        	<%= t.write("please insert the code that we sent to your email",lang) %>
	        	</label>
			</div>
	        <div class="form-group">
	        	<input type="text" name="code" class="form-control" placeholder="<%= t.write("example: 1234",lang) %>" required="required">
	            <div class="waiting-icon"><i class="fa fa-lock-open fa-2x"></i></div>
	        </div>
	        ${wrongeCode} 
	        ${invalidCode}
	        
	        <a href="/HealthTrack/verifymyaccount/resendCode"><%= t.write("resend the code?",lang) %></a>
	        
	        <div class="form-group">
	        	<input type="submit" value="<%= t.write("submit",lang) %>" class="form-control btn btn-primary">
	            <div class="waiting-icon submit-icon"><i class="fab fa-telegram-plane fa-2x"></i></div>
	        </div>
		</form>
	</div>

</div>

<%@include  file="includes/footer.jsp" %>