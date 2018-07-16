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

@RestController
public class UserRegisterationController {
	
	@RequestMapping(value = "/HealthTrack/signup", method = RequestMethod.GET)
    public ModelAndView showForm(ModelMap model, @CookieValue(value = "lang", defaultValue="en") String cookie) {	
		
		model.addAttribute("lang", cookie);
		ModelAndView mav = new ModelAndView("/user/userRegisteration");
        return mav;
    }
	
	@RequestMapping(value = "/HealthTrack/forgetpassword/resendCode", method = RequestMethod.GET)
    public ModelAndView resendCodeToRecoverPassword(ModelMap model, @CookieValue(value = "lang", defaultValue="en") String cookie,HttpSession session, ModelAndView mav)
    throws InstantiationException, IllegalAccessException, ClassNotFoundException,SQLException,AddressException {	
		
		model.addAttribute("lang", cookie);
		if(session.isNew()) {
			mav.setViewName("redirect:/HealthTrack/login");
		}else {
			String username = (String)session.getAttribute("username");
			if(username == null) {
				mav.setViewName("redirect:/HealthTrack/login");
			}
			Person person = PersonDao.getAllInfoAboutUserByUsername(username);
			Validation.sendEmail(person.getEmail(), person.getFirstName(), person.getVerificationCode());
			mav.setViewName("/user/insertCodeWhenForgetPassword");
		}
        return mav;
    }
	
