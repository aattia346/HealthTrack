<%@page import="com.gp.user.Translator"%>
<%@page import="com.gp.user.ContactDao"%>
<%@page import="com.gp.user.Contact"%>
<%@page import="java.util.List"%> 
<%@page import="org.apache.commons.text.WordUtils" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    
    	String lang = (String)request.getAttribute("lang");


    	Translator t = new Translator();
    	
    	int unseenContacts = ContactDao.countUnseenContacts();
    	
    	List<Contact> contacts = ContactDao.getUnseenContacts();
    	request.setAttribute("unseencontacts", contacts);

    %>

<!DOCTYPE html>
<html>
    <head>
    <meta charset="utf-8">
    <title><%= WordUtils.capitalize(t.write(title,lang)) %></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
  
    <meta name="description" content="Sufee Admin - HTML5 Admin Template">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="apple-touch-icon" href="apple-icon.png">
    <link rel="shortcut icon" href="favicon.ico">

    

    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800' rel='stylesheet' type='text/css'>
    
        <meta charset="UTF-8">
        
	    
        <link rel="stylesheet" href="/admin/assets/css/normalize.css">
	    <link rel="stylesheet" href="/admin/assets/css/bootstrap.min.css">
	    <link rel="stylesheet" href="/admin/assets/css/font-awesome.min.css">
	    <link rel="stylesheet" href="/admin/assets/css/themify-icons.css">
	    <link rel="stylesheet" href="/admin/assets/css/flag-icon.min.css">
	    <link rel="stylesheet" href="/admin/assets/css/cs-skin-elastic.css">
	    <!-- <link rel="stylesheet" href="assets/css/bootstrap-select.less"> -->
	    <link rel="stylesheet" href="/admin/assets/scss/style.css">
	    <link rel="stylesheet" href="/admin/assets/css/stylesheet.css">
	    <link href="/admin/assets/css/lib/vector-map/jqvmap.min.css" rel="stylesheet">
	    <link rel="stylesheet" href="/admin/assets/css/lib/datatable/dataTables.bootstrap.min.css">    
    </head>        
    <style>
    	.translation {
    		position: relative;
    	}
    	.translation img:first-of-type{
			width: 39px;
		    height: 34px;
		    margin: 20px;
		    position: absolute;
		    top: -15px;
		    right: 90px;
		    cursor: pointer;
		}
		.translation img:nth-of-type(2){
			width: 53px;
		    height: 44px;
		    margin: 20px;
		    margin-right: -7px;
		    position: absolute;
		    top: -19px;
		    right: 60px;
		    cursor: pointer;
		}
    </style>
<body>

