package com.gp.controllers;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.gp.user.Hospital;
import com.gp.user.HospitalDao;
import com.gp.user.Validation;

@RestController
public class DashboardController {
	
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

	@RequestMapping(value="/HealthTrack/admin/{adminUsername}/hospital/add", method = RequestMethod.GET)
	public ModelAndView dashboard(Model model, ModelAndView mav, @PathVariable("adminUsername") String adminUsername
			, HttpSession session) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
			
		if(Validation.checkIfTheUserIsAdmin(adminUsername)) {
			String username = (String)session.getAttribute("username");
			if(username != null) {
				if(username.equalsIgnoreCase(adminUsername)) {
					mav.setViewName("/admin/addHospital");
				}else {
					mav.setViewName("redirect/:HealthTrack/admin/login");
				}
			}else {
				mav.setViewName("/admin/login");
			}
			
		}
		
		return mav;
	}
	
	@RequestMapping(value="/HealthTrack/admin/hospital/insert", method = RequestMethod.POST)
	public ModelAndView insertHospital(ModelMap model, ModelAndView mav , HttpSession session, HttpServletRequest request) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
			String username = (String)session.getAttribute("username");
			if(username != null) {
				if(Validation.checkIfTheUserIsAdmin(username)) {
					
					String name	 		= request.getParameter("name");
					String intro 		= request.getParameter("intro");
					String url			= request.getParameter("url");
					String phone		= request.getParameter("phone");
					String website		= request.getParameter("website");
					String address		= request.getParameter("address");
					int admin			= Integer.parseInt(request.getParameter("hospitalAdmin"));
					String[] location 	= new String[2];
					float lat			= 0
						, lang			= 0;
					
					
					model.addAttribute("oldName"	, name);
					model.addAttribute("oldIntro"	, intro);
					model.addAttribute("oldUrl"		, url);
					model.addAttribute("oldPhone"	, phone);
					model.addAttribute("oldWebsite"	, website);
					model.addAttribute("oldAddress"	, address);
					
					boolean errors = false;
					
					if(!Validation.validateName(name)) {
						model.addAttribute("invalidName", "<p class=\"wrong-input \">Invalid Name</p>");
						errors = true;
					}
					if(Validation.checkIfSomethingExists("hospital_name", "hospital", name)) {
						model.addAttribute("nameExist", "<p class=\"wrong-input \">This hospital already exists</p>");
						errors = true;
					}
					if(!Validation.validateText(intro)) {
						model.addAttribute("invalidIntro", "<p class=\"wrong-input \">Invalid characters in the intro</p>");
						errors = true;
					}
					if(!Validation.validateURL(website)) {
						model.addAttribute("invalidWebsite", "<p class=\"wrong-input \">Invalid url</p>");
						errors = true;
					}
					if(!Validation.validatePhone(phone)) {
						model.addAttribute("invalidPhone", "<p class=\"wrong-input \">Invalid Phone length: must be mobile number 11 characters or landline number 8 characters</p>");
						errors = true;
					}
					
					if(!Validation.validateURL(url)) {
						model.addAttribute("invalidUrl", "<p class=\"wrong-input \">Invalid url</p>");
						errors = true;
					}else {
						location 	= Validation.getLatAndLangFromUrl(url);
						try {
							lat		= Float.valueOf(location[0]);
							lang	= Float.valueOf(location[1]);
						} catch (Exception e) {
							model.addAttribute("invalidUrl", "<p class=\"wrong-input \">Invalid url</p>");
							errors = true;
						}
						
						if(admin == 0) {
							model.addAttribute("invalidAdmin", "<p class=\"wrong-input \">Please Select the admin of the new hospital</p>");
							errors = true;
						}
					}

					if(errors == false) {
						Hospital hospital = new Hospital();
						hospital.setHospitalName(name);
						hospital.setAdminId(admin);
						hospital.setPhone(phone);
						hospital.setWebsite(website);
						hospital.setAddress(address);
						hospital.setIntro(intro);
						hospital.setGoogleMapsUrl(url);
						hospital.setLat(lat);
						hospital.setLang(lang);
						
						HospitalDao.insertHospital(hospital);
						
						mav.setViewName("redirect:/HealthTrack/profile/hospital/"+admin);
					}else {
						mav.setViewName("/admin/addHospital");
					}
				}else {
					mav.setViewName("redirect/:HealthTrack/admin/login");
				}
			}else {
				mav.setViewName("/admin/login");
			}
			mav.addAllObjects(model);
		return mav;
	}
}
