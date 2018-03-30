$(document).ready(function(){
	
	$(".add-dept-in-hospital-table").click(function(){
		
		var id = $(this).attr("id");
		
		$("."+id).toggle();
		
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
	
$(".confirm-delete-dept").click(function(){
        
        return confirm("Are you sure you want to delete this department?");
        
    });

$(".confirm-delete-hospital").click(function(){
    
    return confirm("Are you sure you want to delete this hospital?");
    
});

});	

