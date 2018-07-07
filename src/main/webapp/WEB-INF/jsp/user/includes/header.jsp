<%@page import="com.gp.user.Translator"%>
<%@page import="org.apache.commons.text.WordUtils" %>
<%
    
    	String lang = (String)request.getAttribute("lang");

    	Translator t = new Translator(lang);
    
    %>
     	 
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title><%= WordUtils.capitalize(t.write(title)) %></title>

		<link rel="stylesheet" href="/user/layout/css/profiles/style.css">
        <link rel="stylesheet" href="/user/layout/css/bootstrap.min.css">
        <link rel="stylesheet" href="/user/layout/css/font-awesome.min.css">
        <link rel="stylesheet" href="/user/layout/css/jquery-ui.min.css">
        <link rel="stylesheet" href="/user/layout/css/jquery.selectBoxIt.css">
        <link rel="stylesheet" href="/user/layout/css/fullcalendar.css">
        <link rel="stylesheet" href="/user/layout/css/jquery.rateyo.css">
        <link href="https://fonts.googleapis.com/css?family=El+Messiri" rel="stylesheet">
        
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
                        <div class="h-100 d-md-flex justify-content-between align-items-center text-capitalize">
                            <p class="welcome-msg"><%= t.write("welcome to healthtrack") %></p>
                        	<div class="translation"><img title="<%= t.write("english") %>" id="en" class="translate text-capitalize" src="/user/layout/images/england.png"><img id="ar" class="translate" title="<%= t.write("arabic") %>" src="/user/layout/images/egypt.svg"></div>
                        </div>
                        <% if(sessionExist){ %>
                        <div class="navbar-user">
	                         <div class="btn-group pull-right">
	                            <span class="btn btn-default dropdown-toggle btn-sm user-dropdown" data-toggle="dropdown">
	                                <%= headerUsername %>
	                                <span class="caret"></span>
	                             </span>
	                                <ul class="dropdown-menu text-capitalize">
	                                    <li><a href="/HealthTrack/MyProfile"><%= t.write("my profile") %></a></li>
	                                    <li><a href="#">My Ads</a></li>
	                                    <li><a href="#">New Item</a></li>
	                                    <li><a href="/HealthTrack/<%= headerUsername %>/changePassword"><%= t.write("change password") %></a></li>
	                                    <li><a href="/HealthTrack/logout"><%= t.write("logout") %></a></li>
	                                </ul>
	                        </div>
	                        </div>
	                        <% }else{ %>
                        		<div class='login-register pull-right text-capitalize'><a href="/HealthTrack/login"><%= t.write("login") %></a>&nbsp; | &nbsp; <a href="/HealthTrack/signup"><%= t.write("signup") %></a></div>
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
                                <a class="navbar-brand" href="/HealthTrack">Health Service Navigator</a>

                                <div class="collapse navbar-collapse" id="medilifeMenu">
                                    <!-- Menu Area -->
                                    <ul class="navbar-nav ml-auto text-capitalize">
                                        <li class="nav-item active">
                                            <a class="nav-link" href="index.html"><%= t.write("home") %></a>
                                        </li>
                                        
                                        <li class="nav-item">
                                            <a class="nav-link" href="about-us.html"><%= t.write("about us") %></a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="services.html"><%= t.write("services") %></a>
                                        </li>
                                       
                                        <li class="nav-item">
                                            <a class="nav-link" href="contact.html"><%= t.write("contact") %></a>
                                        </li>
                                    </ul>
                                    <!-- Appointment Button -->
                                    <a href="/HealthTrack/Emergency" class="btn medilife-appoint-btn ml-30"><%= t.write("for") %> <span><%= t.write("emergencies") %></span> <%= t.write("click here") %></a>
                                </div>
                         <% if(sessionExist){ %>
                        <div class="navbar-user">
	                         <div class="btn-group pull-right">
	                            <span class="btn btn-default dropdown-toggle btn-sm user-dropdown" data-toggle="dropdown">
	                                <%= headerUsername %>
	                                <span class="caret"></span>
	                             </span>
	                                <ul class="dropdown-menu text-capitalize">
	                                    <li><a href="/HealthTrack/MyProfile"><%= t.write("my profile") %></a></li>
	                                    <li><a href="#">My Ads</a></li>
	                                    <li><a href="#">New Item</a></li>
	                                    <li><a href="/HealthTrack/<%= headerUsername %>/changePassword"><%= t.write("change password") %></a></li>
	                                    <li><a href="/HealthTrack/logout"><%= t.write("logout") %></a></li>
	                                </ul>
	                        </div>
	                        </div>
	                        <% }else{ %>
	                        <div class="mobile-view">
                        		<div class='mobile-view-login-register login-register pull-right text-capitalize'><a href="/HealthTrack/login"><%= t.write("login") %></a>&nbsp; | &nbsp; <a href="/HealthTrack/signup"><%= t.write("signup") %></a></div>
	                        	<br><br><br>
	                        <% }%>
	                       	<div class="mobile-view-translation translation"><img title="<%= t.write("english") %>" id="en" class="translate text-capitalize" src="/user/layout/images/england.png"><img id="ar" class="translate" title="<%= t.write("arabic") %>" src="/user/layout/images/egypt.svg"></div>
	                    </div>
                             </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </div>
    </header>
    <!-- ***** Header Area End ***** -->