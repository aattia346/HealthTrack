<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>
<%@page import="com.gp.user.HospitalDao"%>
<%@page import="com.gp.user.ClinicDao"%>
<%@page import="com.gp.user.CenterDao"%>
<%@page import="com.gp.user.PharmacyDao"%>
<%@page import="com.gp.user.ServiceDao"%>
<% 	String title = "Dashboard";
	String username = (String)session.getAttribute("username");
	User admin = UserDao.getUserByUsername(username);

%>
<%@include  file="includes/header.jsp" %>
  

        <div class="breadcrumbs">
            <div class="col-sm-4">
                <div class="page-header float-left">
                    <div class="page-title">
                        <h1><%=t.write("Dashboard",lang) %></h1>
                    </div>
                </div>
            </div>
            <div class="col-sm-8">
                <div class="page-header float-right">
                    <div class="page-title">
                        <ol class="breadcrumb text-right">
                            <li class="active"><%=t.write("Dashboard",lang) %></li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>

		<div class="content mt-3">

            <div class="col-sm-12">

                <div class="alert  alert-danger alert-dismissible fade show" role="alert">
                  <span class="badge badge-pill badge-danger"><%=t.write("Warning",lang) %></span> <%=t.write("You successfully read this important alert message.<br> If you are not the authorized person you will be sued",lang) %>

                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            </div>

			<div class="col-sm-6 col-lg-3">
                <div class="card text-white bg-flat-color-1">
                    <div class="card-body pb-0">
                        <div class="dropdown float-right">
                            <button class="btn bg-transparent dropdown-toggle theme-toggle text-light" type="button" id="dropdownMenuButton" data-toggle="dropdown">
                                <i class="fa fa-cog"></i>
                            </button>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <div class="dropdown-menu-content">
                                    <a class="dropdown-item" href="/HealthTrack/admin/<%= username %>/users"><%= t.write("Manage",lang) %></a>
                                </div>
                            </div>
                        </div>
                        <h4 class="mb-0">
							<span class="count"><%= UserDao.countUsers() %></span>
                        </h4>
                        <p class="text-light"><%=t.write("Members",lang) %></p>


                        <div class="chart-wrapper px-0" style="height:70px;" height="70"/>
                            <canvas id="widgetChart1"></canvas>
                        </div>

                    </div>

                </div>
            </div>
            <!--/.col-->
            
            <div class="col-sm-6 col-lg-3">
                <div class="card text-white bg-flat-color-5">
                    <div class="card-body pb-0">
                        <div class="dropdown float-right">
                            <button class="btn bg-transparent dropdown-toggle theme-toggle text-light" type="button" id="dropdownMenuButton" data-toggle="dropdown">
                                <i class="fa fa-cog"></i>
                            </button>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <div class="dropdown-menu-content">
      								<a class="dropdown-item" href="/HealthTrack/admin/<%= username %>/hospitals"><%= t.write("Manage",lang) %></a>
                                </div>
                            </div>
                        </div>
                        <h4 class="mb-0">
                            <span class="count"><%= HospitalDao.countHospitals() %></span>
                        </h4>
                         <p class="text-light"><%=t.write("Hospitals",lang) %></p>
                        <div class="chart-wrapper px-0" style="height:70px;" height="70"/>
                            <canvas id="widgetChart1"></canvas>
                        </div>

                    </div>

                </div>
            </div>
            <!--/.col-->

           <div class="col-sm-6 col-lg-3">
                <div class="card text-white bg-flat-color-6">
                    <div class="card-body pb-0">
                        <div class="dropdown float-right">
                            <button class="btn bg-transparent dropdown-toggle theme-toggle text-light" type="button" id="dropdownMenuButton" data-toggle="dropdown">
                                <i class="fa fa-cog"></i>
                            </button>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <div class="dropdown-menu-content">

                                    <a class="dropdown-item" href="/HealthTrack/admin/<%= username %>/clinics"><%= t.write("Manage",lang) %></a>

                                </div>
                            </div>
                        </div>
                        <h4 class="mb-0">
                            <span class="count"><%= ClinicDao.countClinics() %></span>
                        </h4>

                         <p class="text-light"><%=t.write("Clinics",lang) %></p>
                        <div class="chart-wrapper px-0" style="height:70px;" height="70"/>
                            <canvas id="widgetChart1"></canvas>
                        </div>

                    </div>

                </div>
            </div>
            <!--/.col-->

            <div class="col-sm-6 col-lg-3">
                <div class="card text-white bg-flat-color-2">
                    <div class="card-body pb-0">
                        <div class="dropdown float-right">
                            <button class="btn bg-transparent dropdown-toggle theme-toggle text-light" type="button" id="dropdownMenuButton" data-toggle="dropdown">
                                <i class="fa fa-cog"></i>
                            </button>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <div class="dropdown-menu-content">

                                    <a class="dropdown-item" href="/HealthTrack/admin/<%= username %>/pharmacies"><%= t.write("Manage",lang) %></a>

                                </div>
                            </div>
                        </div>
                        <h4 class="mb-0">
                            <span class="count"><%= PharmacyDao.countPharmacies() %></span>
                        </h4>

                        	<p class="text-light"><%=t.write("Pharmacies",lang) %></p>


                        <div class="chart-wrapper px-0" style="height:70px;" height="70"/>
                            <canvas id="widgetChart2"></canvas>
                        </div>

                    </div>
                </div>
            </div>
            <!--/.col-->

            <div class="col-sm-6 col-lg-3">
                <div class="card text-white bg-flat-color-3">
                    <div class="card-body pb-0">
                        <div class="dropdown float-right">
                            <button class="btn bg-transparent dropdown-toggle theme-toggle text-light" type="button" id="dropdownMenuButton" data-toggle="dropdown">
                                <i class="fa fa-cog"></i>
                            </button>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <div class="dropdown-menu-content">

                                    <a class="dropdown-item" href="/HealthTrack/admin/<%= username %>/services"><%= t.write("Manage",lang) %></a>

                                </div>
                            </div>
                        </div>
                        <h4 class="mb-0">
                            <span class="count"><%= ServiceDao.countServices() %></span>
                        </h4>

                        <p class="text-light"><%=t.write("Medical Services",lang) %></p>


                    </div>

                        <div class="chart-wrapper px-0" style="height:70px;" height="70"/>
                            <canvas id="widgetChart3"></canvas>
                        </div>
                </div>
            </div>
            <!--/.col-->

            <div class="col-sm-6 col-lg-3">
                <div class="card text-white bg-flat-color-4">
                    <div class="card-body pb-0">
                        <div class="dropdown float-right">
                            <button class="btn bg-transparent dropdown-toggle theme-toggle text-light" type="button" id="dropdownMenuButton" data-toggle="dropdown">
                                <i class="fa fa-cog"></i>
                            </button>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <div class="dropdown-menu-content">

                                    <a class="dropdown-item" href="/HealthTrack/admin/<%= username %>/centers"><%= t.write("Manage",lang) %></a>

                                </div>
                            </div>
                        </div>
                        <h4 class="mb-0">
                            <span class="count"><%= CenterDao.countCenters() %></span>
                        </h4>

                        <p class="text-light"><%=t.write("Medical Centers",lang) %></p>


                        <div class="chart-wrapper px-3" style="height:70px;" height="70"/>
                            <canvas id="widgetChart4"></canvas>
                        </div>

                    </div>
                </div>
            </div>
            <!--/.col-->
<%@include  file="includes/footer.jsp" %>