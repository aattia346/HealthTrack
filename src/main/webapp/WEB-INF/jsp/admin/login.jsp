<% String title="Login"; %>
<%@include  file="../user/includes/header.jsp" %>
<div class="login-body">
	<div class="container login-container">
    	<div class="row">
                    
        	<div class="login-header col-sm-6 col-sm-offset-4 col-lg-4">
        		<h3 class="text-center"><%=t.write("ADMIN LOGIN") %>  </h3>
            </div>
                    
            <div class="col-lg-4 col-sm-offset-4 col-xs-12 login-form col-sm-6">

            	<form method="post" action="/HealthTrack/admin/login/submit" >
                            
                	<div class="form-group">
                    	<label><%=t.write("Username:") %></label>
                        <input type="text" class="form-control" name="username" placeholder=<%=t.write("Username") %> required>                          
                    </div>
                            
                    ${invalidUsername}
                            
                    <div class="form-group">
                    	<label><%=t.write("Password:") %></label>
                        <input type="password" class="form-control" name="password" placeholder=<%=t.write("Password") %> required>
                    </div>
                            
          	        ${notAuthenticated}
                            
                    <div class="form-group">
              	      <input type="submit" class="form-control btn btn-primary admin-login-submit-btn" value="Submit">
                    </div>
                    
             	</form>
                        
        	</div>

     	</div>
    </div>
 </div>
<%@include  file="includes/footer.jsp" %>