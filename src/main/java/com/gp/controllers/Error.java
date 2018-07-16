package com.gp.controllers;

import org.springframework.boot.autoconfigure.web.ErrorController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class Error implements ErrorController{

	@RequestMapping("/error")
    public ModelAndView handleError() {
        return new ModelAndView("/user/error");
    }
	 
	    @Override
	    public String getErrorPath() {
	        return "/error";
	    }
	
}
