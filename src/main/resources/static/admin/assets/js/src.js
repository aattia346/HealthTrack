$(document).ready(function(){
	
	$(".add-dept-in-hospital-table").click(function(){
		
		var id = $(this).attr("id");
		
		$("."+id).slideToggle();
		
	});
	$(".confirm-delete-booking").click(function(){
        
        return confirm("Are you sure you want to delete this booking?");
        
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
	$(".confirm-show-comment").click(function(){
	    
	    return confirm("Are you sure you want to show this comment in the service page?");
	    
	});
	$(".confirm-hide-comment").click(function(){
	    
	    return confirm("Are you sure you want to hide this comment from the service page?");
	    
	});
	$(".confirm-delete-comment").click(function(){
    
    return confirm("Are you sure you want to delete this comment?");
    
	});
   $(".confirm-Ban-user").click(function(){
	    
	    return confirm("Are you sure you want to ban this user?");
	    
	});
   $(".confirm-unBan-user").click(function(){
	    
	    return confirm("Are you sure you want to unban this user?");
	    
	});
	
$(".confirm-delete-dept").click(function(){
        
        return confirm("Are you sure you want to delete this department?");
        
    });

$(".confirm-delete-hospital").click(function(){
    
    return confirm("Are you sure you want to delete this hospital?");
    
});
$(".confirm-delete-service").click(function(){
    
    return confirm("Are you sure you want to delete this service?");
    
});

});	

