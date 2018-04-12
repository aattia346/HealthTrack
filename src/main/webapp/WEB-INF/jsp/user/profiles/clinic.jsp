<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@page import="com.gp.user.Validation"%>
<%@page import="com.gp.user.Clinic"%>
<%@page import="com.gp.user.ClinicDao"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
int clinicId = (Integer)request.getAttribute("clinicId");

Clinic clinic = ClinicDao.getClinicById(clinicId);

Calendar calendar = Calendar.getInstance();
Date today = Calendar.getInstance().getTime();
calendar.setTime(today);
calendar.add(Calendar.DAY_OF_MONTH, 2);	

SimpleDateFormat todayFormat = new SimpleDateFormat ("yyyy-MM-dd");
String todayInMyFormat = todayFormat.format(today);

String title = clinic.getClinicName(); 

%>
<%@include  file="../includes/header.jsp" %>
    <!-- Preloader -->
    <div id="preloader">
        <div class="medilife-load"></div>
    </div>
    
    <section class="breadcumb-area bg-img gradient-background-overlay" style="background-image: url(/user/layout/images/profiles/bg-img/breadcumb2.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="breadcumb-content">
                        <h3 class="breadcumb-title"><%= clinic.getClinicName() %></h3>
                        <p class="breadcumb-intro"><%= clinic.getIntro() %></p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
        <!-- ***** Book An Appoinment Area Start ***** -->
    <div class="medilife-book-an-appoinment-area">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="appointment-form-content">
                        <div class="row no-gutters align-items-center">
                            <div class="col-12 col-lg-9 col-md-6">
                             <div class="my-table text-center">
                            <table class="table table-bordered">
                    
                        <thead>
                            <tr class="table-head">
                                <th>thu 12/4</th>
                                <th>Fri 13/4</th>
                                <th>Sat 14/4</th>
                                <th>Sun 15/4</th>
                                <th>mon 16/4</th>
                                <th>tue 17/4</th>
                                <th>wed 18/4</th>
                            </tr>
                          </thead>
                        <tbody>
                            <tr>
                              <td>12:00</td>
                              <td>01:00</td>
                              <td class="booked">02:00</td>
                              <td class="booked">02:00</td>
                              <td>02:00</td>
                              <td>02:00</td>
                              <td>03:30</td>
                          </tr>
                          <tr>
                              <td>12:00</td>
                              <td class="booked">01:00</td>
                              <td>02:00</td>
                              <td>02:00</td>
                              <td class="booked">02:00</td>
                              <td>02:00</td>
                              <td class="booked">03:30</td>
                          </tr>
                            <tr>
                              <td class="booked">12:00</td>
                              <td class="booked">01:00</td>
                              <td>02:00</td>
                              <td class="booked">02:00</td>
                              <td>02:00</td>
                              <td class="booked">02:00</td>
                              <td>03:30</td>
                          </tr>
                        </tbody>
                    </table>
                    </div>
                                <div class="medilife-appointment-form">
                                    <form action="#" method="post">
                                        <div class="row align-items-end">
                                            <div class="col-12 col-md-3">
                                                <div class="form-group">
                                                    <input type="text" class="form-control border-top-0 border-right-0 border-left-0" name="firstName" id="name" placeholder="First Name">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-3">
                                                <div class="form-group">
                                                    <input type="text" class="form-control border-top-0 border-right-0 border-left-0" name="lastName" id="name" placeholder="Last Name">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-3">
                                                <div class="form-group">
                                                    <input type="date" class="form-control" name="date" id="date" placeholder="Date" min="<%= todayInMyFormat %>" value="<%= todayInMyFormat %>">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-3">
                                                <div class="form-group">
                                                    <input type="time" class="form-control" name="time" id="time" placeholder="Time">
                                                </div>
                                            </div>
                                            
                                            <div class="col-12 col-md-6">
                                                <div class="form-group">
                                                    <input type="text" class="form-control border-top-0 border-right-0 border-left-0" name="number" id="number" placeholder="Phone">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <div class="form-group">
                                                    <input type="email" class="form-control border-top-0 border-right-0 border-left-0" name="email" id="email" placeholder="E-mail">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-12">
                                                <div class="form-group mb-0">
                                                    <textarea name="message" class="form-control mb-0 border-top-0 border-right-0 border-left-0" id="message" cols="30" rows="10" placeholder="Message"></textarea>
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-4 mb-0">
                                                <div class="form-group mb-0">
                                                    <button type="submit" class="btn medilife-btn medilife-btn-appointment">Make an Appointment <span>+</span></button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div class="col-12 col-lg-3">
                                <div class="medilife-contact-info">
                                    <!-- Single Contact Info -->
                                    <div class="single-contact-info mb-30">
                                        <img src="img/icons/alarm-clock.png" alt="">
                                        <p>Mon - Sat 08:00 - 21:00 <br>Sunday CLOSED</p>
                                    </div>
                                    <!-- Single Contact Info -->
                                    <div class="single-contact-info mb-30">
                                        <img src="img/icons/envelope.png" alt="">
                                        <p>0080 673 729 766 <br>contact@business.com</p>
                                    </div>
                                    <!-- Single Contact Info -->
                                    <div class="single-contact-info">
                                        <img src="img/icons/map-pin.png" alt="">
                                        <p>Lamas Str, no 14-18 <br>41770 Miami</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ***** Book An Appoinment Area End ***** -->

<div id="map" class="hospital-map"></div>

	<script>
      function hospitalMarker() {
        var uluru = {lat: <%= clinic.getLat() %>, lng: <%= clinic.getLang() %>};
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 11,
          center: uluru
        });
        var marker = new google.maps.Marker({
          position: uluru,
          map: map
        });
      }
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCF4-LBT961bTAMeLJr6Pt1-b9FOjljREg&callback=hospitalMarker">
    </script>
    <%@include  file="../includes/footer.jsp" %>