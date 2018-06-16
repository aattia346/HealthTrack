<% String title="Recover your Password"; %>
<%@include  file="includes/header.jsp" %>

<div class="login-body">
	<div class="container login-container">
	    	<div class="row">
	                    
	        	<div class="login-header col-sm-4 col-sm-offset-4">
	        		<h3 class="text-center"> <%= t.write("remember your passwored") %></h3>
	            </div>
	                    
	            <div class="col-sm-4 col-sm-offset-4 col-xs-12 login-form">
	
	            	<form method="post" action="/HealthTrack/login/recovermypassword/submit" >
	                            
	                	<div class="form-group">
	                    	<label class="write-email">
	                    	<%= t.write("please insert the code that we sent to your email") %></label>
	                        <input type="text" class="form-control" name="code" placeholder="<%= t.write("example: 1234") %>" required>                          
	                    </div>
	                    ${wrongeCode}        
	                    
	                     <a href="/HealthTrack/forgetpassword/resendCode"><%= t.write("resend the code?") %></a>
	                            
	                    <div class="form-group">
	              	      <input type="submit" class="form-control btn btn-info" value="<%= t.write("submit") %>">
	                    </div>
	 
	             	</form>
	       
	        	</div>
	
	     	</div>
	    </div>
</div>

<%@include  file="includes/footer.jsp" %>