<%@page import="com.gp.user.Translation"%>
<%
    
    	String lang = (String)request.getAttribute("lang");

    	Translation t = new Translation(lang);
    
    %>
     	 
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title><%= title %></title>

		<link rel="stylesheet" href="/user/layout/css/profiles/style.css">
        <link rel="stylesheet" href="/user/layout/css/bootstrap.min.css">
        <link rel="stylesheet" href="/user/layout/css/font-awesome.min.css">
        <link rel="stylesheet" href="/user/layout/css/jquery-ui.min.css">
        <link rel="stylesheet" href="/user/layout/css/jquery.selectBoxIt.css">
        <link rel="stylesheet" href="/user/layout/css/fullcalendar.css">
        <link rel="stylesheet" href="/user/layout/css/jquery.rateyo.css">
        
       	<link rel="stylesheet" href="/user/layout/css/stylesheet.css">

    </head>    
<body>
	
	<%
	boolean sessionExist = false;
	HttpSession headerSession = request.getSession();
	String headerUsername = (String)session.getAttribute("username");
	if(headerUsername == null) {
		sessionExist = false;
	}else {
		sessionExist = true;
	}
	
	%>
	
	    <!-- ***** Header Area Start ***** -->
    <header class="header-area">
        <!-- Top Header Area -->
        <div class="top-header-area">
            <div class="container h-100">
                <div class="row h-100">
                    <div class="col-12 h-100">
                        <div class="h-100 d-md-flex justify-content-between align-items-center">
                            <p><%= t.write("Welcome to") %><span><%= t.write("HealthTrack") %></span></p>
                            <p class="pull-right" style="margin-right: 30px;"><%= t.write("introduction to healthtrack") %><span>+12-823-611-8721</span></p>
                        </div>
                        <% if(sessionExist){ %>
                        <div class="navbar-user">
                            <img class="img-circle upper-img img-thumbnail" src="/user/layout/images/default.jpg">
	                         <div class="btn-group pull-right">
	                            <span class="btn btn-default dropdown-toggle btn-sm user-dropdown" data-toggle="dropdown">
	                                <%= headerUsername %>
	                                <span class="caret"></span>
	                             </span>
	                                <ul class="dropdown-menu">
	                                    <li><a href="#"><%= t.write("My Profile") %></a></li>
	                                    <li><a href="#">My Ads</a></li>
	                                    <li><a href="#">New Item</a></li>
	                                    <li><a href="/HealthTrack/<%= headerUsername %>/changePassword"><%= t.write("change password") %></a></li>
	                                    <li><a href="/HealthTrack/logout"><%= t.write("logout") %></a></li>
	                                </ul>
	                        </div>
	                        </div>
	                        <% }else{ %>
	                        	<a href='/HealthTrack/login' class="login-signup">
                        			<span class='pull-right'><%= t.write("login") %>&nbsp; | &nbsp; <%= t.write("signup") %></span>
                    			</a>
	                        <% }%>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Header Area -->
        <div id="stickyHeader-sticky-wrapper" class="sticky-wrapper">
        <div class="main-header-area" id="stickyHeader">
            <div class="container h-100">
                <div class="row h-100 align-items-center">
                    <div class="col-12 h-100">
                        <div class="main-menu h-100">
                            <nav class="navbar h-100 navbar-expand-lg">
                                <!-- Logo Area  -->
                                <a class="navbar-brand" href="index.html">Health Service Navigator</a>

                                <div class="collapse navbar-collapse" id="medilifeMenu">
                                    <!-- Menu Area -->
                                    <ul class="navbar-nav ml-auto">
                                        <li class="nav-item active">
                                            <a class="nav-link" href="index.html"><%= t.write("Home") %></a>
                                        </li>
                                        
                                        <li class="nav-item">
                                            <a class="nav-link" href="about-us.html"><%= t.write("About Us") %></a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="services.html"><%= t.write("Services") %></a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="blog.html"><%= t.write("News") %></a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="contact.html"><%= t.write("Contact") %></a>
                                        </li>
                                    </ul>
                                    <!-- Appointment Button -->
                                    <a href="#" class="btn medilife-appoint-btn ml-30"><%= t.write("for") %> <span><%= t.write("emergencies") %></span> <%= t.write("click here") %></a>
                                </div>
                                <a id="en" class="translate"><%= t.write("English") %></a>
						       &nbsp;|&nbsp;
						        <a id="ar" class="translate"><%= t.write("Arabic") %></a>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </div>
    </header>
    <!-- ***** Header Area End ***** -->