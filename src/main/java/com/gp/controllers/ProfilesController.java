package com.gp.controllers;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.gp.user.User;
import com.gp.user.UserDao;
import com.gp.user.Validation;

@RestController
public class ProfilesController {
	
	@RequestMapping(value="/HealthTrack/changePassword/{userId}", method = RequestMethod.GET)
    public ModelAndView changePassword(@PathVariable("userId") int id, ModelAndView mav, ModelMap m, HttpServletRequest request) 
    		throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		if(Validation.validateNumber(id) & 
				Validation.checkIfSomethingExists("user_id", "user", Integer.toString(id))) {		
			HttpSession session = request.getSession();
			if(session.isNew()) {
				mav.setViewName("/user/login");
			}else {
			User user = UserDao.getUserById(id);
			m.addAttribute("id", user.getId());
			mav.setViewName("/user/profiles/user");
		}

    }else {
    	mav.setViewName("/user/login");
    }
		return mav;
    }
	
	@RequestMapping(value="/HealthTrack/profile/{type}/{userId}", method = RequestMethod.GET)
    public ModelAndView profile(HttpServletRequest request, @PathVariable("userId") int id, @PathVariable("type") String type,ModelAndView mav, ModelMap m) 
    throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		if(Validation.validateNumber(id) & Validation.checkIfSomethingExists("user_id", "user", Integer.toString(id))) {
			m.addAttribute("id", id);
			String url = "/user/profiles/" + type;
			mav.setViewName(url);
			
			if(type.equalsIgnoreCase("hospital")) {
				HttpSession session = request.getSession();
				session.setAttribute("hospitalId", id);
			}
		}else {
			mav.setViewName("/user/login");
		}
		
        return mav;
	
	}
	
	@RequestMapping(value="/HealthTrack/profile/service/{id}", method = RequestMethod.GET)   
	public ModelAndView servicePage(HttpServletRequest request, @PathVariable("id") int id, ModelAndView mav) 
    throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		if(Validation.validateNumber(id) & Validation.checkIfSomethingExists("service_id", "service", Integer.toString(id))) {
			HttpSession session = request.getSession();
			session.setAttribute("serviceId", id);
			String url = "/user/profiles/service";
			mav.setViewName(url);			
		}else {
			mav.setViewName("/user/login");
		}
		
        return mav;
	
	}
}
