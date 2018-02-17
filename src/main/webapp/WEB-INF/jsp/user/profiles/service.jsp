<% String title="Service"; %>
<%@include  file="../includes/header.jsp" %>

<div class="hospital-body">
        
            <div class="container">

                <div class="row service-img">

                    <div class="thumbnail col-sm-4">

                        <img class="img-responsive" src="/user/layout/images/icu.jpg">

                    </div>

                    <div class="col-sm-8  col-xs-12">
                         <div class="hospital-info">
                            <h4 class="about-title">Name: </h4><p class="about-detail">Dar Elfo2ad</p>
                        </div>
                         <div class="hospital-info">
                            <h4 class="about-title">Department: </h4><p class="about-detail">Dar Elfo2ad</p>
                        </div>
                         <div class="hospital-info">
                            <h4 class="about-title">Hospital: </h4><p class="about-detail">Dar Elfo2ad</p>
                        </div>
                         <div class="hospital-info">
                            <h4 class="about-title">Fees: </h4><p class="about-detail">Dar Elfo2ad</p>
                        </div>
                        <div class="hospital-info">
                            <h4 class="about-title">Location: </h4><p class="about-detail">Dar Elfo2ad</p>
                        </div>
                    </div>

                </div>
                
                <div class="col-sm-12 hospital-depts service-booking">
                    <h4 class="text-center">Book ICU</h4>
                    <form method="post" action="#">
                        
                        <div class="col-sm-5 personal-info">
                    
                            <div class="form-group name">
                                    <input type="text" class="form-control input-sm" name="firstName" placeholder="First Name" required> 

                                    <input type="text" class="form-control input-sm" name="lastName" placeholder="Last Name" required> 
                            </div>
                            <div class="form-group">
                                    <input type="number" class="form-control input-sm" name="age" placeholder="Age" required> 
                            </div>
                            <div class="form-group">
                                    <input type="email" class="form-control input-sm" name="email" placeholder="Enter Valid Email" required> 
                            </div>
                            <div class="form-group">
                                    <input type="text" class="form-control input-sm" name="phone" placeholder="Phone Number(optional)"> 
                            </div>
                        </div>
                        
                        <div class="col-sm-7 service-info">
                            <div class="hospital-info">
                                <h4 class="about-title">Booked Till: </h4><p class="about-detail">wednesDay 15/1/2018</p><p class="last-updated pull-right">last updated: 10/1/2018</p>
                            </div>
                            <div>
                                <h4 class="about-title">Book From: </h4>
                                <input type="date" class="booking-date" required>
                            </div>  
                            <div>
                                <h4 class="about-title">To: </h4>
                                <input type="date" class="booking-date" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <input type="submit" class="form-control input-sm  btn btn-primary"> 
                        </div>
                    </form>
                    
                </div>

            </div>
        </div>
	 
<%@include  file="../includes/footer.jsp" %>