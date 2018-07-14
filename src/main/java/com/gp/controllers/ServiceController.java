package com.gp.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Time;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.springframework.ui.Model;
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
import com.gp.user.HospitalDao;
import com.gp.user.PersonDao;
import com.gp.user.ServiceDao;
import com.gp.user.Translator;
import com.gp.user.User;
import com.gp.user.UserDao;
import com.gp.user.Validation;
import com.gp.user.WhatsappSender;

@RestController
public class ServiceController {


	@RequestMapping(value = "/HealthTrack/clinic/{clinicId}/BookingClinic/Submit", method = RequestMethod.POST)
	public ModelAndView submitBookingClinic(@CookieValue(value = "lang", defaultValue = "en") String cookie,
			@PathVariable("clinicId") int clinicId, ModelAndView mav, ModelMap model, HttpServletRequest request) throws Exception {

		Translator t = new Translator();

		model.addAttribute("lang", cookie);
		int userId = Integer.parseInt(request.getParameter("userId"));
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		int age = Integer.parseInt(request.getParameter("age"));
		String sex = request.getParameter("sex");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String day = request.getParameter("date");
		String msg = request.getParameter("msg");

		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date dayAsDate = format.parse(day);

		model.addAttribute("oldFirstName", firstName);
		model.addAttribute("oldLastName", lastName);
		model.addAttribute("oldAge", age);
		model.addAttribute("oldPhone", phone);
		model.addAttribute("oldmsg", msg);
		model.addAttribute("oldEmail", email);
		if (userId != 0) {

			boolean errors = false;

			
			if(!Validation.validateName(firstName) || !Validation.validateName(lastName)) {
				model.addAttribute("invalidName", "<p class=\"wrong-input wrong-input-register-page-1\">" + t.write("Invalid Name",cookie) + "</p>");
				errors = true;
			}
			
			if(!Validation.validateEmail(email)) {
				model.addAttribute("invalidEmail", "<p class=\"wrong-input wrong-input-register-page-1\">" + t.write("Invalid Email",cookie) + "</p>");
				errors = true;
			}
			if(!Validation.validatePhone(phone)) {
				model.addAttribute("invalidPhone", "<p class=\"wrong-input wrong-input-register-page-1\">" + t.write("Invalid Phone Number",cookie) + "</p>");
				errors = true;
			}
			
			if(!Validation.validateText(msg)) {
				model.addAttribute("invalidmsg", "<p class=\"wrong-input wrong-input-register-page-1\">" + t.write("Your message has invalid characters",cookie) + "</p>");
				errors = true;
			}
			if(PersonDao.canPersonBook(userId)){
				request.setAttribute("limitExceed", " ");				
			}else{
				request.setAttribute("limitExceed", "<p class=\"wrong-input wrong-input-register-page-1\">" + t.write("Sorry you have reached the maximum number of bookings per day(3)",cookie) + "</p>");

				errors = true;
			}
			mav.addAllObjects(model);
			if (errors) {
				model.addAttribute("clinicId", clinicId);

				model.addAttribute("checkYourBooking",
						"<div class=\"alert alert-danger text-center\">"
								+ t.write("Your information have some errors, Please check the booking and resend it",cookie)
								+ "</div>");

				mav.setViewName("user/profiles/clinic");
			} else {
				Booking booking = new Booking();
				booking.setUserId(userId);
				booking.setFirstName(firstName);
				booking.setLastName(lastName);
				booking.setAge(age);
				booking.setClinicId(clinicId);
				booking.setPhone(phone);
				booking.setMsg(msg);
				booking.setSex(sex);
				booking.setDayOfBooking(dayAsDate);
				BookingDao.insertBookingClinic(booking);
				String whatsUpMessage = t.write("Hello ",cookie) + firstName + " " + lastName + " " +
						t.write(" you successfully booked through SoSHealth",cookie) + " " + t.write("on",cookie) + " " + day + " " + t.write("please follow the instructions of clinic to confirm your booking",cookie);
				WhatsappSender.sendMessage("2" + phone.toString(), whatsUpMessage);

				PersonDao.increaseBookings(userId);
				mav.setViewName("redirect:/HealthTrack/MyProfile");
			}
		} else {
			model.addAttribute("clinicId", clinicId);

			model.addAttribute("loginFirst",
					"<div class=\"alert alert-danger text-center\">" + t.write("to book please",cookie)
							+ "<a target=\"_blank\" href=\"/HealthTrack/login\">" + t.write("login",cookie) + "</a>"
							+ t.write("first or",cookie) + "<a target=\"_blank\" href=\"/HealthTrack/signup\">"
							+ t.write("register",cookie) + "</a></div>");

			mav.setViewName("user/profiles/clinic");
		}

		return mav;

	}


