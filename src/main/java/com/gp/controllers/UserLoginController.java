package com.gp.controllers;

import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

import javax.mail.internet.AddressException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.gp.user.Person;
import com.gp.user.PersonDao;
import com.gp.user.User;
import com.gp.user.UserDao;
import com.gp.user.Validation;

@RestController
public class UserLoginController {	
	
	@RequestMapping(value="/HealthTrack", method = RequestMethod.GET)
    public ModelAndView home() {
        return new ModelAndView("/user/findService");
    }
	
	@RequestMapping(value = "/HealthTrack/login", method = RequestMethod.GET)
    public ModelAndView showForm(ModelAndView mav, HttpServletRequest request){
		HttpSession session = request.getSession();
		if(session.isNew()) {
			mav.setViewName("/user/login");
		}else {
			System.out.println(session.getAttribute("username"));
			mav.setViewName("redirect:/HealthTrack");			
		}
        return mav;
    }
	
	@RequestMapping(value = "/HealthTrack/login/submit", method = RequestMethod.GET)
    public ModelAndView submitByGetRequest(ModelAndView mav) {
		mav.setViewName("redirect:/HealthTrack/login");
		return mav;
    }
	
	@RequestMapping(value="/HealthTrack/login/verifymyaccount/submit", method = RequestMethod.GET)
    public ModelAndView forgetGet(ModelMap model , ModelAndView mav) {	
		mav.setViewName("redirect:/HealthTrack/login/");
        return mav;
    }
	
	@RequestMapping(value="/HealthTrack/forgetmypassword/submit", method = RequestMethod.GET)
    public ModelAndView forgetSubmitByGetRequest() {
		return new ModelAndView("redirect:/HealthTrack/login/");
	}
	
	@RequestMapping(value="/HealthTrack/login/forgetmypassword", method = RequestMethod.GET)
    public ModelAndView forget(ModelMap model , ModelAndView mav) {
		mav.setViewName("user/forgetPassword");
        return mav;
    }
	
	@RequestMapping(value="/HealthTrack/login/recovermypassword/submit", method = RequestMethod.GET)
	public ModelAndView recoverPasswordSubmitByGetRequest() {

		return new ModelAndView("redirect:/HealthTrack/login/");
	}
	
	@RequestMapping(value = "/HealthTrack/login/submit", method = RequestMethod.POST)
    public ModelAndView submit(HttpServletRequest request, User user, ModelMap model, ModelAndView mav)throws InstantiationException,
    IllegalAccessException, ClassNotFoundException, SQLException, NoSuchAlgorithmException {
		
	   
	   	String username = request.getParameter("username");
	   	String password = request.getParameter("password");

	   	if(Validation.validateUsername(username)) {
	   		
	   		String encryptedPassword = Validation.encryptePssword(password);
	   		int userId = UserDao.loginSubmit(username, encryptedPassword);
	       	if(userId !=0 ) {     
	       		user = UserDao.getUserById(userId);
	       		if(user.getType().equalsIgnoreCase("person")) {
	       			Person person = PersonDao.getPersonByUserID(user.getId());
		       	   	if(person.getVerified()==0) {
		       	   		HttpSession session = request.getSession();		
		       	   		session.setAttribute("username", username); //create new session with username
		       	   		mav.setViewName("/user/verificationPage");
		       	   	}else {		       	   		
						HttpSession session = request.getSession();		
						session.setAttribute("username", username); //create new session with username
						mav.setViewName("redirect:/HealthTrack");				
		       	   	}
	       			
	       		}else {
	       			HttpSession session = request.getSession();		
					session.setAttribute("username", username); //create new session with username
	       			String url = "redirect:/HealthTrack/profile/"+ user.getType() + "/" +user.getId();
	       			mav.setViewName(url);
	       		}
	       	   	
	          }else {
	        	  
	       	   model.addAttribute("notAuthenticated", "<p class=\"wrong-input\">please check username and password</p>");
	       	   mav.addAllObjects(model);
	       	   mav.setViewName("/user/login");
	          }
	   	}else {
	   		
	   		model.addAttribute("invalidUsername", "<p class=\"wrong-input\">Invalid username</p>");
	   		mav.addAllObjects(model);
	   		mav.setViewName("/user/login");
   	}
	   	return mav;
   	
   }
	
