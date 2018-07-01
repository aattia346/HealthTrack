package com.gp.controllers;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

import javax.mail.internet.AddressException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.simple.parser.ParseException;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.gp.user.Person;
import com.gp.user.PersonDao;
import com.gp.user.Translator;
import com.gp.user.User;
import com.gp.user.UserDao;
import com.gp.user.Validation;
import com.gp.user.WaitingRequest;
import com.gp.user.WaitingRequestDao;

@RestController
public class UserLoginController {	
		
	@RequestMapping(value="/HealthTrack/WaitingList", method = RequestMethod.GET)
    public ModelAndView waitingList(@CookieValue(value = "lang", defaultValue="en") String cookie, ModelMap model) {
		model.addAttribute("lang", cookie);
		
        return new ModelAndView("/user/waitingList");
    }
	
	@RequestMapping(value="/HealthTrack", method = RequestMethod.GET)
    public ModelAndView home(@CookieValue(value = "lang", defaultValue="en") String cookie, ModelMap model) {
		model.addAttribute("lang", cookie);
        return new ModelAndView("/user/findService");
    }
	
	@RequestMapping(value="/HealthTrack/Emergency", method = RequestMethod.GET)
    public ModelAndView emergency(@CookieValue(value = "lang", defaultValue="en") String cookie, ModelMap model) {
		model.addAttribute("lang", cookie);
        return new ModelAndView("/user/emergency");
    }
	
	@RequestMapping(value = "/HealthTrack/login", method = RequestMethod.GET)
    public ModelAndView showForm(ModelMap model, ModelAndView mav, HttpServletRequest request,@CookieValue(value = "lang", defaultValue="en") String cookie){
		model.addAttribute("lang", cookie);
		HttpSession session = request.getSession();
		System.out.println(cookie);
		String username = (String)session.getAttribute("username");
		
		if(username == null) {
			mav.setViewName("/user/login");
		}else {
			mav.setViewName("redirect:/HealthTrack");			
		}
        return mav;
    }

	@RequestMapping(value="/HealthTrack/login/forgetmypassword", method = RequestMethod.GET)
    public ModelAndView forget(@CookieValue(value = "lang", defaultValue="en") String cookie, ModelMap model , ModelAndView mav) {
		
		model.addAttribute("lang", cookie);
		mav.setViewName("user/forgetPassword");
        return mav;
    }