	@RequestMapping(value = "/HealthTrack/{place}/Service/{serviceId}/BookingDay/Submit", method = RequestMethod.POST)
	public ModelAndView submitBookingDay(@CookieValue(value = "lang", defaultValue = "en") String cookie,
			@PathVariable("serviceId") int serviceId, @PathVariable("place") String place, ModelAndView mav,
			ModelMap model, HttpServletRequest request) throws Exception {

		Translator t = new Translator();

		model.addAttribute("lang", cookie);

		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");

		int userId = Integer.parseInt(request.getParameter("userId"));
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		int age = Integer.parseInt(request.getParameter("age"));
		String sex = request.getParameter("sex");
		String phone = request.getParameter("phone");
		String bookFrom = request.getParameter("bookFrom");
		String bookTo = request.getParameter("bookTo");
		String msg = request.getParameter("msg");
		String email = request.getParameter("email");

		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date bookFromAsDate = format.parse(bookFrom);
		Date bookToAsDate = format.parse(bookTo);

		model.addAttribute("oldFirstName", firstName);
		model.addAttribute("oldLastName", lastName);
		model.addAttribute("oldAge", age);
		model.addAttribute("oldPhone", phone);
		model.addAttribute("oldmsg", msg);
		model.addAttribute("oldEmail", email);
		
		if (userId != 0) {

			boolean errors = false;

			
			if(!Validation.validateName(firstName) || !Validation.validateName(lastName)) {
				model.addAttribute("invalidName", "<p class=\"wrong-input wrong-input-register-page-1\">" + t.write("Invalid Name",cookie) + "</p>");
				errors = true;
			}
			if(!Validation.validateEmail(email)) {
				model.addAttribute("invalidEmail", "<p class=\"wrong-input wrong-input-register-page-1\">" + t.write("Invalid Email",cookie) + "</p>");
				errors = true;
			}
			if(!Validation.validatePhone(phone)) {
				model.addAttribute("invalidPhone", "<p class=\"wrong-input wrong-input-register-page-1\">" + t.write("Invalid Phone Number",cookie) + "</p>");
				errors = true;
			}
			if(!Validation.validateBookDate(serviceId, bookFromAsDate) || !Validation.validateBookDate(serviceId, bookToAsDate)) {
				model.addAttribute("invalidDate", "<p class=\"wrong-input wrong-input-register-page-1\">" + t.write("Sorry this date has been already booked",cookie) + "</p>");
				errors = true;
			}
			if(bookFromAsDate.after(bookToAsDate)) {
				model.addAttribute("invalidDate", "<p class=\"wrong-input wrong-input-register-page-1\">" + t.write("Invalid Date",cookie) + "</p>");
				errors = true;
			}
			if(!Validation.validateText(msg)) {
				model.addAttribute("invalidmsg", "<p class=\"wrong-input wrong-input-register-page-1\">" + t.write("Your message has invalid characters",cookie) + "</p>");
				errors = true;
			}
			if(PersonDao.canPersonBook(userId)){
				request.setAttribute("limitExceed", " ");				
			}else{
				request.setAttribute("limitExceed", "<p class=\"wrong-input wrong-input-register-page-1\">" + t.write("Sorry you have reached the maximum number of bookings per day(3)",cookie) + "</p>");

				errors = true;
			}
			mav.addAllObjects(model);
			if (errors) {
				model.addAttribute("serviceId", serviceId);
				model.addAttribute("place", place);

				model.addAttribute("checkYourBooking",
						"<div class=\"alert alert-danger text-center\">"
								+ t.write("Your information have some errors, Please check the booking and resend it",cookie)
								+ "</div>");

				mav.setViewName("user/profiles/service");
			} else {
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
				String whatsUpMessage = t.write("Hello ",cookie) + firstName + " " + lastName + " " +
						t.write(" you successfully booked through SoSHealth",cookie) + " " + t.write("from",cookie) + " " + bookFrom + 
						" " + t.write("to",cookie) + " " + bookTo + " " + t.write("please follow the instructions of hospital to confirm your booking",cookie);
				WhatsappSender.sendMessage("2" + phone.toString(), whatsUpMessage);
				PersonDao.increaseBookings(userId);
				model.addAttribute("username", username);
				mav.setViewName("user/profiles/user");
			}
		} else {
			model.addAttribute("serviceId", serviceId);
			model.addAttribute("place", place);

			model.addAttribute("loginFirst",
					"<div class=\"alert alert-danger text-center\">" + t.write("To book Please",cookie)
							+ "<a target=\"_blank\" href=\"/HealthTrack/login\">" + t.write("Login",cookie) + "</a>"
							+ t.write("First or",cookie) + "<a target=\"_blank\" href=\"/HealthTrack/signup\">"
							+ t.write("Register",cookie) + "</a></div>");

			mav.setViewName("user/profiles/service");
		}

		return mav;

	}


