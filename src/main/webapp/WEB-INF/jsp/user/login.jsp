<%@page import="javax.servlet.http.Cookie" %> 

<% String title="Login";%>

<%@include  file="includes/header.jsp" %>
<div class="login-body">


	<div class="container login-container">
    	<div class="row">
                    
        	<div class="login-header col-sm-6 col-sm-offset-4 col-lg-4">
        		<h3 class="text-center"> LOGIN </h3>
            </div>
                    
            <div class="col-lg-4 col-sm-offset-4 col-xs-12 login-form col-sm-6">

            	<form method="post" action="/HealthTrack/login/submit" >
                            
                	<div class="form-group">
                    	<label><%= t.write("username:") %></label>
                        <input type="text" class="form-control" name="username" placeholder="<%= t.write("username") %>" required value="${oldUsername}">                          
                    </div>
                            
                    ${invalidUsername}
                            
                    <div class="form-group">
                    	<label><%= t.write("password:") %></label>
                        <input type="password" class="form-control" name="password" placeholder="<%= t.write("password") %>" required>
                    </div>
                            
          	        ${notAuthenticated}
                            
                    <div class="form-group">
              	      <input type="submit" class="form-control btn btn-primary" value="<%= t.write("submit") %>">
                    </div>
                    
             	</form>
                        
                <div class="form-group">
	                <a class="text-center" href="/HealthTrack/login/forgetmypassword"><%= t.write("forget your password?") %></a>
                </div>
                        
                <div class="text-center">
                    <a href="/HealthTrack/signup" class="btn btn-danger form-control">
                       	<i class="fa fa-plus fa-lg"></i> <%= t.write("create new account") %>
                  	</a>
                  	
                </div>
                        
        	</div>

     	</div>
    </div>
 </div>
<%@include  file="includes/footer.jsp" %>