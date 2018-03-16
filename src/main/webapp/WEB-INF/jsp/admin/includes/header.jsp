<!DOCTYPE html>
<html>
    <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><%= title %></title>
    <meta name="description" content="Sufee Admin - HTML5 Admin Template">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="apple-touch-icon" href="apple-icon.png">
    <link rel="shortcut icon" href="favicon.ico">

    

    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800' rel='stylesheet' type='text/css'>
    
        <meta charset="UTF-8">
        
	    <link rel="stylesheet" href="/user/layout/css/stylesheet.css">
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
                        <a href="/HealthTrack/admin/dashboard"> <i class="menu-icon fa fa-dashboard"></i>Dashboard </a>
                    </li>
                    <h3 class="menu-title">Services</h3><!-- /.menu-title -->
                    
                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="menu-icon fa fa-table"></i>Places</a>
                        <ul class="sub-menu children dropdown-menu">
                            <li><i class="fa fa-h-square menu-icon"></i><a href="/HealthTrack/admin/<%= admin.getUsername()%>/hospitals">Hospitals</a></li>
                            <li><i class="fa fa-stethoscope"></i><a href="/HealthTrack/admin/<%= admin.getUsername()%>/clinics">Clinics</a></li>
                            <li><img src="/admin/icons/if_medical_icon_3_1290986.svg" class="my-icon"><a href="/HealthTrack/admin/<%= admin.getUsername()%>/centers">Centers</a></li>
                            <li><img src="/admin/icons/if_pill_36347.png" class="my-icon pharmacy-icon"><a href="/HealthTrack/admin/<%= admin.getUsername()%>/pharmacies">Pharmacies</a></li>
                        </ul>
                    </li>
                    
                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="menu-icon fa fa-table"></i>Single Services</a>
                        <ul class="sub-menu children dropdown-menu">
                            <li><img src="/admin/icons/mri.svg" class="my-icon"><a href="tables-data.html">MRI</a></li>
                            <li><img src="/admin/icons/icu-monitor.svg" class="my-icon"><a href="tables-data.html">ICU</a></li>
                            <li><img src="/admin/icons/baby-incubators.svg" class="my-icon"><a href="tables-data.html">Incubators</a></li>
                            <li><img src="/admin/icons/x-rays.svg" class="my-icon pharmacy-icon"><a href="tables-data.html">X-ray</a></li>
                        </ul>
                    </li>
                    
                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-calendar menu-icon"></i>Bookings</a>
                        <ul class="sub-menu children dropdown-menu">
                            <li><i class="fa fa-calendar"></i><a href="tables-data.html">Day Slots</a></li>
                            <li><i class="fa fa-calendar"></i><a href="tables-data.html">Time Slots</a></li>
                        </ul>
                    </li>
                    
                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="menu-icon fa fa-users"></i>Users</a>
                        <ul class="sub-menu children dropdown-menu">
                            <li><i class="fa fa-h-square"></i><a href="tables-data.html">Hospitals</a></li>
                            <li><i class="fa fa-stethoscope"></i><a href="tables-data.html">Clinics</a></li>
                            <li><img src="/admin/icons/if_medical_icon_3_1290986.svg" class="my-icon"><a href="tables-data.html">Centers</a></li>
                            <li><img src="/admin/icons/if_pill_36347.png" class="my-icon pharmacy-icon"><a href="tables-data.html">Pharmacies</a></li>
                            <li><i class="fa fa-ban"></i><a href="tables-data.html">Banned Users</a></li>
                        </ul>
                    </li>
                    
                </ul>
            </div><!-- /.navbar-collapse -->
        </nav>
    </aside>
    
    