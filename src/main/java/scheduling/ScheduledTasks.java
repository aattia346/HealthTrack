package scheduling;


import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class ScheduledTasks {


    @Scheduled(fixedRate = 3600000)
    public void reportCurrentTime() {
    	System.out.println("one hour passed");
    }
}