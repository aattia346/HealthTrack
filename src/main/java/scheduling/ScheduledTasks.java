package scheduling;

import java.util.Calendar;
import java.util.List;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.gp.user.Service;
import com.gp.user.ServiceDao;
import com.gp.user.Validation;
import com.gp.user.WaitingRequest;
import com.gp.user.WaitingRequestDao;
import com.gp.user.WhatsappSender;

@Component
public class ScheduledTasks {

    @Scheduled(fixedRate = 86400000)
    public void reportCurrentTime() throws Exception {

    	List<WaitingRequest> requests = WaitingRequestDao.getAllUnrespondedRequests();
    	
    	for(WaitingRequest request : requests) {
    		
    		String serviceName = request.getService();
    		
    		List<Service> services = ServiceDao.getServices(serviceName);
    		
    		for(Service s :services) {
    			if(Validation.validateBookDate(s.getServiceId(), Calendar.getInstance().getTime())) {
    				
    				String message = "Hello " + request.getName() + " we found what you are looking for " +
    						s.getServiceName() + " available in " + s.getAddress() + "\r\n Good luck";
    				WhatsappSender.sendMessage("2" + request.getPhone() , message);
    			}else {
    				String message = "Hello " + request.getName() + " we are still looking for " + s.getServiceName() + " for you " + "\r\n" + "Good luck";
    				WhatsappSender.sendMessage("2" + request.getPhone() , message);
    			}
    		}
    		
    	}
    }
}