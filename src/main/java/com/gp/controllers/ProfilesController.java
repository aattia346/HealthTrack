package com.gp.controllers;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.gp.user.Booking;
import com.gp.user.BookingDao;
import com.gp.user.ClinicDao;
import com.gp.user.Translator;
import com.gp.user.User;
import com.gp.user.UserDao;
import com.gp.user.Validation;
import com.gp.user.WhatsappSender;

@RestController
public class ProfilesController {
	
	@RequestMapping(value="/HealthTrack/changePassword/{userId}", method = RequestMethod.GET)
    public ModelAndView changePassword(@CookieValue(value = "lang", defaultValue="en") String cookie, @PathVariable("userId") int id, ModelAndView mav, ModelMap m, HttpServletRequest request) 
    		throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		m.addAttribute("lang", cookie);
		if(Validation.validateNumber(id) & 
				Validation.checkIfSomethingExists("user_id", "user", Integer.toString(id))) {		
			HttpSession session = request.getSession();
			String username = (String)session.getAttribute("username");
			if(username == null) {
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
    public ModelAndView hospitalProfile(@CookieValue(value = "lang", defaultValue="en") String cookie, @PathVariable("userId") int id, ModelAndView mav, ModelMap m) 
    throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		m.addAttribute("lang", cookie);
		if(Validation.validateNumber(id) & Validation.checkIfSomethingExists("user_id", "user", Integer.toString(id))) {
			m.addAttribute("hospitalId", id);
			String url = "/user/profiles/hospital";
			mav.setViewName(url);
		}else {
			mav.setViewName("/user/login");
		}
		
        return mav;
	
	}
	
	@RequestMapping(value="/HealthTrack/profile/center/{userId}", method = RequestMethod.GET)
    public ModelAndView centerProfile(@PathVariable("userId") int id, ModelAndView mav, ModelMap m, @CookieValue(value = "lang", defaultValue="en") String cookie) 
    throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		m.addAttribute("lang", cookie);
		if(Validation.validateNumber(id) & Validation.checkIfSomethingExists("user_id", "user", Integer.toString(id))) {
			m.addAttribute("centerId", id);
			String url = "/user/profiles/center";
			mav.setViewName(url);
		}else {
			mav.setViewName("/user/login");
		}		
        return mav;	
	}
	
	@RequestMapping(value="/HealthTrack/profile/service/{place}/{id}", method = RequestMethod.GET)   
	public ModelAndView servicePage(ModelMap m, HttpServletRequest request, @PathVariable("id") int id, ModelAndView mav, @PathVariable("place") String place, @CookieValue(value = "lang", defaultValue="en") String cookie) 
    throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		m.addAttribute("lang", cookie);
		if(Validation.validateNumber(id) & Validation.checkIfSomethingExists("service_id", "service", Integer.toString(id))) {
			
			m.addAttribute("serviceId", id);
			m.addAttribute("place", place);
			String url = "/user/profiles/service";
			mav.setViewName(url);			
		}else {
			mav.setViewName("/user/login");
		}
		
