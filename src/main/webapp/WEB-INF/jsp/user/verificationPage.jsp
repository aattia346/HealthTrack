<% String title="Verify Your Account"; %>
<%@include  file="includes/header.jsp" %>

<div class="login-body">
	<div class="container login-container">
	    	<div class="row">
	                    
	        	<div class="login-header col-sm-4 col-sm-offset-4">
	        		<h3 class="text-center"> Verify Your Account</h3>
	            </div>
	                    
	            <div class="col-sm-4 col-sm-offset-4 col-xs-12 login-form">
	
	            	<form method="post" action="/HealthTrack/login/verifymyaccount/submit" >
	                            
	                	<div class="form-group">
	                    	<label class="write-email">
	                    	Please insert the code we sent to your email to verify your account</label>
	                        <input type="text" class="form-control" name="code" placeholder="Example: 1234" required>                          
	                    </div>
	                    ${wrongeCode}  
	                    ${invalidCode}      

	                    <a href="/HealthTrack/verifymyaccount/resendCode">Resend the code?</a>
	                            
	                    <div class="form-group">
	              	      <input type="submit" class="form-control btn btn-info" value="Submit">
	                    </div>
	 
	             	</form>
	       
	        	</div>
	
	     	</div>
	    </div>
</div>

<%@include  file="includes/footer.jsp" %>