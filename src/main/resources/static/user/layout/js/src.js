$(document).ready(function(){

	var cookie = document.cookie;
	console.log(cookie);
	switch(cookie){
	
		case "lang=en": 
			break;
		case "lang=ar":
			break;
		default:
			document.cookie = "lang=en;path=/";
			location.reload();
			break;
	}
	
	$(".translate").click(function(){
    	
    	"use strict";
    	
    	var id = $(this).attr("id");
    	    	
    	document.cookie = "lang=" + id + ";path=/"; 
    	    	    	
    	location.reload();
    	
    });
	
	
	$("#reviewFailed").hide();
	$("#reviewSucceeded").hide();
		
	$(function () {
		
		$(".service-review #rateYo").rateYo({
	    fullStar: true,
	    ratedFill: "#f1c40f",
	    normalFill: "#fff",
	    starWidth: "40px",
	    spacing: "5px",
	    onSet: function (rating, rateYoInstance) {
	  	        var userId = $("#userId").val();
	  	        var serviceId = $("#serviceId").val();
	  	        var place = $("#place").val();
	  	        var placeId = $("#placeId").val();
	  	        if(userId ==0 ){
	  	        	$("#rateYo").hide();
	  	        	$("#reviewFailed").fadeIn(500);
	  	        }else{
		  	      $.ajax({
		              url: '/healthTrack/Service/review/' + place + '/' + placeId + '/' + serviceId + '/' + userId + '/' + rating,
		              type: 'POST',
		              data: {
		                  review: rating
		              },
		              success: function(data) {
		            	  $("#rateYo").hide();
		            	  $("#reviewSucceeded").fadeIn(500);
		              },
		              failure: function(data) {
		                  alert('Update Failed');
		              }
		          });
	  	      
	  	        }
	    }
	    
	});
	});
	
	$(function () {
		
		$(".clinic-review #rateYo").rateYo({
	    fullStar: true,
	    ratedFill: "#f1c40f",
	    normalFill: "#fff",
	    starWidth: "40px",
	    spacing: "5px",
	    onSet: function (rating, rateYoInstance) {
	  	        var userId = $("#userId").val();
	  	        var clinicId = $("#clinicId").val();
	  	        if(userId ==0 ){
	  	        	$("#rateYo").hide();
	  	        	$("#reviewFailed").fadeIn(500);
	  	        }else{
		  	      $.ajax({
		              url: '/healthTrack/clinic/review/' + clinicId + '/' + userId + '/' + rating,
		              type: 'POST',
		              data: {
		                  review: rating
		              },
		              success: function(data) {
		            	  $("#rateYo").hide();
		            	  $("#reviewSucceeded").fadeIn(500);
		              },
		              failure: function(data) {
		                  alert('Update Failed');
		              }
		          });
	  	      
	  	        }
	    }
	    
	});
	});
	
	$(".hospital-depts ul li:first-of-type").css("background", "rgb(39, 127, 171)");
	$(".hospital-depts a:first-of-type").removeClass("hidden");
	$(".hospital-depts li").click(function(){
		$(this).css("background", "rgb(39, 127, 171)").siblings().css("background", "#49BCF5");
        var id = $(this).attr("id");
        console.log(id);
        var selector = "." + id;
        $(selector).removeClass("hidden").siblings("a").addClass("hidden");
        $(selector).removeClass("hidden");
    });
	
	$(".confirm-delete-booking").click(function(){
        
        return confirm("Are you sure you want to delete this booking?");
        
    });
	$(".confirm-verify-booking").click(function(){
	        
	        return confirm("Are you sure you want to verify this booking?");
	        
	    });
	$(".confirm-unverify-booking").click(function(){
	    
	    return confirm("Are you sure you want to unverify this booking?");
	    
	});
	
	$(window).scroll(function() {
		if($(window).scrollTop() == 0){
			$("#stickyHeader-sticky-wrapper").removeClass("is-sticky");
			$(".top-header-area").removeClass("hidden");
		   }else{
			   $("#stickyHeader-sticky-wrapper").addClass("is-sticky");
			   $(".top-header-area").addClass("hidden");
		   }
	});

	// :: Nicescroll Active Code
    if ($.fn.niceScroll) {
        $("body, textarea, .my-table").niceScroll({
            cursorcolor: "#151515",
            cursorwidth: "6px",
            background: "#f0f0f0"
        });
    }
    
    var today 	= $("#day-select").val();
    var todayId = $("#day-select option[value='" + today +"']").attr("id");
    $("."+todayId).removeClass("hidden");
    
    $("#day-select").on("change" , function(){
    	var day 	= $(this).val();
    	var dayId 	= $("#day-select option[value='" + day +"']").attr("id");
    	$("#time-select option").siblings("option").addClass("hidden");
    	$("."+dayId).removeClass("hidden");
    	$("."+dayId).siblings("option[value='0']").removeClass("hidden");
    });
    
    $(".user-dropdown").click(function(){
    	$("#stickyHeader-sticky-wrapper").slideToggle(500);
    });
    
});	

//:: ScrollUp Active Code
if ($.fn.scrollUp) {
    $.scrollUp({
        scrollSpeed: 1000,
        easingType: 'easeInOutQuart',
        scrollText: '<i class="fa fa-angle-up" aria-hidden="true"></i>'
    });
}