	@RequestMapping(value = "/HealthTrack/{place}/Service/{serviceId}/BookingTime/Submit", method = RequestMethod.POST)
	public ModelAndView submitBookingTime(@CookieValue(value = "lang", defaultValue = "en") String cookie,
			@PathVariable("serviceId") int serviceId, @PathVariable("place") String place, ModelAndView mav,
			ModelMap model, HttpServletRequest request) throws Exception {

		Translator t = new Translator();

		model.addAttribute("lang", cookie);
		int userId = Integer.parseInt(request.getParameter("userId"));
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		int age = Integer.parseInt(request.getParameter("age"));
		String sex = request.getParameter("sex");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");

		DateFormat formatter = new SimpleDateFormat("HH:mm");
		Time time = null;
		String msg = request.getParameter("msg");

		int thisYear = Calendar.getInstance().get(Calendar.YEAR);
		String day = request.getParameter("day") + "/" + thisYear;
		DateFormat format = new SimpleDateFormat("d/M/y");
		Date dayAsDate = format.parse(day);

		model.addAttribute("oldFirstName", firstName);
		model.addAttribute("oldLastName", lastName);
		model.addAttribute("oldAge", age);
		model.addAttribute("oldPhone", phone);
		model.addAttribute("oldmsg", msg);
		model.addAttribute("oldEmail", email);

		if (userId != 0) {

			boolean errors = false;

			try {
				time = new java.sql.Time(formatter.parse(request.getParameter("time")).getTime());
			} catch (Exception e) {

				model.addAttribute("invalidTime", "<p class=\"wrong-input wrong-input-register-page-1\">" + t.write("Please choose time",cookie) + "</p>");
				errors = true;
			}
			
			if(!Validation.validateName(firstName) || !Validation.validateName(lastName)) {
				model.addAttribute("invalidName", "<p class=\"wrong-input wrong-input-register-page-1\">" + t.write("Invalid Name",cookie) + "</p>");
				errors = true;
			}
			
			if(!Validation.validateEmail(email)) {
				model.addAttribute("invalidEmail", "<p class=\"wrong-input wrong-input-register-page-1\">" + t.write("Invalid Email",cookie) + "</p>");
				errors = true;
			}
			if(!Validation.validatePhone(phone)) {
				model.addAttribute("invalidPhone", "<p class=\"wrong-input wrong-input-register-page-1\">" + t.write("Invalid Phone Number",cookie) + "</p>");
				errors = true;
			}
			
			if(!Validation.validateText(msg)) {
				model.addAttribute("invalidmsg", "<p class=\"wrong-input wrong-input-register-page-1\">" + t.write("Your message has invalid characters",cookie) + "</p>");
				errors = true;
			}
			if(PersonDao.canPersonBook(userId)){
				request.setAttribute("limitExceed", " ");				
			}else{
				request.setAttribute("limitExceed", "<p class=\"wrong-input wrong-input-register-page-1\">" + t.write("Sorry you have reached the maximum number of bookings per day(3)",cookie) + "</p>");

				errors = true;
			}
			mav.addAllObjects(model);
			if (errors) {
				model.addAttribute("serviceId", serviceId);
				model.addAttribute("place", place);

				model.addAttribute("checkYourBooking",
						"<div class=\"alert alert-danger text-center\">"
								+ t.write("Your information have some errors, Please check the booking and resend it",cookie)
								+ "</div>");

				mav.setViewName("user/profiles/service");
			} else {
				Booking booking = new Booking();
				booking.setServiceId(serviceId);
				booking.setUserId(userId);
				booking.setFirstName(firstName);
				booking.setLastName(lastName);
				booking.setAge(age);
				booking.setTimeFrom(time);
				booking.setPhone(phone);
				booking.setMsg(msg);
				booking.setSex(sex);
				booking.setDayOfBooking(dayAsDate);
				BookingDao.insertBookingTimes(booking);
				String whatsUpMessage = t.write("Hello ",cookie) + firstName + " " + lastName + " " +
						t.write(" you successfully booked through SoSHealth",cookie) + " " + t.write("on",cookie) + " " + day + 
						" " + time + " " + t.write("please follow the instructions of hospital to confirm your booking",cookie);
				WhatsappSender.sendMessage("2" + phone.toString(), whatsUpMessage);

				PersonDao.increaseBookings(userId);
				mav.setViewName("user/profiles/user");
			}
		} else {
			model.addAttribute("serviceId", serviceId);
			model.addAttribute("place", place);

			model.addAttribute("loginFirst",
					"<div class=\"alert alert-danger text-center\">" + t.write("To book Please",cookie)
							+ "<a target=\"_blank\" href=\"/HealthTrack/login\">" + t.write("Login",cookie) + "</a>"
							+ t.write("First or",cookie) + "<a target=\"_blank\" href=\"/HealthTrack/signup\">"
							+ t.write("Register",cookie) + "</a></div>");
			mav.setViewName("user/profiles/service");

		}

		return mav;

	}