        return mav;
	
	}
	
	@RequestMapping(value="/HealthTrack/profile/user/{id}", method = RequestMethod.GET)   
	public ModelAndView personPage(ModelMap m, @CookieValue(value = "lang", defaultValue="en") String cookie, HttpServletRequest request, @PathVariable("id") int id, ModelAndView mav) 
    throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		m.addAttribute("lang", "coookie");
		if(Validation.validateNumber(id) & Validation.checkIfSomethingExists("user_id", "user", Integer.toString(id))) {
			String url = "/user/profiles/user";
			mav.setViewName(url);			
		}else {
			mav.setViewName("/user/login");
		}
		
        return mav;
	
	}
	
	@RequestMapping(value="/HealthTrack/profile/booking/delete/{userId}/{bookingId}", method = RequestMethod.GET)   
	public ModelAndView deleteBooking(ModelMap m, @CookieValue(value = "lang", defaultValue="en") String cookie, HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("bookingId") int bookingId, ModelAndView mav) 
    throws Exception {
		m.addAttribute("lang", cookie);
		Translator t = new Translator();
		if(Validation.validateNumber(bookingId) & Validation.checkIfSomethingExists("booking_id", "booking", Integer.toString(bookingId))
				& Validation.validateNumber(userId) & Validation.checkIfSomethingExists("user_id", "user", Integer.toString(userId))) {
			Booking B = BookingDao.getBookingById(bookingId);
			if(B.getUserId()==userId) {		
				BookingDao.deleteBooking(bookingId);
				WhatsappSender.sendMessage("2" + B.getPhone() , t.write("Your booking has been cancelled",cookie));
				mav.setViewName("/user/profiles/user");
			}
		}else {
			mav.setViewName("/user/login");
		}
        return mav;
	}
	
	@RequestMapping(value="/HealthTrack/profile/user/booking/delete/{userId}/{bookingId}", method = RequestMethod.GET)   
	public ModelAndView deleteBookingByUser(HttpSession session, ModelMap m, @CookieValue(value = "lang", defaultValue="en") String cookie, HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("bookingId") int bookingId, ModelAndView mav) 
    throws Exception {
		m.addAttribute("lang", cookie);
		Translator t = new Translator();
		String username = (String) session.getAttribute("username");
		User user = UserDao.getUserByUsername(username);
		if(user.getId() == userId) {
			int bookingOwner = BookingDao.getBookingOwner(bookingId);
			if(bookingOwner == userId) {		
				Booking B = BookingDao.getSimpleInfoAboutBookingById(bookingId);
				BookingDao.deleteBooking(bookingId);
				WhatsappSender.sendMessage("2" + B.getBookingPhone() , t.write("Your booking has been cancelled",cookie));
				mav.setViewName("/user/profiles/user");
			}
		}else {
			mav.setViewName("/user/login");
		}
        return mav;
	}

	@RequestMapping(value="/HealthTrack/profile/clinic/{userId}", method = RequestMethod.GET)
    public ModelAndView clinicProfile(@PathVariable("userId") int id, ModelAndView mav, ModelMap m, @CookieValue(value = "lang", defaultValue="en") String cookie) 
    throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		m.addAttribute("lang", cookie);
		if(Validation.validateNumber(id) & Validation.checkIfSomethingExists("user_id", "user", Integer.toString(id))) {
			m.addAttribute("clinicId", id);
			String url = "/user/profiles/clinic";
			mav.setViewName(url);
		}else {
			mav.setViewName("/user/login");
		}
		
        return mav;
	
	}
	@RequestMapping(value="/HealthTrack/MyProfile", method = RequestMethod.GET)
    public ModelAndView userProfile(@CookieValue(value = "lang", defaultValue="en") String cookie, ModelMap m) 
    throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		m.addAttribute("lang", cookie);
        return new ModelAndView("/user/profiles/user");
	
	}
	@RequestMapping(value="/HealthTrack/admin/{username}/Clinic/{clinicId}/showComments", method = RequestMethod.GET)
    public ModelAndView showCommentsClinic(HttpServletRequest request, @PathVariable("clinicId") int clinicId, @PathVariable("username") String username, ModelAndView mav, ModelMap m, @CookieValue(value = "lang", defaultValue="en") String cookie) 
    throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		m.addAttribute("lang", cookie);
		
		HttpSession session = request.getSession();
		
		String usernameSession = (String)session.getAttribute("username");
		if(usernameSession == null) {
			mav.setViewName("/user/login");
		}else if(usernameSession.equals(username)) {
			if(ClinicDao.isTheUserAuthorized(username , clinicId)) {
				m.addAttribute("clinicId", clinicId);
				mav.setViewName("/user/profiles/showCommentsClinic");
			}else {
				mav.setViewName("/user/login");
			}
		}else {
			mav.setViewName("/user/login");
		}
        return mav;
	}
	
	@RequestMapping(value="/HealthTrack/admin/{username}/Clinic/{clinicId}/showBookings", method = RequestMethod.GET)
    public ModelAndView showBookingsClinic(HttpServletRequest request, @PathVariable("clinicId") int clinicId, @PathVariable("username") String username, ModelAndView mav, ModelMap m, @CookieValue(value = "lang", defaultValue="en") String cookie) 
    throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		m.addAttribute("lang", cookie);
		
		HttpSession session = request.getSession();
		
		String usernameSession = (String)session.getAttribute("username");
		if(usernameSession == null) {
			mav.setViewName("/user/login");
		}else if(usernameSession.equals(username)) {
			if(ClinicDao.isTheUserAuthorized(username , clinicId)) {
				m.addAttribute("clinicId", clinicId);
				mav.setViewName("/user/profiles/showBookingsClinic");
			}else {
				mav.setViewName("/user/login");
			}
		}else {
			mav.setViewName("/user/login");
		}
        return mav;
	}
}
