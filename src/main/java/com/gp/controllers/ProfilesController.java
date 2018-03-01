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

import com.gp.user.Booking;
import com.gp.user.ServiceDao;
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
	
	@RequestMapping(value="/HealthTrack/profile/hospital/{userId}", method = RequestMethod.GET)
    public ModelAndView profile(@PathVariable("userId") int id, ModelAndView mav, ModelMap m) 
    throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		if(Validation.validateNumber(id) & Validation.checkIfSomethingExists("user_id", "user", Integer.toString(id))) {
			m.addAttribute("hospitalId", id);
			String url = "/user/profiles/hospital";
			mav.setViewName(url);
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
	
	@RequestMapping(value="/HealthTrack/profile/user/{id}", method = RequestMethod.GET)   
	public ModelAndView personPage(HttpServletRequest request, @PathVariable("id") int id, ModelAndView mav) 
    throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		if(Validation.validateNumber(id) & Validation.checkIfSomethingExists("user_id", "user", Integer.toString(id))) {
			String url = "/user/profiles/user";
			mav.setViewName(url);			
		}else {
			mav.setViewName("/user/login");
		}
		
        return mav;
	
	}
	
	@RequestMapping(value="/HealthTrack/profile/booking/delete/{userId}/{bookingId}", method = RequestMethod.GET)   
	public ModelAndView deleteBooking(HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("bookingId") int bookingId, ModelAndView mav) 
    throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		if(Validation.validateNumber(bookingId) & Validation.checkIfSomethingExists("id", "booking", Integer.toString(bookingId))
				& Validation.validateNumber(userId) & Validation.checkIfSomethingExists("user_id", "user", Integer.toString(userId))) {
			
			Booking B = ServiceDao.getBookingById(bookingId);
			if(B.getUserId()==userId) {
				
				ServiceDao.deleteBooking(bookingId);
				mav.setViewName("/user/profiles/user");
			}
		}else {
			mav.setViewName("/user/login");
		}
        return mav;
	}
	
}
