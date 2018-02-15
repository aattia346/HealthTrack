<% String title="Forget Your Password"; %>
<%@include  file="includes/header.jsp" %>
<div class="login-body">
	<div class="container login-container">
	    	<div class="row">
	                    
	        	<div class="login-header col-sm-4 col-sm-offset-4">
	        		<h3 class="text-center"> Change Your Password</h3>
	            </div>
	                    
	            <div class="col-sm-4 col-sm-offset-4 col-xs-12 login-form">
	
	            	<form method="post" action="/HealthTrack/forgetmypassword/submit" >
	                            
	                	<div class="form-group">
	                    	<label class="write-email">
	                    	Please insert your email and we will send to you the instructions to
	                    	 set a new password</label>
	                        <input type="email" class="form-control" name="email" placeholder="Email" required>                          
	                    </div>
	                            
	                    ${invalidEmail}
	                    ${wrongeEmail}        
                 
	                    <div class="form-group">
	              	      <input type="submit" class="form-control btn btn-info" value="Submit">
	                    </div>
	 
	             	</form>
	       
	        	</div>
	
	     	</div>
	    </div>
</div>
<%@include  file="includes/footer.jsp" %>