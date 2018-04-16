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
	
	$(window).scroll(function() {
		if($(window).scrollTop() == 0){
			$("#stickyHeader-sticky-wrapper").removeClass("is-sticky");
			$(".top-header-area").removeClass("hidden");
			console.log("yes");
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

});	

//:: ScrollUp Active Code
if ($.fn.scrollUp) {
    $.scrollUp({
        scrollSpeed: 1000,
        easingType: 'easeInOutQuart',
        scrollText: '<i class="fa fa-angle-up" aria-hidden="true"></i>'
    });
}