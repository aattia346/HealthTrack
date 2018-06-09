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
public class UserRegisterationController {
	
	@RequestMapping(value = "/HealthTrack/signup", method = RequestMethod.GET)
    public ModelAndView showForm() {	
		ModelAndView mav = new ModelAndView("/user/userRegisteration");
        return mav;
    }
	
	@RequestMapping(value = "/HealthTrack/forgetpassword/resendCode", method = RequestMethod.GET)
    public ModelAndView resendCodeToRecoverPassword(HttpSession session, ModelAndView mav)
    throws InstantiationException, IllegalAccessException, ClassNotFoundException,SQLException,AddressException {	
		
		if(session.isNew()) {
			mav.setViewName("redirect:/HealthTrack/login");
		}else {
			String username = (String)session.getAttribute("username");
			Person person = PersonDao.getAllInfoAboutUserByUsername(username);
			Validation.sendEmail(person.getEmail(), person.getFirstName(), person.getVerificationCode());
			mav.setViewName("/user/insertCodeWhenForgetPassword");
		}
        return mav;
    }
	
	@RequestMapping(value = "/HealthTrack/verifymyaccount/resendCode", method = RequestMethod.GET)
    public ModelAndView resendCodeToVerifyAccount(HttpSession session, ModelAndView mav)
    throws InstantiationException, IllegalAccessException, ClassNotFoundException,SQLException,AddressException {	
		
		if(session.isNew()) {
			mav.setViewName("redirect:/HealthTrack/login");
		}else {
			String username = (String)session.getAttribute("username");
			Person person = PersonDao.getAllInfoAboutUserByUsername(username);
			Validation.sendEmail(person.getEmail(), person.getFirstName(), person.getVerificationCode());
			mav.setViewName("/user/verificationPage");
		}
        return mav;
    }
	
	@RequestMapping(value = "/HealthTrack/signup/submit", method = RequestMethod.GET)
    public ModelAndView registerSubmitWithGetMethod() {	
		ModelAndView mav = new ModelAndView("/user/userRegisteration");
        return mav;
    }
	
	@RequestMapping(value = "/HealthTrack/signup/submit", method = RequestMethod.POST)
    public ModelAndView registerSubmit(HttpServletRequest request, ModelMap model)
    throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException,
    NoSuchAlgorithmException, AddressException {
		
		ModelAndView verifyMav  = new ModelAndView("/user/verificationPage");
		ModelAndView registerMav = new ModelAndView("/user/userRegisteration");
		
		String firstName		= request.getParameter("firstName");
		String lastName			= request.getParameter("lastName");
		String username			= request.getParameter("username");
		String password			= request.getParameter("password");
		String confirmPassword	= request.getParameter("confirmPassword");
		String phone 			= request.getParameter("phone");
		String email			= request.getParameter("email");
		
		model.addAttribute("oldFirstName", firstName);
		model.addAttribute("oldLastName", lastName);
		model.addAttribute("oldUsername", username);
		model.addAttribute("oldPhone", phone);
		model.addAttribute("oldEmail", email);
		
		boolean errors = true;
		
		if(!Validation.validateName(firstName)) {
			model.addAttribute("invalidFirstName", "<p class=\"wrong-input wrong-input-register-page-1\">Invalid First Name</p>");
			errors = false;
		}
		if(!Validation.validateName(lastName)) {
			model.addAttribute("invalidLastName", "<p class=\"wrong-input wrong-input-register-input-2\">Invalid Last Name</p>");
			errors = false;
		}
		if(!Validation.validateUsername(username)) {
			model.addAttribute("invalidUsername", "<p class=\"wrong-input\">Invalid username</p>");
			errors = false;
		}
		if(Validation.checkIfSomethingExists("username", "user", username)) {
			model.addAttribute("usernameAlreadyExists", "<p class=\"wrong-input\">Sorry this username has been taken</p>");
			errors = false;
		}
		if(password.length()<6) {
			model.addAttribute("invalidPassword", "<p class=\"wrong-input\">Password shouldn't be less than 6 characters</p>");
			errors = false;
		}
		if(!password.equals(confirmPassword)) {
			model.addAttribute("passwordNotMatch", "<p class=\"wrong-input\">Password doesn't match</p>");
			errors = false;
		}
		if(!Validation.validatePhone(phone)) {
			model.addAttribute("invalidPhone", "<p class=\"wrong-input\">Invalid Phone Number</p>");
			errors = false;
		}
		if(!Validation.validateEmail(email)) {
			model.addAttribute("invalidEmail", "<p class=\"wrong-input\">Invalid Email</p>");
			errors = false;
		}
		if(Validation.checkIfSomethingExists("email", "person", email)) {
			model.addAttribute("emailAlreadyExists", "<p class=\"wrong-input\">Sorry this email alreay exists</p>");
			errors = false;
		}
		
		if(Validation.checkEmailBan("email")) {
			model.addAttribute("bannedEmail", "<p class=\"wrong-input\">Sorry this email is banned</p>");
			errors = false;
		}
	
		if(errors) {
			//create the info of login
			String encryptedPassword = Validation.encryptePssword(password);
			int verificationCode = Validation.generateCode();
			User user = new User(username, encryptedPassword, "person", verificationCode);
			user.setId(UserDao.insertUser(user));
			//start the storage to the database		
			
			Person person = new Person();
			person.setUserId(user.getId());
			person.setFirstName(firstName);
			person.setLastName(lastName);
			person.setEmail(email);
			person.setPhone(phone);
			person.setVerified(0);
			PersonDao.insertPerson(person);
			
			HttpSession session = request.getSession();		
			session.setAttribute("username", username); //create new session with username
			
			Validation.sendEmail(email, firstName,verificationCode);
			//and after storing the data redirect to the profile
			model.addAttribute("id"			, user.getId());
			model.addAttribute("username"	, user.getUsername());
			model.addAttribute("password"	, user.getPassword());
			model.addAttribute("firstName"	, person.getFirstName());
			model.addAttribute("lastName"	, person.getLastName());
			model.addAttribute("email"		, person.getEmail());
			model.addAttribute("phone"		, person.getPhone());
			model.addAttribute("type"		, user.getType());
			verifyMav.addAllObjects(model);
			return verifyMav;
		}else {
			registerMav.addAllObjects(model);
			return registerMav;
		}
    }

}