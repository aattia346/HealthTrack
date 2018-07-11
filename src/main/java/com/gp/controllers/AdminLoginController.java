package com.gp.controllers;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

import javax.mail.internet.AddressException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.simple.parser.ParseException;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.gp.user.Contact;
import com.gp.user.ContactDao;
import com.gp.user.Translator;
import com.gp.user.User;
import com.gp.user.UserDao;
import com.gp.user.Validation;

@RestController
public class AdminLoginController {
	
	@RequestMapping(value="/HealthTrack/admin/login", method = RequestMethod.GET)
	public ModelAndView adminLogin(@CookieValue(value="lang", defaultValue="en") String cookie, Model model, ModelAndView mav, HttpServletRequest request)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
		
		model.addAttribute("lang", cookie);
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
		if(username == null) {
			mav.setViewName("/admin/login");
		}else {
			if(Validation.checkIfTheUserIsAdmin(username)) {
				mav.setViewName("/admin/dashboard");
			}
		}
		return mav;
	}

	@RequestMapping(value="/HealthTrack/admin/login/submit", method = RequestMethod.POST)
	public ModelAndView adminLoginSubmit(Model model, ModelAndView mav, HttpServletRequest request)
			throws NoSuchAlgorithmException, InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
		
		String username = request.getParameter("username");
	   	String password = request.getParameter("password");

	   	if(Validation.validateUsername(username)) {
	   		
	   		String encryptedPassword = Validation.encryptePssword(password);
	   		int userId = UserDao.adminLoginSubmit(username, encryptedPassword);
	       	if(userId !=0 ) {     
	       		User user = UserDao.getUserById(userId);
	       		HttpSession session = request.getSession();
	       		session.setAttribute("username", user.getUsername());
	       		mav.setViewName("redirect:/HealthTrack/admin/dashboard");
	          }else {
	        	  
	       	   model.addAttribute("notAuthenticated", "<p class=\"wrong-input\">please check username and password</p>");
	       	   mav.setViewName("/admin/login");
	          }
	   	}else {
	   		
	   		model.addAttribute("invalidUsername", "<p class=\"wrong-input\">Invalid username</p>");
	   		mav.setViewName("/admin/login");
   	}
		return mav;
	}
	
	@RequestMapping(value="/HealthTrack/Contact/Submit", method = RequestMethod.POST)
	public ModelAndView adminLoginSubmit(@CookieValue(value="lang", defaultValue="en") String cookie, ModelMap m, HttpServletRequest request)
			throws NoSuchAlgorithmException, InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException, ParseException, JSONException, IOException{
		
		Translator t = new Translator();
		
		m.addAttribute("lang", cookie);
		
		String name	 = request.getParameter("name");
	   	String email = request.getParameter("email");
	   	String msg	 = request.getParameter("msg");
	   	
	   	boolean errors = false;
	   	
	   	if(!Validation.validateName(name)) {
	   		m.addAttribute("invalidName", "<p class=\"wrong-input\">" + t.write("Invalid Name",cookie) + "</p>");
	   		errors = true;
	   	}
	   	
	   	if(!Validation.validateEmail(email)) {
	   		m.addAttribute("invalidEmail", "<p class=\"wrong-input\">" + t.write("Invalid Email",cookie) + "</p>");
	   		errors = true;
	   	}
	   	
	   	if(!Validation.validateText(msg)) {
	   		m.addAttribute("invalidMsg", "<p class=\"wrong-input\">" + t.write("your messagr has invalid characters",cookie) + "</p>");
	   		errors = true;
	   	}
	   	
	   	if(!errors) {
	   		Contact contact = new Contact(name , email , msg);
	   		ContactDao.insertContact(contact);
	   		m.addAttribute("contactSucceed", "<p class=\"reviewSucceeded\">" + t.write("Thanks for your contact",cookie) + "</p>");
	   	}
	   	
	   	return new ModelAndView("redirect:/HealthTrack#contact");
	}
	
	@RequestMapping(value="/HealthTrack/admin/logout", method = RequestMethod.GET)
    public ModelAndView logout(ModelMap model, @CookieValue(value = "lang", defaultValue="en") String cookie, ModelAndView mav, HttpSession session) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException, AddressException {
		
		model.addAttribute("lang", cookie);
		String username = (String)session.getAttribute("username");
		if(username != null) {		
			session.invalidate();
		}
		mav.setViewName("redirect:/HealthTrack/admin/login");
		return mav;	
	}
}
