$(document).ready(function(){
	
	/*****************************my carousel***********************************************/
	$(".comment").hide();
	$(".comment1").show();
	$(".comments ul li").click(function(){
		$(this).addClass("active");
		$(this).siblings().removeClass("active");
		var id = $(this).attr("id");
		$("." + id).siblings(".comment").hide().removeClass("active-comment");
		$("." + id).show().addClass("active-comment");
	});
	$("#myCarousel .left-arrow").click(function(){
		if($(".comment1").hasClass("active-comment")){
			$(".comment1").removeClass("active-comment");
			$(".comment1").hide();
			$(".comment5").addClass("active-comment").show();
			$("#comment5").addClass("active").siblings("li").removeClass("active");
		}else{
			$(".active-comment").removeClass("active-comment").prev(".comment").addClass("active-comment");	
			$(".active-comment").siblings(".comment").hide();
			$(".active-comment").show();
			$(".active").removeClass("active").prev("li").addClass("active");
		}
	});
	$("#myCarousel .right-arrow").click(function(){
		if($(".comment5").hasClass("active-comment")){
			$(".comment5").removeClass("active-comment");
			$(".comment5").hide();
			$(".comment1").addClass("active-comment").show();
			$("#comment1").addClass("active").siblings("li").removeClass("active");
		}else{
			$(".active-comment").removeClass("active-comment").next(".comment").addClass("active-comment");	
			$(".active-comment").siblings(".comment").hide();
			$(".active-comment").show();
			$(".active").removeClass("active").next("li").addClass("active");
		}
	});
	setInterval(changeComment, 3000);
	function changeComment(){
		if($(".comment5").hasClass("active-comment")){
			$(".comment5").removeClass("active-comment");
			$(".comment5").hide(500);
			$(".comment1").addClass("active-comment").show(1000);
			$("#comment1").addClass("active").siblings("li").removeClass("active");
		}else{
			$(".active-comment").removeClass("active-comment").next(".comment").addClass("active-comment");	
			$(".active-comment").siblings(".comment").hide(500);
			$(".active-comment").show(1000);
			$(".active").removeClass("active").next("li").addClass("active");
		}
	}
	/*=====================================================================================*/
	var cookie = document.cookie;
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
    
    $(".booking-info").mouseenter(function(){
    	$(this).children(".booking-card").children(".card-head").children(".delete-booking-icon").show();
    });
    
    $(".booking-info").mouseleave(function(){
    	$(this).children(".booking-card").children(".card-head").children(".delete-booking-icon").hide();
    });
    
    $(".confirm-user-delete-booking").click(function(){
    	return confirm("Are you sure you want to cancel this booking?");
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