	@RequestMapping(value = "/HealthTrack/verifymyaccount/resendCode", method = RequestMethod.GET)
    public ModelAndView resendCodeToVerifyAccount(ModelMap model, @CookieValue(value = "lang", defaultValue="en") String cookie,HttpSession session, ModelAndView mav)
    throws InstantiationException, IllegalAccessException, ClassNotFoundException,SQLException,AddressException {	
		
		model.addAttribute("lang", cookie);
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

	@RequestMapping(value = "/HealthTrack/signup/submit", method = RequestMethod.POST)
    public ModelAndView registerSubmit(@CookieValue(value = "lang", defaultValue="en") String cookie,HttpServletRequest request, ModelMap model)
    throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException,
    NoSuchAlgorithmException, AddressException, ParseException, JSONException, IOException {
		
		Translator t = new Translator();
		model.addAttribute("lang", cookie);
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
			model.addAttribute("invalidFirstName", "<p class=\"wrong-input wrong-input-register-page-1\">" + t.write("Invalid First Name", cookie) + "</p>");
			errors = false;
		}
		if(!Validation.validateName(lastName)) {
			model.addAttribute("invalidLastName", "<p class=\"wrong-input wrong-input-register-input-2\">" + t.write("Invalid Last Name", cookie) + "</p>");
			errors = false;
		}
		if(!Validation.validateUsername(username)) {
			model.addAttribute("invalidUsername", "<p class=\"wrong-input\">" + t.write("Invalid username", cookie) + "</p>");
			errors = false;
		}
		if(Validation.checkIfSomethingExists("username", "user", username)) {
			model.addAttribute("usernameAlreadyExists", "<p class=\"wrong-input\">" + t.write("Sorry this username has been taken", cookie) + "</p>");
			errors = false;
		}
		if(password.length()<6) {
			model.addAttribute("invalidPassword", "<p class=\"wrong-input\">" + t.write("Password shouldn't be less than 6 characters", cookie) + "</p>");
			errors = false;
		}
		if(!password.equals(confirmPassword)) {
			model.addAttribute("passwordNotMatch", "<p class=\"wrong-input\">" + t.write("Password doesn't match", cookie) + "</p>");
			errors = false;
		}
		if(!Validation.validatePhone(phone)) {
			model.addAttribute("invalidPhone", "<p class=\"wrong-input\">" + t.write("Invalid Phone Number", cookie) + "</p>");
			errors = false;
		}
		if(!Validation.validateEmail(email)) {
			model.addAttribute("invalidEmail", "<p class=\"wrong-input\">" + t.write("Invalid Email", cookie) + "</p>");
			errors = false;
		}
		if(Validation.checkIfSomethingExists("email", "person", email)) {
			model.addAttribute("emailAlreadyExists", "<p class=\"wrong-input\">" + t.write("Sorry this email alreay exists", cookie) + "</p>");
			errors = false;
		}
		
		if(Validation.checkEmailBan("email")) {
			model.addAttribute("bannedEmail", "<p class=\"wrong-input\">" + t.write("Sorry this email is banned", cookie) + "</p>");
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
			person.setId(user.getId());
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
	
	@RequestMapping(value = "/HealthTrack/Profile/Edit", method = RequestMethod.POST)
    public ModelAndView editUser(@CookieValue(value = "lang", defaultValue="en") String cookie,HttpServletRequest request, ModelMap model, ModelAndView mav)
    throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException,
    NoSuchAlgorithmException, AddressException, ParseException, JSONException, IOException {
				
		Translator t = new Translator();
		model.addAttribute("lang", cookie);
		
		int id					= Integer.parseInt((String)request.getParameter("id"));
		String firstName		= request.getParameter("firstName");
		String lastName			= request.getParameter("lastName");
		String oldPassword		= request.getParameter("oldPassword");
		String newPassword		= request.getParameter("newPassword");
		String confirmPassword	= request.getParameter("confirmPassword");
		String email			= request.getParameter("email");
		
		User U = UserDao.getUserById(id);
		Person P = PersonDao.getPersonByUserID(id);
		
		model.addAttribute("oldFirstName", firstName);
		model.addAttribute("oldLastName", lastName);
		model.addAttribute("oldEmail", email);
		
		boolean errors = true;
		
		if(!Validation.encryptePssword(oldPassword).equals(U.getPassword())) {
			model.addAttribute("incorrectPassword", "<p class=\"wrong-input wrong-input-register-page-1\">" + t.write("wronge password", cookie) + "</p>");
			errors = false;
		}
		
		if(!Validation.validateName(firstName)) {
			model.addAttribute("invalidFirstName", "<p class=\"wrong-input wrong-input-register-page-1\">" + t.write("Invalid First Name", cookie) + "</p>");
			errors = false;
		}
		if(!Validation.validateName(lastName)) {
			model.addAttribute("invalidLastName", "<p class=\"wrong-input wrong-input-register-input-2\">" + t.write("Invalid Last Name", cookie) + "</p>");
			errors = false;
		}
		if(newPassword.length()<6) {
			model.addAttribute("invalidPassword", "<p class=\"wrong-input\">" + t.write("Password shouldn't be less than 6 characters", cookie) + "</p>");
			errors = false;
		}
		if(!newPassword.equals(confirmPassword)) {
			model.addAttribute("passwordNotMatch", "<p class=\"wrong-input\">" + t.write("Password doesn't match", cookie) + "</p>");
			errors = false;
		}
		if(!Validation.validateEmail(email)) {
			model.addAttribute("invalidEmail", "<p class=\"wrong-input\">" + t.write("Invalid Email", cookie) + "</p>");
			errors = false;
		}
		if(Validation.checkEmailBan("email")) {
			model.addAttribute("bannedEmail", "<p class=\"wrong-input\">" + t.write("Sorry this email is banned", cookie) + "</p>");
			errors = false;
		}
	
		if(errors) {
			//create the info of login
			String encryptedPassword = Validation.encryptePssword(newPassword);
			int verificationCode = Validation.generateCode();
			U.setPassword(encryptedPassword);
			U.setVerificationCode(verificationCode);
			UserDao.updateUser(U);
			//start the storage to the database		
			
			Person person = new Person();
			person.setId(U.getId());
			person.setFirstName(firstName);
			person.setLastName(lastName);
			person.setEmail(email);
			person.setVerified(0);
			person.setPhone(P.getPhone());
			PersonDao.updatePerson(person);
			
			Validation.sendEmail(email, firstName,verificationCode);
			mav.setViewName("/user/verificationPage");
		}else {
			model.addAttribute("alert"		, "alert alert-danger");
			mav.addAllObjects(model);
			mav.setViewName("/user/profiles/user");
		}
		return mav;
    }

}