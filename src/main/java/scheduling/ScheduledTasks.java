package scheduling;


import java.sql.SQLException;
import java.text.ParseException;
import java.util.Calendar;
import java.util.List;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.gp.user.Service;
import com.gp.user.ServiceDao;
import com.gp.user.Validation;
import com.gp.user.WaitingRequest;
import com.gp.user.WaitingRequestDao;

@Component
public class ScheduledTasks {


    @Scheduled(fixedRate = 86400000)
    public void reportCurrentTime() throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException, ParseException {

    	List<WaitingRequest> requests = WaitingRequestDao.getAllUnrespondedRequests();
    	
    	for(WaitingRequest request : requests) {
    		
    		String serviceName = request.getService();
    		
    		List<Service> services = ServiceDao.getServices(serviceName);
    		
    		for(Service s :services) {
    			if(Validation.validateBookDate(s.getServiceId(), Calendar.getInstance().getTime())) {
    				//send whatsup message to request.getPhone();
    				System.out.println(s.getServiceId());
    			}else {
    				System.out.println("no");
    			}
    		}
    		
    	}
    }
}