	@RequestMapping(value = "/healthTrack/Service/VerifyBooking/{place}/{serviceId}/{bookingId}", method = RequestMethod.GET)
	public ModelAndView verifyBooking(@PathVariable("place") String place,
			@CookieValue(value = "lang", defaultValue = "en") String cookie, @PathVariable("bookingId") int bookingId,
			@PathVariable("serviceId") int serviceId, ModelAndView mav, ModelMap model, HttpServletRequest request) throws Exception {

		model.addAttribute("lang", cookie);
		
		Translator t = new Translator();
		
		if (!Validation.checkIfSomethingExists("booking_id", "booking", Integer.toString(bookingId))
				|| !Validation.checkIfSomethingExists("service_id", "service", Integer.toString(serviceId))) {
			mav.setViewName("redirect:/HealthTrack");
		} else {
			HttpSession session = request.getSession();
			String username = (String) session.getAttribute("username");
			if (username.equals(null)) {
				mav.setViewName("user/login");
			} else {
				User user = UserDao.getUserByUsername(username);
				Booking booking = BookingDao.getBookingById(bookingId);
				if (booking.getAdminId() == user.getId()) {
					BookingDao.verifyBooking(bookingId);
					WhatsappSender.sendMessage("2" + booking.getPhone() , t.write("Your booking has been confirmed",cookie));
					mav.setViewName("redirect:/HealthTrack/admin/" + username + "/" + serviceId + "/" + place
							+ "/showBookings");
				} else {
					mav.setViewName("redirect:/HealthTrack/admin/" + username + "/" + serviceId + "/" + place
							+ "/showBookings");
				}
			}
		}

		return mav;
	}

	@RequestMapping(value = "/healthTrack/Clinic/VerifyBooking/{clinicId}/{bookingId}", method = RequestMethod.GET)
	public ModelAndView verifyBookingClinic(@CookieValue(value = "lang", defaultValue = "en") String cookie,
			@PathVariable("bookingId") int bookingId, @PathVariable("clinicId") int clinicId, ModelAndView mav,
			ModelMap model, HttpServletRequest request) throws Exception {

		model.addAttribute("lang", cookie);
		Translator t = new Translator();

		if (!Validation.checkIfSomethingExists("booking_id", "booking", Integer.toString(bookingId))
				|| !Validation.checkIfSomethingExists("clinic_id", "clinic", Integer.toString(clinicId))) {
			mav.setViewName("redirect:/HealthTrack");
		} else {
			HttpSession session = request.getSession();
			String username = (String) session.getAttribute("username");
			if (username.equals(null)) {
				mav.setViewName("user/login");
			} else {
				User user = UserDao.getUserByUsername(username);
				Booking booking = ClinicDao.getBookingOfClinicById(bookingId);
				if (booking.getAdminId() == user.getId()) {
					BookingDao.verifyBooking(bookingId);
					WhatsappSender.sendMessage("2" + booking.getPhone() , t.write("Your booking has been confirmed",cookie));
					mav.setViewName("redirect:/"
							+ request.getHeader("Referer").substring(request.getHeader("Referer").indexOf("//") + 1));
				} else {
					mav.setViewName("redirect:/"
							+ request.getHeader("Referer").substring(request.getHeader("Referer").indexOf("//") + 1));
				}
			}
		}

		return mav;
	}
	
	@RequestMapping(value = "/healthTrack/Clinic/UnverifyBooking/{clinicId}/{bookingId}", method = RequestMethod.GET)
	public ModelAndView unverifyBookingClinic(@CookieValue(value = "lang", defaultValue = "en") String cookie,
			@PathVariable("bookingId") int bookingId, @PathVariable("clinicId") int clinicId, ModelAndView mav,
			ModelMap model, HttpServletRequest request)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		model.addAttribute("lang", cookie);

