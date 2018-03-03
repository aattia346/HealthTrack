$(document).ready(function(){
	
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

});	