	@RequestMapping(value = "/HealthTrack/login/submit", method = RequestMethod.POST)
    public ModelAndView submit(@CookieValue(value = "lang", defaultValue="en") String cookie, HttpServletRequest request, User user, ModelMap model, ModelAndView mav)throws InstantiationException,
    IllegalAccessException, ClassNotFoundException, SQLException, NoSuchAlgorithmException, ParseException, JSONException, IOException ,NullPointerException{
		
	    model.addAttribute("lang", cookie);
	    
	    Translator t= new Translator(); ;
		
	    
	   	String username = request.getParameter("username");
	   	String password = request.getParameter("password");
	   	
	   	model.addAttribute("oldUsername", username);
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
	        	  
	       	   model.addAttribute("notAuthenticated", "<p class=\"wrong-input\">" + t.write("please check username and password",cookie) + "</p>");
	       	   mav.addAllObjects(model);
	       	   mav.setViewName("/user/login");
	          }
	   	}else {
	   		
	   		model.addAttribute("invalidUsername", "<p class=\"wrong-input\">" + t.write("Invalid username",cookie) + "</p>");
	   		mav.addAllObjects(model);
	   		mav.setViewName("/user/login");
   	}
	   	return mav;
   	
   }
	
	@RequestMapping(value="/HealthTrack/login/recovermypassword/submit", method = RequestMethod.POST)
	public ModelAndView recoverPasswordSubmitByPostRequest(@CookieValue(value = "lang", defaultValue="en") String cookie, HttpServletRequest request,ModelAndView mav, ModelMap m) throws NumberFormatException, InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException, ParseException, JSONException, IOException {
		
		Translator t = new Translator();
		m.addAttribute("lang", cookie);
		if(Validation.validateNumber(request.getParameter("code"))) {
			int insertedCode = Integer.parseInt(request.getParameter("code"));
				HttpSession session = request.getSession();
				User user = UserDao.getUserByUsername((String) session.getAttribute("username"));
				int code = user.getVerificationCode();
				if(code==insertedCode) {
					UserDao.changeCode(user.getId());
					mav.setViewName("/user/recoverPassword");
				}else {
					mav.setViewName("/user/insertCodeWhenForgetPassword");
					m.addAttribute("wrongeCode", "<p class=\"wrong-input\">" + t.write("wronge Code",cookie) + "</p>");
				}
			}else {
				m.addAttribute("wrongeCode", "<p class=\"wrong-input\">" + t.write("Invalid Code",cookie) + "</p>");
				mav.setViewName("/user/insertCodeWhenForgetPassword");
			}
		
		return mav;
	}

	@RequestMapping(value="/HealthTrack/forgetmypassword/submit", method = RequestMethod.POST)
    public ModelAndView forgetSubmit(@CookieValue(value = "lang", defaultValue="en") String cookie, ModelMap model, HttpServletRequest request) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException, AddressException, ParseException, JSONException, IOException {
		
		Translator t = new Translator();
		model.addAttribute("lang", cookie);
		ModelAndView mav = new ModelAndView();
		String email = request.getParameter("email");
		
		if(Validation.validateEmail(email)) {		
			if(!Validation.checkIfSomethingExists("email", "person", email)) {				
				mav.setViewName("/user/forgetPassword");
				model.addAttribute("wrongeEmail" , "<p class=\"wrong-input\">" + t.write("please check the Email",cookie) + "</p>"); 
			}else {
				Person person = PersonDao.getAllInfoAboutUserByEmail(email); 
				Validation.sendEmail(email, person.getFirstName(), person.getVerificationCode());
				HttpSession session = request.getSession();
				session.setAttribute("username", person.getUsername());
				mav.setViewName("/user/insertCodeWhenForgetPassword"); //page with security details to change the password
			}
		}else {
			mav.setViewName("/user/forgetPassword");
			model.addAttribute("invalidEmail" , "<p class=\"wrong-input\">" + t.write("Invalid Email",cookie) + "</p>");
		}
		
		mav.addAllObjects(model);
        return mav;
    }
	
	@RequestMapping(value="/HealthTrack/changePassword/submit", method = RequestMethod.POST)
    public ModelAndView changePasswordSubmit(@CookieValue(value = "lang", defaultValue="en") String cookie, ModelAndView mav, HttpSession session, HttpServletRequest request, ModelMap model)
    		throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException, AddressException, NoSuchAlgorithmException, ParseException, JSONException, IOException {
		
		Translator t = new Translator();
		model.addAttribute("lang", cookie);
		String username = (String)session.getAttribute("username");
		
		if(username == null) {
			mav.setViewName("/user/login");
		}else {
			String oldPassword		= Validation.encryptePssword(request.getParameter("oldPassword"));
			String password			= request.getParameter("password");
			String confirmPassword	= request.getParameter("confirmPassword");
			
			
			User user = UserDao.getUserByUsername(username);
			
			boolean errors = false;
			
			if(!user.getPassword().equals(oldPassword)) {
				model.addAttribute("wrongPassword", "<p class=\"wrong-input\">" + t.write("Wrong Password",cookie) + "</p>");
				errors = true;
			}
			
			if(password.length()<6) {
				model.addAttribute("invalidPassword", "<p class=\"wrong-input\">" + t.write("Password shouldn't be less than 6 characters",cookie) + "</p>");
				errors = true;
			}
			if(!password.equals(confirmPassword)) {
				model.addAttribute("passwordNotMatch", "<p class=\"wrong-input\">" + t.write("Password doesn't match",cookie) + "</p>");
				errors = true;
			}
			
			if(errors) {
				mav.setViewName("/user/changePassword");
			}else {
				String hashedPassword = Validation.encryptePssword(password);				
				PersonDao.changePassword(user.getId(), hashedPassword);
				mav.setViewName("/user/profiles/user");
			}
			
		}		
		return mav;	
	}
	
	@RequestMapping(value="/HealthTrack/recoverPassword/submit", method = RequestMethod.POST)
    public ModelAndView recoverPasswordSubmit(@CookieValue(value = "lang", defaultValue="en") String cookie, ModelAndView mav, HttpSession session, HttpServletRequest request, ModelMap model)
    		throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException, AddressException, NoSuchAlgorithmException, ParseException, JSONException, IOException {
		
		Translator t = new Translator();
		model.addAttribute("lang", cookie);
		String username = (String)session.getAttribute("username");
		
		if(username == null) {
			mav.setViewName("/user/login");
		}else {
			String password			= request.getParameter("password");
			String confirmPassword	= request.getParameter("confirmPassword");		
			
			User user = UserDao.getUserByUsername(username);
			
			boolean errors = false;
		
			if(password.length()<6) {
				model.addAttribute("invalidPassword", "<p class=\"wrong-input\">" + t.write("Password shouldn't be less than 6 characters",cookie) + "</p>");
				errors = true;
			}
			if(!password.equals(confirmPassword)) {
				model.addAttribute("passwordNotMatch", "<p class=\"wrong-input\">" + t.write("Password doesn't match",cookie) + "</p>");
				errors = true;
			}
			
			if(errors) {
				mav.setViewName("/user/recoverPassword");
			}else {
				String hashedPassword = Validation.encryptePssword(password);				
				PersonDao.changePassword(user.getId(), hashedPassword);
				mav.setViewName("/user/profiles/user");
			}
			
		}		
		return mav;	
	}
	
	@RequestMapping(value="/HealthTrack/{username}/changePassword", method = RequestMethod.GET)
    public ModelAndView changePassword(ModelMap model, @CookieValue(value = "lang", defaultValue="en") String cookie, ModelAndView mav, HttpSession session) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException, AddressException {
		
		model.addAttribute("lang", cookie);
		String username = (String)session.getAttribute("username");
		if(username == null) {
			mav.setViewName("/user/login");
		}else {
			mav.setViewName("/user/changePassword");
		}		
		return mav;	
	}
	
	@RequestMapping(value="/HealthTrack/logout", method = RequestMethod.GET)
    public ModelAndView logout(ModelMap model, @CookieValue(value = "lang", defaultValue="en") String cookie, ModelAndView mav, HttpSession session) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException, AddressException {
		
		model.addAttribute("lang", cookie);
		String username = (String)session.getAttribute("username");
		if(username != null) {		
			session.invalidate();
		}
		mav.setViewName("/user/login");
		return mav;	
	}
	
	@RequestMapping(value="/HealthTrack/login/verifymyaccount/submit", method = RequestMethod.POST) 
	public ModelAndView submitCode(@CookieValue(value = "lang", defaultValue="en") String cookie,ModelMap model, HttpServletRequest request, HttpSession session, ModelAndView mav) 
    		throws InstantiationException, IllegalAccessException, ClassNotFoundException,
    		SQLException, AddressException, ParseException, JSONException, IOException {
        
		Translator t = new Translator();
		model.addAttribute("lang", cookie);
		String username = (String)session.getAttribute("username");
		if(Validation.validateNumber(request.getParameter("code"))) {
			int insertedCode = Integer.parseInt(request.getParameter("code"));
			User user = UserDao.getUserByUsername(username);       
			Person person = PersonDao.getPersonByUserID(user.getId());
			Validation.sendEmail(person.getEmail(), person.getFirstName(), user.getVerificationCode());

	        if(user.getVerificationCode()==insertedCode) {
	        	
	        	PersonDao.verifyAccount(user.getId());
	        	UserDao.changeCode(user.getId());
	        	String url = "/user/profiles/user";
	        	mav.setViewName(url);
	        	
	        }else {
	        	
	        	mav.setViewName("/user/verificationPage");
	        	model.addAttribute("wrongeCode", "<p class=\"wrong-input\">" + t.write("wronge Code",cookie) + "</p>");
	        	mav.addAllObjects(model);
	        	
	        	}
		}else {
				mav.setViewName("/user/verificationPage");
	        	model.addAttribute("invalidCode", "<p class=\"wrong-input\">" + t.write("Invalid Code",cookie) + "</p>");
	        	mav.addAllObjects(model);	
		}
	
		return mav;
    }
	
	@RequestMapping(value="/HealthTrack/Waiting/Submit", method = RequestMethod.POST)
    public ModelAndView waitingListSubmit(HttpServletRequest request ,ModelAndView mav , @CookieValue(value = "lang", defaultValue="en") String cookie, ModelMap model) throws ParseException, JSONException, IOException, InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		model.addAttribute("lang", cookie);
		Translator t = new Translator();
		
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String service = request.getParameter("service");
		
		model.addAttribute("oldName"	, name);
		model.addAttribute("oldPhone"	, phone);
		
		boolean errors = false;
		
		if(!Validation.validateName(name)) {
			model.addAttribute("invalidName", "<p class=\"wrong-input\">" + t.write("invalide name",cookie) + "</p>");
			errors = true;			
		}
		
		if(!Validation.validatePhone(phone)) {
			model.addAttribute("invalidPhone", "<p class=\"wrong-input\">" + t.write("invalide phone",cookie) + "</p>");
			errors = true;			
		}
		
		if(service.equals("0")) {
			model.addAttribute("invalidService", "<p class=\"wrong-input\">" + t.write("please select a service",cookie) + "</p>");
			errors = true;			
		}
		
		if(!errors) {
			model.addAttribute("submitSucceed", "<p class=\"alert alert-success col-sm-offset-3 col-sm-6\">" + t.write("your request has been sent successfully",cookie) + "</p>");
			WaitingRequest waitingRequest = new WaitingRequest(name, phone, service);
			WaitingRequestDao.insertRequest(waitingRequest);
			//send whatsup message
		}
		//String url = request.getHeader("Referer");
		mav.setViewName("/user/waitingList");
		
        return mav;
    }
	
}