
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title><%= title %></title>

        <link rel="stylesheet" href="/user/layout/css/bootstrap.min.css">
        <link rel="stylesheet" href="/user/layout/css/font-awesome.min.css">
        <link rel="stylesheet" href="/user/layout/css/jquery-ui.min.css">
        <link rel="stylesheet" href="/user/layout/css/jquery.selectBoxIt.css">
        <link rel="stylesheet" href="/user/layout/css/fullcalendar.css">
        <link rel="stylesheet" href="/user/layout/css/stylesheet.css">

    </head>    
<body>

	<nav class="navbar navbar-inverse">
  <div class="container">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" 
              data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#"title="Home Page">Health SoS Navigator</a>
    </div>

    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li><a href="#">Hospitals</a></li>
        <li><a href="#">Clinics</a></li>
        <li><a href="#">Centers</a></li>
        <li><a href="#">Services</a></li>
        <li><a href="#">Labs</a></li>
      </ul>
        
          <ul class="nav navbar-nav navbar-right">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" 
             aria-expanded="false"><img class="img-circle navbar-img" src='#'><span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="#">My Profile</a></li>
            <li><a href="#">edit</a></li>
            <li><a href="#">add article</a></li>
            <li><a href="#">logout</a></li>
          </ul>
        </li>
      </ul>      

        <div class="pull-right login-register">
            
            <a href="#">Login</a><span> or</span>
            
            <a href="#">Register</a></div>
      
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>