<% String title="Login"; %>
<%@include  file="includes/header.jsp" %>
<div class="login-body">
<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = 'https://connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v2.12&appId=145236359485290&autoLogAppEvents=1';
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>
	<div class="container login-container">
    	<div class="row">
                    
        	<div class="login-header col-sm-6 col-sm-offset-4 col-lg-4">
        		<h3 class="text-center"> LOGIN </h3>
            </div>
                    
            <div class="col-lg-4 col-sm-offset-4 col-xs-12 login-form col-sm-6">

            	<form method="post" action="/HealthTrack/login/submit" >
                            
                	<div class="form-group">
                    	<label>Username:</label>
                        <input type="text" class="form-control" name="username" placeholder="Username" required>                          
                    </div>
                            
                    ${invalidUsername}
                            
                    <div class="form-group">
                    	<label>Password:</label>
                        <input type="password" class="form-control" name="password" placeholder="Password" required>
                    </div>
                            
          	        ${notAuthenticated}
                            
                    <div class="form-group">
              	      <input type="submit" class="form-control btn btn-primary" value="Submit">
                    </div>
                    
             	</form>
                        
                <div class="form-group">
	                <a class="text-center" href="/HealthTrack/login/forgetmypassword">Forget your password?</a>
                </div>
                        
                <div class="text-center">
                    <a href="/HealthTrack/signup" class="btn btn-danger form-control">
                       	<i class="fa fa-plus fa-lg"></i> Create New Account
                  	</a>
                </div>
                        
        	</div>

     	</div>
    </div>
 </div>
<%@include  file="includes/footer.jsp" %>