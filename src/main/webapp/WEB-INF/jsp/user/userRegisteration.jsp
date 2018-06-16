<% String title="Register"; %>
<%@include  file="includes/header.jsp" %>

<div class="login-body">
            <div class="container login-container">
                <div class="row">
                    
                    <div class="login-header col-sm-4 col-sm-offset-4">
                        <h3 class="text-center"> <%= t.write("signup") %> </h3>
                    </div>
                    
                    <div class="col-sm-4 col-sm-offset-4 col-xs-12 login-form">

                        <form method="post" action="/HealthTrack/signup/submit">
                            
                            <div class="form-group register-name">
                                <input type="text" class="form-control input-sm" name="firstName" placeholder="<%= t.write("first name") %>" required maxlength="15" value="${oldFirstName}"> 
                                
                                <input type="text" class="form-control input-sm" name="lastName" placeholder="<%= t.write("last name") %>" required maxlength="15" value="${oldLastName}"> 
                            	${invalidFirstName}
                            	${invalidLastName}
                            </div>
                            
                            <div class="form-group">
                                <input type="text" class="form-control" name="username" placeholder="<%= t.write("username") %>" required maxlength="15" value="${oldUsername}">                          
                            	${invalidUsername}
                            	${usernameAlreadyExists}
                            </div>
                             <div class="form-group">
                                <input type="password" class="form-control" name="password" placeholder="<%= t.write("password") %>" required maxlength="20">
                            	${invalidPassword}
                            </div>
                            <div class="form-group">
                                <input type="password" class="form-control" name="confirmPassword" placeholder="<%= t.write("confirm your password") %>" required>
                            	${passwordNotMatch}
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" name="phone" placeholder="<%= t.write("your phone number") +"  "+ t.write("(optional)") %>" value="${oldPhone}">
                            	${invalidPhone}
                            </div>
                            <div class="form-group">
                                <input type="email" class="form-control" name="email" placeholder="<%= t.write("email") %>" required value="${oldEmail}">
                            	${invalidEmail}
                            	${emailAlreadyExists}
                            	${bannedEmail}
                            </div>
                            <div class="form-group">
                                <input type="submit" class="form-control btn btn-primary" value="<%= t.write("submit") %>">
                            </div>
                        
                        </form>

                    </div>

                </div>
            </div>
        </div>

<%@include  file="includes/footer.jsp" %>