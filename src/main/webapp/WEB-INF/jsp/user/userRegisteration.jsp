<% String title="Register"; %>
<%@include  file="includes/header.jsp" %>

<div class="login-body">
            <div class="container login-container">
                <div class="row">
                    
                    <div class="login-header col-sm-4 col-sm-offset-4">
                        <h3 class="text-center"> Signup </h3>
                    </div>
                    
                    <div class="col-sm-4 col-sm-offset-4 col-xs-12 login-form">

                        <form method="post" action="/HealthTrack/signup/submit">
                            
                            <div class="form-group name">
                                <input type="text" class="form-control input-sm" name="firstName" placeholder="First Name" required maxlength="15"> 
                                
                                <input type="text" class="form-control input-sm" name="lastName" placeholder="Last Name" required maxlength="15"> 
                            	${invalidFirstName}
                            	${invalidLastName}
                            </div>
                            
                            <div class="form-group">
                                <input type="text" class="form-control" name="username" placeholder="Username" required maxlength="15">                          
                            	${invalidUsername}
                            	${usernameAlreadyExists}
                            </div>
                             <div class="form-group">
                                <input type="password" class="form-control" name="password" placeholder="Password" required maxlength="20">
                            	${invalidPassword}
                            </div>
                            <div class="form-group">
                                <input type="password" class="form-control" name="confirmPassword" placeholder="Confirm Your Password" required>
                            	${passwordNotMatch}
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" name="phone" placeholder="Your Phone Number(optional)">
                            	${invalidPhone}
                            </div>
                            <div class="form-group">
                                <input type="email" class="form-control" name="email" placeholder="Your Email" required>
                            	${invalidEmail}
                            	${emailAlreadyExists}
                            </div>
                            <div class="form-group">
                                <input type="submit" class="form-control btn btn-info" value="Submit">
                            </div>
                        
                        </form>

                    </div>

                </div>
            </div>
        </div>

<%@include  file="includes/footer.jsp" %>