<aside id="left-panel" class="left-panel">
        <nav class="navbar navbar-expand-sm navbar-default">

            <div class="navbar-header">
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#main-menu" aria-controls="main-menu" aria-expanded="false" aria-label="Toggle navigation">
                    <i class="fa fa-bars"></i>
                </button>
                     <span class="brand-dashboard navbar-brand navbar-brand-dashboard">Health Services Navigator<img src="/user/layout/images/logo.png"></a>
               
            </div>

            <div id="main-menu" class="main-menu collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li class="active">
                        <a href="/HealthTrack/admin/dashboard"> <i class="menu-icon fa fa-dashboard"></i><%=t.write("Dashboard",lang) %> </a>
                    </li>
                    <h3 class="menu-title">Services</h3><!-- /.menu-title -->
                    
                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="menu-icon fa fa-table"></i><%=t.write("Locations",lang) %></a>
                        <ul class="sub-menu children dropdown-menu">
                            <li><i class="fa fa-h-square menu-icon"></i><a href="/HealthTrack/admin/<%= admin.getUsername()%>/hospitals"><%=t.write("Hospitals",lang) %></a></li>
                            <li><i class="fa fa-h-square menu-icon"></i><a href="/HealthTrack/admin/<%= admin.getUsername()%>/departments"><%=t.write("Departments",lang) %></a></li>
                            <li><i class="fa fa-stethoscope"></i><a href="/HealthTrack/admin/<%= admin.getUsername()%>/clinics"><%=t.write("Clinics",lang) %></a></li>
                            <li><img src="/admin/icons/if_medical_icon_3_1290986.svg" class="my-icon"><a href="/HealthTrack/admin/<%= admin.getUsername()%>/centers"><%=t.write("Centers",lang) %></a></li>
                            <li><img src="/admin/icons/if_pill_36347.png" class="my-icon pharmacy-icon"><a href="/HealthTrack/admin/<%= admin.getUsername()%>/pharmacies"><%=t.write("Pharmacies",lang) %></a></li>
                            <li><img src="/admin/icons/mri.svg" class="my-icon"><a href="/HealthTrack/admin/<%= admin.getUsername()%>/services"><%=t.write("Services",lang) %></a></li>
                            
                        </ul>
                    </li>

                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-calendar menu-icon"></i><%=t.write("Bookings",lang) %></a>
                        <ul class="sub-menu children dropdown-menu">
                            <li><i class="fa fa-calendar"></i><a href="/HealthTrack/admin/<%= admin.getUsername()%>/daySlotBooking"><%=t.write("Day Slots",lang) %></a></li>
                            <li><i class="fa fa-calendar"></i><a href="/HealthTrack/admin/<%= admin.getUsername()%>/timeSlotBooking"><%=t.write("Time Slots",lang) %></a></li>
                        </ul>
                    </li>
                    
                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="menu-icon fa fa-users"></i><%=t.write("Users",lang) %></a>
                        <ul class="sub-menu children dropdown-menu">
                            <li><i class="fa fa-h-square"></i><a href="/HealthTrack/admin/<%= admin.getUsername()%>/users"><%=t.write("All Users",lang) %></a></li>
                            <li><i class="fa fa-ban"></i><a href="/HealthTrack/admin/<%= admin.getUsername()%>/bannedUsers"><%=t.write("Banned Users",lang) %></a></li>
                        </ul>
                    </li>
                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="menu-icon fa fa-plus-square"></i><%=t.write("Others",lang) %></a>
                        <ul class="sub-menu children dropdown-menu">
                            <li><i class="fa fa-phone-square"></i><a href="/HealthTrack/admin/<%= admin.getUsername()%>/Contacts"><%=t.write("Contacts",lang) %></a></li>
                            <li><i class="fa fa-comment"></i><a href="/HealthTrack/admin/<%= admin.getUsername()%>/Comments"><%=t.write("Comments",lang) %></a></li>
                        </ul>
                    </li>
                    
                </ul>
            </div><!-- /.navbar-collapse -->
        </nav>
    </aside>
    
    <div id="right-panel" class="right-panel">

        <!-- Header-->
        <header id="header" class="header">

            <div class="header-menu">

                <div class="col-sm-7">
                    <a id="menuToggle" class="menutoggle pull-left"><i class="fa fa fa-tasks"></i></a>
                    <div class="header-left">
                        <button class="search-trigger"><i class="fa fa-search"></i></button>
                        <div class="form-inline">
                            <form class="search-form">
                                <input class="form-control mr-sm-2" type="text" placeholder="Search ..." aria-label="Search">
                                <button class="search-close" type="submit"><i class="fa fa-close"></i></button>
                            </form>
                        </div>

                        <div class="dropdown for-notification">
                          <button class="btn btn-secondary dropdown-toggle" type="button" id="notification" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fa fa-bell"></i>
                            <span class="count bg-danger"><%= unseenContacts %></span>
                          </button>
                          <div class="dropdown-menu" aria-labelledby="notification">

                            <p class="red"><%=t.write("You have",lang) + " " + unseenContacts + " " + t.write("Notifications",lang) %></p>
                            	<c:forEach var="contact" items="${unseencontacts}">
                            		<a class="dropdown-item media bg-flat-color" href="/HealthTrack/admin/<%= admin.getUsername() %>/Contacts#contact-${contact.contactId}">
                            			<p><%= t.write("Contact",lang) %>#${contact.contactId}  <%= t.write("from",lang) %> ${contact.name}</p>
                            		</a>
                            	</c:forEach>

                          </div>
                        </div>
                    </div>
                </div>

                <div class="col-sm-5">
                    <div class="user-area dropdown float-right">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <img class="user-avatar rounded-circle" src="/admin/images/admin.jpg" alt="User Avatar">
                        </a>

                        <div class="user-menu dropdown-menu">

                                <a class="nav-link" href="/HealthTrack/admin/dashboard"><i class="fa fa- user"></i><%=t.write("Dashboard",lang) %></a>

                                <a class="nav-link" href="#"><i class="fa fa- user"></i><%=t.write("Contacts",lang) %> <span class="count"><%= ContactDao.countUnseenContacts() %></span></a>

                                <a class="nav-link" href="/HealthTrack/<%= admin %>/changePassword"><i class="fa fa -cog"></i><%=t.write("Change Password",lang) %></a>

                                <a class="nav-link" href="/HealthTrack/admin/logout"><i class="fa fa-power -off"></i><%=t.write("Logout",lang) %></a>

                        </div>
                    </div>
                    <div class="translation">
                   		<img title="<%= t.write("english",lang) %>" id="en" class="translate text-capitalize" src="/user/layout/images/england.png">
                   		<img id="ar" class="translate" title="<%= t.write("arabic",lang) %>" src="/user/layout/images/egypt.svg">
                    </div>

                </div>
            </div>

        </header><!-- /header -->
        <!-- Header-->