		if (!Validation.checkIfSomethingExists("booking_id", "booking", Integer.toString(bookingId))
				|| !Validation.checkIfSomethingExists("clinic_id", "clinic", Integer.toString(clinicId))) {
			mav.setViewName("redirect:/HealthTrack");
		} else {
			HttpSession session = request.getSession();
			String username = (String) session.getAttribute("username");
			if (username.equals(null)) {
				mav.setViewName("user/login");
			} else {
				User user = UserDao.getUserByUsername(username);
				Booking booking = ClinicDao.getBookingOfClinicById(bookingId);
				if (booking.getAdminId() == user.getId()) {
					BookingDao.unverifyBooking(bookingId);
					mav.setViewName("redirect:/"
							+ request.getHeader("Referer").substring(request.getHeader("Referer").indexOf("//") + 1));
				} else {
					mav.setViewName("redirect:/"
							+ request.getHeader("Referer").substring(request.getHeader("Referer").indexOf("//") + 1));
				}
			}
		}

		return mav;
	}
	
	@RequestMapping(value = "/healthTrack/Clinic/DeleteBooking/{clinicId}/{bookingId}", method = RequestMethod.GET)
	public ModelAndView deleteBookingClinic(@CookieValue(value = "lang", defaultValue = "en") String cookie,
			@PathVariable("bookingId") int bookingId, @PathVariable("clinicId") int clinicId, ModelAndView mav,
			ModelMap model, HttpServletRequest request) throws Exception {
		model.addAttribute("lang", cookie);		
		Translator t = new Translator();
		if (!Validation.checkIfSomethingExists("booking_id", "booking", Integer.toString(bookingId))
				|| !Validation.checkIfSomethingExists("clinic_id", "clinic", Integer.toString(clinicId))) {
			mav.setViewName("redirect:/HealthTrack");
		} else {
			HttpSession session = request.getSession();
			String username = (String) session.getAttribute("username");
			if (username.equals(null)) {
				mav.setViewName("user/login");
			} else {
				User user = UserDao.getUserByUsername(username);
				Booking booking = ClinicDao.getBookingOfClinicById(bookingId);
				if (booking.getAdminId() == user.getId()) {
					BookingDao.deleteBooking(bookingId);
					WhatsappSender.sendMessage("2" + booking.getPhone() , t.write("Your booking has been cancelled",cookie));
					mav.setViewName("redirect:/"
							+ request.getHeader("Referer").substring(request.getHeader("Referer").indexOf("//") + 1));
				} else {
					mav.setViewName("redirect:/"
							+ request.getHeader("Referer").substring(request.getHeader("Referer").indexOf("//") + 1));
				}
			}
		}

		return mav;
	}
	
	@RequestMapping(value = "/healthTrack/Service/UnverifyBooking/{place}/{serviceId}/{bookingId}", method = RequestMethod.GET)
	public ModelAndView unverifyBooking(@PathVariable("place") String place,
			@CookieValue(value = "lang", defaultValue = "en") String cookie, @PathVariable("bookingId") int bookingId,
			@PathVariable("serviceId") int serviceId, ModelAndView mav, ModelMap model, HttpServletRequest request)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		model.addAttribute("lang", cookie);
		if (!Validation.checkIfSomethingExists("booking_id", "booking", Integer.toString(bookingId))) {
			mav.setViewName("redirect:/HealthTrack/profile/service/" + serviceId);
		} else {
			HttpSession session = request.getSession();
			String username = (String) session.getAttribute("username");
			if (username.equals(null)) {
				mav.setViewName("user/login");
			} else {
				User user = UserDao.getUserByUsername(username);
				Booking booking = BookingDao.getBookingById(bookingId);
				if (booking.getAdminId() == user.getId()) {
					BookingDao.unverifyBooking(bookingId);
					mav.setViewName("redirect:/HealthTrack/admin/" + username + "/" + serviceId + "/" + place
							+ "/showBookings");
				} else {
					mav.setViewName("redirect:/HealthTrack/admin/" + username + "/" + serviceId + "/" + place
							+ "/showBookings");
				}
			}
		}

		return mav;
	}

	@RequestMapping(value = "/healthTrack/Service/DeleteBooking/{place}/{serviceId}/{bookingId}", method = RequestMethod.GET)
	public ModelAndView deleteBooking(@PathVariable("place") String place,
			@CookieValue(value = "lang", defaultValue = "en") String cookie, @PathVariable("bookingId") int bookingId,
			@PathVariable("serviceId") int serviceId, ModelAndView mav, ModelMap model, HttpServletRequest request) throws Exception {

		model.addAttribute("lang", cookie);
		
		Translator t = new Translator();
		if (!Validation.checkIfSomethingExists("booking_id", "booking", Integer.toString(bookingId))) {
			mav.setViewName("redirect:/HealthTrack/profile/service/" + serviceId);
		} else {
			HttpSession session = request.getSession();
			String username = (String) session.getAttribute("username");
			if (username.equals(null)) {
				mav.setViewName("user/login");
			} else {
				User user = UserDao.getUserByUsername(username);
				Booking booking = BookingDao.getBookingById(bookingId);
				if (booking.getAdminId() == user.getId()) {
					BookingDao.deleteBooking(bookingId);
					WhatsappSender.sendMessage("2" + booking.getPhone() , t.write("Your booking has been cancelled",cookie));
					mav.setViewName("redirect:/HealthTrack/admin/" + username + "/" + serviceId + "/" + place
							+ "/showBookings");
				} else {
					mav.setViewName("redirect:/HealthTrack/admin/" + username + "/" + serviceId + "/" + place
							+ "/showBookings");
				}
			}
		}

		return mav;
	}


	@RequestMapping(value = "/healthTrack/Service/review/{place}/{placeId}/{serviceId}/{userId}/{review}", method = RequestMethod.POST)
	public void review(@CookieValue(value = "lang", defaultValue = "en") String cookie,
			@PathVariable("place") String place, @PathVariable("placeId") int placeId,
			@PathVariable("review") int review, @PathVariable("userId") int userId,
			@PathVariable("serviceId") int serviceId, ModelAndView mav, ModelMap model, HttpServletRequest request)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		model.addAttribute("lang", cookie);
		if (ServiceDao.checkUserReviewOfService(userId, serviceId)) {
			ServiceDao.updateUserServiceReview(userId, serviceId, review);
		} else {
			ServiceDao.setServiceReview(userId, serviceId, review);
		}
		ServiceDao.updateServiceReview(serviceId);
		if (place.equalsIgnoreCase("hospital")) {
			ServiceDao.updateHospitalReview(placeId);
		} else if (place.equalsIgnoreCase("center")) {
			ServiceDao.updateCenterReview(placeId);
		}
	}

	@RequestMapping(value = "/healthTrack/Service/{place}/review/{serviceId}/{userId}/comment", method = RequestMethod.POST)
	public ModelAndView reviewComment(@CookieValue(value = "lang", defaultValue = "en") String cookie,
			@PathVariable("place") String place, @PathVariable("userId") int userId,
			@PathVariable("serviceId") int serviceId, ModelAndView mav, ModelMap model, HttpServletRequest request)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException,
			org.json.simple.parser.ParseException, JSONException, IOException {

		Translator t = new Translator();
		model.addAttribute("lang", cookie);
		if (userId == 0) {
			request.setAttribute("commentLoginFirst",
					"<p class=\"wrong-input wrong-input-register-page-1\">" + t.write("Please login first",cookie) + "</p>");
		} else if (UserDao.canUserComment(userId, serviceId)) {

			String comment = request.getParameter("comment");

			if (!Validation.validateText(comment)) {
				request.setAttribute("invalidComment", "<p class=\"wrong-input wrong-input-register-page-1\">"
						+ t.write("Invalid characters in your comment",cookie) + "</p>");
			} else {

				ServiceDao.insertComment(userId, serviceId, comment);

			}
		} else {
			request.setAttribute("commentsLimitExceeded", "<p class=\"wrong-input wrong-input-register-page-1\">"
					+ t.write("sorry you reached the maximum number of comments for this service",cookie) + "</p>");
		}

		model.addAttribute("serviceId", serviceId);
		model.addAttribute("place", place);
		mav.setViewName("user/profiles/service");
		return mav;
	}

	@RequestMapping(value = "/healthTrack/clinic/review/{clinicId}/{userId}/{review}", method = RequestMethod.POST)
	public void clinicReview(@CookieValue(value = "lang", defaultValue = "en") String cookie,
			@PathVariable("clinicId") int clinicId, @PathVariable("review") int review,
			@PathVariable("userId") int userId, ModelAndView mav, ModelMap model, HttpServletRequest request)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		model.addAttribute("lang", cookie);
		if (ClinicDao.checkUserReviewOfClinic(userId, clinicId)) {
			ClinicDao.updateUserClinicReview(userId, clinicId, review);
		} else {
			ClinicDao.setClinicReview(userId, clinicId, review);
		}
		ClinicDao.updateClinicReview(clinicId);

	}


	@RequestMapping(value = "/healthTrack/clinic/review/{clinicId}/{userId}/comment", method = RequestMethod.POST)
	public ModelAndView clinicComment(@CookieValue(value = "lang", defaultValue = "en") String cookie,
			@PathVariable("userId") int userId, @PathVariable("clinicId") int clinicId, ModelAndView mav,
			ModelMap model, HttpServletRequest request) throws InstantiationException, IllegalAccessException,
			ClassNotFoundException, SQLException, org.json.simple.parser.ParseException, JSONException, IOException {

		Translator t = new Translator();
		model.addAttribute("lang", cookie);
		if (userId == 0) {
			request.setAttribute("commentLoginFirst",
					"<p class=\"wrong-input wrong-input-register-page-1\">" + t.write("Please login first",cookie) + "</p>");
		} else if (UserDao.canUserComment(userId, clinicId)) {

			String comment = request.getParameter("comment");

			if (!Validation.validateText(comment)) {
				request.setAttribute("invalidComment", "<p class=\"wrong-input wrong-input-register-page-1\">"
						+ t.write("Invalid characters in your comment",cookie) + "</p>");
			} else {
				ClinicDao.insertComment(userId, clinicId, comment);
			}
		} else {
			request.setAttribute("commentsLimitExceeded", "<p class=\"wrong-input wrong-input-register-page-1\">"
					+ t.write("sorry you reached the maximum number of comments for this service",cookie) + "</p>");
		}


		model.addAttribute("clinicId", clinicId);
		mav.setViewName("user/profiles/clinic");
		return mav;
	}

	@RequestMapping(value = "/HealthTrack/admin/{adminUsername}/{serviceId}/{place}/{url}", method = RequestMethod.GET)
	public ModelAndView adminPlace(@CookieValue(value = "lang", defaultValue = "en") String cookie, Model model,
			HttpSession session, ModelAndView mav, @PathVariable("url") String url,
			@PathVariable("adminUsername") String adminUsername, @PathVariable("serviceId") int serviceId,
			@PathVariable("place") String place)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		model.addAttribute("lang", cookie);
		model.addAttribute("serviceId", serviceId);
		model.addAttribute("place", place);
		String username = (String) session.getAttribute("username");
		if (username != null) {
			if (username.equalsIgnoreCase(adminUsername)) {
				mav.setViewName("/user/profiles/" + url);
			} else {
				mav.setViewName("redirect:/HealthTrack/login");
			}
		} else {
			mav.setViewName("/login");
		}
		return mav;
	}
	@RequestMapping(value = "/HealthTrack/admin/{adminUsername}/{serviceId}/{place}/{url}/add", method = RequestMethod.GET)
	public ModelAndView AddHAvailability(@CookieValue(value = "lang", defaultValue = "en") String cookie, Model model,
			HttpSession session, ModelAndView mav, @PathVariable("url") String url,
			@PathVariable("adminUsername") String adminUsername, @PathVariable("serviceId") int serviceId,
			@PathVariable("place") String place)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		model.addAttribute("lang", cookie);
		model.addAttribute("serviceId", serviceId);
		model.addAttribute("place", place);
		model.addAttribute("action","add");
		String username = (String) session.getAttribute("username");
		if (username != null) {
			if (username.equalsIgnoreCase(adminUsername)) {
				mav.setViewName("/user/profiles/" + url);
			} else {
				mav.setViewName("redirect:/HealthTrack/login");
			}
		} else {
			mav.setViewName("/login");
		}
		return mav;
	}

	@RequestMapping(value = "/HealthTrack/admin/{username}/{serviceId}/{placeType}/{place}/delete/{placeId}/{url}", method = RequestMethod.GET)
	public ModelAndView deleteHospital(@CookieValue(value = "lang", defaultValue = "en") String cookie, Model model,
			ModelAndView mav, HttpServletRequest request, @PathVariable("url") String url,
			@PathVariable("placeId") String placeId, @PathVariable("serviceId") int serviceId,
			@PathVariable("place") String place, @PathVariable("placeType") String placeType)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		model.addAttribute("lang", cookie);
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
		if (username == null) {
			mav.setViewName("/admin/login");
		} else {
			if (Validation.checkIfSomethingExists(place + "_id", place, placeId) && Validation.checkIfTheUserIsAdmin(username)) {
				HospitalDao.deleteSomthing(place, place + "_id", Integer.parseInt(placeId));
				mav.setViewName(
						"redirect:/HealthTrack/admin/" + username + "/" + serviceId + "/" + placeType + "/" + url);
			} else {
				mav.setViewName("/user/login");
			}

		}

		return mav;
	}

	@RequestMapping(value = "/HealthTrack/Service/ShowComment/{place}/{serviceId}/{reviewId}", method = RequestMethod.GET)
	public ModelAndView showComment(HttpServletRequest request, Model model, HttpSession session,
			@PathVariable("place") String place, @PathVariable("serviceId") int serviceId,
			@PathVariable("reviewId") int reviewId)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		String username = (String) session.getAttribute("username");

		if (username != null) {
			User user = UserDao.getUserByUsername(username);
			if (UserDao.isTheUserAuthorized(user.getId(), place, serviceId)) {
				ServiceDao.showComment(reviewId);
			}
		}
		return new ModelAndView(
				"redirect:/" + request.getHeader("Referer").substring(request.getHeader("Referer").indexOf("//") + 1));
	}

	@RequestMapping(value = "/HealthTrack/Clinic/ShowComment/{clinicId}/{reviewId}", method = RequestMethod.GET)
	public ModelAndView showCommentClinic(HttpServletRequest request, Model model, HttpSession session,
			@PathVariable("clinicId") int clinicId, @PathVariable("reviewId") int reviewId)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		String username = (String) session.getAttribute("username");

		if (username != null) {
			if (ClinicDao.isTheUserAuthorized(username, clinicId)) {
				ServiceDao.showComment(reviewId);
			}
		}
		return new ModelAndView(
				"redirect:/" + request.getHeader("Referer").substring(request.getHeader("Referer").indexOf("//") + 1));
	}

	@RequestMapping(value = "/HealthTrack/Clinic/HideComment/{clinicId}/{reviewId}", method = RequestMethod.GET)
	public ModelAndView hideCommentClinic(HttpServletRequest request, Model model, HttpSession session,
			@PathVariable("clinicId") int clinicId, @PathVariable("reviewId") int reviewId)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		String username = (String) session.getAttribute("username");

		if (username != null) {
			if (ClinicDao.isTheUserAuthorized(username, clinicId)) {
				ServiceDao.hideComment(reviewId);
			}
		}
		return new ModelAndView(
				"redirect:/" + request.getHeader("Referer").substring(request.getHeader("Referer").indexOf("//") + 1));
	}

	@RequestMapping(value = "/HealthTrack/Clinic/DeleteComment/{clinicId}/{reviewId}", method = RequestMethod.GET)
	public ModelAndView deleteCommentClinic(HttpServletRequest request, Model model, HttpSession session,
			@PathVariable("clinicId") int clinicId, @PathVariable("reviewId") int reviewId)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		String username = (String) session.getAttribute("username");

		if (username != null) {
			if (ClinicDao.isTheUserAuthorized(username, clinicId)) {
				ServiceDao.deleteComment(reviewId);
			}
		}
		return new ModelAndView(
				"redirect:/" + request.getHeader("Referer").substring(request.getHeader("Referer").indexOf("//") + 1));
	}

	@RequestMapping(value = "/HealthTrack/Service/HideComment/{place}/{serviceId}/{reviewId}", method = RequestMethod.GET)
	public ModelAndView hideComment(HttpServletRequest request, Model model, HttpSession session,
			@PathVariable("place") String place, @PathVariable("serviceId") int serviceId,
			@PathVariable("reviewId") int reviewId)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		String username = (String) session.getAttribute("username");

		if (username != null) {
			User user = UserDao.getUserByUsername(username);
			if (UserDao.isTheUserAuthorized(user.getId(), place, serviceId)) {
				ServiceDao.hideComment(reviewId);
			}
		}
		return new ModelAndView(
				"redirect:/" + request.getHeader("Referer").substring(request.getHeader("Referer").indexOf("//") + 1));
	}


	@RequestMapping(value = "/HealthTrack/Service/DeleteComment/{place}/{serviceId}/{reviewId}", method = RequestMethod.GET)
	public ModelAndView deleteComment(HttpServletRequest request, Model model, HttpSession session,
			@PathVariable("place") String place, @PathVariable("serviceId") int serviceId,
			@PathVariable("reviewId") int reviewId)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {


		String username = (String) session.getAttribute("username");

		if (username != null) {
			User user = UserDao.getUserByUsername(username);
			if (UserDao.isTheUserAuthorized(user.getId(), place, serviceId)) {
				ServiceDao.deleteComment(reviewId);
			}
		}
		return new ModelAndView(
				"redirect:/" + request.getHeader("Referer").substring(request.getHeader("Referer").indexOf("//") + 1));
	}
	
	@RequestMapping(value = "/HealthTrack/admin/{username}/delete/service/{serviceId}", method = RequestMethod.GET)
	public ModelAndView deleteService(HttpServletRequest request, Model model, HttpSession session, @PathVariable("serviceId") int serviceId, @PathVariable("username") String username)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		if (username.equals((String) session.getAttribute("username")) && Validation.checkIfTheUserIsAdmin(username)) {
			ServiceDao.deleteService(serviceId);
		}
		return new ModelAndView(
				"redirect:/" + request.getHeader("Referer").substring(request.getHeader("Referer").indexOf("//") + 1));
	}
	
}
