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
import com.gp.user.BookingDao;
import com.gp.user.PersonDao;
import com.gp.user.User;
import com.gp.user.UserDao;
import com.gp.user.Validation;


@RestController
public class ServiceController {
		
	@RequestMapping(value="/HealthTrack/{place}/Service/{serviceId}/Booking/Submit", method = RequestMethod.POST)
    public ModelAndView submitBooking(@PathVariable("serviceId") int serviceId, @PathVariable("place") String place,ModelAndView mav, ModelMap model, HttpServletRequest request)
    throws ParseException, InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		int userId 			= Integer.parseInt(request.getParameter("userId"));
		String firstName 	= request.getParameter("firstName");
		String lastName 	= request.getParameter("lastName");
		int age 			= Integer.parseInt(request.getParameter("age"));
		String phone 		= request.getParameter("phone");
		String bookFrom 	= request.getParameter("bookFrom"); 
		String bookTo 		= request.getParameter("bookTo");
		String sex 			= request.getParameter("sex");
		String msg			= request.getParameter("msg");
		String email			= request.getParameter("email");
		
		DateFormat format 	= new SimpleDateFormat("yyyy-MM-dd");
		Date bookFromAsDate = format.parse(bookFrom);
		Date bookToAsDate 	= format.parse(bookTo);
		
		model.addAttribute("oldFirstName", firstName);
		model.addAttribute("oldLastName", lastName);
		model.addAttribute("oldAge", age);
		model.addAttribute("oldPhone", phone);
		model.addAttribute("oldmsg", msg);
		model.addAttribute("oldEmail", email);
		
		if(userId!=0) {
		
			boolean errors = false;
			
			if(!Validation.validateName(firstName) || !Validation.validateName(lastName)) {
				model.addAttribute("invalidName", "<p class=\"wrong-input wrong-input-register-page-1\">Invalid Name</p>");
				errors = true;
			}
			if(!Validation.validateEmail(email)) {
				model.addAttribute("invalidEmail", "<p class=\"wrong-input wrong-input-register-page-1\">Invalid Email</p>");
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
			if(!Validation.validateText(msg)) {
				model.addAttribute("invalidmsg", "<p class=\"wrong-input wrong-input-register-page-1\">Your message has invalid characters</p>");
				errors = true;
			}
			mav.addAllObjects(model);
			if(errors) {
				model.addAttribute("serviceId", serviceId);
				model.addAttribute("place", place);
				model.addAttribute("checkYourBooking", "<div class=\"alert alert-danger text-center\">Your information have some errors, Please check the booking and resend it</div>");
				mav.setViewName("user/profiles/service");
			}else {
				Booking booking = new Booking();
				booking.setServiceId(serviceId);
				booking.setUserId(userId);
				booking.setFirstName(firstName);
				booking.setLastName(lastName);
				booking.setAge(age);
				booking.setDateFrom(bookFromAsDate);
				booking.setDateTo(bookToAsDate);
				booking.setPhone(phone);
				booking.setMsg(msg);
				booking.setSex(sex);
				BookingDao.insertBookingDays(booking);
				PersonDao.increaseBookings(userId);
				mav.setViewName("user/profiles/user");
			}
		}else {
			model.addAttribute("serviceId", serviceId);
			model.addAttribute("place", place);
			model.addAttribute("loginFirst", "<div class=\"alert alert-danger text-center\">To book Please <a target=\"_blank\" href=\"/HealthTrack/login\">Login</a> First or <a target=\"_blank\" href=\"/HealthTrack/signup\">Register</a></div>");
			mav.setViewName("user/profiles/service");
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
				Booking booking = BookingDao.getBookingById(bookingId);
				if(booking.getAdminId() == user.getId()) {	
					BookingDao.verifyBooking(bookingId);
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
				Booking booking = BookingDao.getBookingById(bookingId);
				if(booking.getAdminId() == user.getId()) {	
					BookingDao.unverifyBooking(bookingId);
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
				Booking booking = BookingDao.getBookingById(bookingId);
				if(booking.getAdminId() == user.getId()) {	
					BookingDao.deleteBooking(bookingId);
					mav.setViewName("redirect:/HealthTrack/profile/service/"+serviceId);
				}else {
					mav.setViewName("redirect:/HealthTrack/profile/service/"+serviceId);
				}
			}
		}
		
		return mav;
	}

}