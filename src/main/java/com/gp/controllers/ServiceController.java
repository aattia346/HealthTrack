package com.gp.controllers;

import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

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
public class ServiceController {
		
	@RequestMapping(value="/HealthTrack/addservice")
	public ModelAndView addservice(ModelAndView mav) {
		mav.setViewName("user/hospital_admin/addservice");
		return mav;
	}
	
	@RequestMapping(value="/HealthTrack/Service/{serviceId}/Booking/Submit", method = RequestMethod.POST)
    public ModelAndView submitBooking(@PathVariable("serviceId") int serviceId, ModelAndView mav, ModelMap model, HttpServletRequest request)
    throws ParseException, InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		int userId 			= Integer.parseInt(request.getParameter("userId"));
		String firstName 	= request.getParameter("firstName");
		String lastName 	= request.getParameter("lastName");
		int age 			= Integer.parseInt(request.getParameter("age"));
		String phone 		= request.getParameter("phone");
		String bookFrom 	= request.getParameter("bookFrom"); 
		String bookTo 		= request.getParameter("bookTo");
		
		DateFormat format 	= new SimpleDateFormat("yyyy-MM-dd");
		Date bookFromAsDate = format.parse(bookFrom);
		Date bookToAsDate 	= format.parse(bookTo);
		
		boolean errors = false;
		
		if(!Validation.validateName(firstName) || !Validation.validateName(lastName)) {
			model.addAttribute("invalidName", "<p class=\"wrong-input wrong-input-register-page-1\">Invalid Name</p>");
			errors = true;
		}
		if(!Validation.validatePhone(phone)) {
			model.addAttribute("invalidPhone", "<p class=\"wrong-input wrong-input-register-page-1\">Invalid Phone Number</p>");
			errors = true;
		}
		if(!Validation.validateBookDate(serviceId, bookFromAsDate) || !Validation.validateBookDate(serviceId, bookToAsDate)) {
			model.addAttribute("invalidDate", "<p class=\"wrong-input wrong-input-register-page-1\">Sorry this date has been already booked</p>");
			errors = true;
		}
		if(bookFromAsDate.after(bookToAsDate)) {
			model.addAttribute("invalidDate", "<p class=\"wrong-input wrong-input-register-page-1\">Invalid Date</p>");
			errors = true;
		}
		mav.addAllObjects(model);
		if(errors) {
			mav.setViewName("/user/profiles/service");
		}else {
			ServiceDao.insertBookingDays(serviceId, userId, firstName, lastName, age, bookFromAsDate, bookToAsDate, phone);
			mav.setViewName("user/profiles/user");
		}
		
		return mav;
	
	}

	@RequestMapping(value="/healthTrack/Service/VerifyBooking/{serviceId}/{bookingId}", method = RequestMethod.GET)
    public ModelAndView verifyBooking(@PathVariable("bookingId") int bookingId, @PathVariable("serviceId") int serviceId, ModelAndView mav, ModelMap model, HttpServletRequest request)
    		throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		if(!Validation.checkIfSomethingExists("id", "booking", Integer.toString(bookingId)) || !Validation.checkIfSomethingExists("service_id", "service", Integer.toString(serviceId))){
			mav.setViewName("redirect:/HealthTrack/profile/service/"+serviceId);
		}else {
			HttpSession session = request.getSession();
			String username = (String) session.getAttribute("username");
			if(username.equals(null)) {
				mav.setViewName("user/login");
			}else {
				User user = UserDao.getUserByUsername(username);
				Booking booking = ServiceDao.getBookingById(bookingId);
				if(booking.getAdminId() == user.getId()) {	
					ServiceDao.verifyBooking(bookingId);
					mav.setViewName("redirect:/HealthTrack/profile/service/"+serviceId);
				}else {
					mav.setViewName("redirect:/HealthTrack/profile/service/"+serviceId);
				}
			}
		}
		
		return mav;
	}
	
	@RequestMapping(value="/healthTrack/Service/UnverifyBooking/{serviceId}/{bookingId}", method = RequestMethod.GET)
    public ModelAndView unverifyBooking(@PathVariable("bookingId") int bookingId, @PathVariable("serviceId") int serviceId, ModelAndView mav, ModelMap model, HttpServletRequest request)
    		throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		if(!Validation.checkIfSomethingExists("id", "booking", Integer.toString(bookingId))){
			mav.setViewName("redirect:/HealthTrack/profile/service/"+serviceId);
		}else {
			HttpSession session = request.getSession();
			String username = (String) session.getAttribute("username");
			if(username.equals(null)) {
				mav.setViewName("user/login");
			}else {
				User user = UserDao.getUserByUsername(username);
				Booking booking = ServiceDao.getBookingById(bookingId);
				if(booking.getAdminId() == user.getId()) {	
					ServiceDao.unverifyBooking(bookingId);
					mav.setViewName("redirect:/HealthTrack/profile/service/"+serviceId);
				}else {
					mav.setViewName("redirect:/HealthTrack/profile/service/"+serviceId);
				}
			}
		}
		
		return mav;
	}
	
	@RequestMapping(value="/healthTrack/Service/DeleteBooking/{serviceId}/{bookingId}", method = RequestMethod.GET)
    public ModelAndView deleteBooking(@PathVariable("bookingId") int bookingId, @PathVariable("serviceId") int serviceId, ModelAndView mav, ModelMap model, HttpServletRequest request)
    		throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		if(!Validation.checkIfSomethingExists("id", "booking", Integer.toString(bookingId))){
			mav.setViewName("redirect:/HealthTrack/profile/service/"+serviceId);
		}else {
			HttpSession session = request.getSession();
			String username = (String) session.getAttribute("username");
			if(username.equals(null)) {
				mav.setViewName("user/login");
			}else {
				User user = UserDao.getUserByUsername(username);
				Booking booking = ServiceDao.getBookingById(bookingId);
				if(booking.getAdminId() == user.getId()) {	
					ServiceDao.deleteBooking(bookingId);
					mav.setViewName("redirect:/HealthTrack/profile/service/"+serviceId);
				}else {
					mav.setViewName("redirect:/HealthTrack/profile/service/"+serviceId);
				}
			}
		}
		
		return mav;
	}

}
