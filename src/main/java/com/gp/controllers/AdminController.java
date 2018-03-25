package com.gp.controllers;

import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.gp.user.User;
import com.gp.user.UserDao;
import com.gp.user.Validation;

@RestController
public class AdminController {
	
	@RequestMapping(value="/HealthTrack/admin/dashboard", method = RequestMethod.GET)
	public ModelAndView dashboard(Model model, ModelAndView mav, HttpServletRequest request)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
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
	
	@RequestMapping(value="/HealthTrack/admin/login", method = RequestMethod.GET)
	public ModelAndView adminLogin(Model model, ModelAndView mav, HttpServletRequest request)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
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

	@RequestMapping(value="/HealthTrack/admin/{adminUsername}/{place}", method = RequestMethod.GET)
	public ModelAndView adminPlaces(Model model, HttpSession session, ModelAndView mav, @PathVariable("adminUsername") String adminUsername, @PathVariable("place") String place)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
		if(Validation.checkIfTheUserIsAdmin(adminUsername)) {
			String username = (String)session.getAttribute("username");
			if(username != null) {
				if(username.equalsIgnoreCase(adminUsername)) {
					mav.setViewName("/admin/" + place);
				}else {
					mav.setViewName("redirect/:HealthTrack/admin/login");
				}
			}else {
				mav.setViewName("/admin/login");
			}
			
		}
		
		return mav;
	}


}
