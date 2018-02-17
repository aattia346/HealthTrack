$(document).ready(function(){
	
	$(".hospital-depts ul li:first-of-type").css("background", "rgb(39, 127, 171)");
	var selector = "." + $("li:first-of-type").attr("id");
	$(selector).removeClass("hidden");
	$(".hospital-depts li").click(function(){
		$(this).css("background", "rgb(39, 127, 171)").siblings().css("background", "#49BCF5");
        var id = $(this).attr("id");
        console.log(id);
        var selector = "." + id;
        console.log(selector);
        $(selector).removeClass("hidden").siblings("a").addClass("hidden");       
        $(selector).removeClass("hidden");
    });

});	