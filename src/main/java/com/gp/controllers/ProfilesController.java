package com.gp.controllers;

import java.sql.SQLException;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.gp.user.Validation;

@RestController
public class ProfilesController {
	
	@RequestMapping(value="/HealthTrack/changePassword/{userId}", method = RequestMethod.GET)
    public ModelAndView changePassword(@PathVariable("userId") int id, ModelAndView mav, ModelMap m) 
    		throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		if(Validation.validateNumber(id) & Validation.checkIfSomethingExists("user_id", "user", Integer.toString(id))) {
			m.addAttribute("id", id);
			mav.setViewName("/user/profiles/user");
		}else {
			mav.setViewName("/user/login");
		}
		
        return mav;
    }
	
	@RequestMapping(value="/HealthTrack/profile/{type}/{userId}", method = RequestMethod.GET)
    public ModelAndView profile(@PathVariable("userId") int id, @PathVariable("type") String type,ModelAndView mav, ModelMap m) 
    throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
	
		if(Validation.validateNumber(id) & Validation.checkIfSomethingExists("user_id", "user", Integer.toString(id))) {
			m.addAttribute("id", id);
			String url = "/user/profiles/" + type;
			mav.setViewName(url);
		}else {
			mav.setViewName("/user/login");
		}
		
        return mav;
	
	}
}
