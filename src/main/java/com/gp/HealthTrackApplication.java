package com.gp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

@SpringBootApplication
@ComponentScan(basePackages= {"com.gp.controllers"})

public class HealthTrackApplication {

	public static void main(String[] args) {
		SpringApplication.run(HealthTrackApplication.class, args);
	}
	
	@Bean
    public ViewResolver getViewResolver(){
        InternalResourceViewResolver resolver = new
            InternalResourceViewResolver();
        resolver.setPrefix("/WEB-INF/jsp/");
        resolver.setSuffix(".jsp");
        resolver.setViewClass(JstlView.class);
        return resolver;
    }
}
