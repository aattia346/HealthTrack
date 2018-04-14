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
                            <p>Welcome to <span>Medifile</span> template</p>
                            <p class="pull-right">Opening Hours : Monday to Saturday - 8am to 10pm Contact : <span>+12-823-611-8721</span></p>
                        </div>
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
                                            <a class="nav-link" href="index.html">Home</a>
                                        </li>
                                        <li class="nav-item dropdown">
                                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Pages</a>
                                            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                                <a class="dropdown-item" href="index.html">Home</a>
                                                <a class="dropdown-item" href="about-us.html">About Us</a>
                                                <a class="dropdown-item" href="services.html">Services</a>
                                                <a class="dropdown-item" href="blog.html">News</a>
                                                <a class="dropdown-item" href="single-blog.html">News Details</a>
                                                <a class="dropdown-item" href="contact.html">Contact</a>
                                                <a class="dropdown-item" href="elements.html">Elements</a>
                                                <a class="dropdown-item" href="index-icons.html">All Icons</a>
                                            </div>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="about-us.html">About Us</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="services.html">Services</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="blog.html">News</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="contact.html">Contact</a>
                                        </li>
                                    </ul>
                                    <!-- Appointment Button -->
                                    <a href="#" class="btn medilife-appoint-btn ml-30">For <span>emergencies</span> Click here</a>
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