	@RequestMapping(value="/HealthTrack/login/recovermypassword/submit", method = RequestMethod.POST)
	public ModelAndView recoverPasswordSubmitByPostRequest(HttpServletRequest request,ModelAndView mav, ModelMap m) throws NumberFormatException, InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		if(Validation.validateNumber(request.getParameter("code"))) {
			int insertedCode = Integer.parseInt(request.getParameter("code"));
				HttpSession session = request.getSession();
				User user = UserDao.getUserByUsername((String) session.getAttribute("username"));
				int id = user.getId();
				int code = user.getVerificationCode();
				if(code==insertedCode) {
					UserDao.changeCode(user.getId());
					String url = "/HealthTrack/changePassword/" + id;
					mav.setViewName("redirect:"+url);
				}else {
					mav.setViewName("/user/insertCodeWhenForgetPassword");
					m.addAttribute("wrongeCode", "<p class=\"wrong-input\">wronge Code</p>");
				}
			}else {
				m.addAttribute("wrongeCode", "<p class=\"wrong-input\">Invalid Code</p>");
				mav.setViewName("/user/insertCodeWhenForgetPassword");
			}
		
		return mav;
	}

	@RequestMapping(value="/HealthTrack/forgetmypassword/submit", method = RequestMethod.POST)
    public ModelAndView forgetSubmit(ModelMap model, HttpServletRequest request) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException, AddressException {
		
		ModelAndView mav = new ModelAndView();
		String email = request.getParameter("email");
		
		if(Validation.validateEmail(email)) {		
			if(!Validation.checkIfSomethingExists("email", "person", email)) {				
				mav.setViewName("/user/forgetPassword");
				model.addAttribute("wrongeEmail" , "<p class=\"wrong-input\">please check the Email</p>"); 
			}else {
				Person person = PersonDao.getAllInfoAboutUserByEmail(email); 
				Validation.sendEmail(email, person.getFirstName(), person.getVerificationCode());
				HttpSession session = request.getSession();
				session.setAttribute("username", person.getUsername());
				mav.setViewName("/user/insertCodeWhenForgetPassword"); //page with security details to change the password
			}
		}else {
			mav.setViewName("/user/forgetPassword");
			model.addAttribute("invalidEmail" , "<p class=\"wrong-input\">Invalid Email</p>");
		}
		
		mav.addAllObjects(model);
        return mav;
    }
	
	@RequestMapping(value="/HealthTrack/login/verifymyaccount/submit", method = RequestMethod.POST) 
	public ModelAndView submitCode(ModelMap model, HttpServletRequest request, HttpSession session, ModelAndView mav) 
    		throws InstantiationException, IllegalAccessException, ClassNotFoundException,
    		SQLException, AddressException {
        
		String username = (String)session.getAttribute("username");
		if(Validation.validateNumber(request.getParameter("code"))) {
			int insertedCode = Integer.parseInt(request.getParameter("code"));
			User user = UserDao.getUserByUsername(username);       
			Person person = PersonDao.getPersonByUserID(user.getId());
			Validation.sendEmail(person.getEmail(), person.getFirstName(), user.getVerificationCode());
			//UserDao.changeCode(user.getId());

	        if(user.getVerificationCode()==insertedCode) {
	        	
	        	PersonDao.verifyAccount(user.getId());
	        	UserDao.changeCode(user.getId());
	        	String url = "redirect:/HealthTrack/profile/" + user.getId();
	        	mav.setViewName(url);
	        	
	        }else {
	        	
	        	mav.setViewName("/user/verificationPage");
	        	model.addAttribute("wrongeCode", "<p class=\"wrong-input\">the code you inserted is false</p>");
	        	mav.addAllObjects(model);
	        	
	        	}
		}else {
				mav.setViewName("/user/verificationPage");
	        	model.addAttribute("invalidCode", "<p class=\"wrong-input\">Invalid Code</p>");
	        	mav.addAllObjects(model);	
		}
	
		return mav;
    }
}