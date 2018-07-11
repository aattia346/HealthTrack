    <footer class="footer-area section-padding-100" id="contact">
        <!-- Main Footer Area -->
        <div class="main-footer-area">
            <div class="container-fluid">
                <div class="row">

                    <div class="col-12 col-sm-6 col-lg-6">
                        <div class="footer-widget-area">
                            <div class="footer-logo">
                                <a href="/HealthTrack"><h2>HEALTH SERVICE <span> NAVIGATOR </span></h2></a>
                            </div>
                            <p><%= t.write("about us part")%>
                            <div class="footer-social-info">
                                <a href="#contact"><i class="fab fa-google-plus fa-3x" aria-hidden="true"></i></a>
                                <a href="#contact"><i class="fab fa-facebook-square fa-3x" aria-hidden="true"></i></a>
                                <a href="#contact"><i class="fab fa-pinterest-square fa-3x" aria-hidden="true"></i></a>
                                <a href="#contact"><i class="fab fa-twitter-square fa-3x" aria-hidden="true" ></i></a>
                            </div>
                        </div>
                    </div>
                   
                    <div class="col-12 col-sm-6 col-lg-6">
                        <div class="footer-widget-area">
                            <div class="widget-title">
                                <h2>Contact Form</h2>
                            </div>
                            <div class="footer-contact-form">
                                <form action="/HealthTrack/Contact/Submit" method="post">
                                    <input type="text" class="form-control border-top-0 border-right-0 border-left-0" name="name" id="footer-name" placeholder="<%= t.write("name") %>" required="required">
                                    ${invalidName}
                                    <input type="email" class="form-control border-top-0 border-right-0 border-left-0" name="email" id="footer-email" placeholder="<%= t.write("email") %>" required="required">
                                    ${invalidEmail}
                                    <textarea name="msg" class="form-control border-top-0 border-right-0 border-left-0" id="footerMessage" placeholder="<%= t.write("message") %>" required="required"></textarea>
                                    ${invalidMsg}
                                    <button type="submit" class="btn medilife-btn about-us-btn"><%= t.write("Contact Us ") %><span>+</span></button>
                                	${contactSucceed}
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>        
        <script src="/user/layout/js/jquery-3.2.1.min.js"></script>
        <script src="/user/layout/js/bootstrap.min.js"></script>

        <script src="/user/layout/js/jquery-ui.min.js"></script>
        <script src="/user/layout/js/jquery.selectBoxIt.min.js"></script>
        <script src='/user/layout/js/moment.min.js'></script>
        
        <script src="/user/layout/js/profiles/jquery-2.2.4.min.js"></script>
        <script src="/user/layout/js/profiles/popper.min.js"></script>
        <script src="/user/layout/js/profiles/plugins.js"></script>

        <script src="/user/layout/js/profiles/active.js"></script>
        <script src="/user/layout/js/jquery.rateyo.js"></script>
        <script defer src="https://use.fontawesome.com/releases/v5.0.10/js/all.js" integrity="sha384-slN8GvtUJGnv6ca26v8EzVaR9DC58QEwsIk9q1QXdCU8Yu8ck/tL/5szYlBbqmS+" crossorigin="anonymous"></script>
        <script src='/user/layout/js/fullcalendar.js'></script>
             
        <script src="/user/layout/js/src.js"></script>
        		        
    </body>
</html>

