package com.gp.controllers;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.CookieValue;
import org.json.JSONException;
import org.json.simple.parser.ParseException;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.gp.user.BookingDao;
import com.gp.user.Center;
import com.gp.user.CenterDao;
import com.gp.user.Clinic;
import com.gp.user.ClinicDao;
import com.gp.user.Hospital;
import com.gp.user.HospitalDao;
import com.gp.user.Person;
import com.gp.user.PersonDao;
import com.gp.user.Pharmacy;
import com.gp.user.PharmacyDao;
import com.gp.user.Service;
import com.gp.user.ServiceDao;
import com.gp.user.Translator;
import com.gp.user.Translator.language;
import com.gp.user.User;
import com.gp.user.UserDao;
import com.gp.user.Validation;

@RestController
public class DashboardController {
	
	@RequestMapping(value="/HealthTrack/admin/dashboard", method = RequestMethod.GET)
	public ModelAndView dashboard(@CookieValue(value="lang", defaultValue="en") String cookie,Model model, ModelAndView mav, HttpServletRequest request)
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
	
	@RequestMapping(value="/HealthTrack/admin/{adminUsername}/{place}", method = RequestMethod.GET)
	public ModelAndView adminPlaces(@CookieValue(value="lang", defaultValue="en") String cookie,Model model, HttpSession session, ModelAndView mav, @PathVariable("adminUsername") String adminUsername, @PathVariable("place") String place)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
		model.addAttribute("lang", cookie);
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

	@RequestMapping(value="/HealthTrack/admin/{adminUsername}/{place}/add", method = RequestMethod.GET)
	public ModelAndView dashboard(@CookieValue(value="lang", defaultValue="en") String cookie,Model model, ModelAndView mav, @PathVariable("adminUsername") String adminUsername
			, @PathVariable("place") String place
			, HttpSession session) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException, ParseException, JSONException, IOException {
		Translator t =new Translator(cookie);
		model.addAttribute("lang", cookie);
		if(Validation.checkIfTheUserIsAdmin(adminUsername)) {
			String username = (String)session.getAttribute("username");
			
				if(username != null) {
					if(username.equalsIgnoreCase(adminUsername)) {
						
						//t.translate2English("Amiar","amira");
						model.addAttribute("action","add");
						String x=t.write("username");
						System.out.println(x);
						mav.setViewName("/admin/manage"+place);
					}else {
						mav.setViewName("redirect/:HealthTrack/admin/login");
					}
				}
		   	
	   		else {
				mav.setViewName("/admin/login");
			}
			
		}
		
		return mav;
	}
	
	@RequestMapping(value="/HealthTrack/admin/{place}/insert", method = RequestMethod.POST)
	public ModelAndView insertHospital(@CookieValue(value="lang", defaultValue="en") String cookie,ModelMap model, ModelAndView mav , HttpSession session, HttpServletRequest request
			, @PathVariable("place") String place) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException, ParseException, JSONException, IOException {
		   Translator t = new Translator(cookie);
		    model.addAttribute("lang", cookie);
			String username = (String)session.getAttribute("username");
			if(username != null) {
				if(Validation.checkIfTheUserIsAdmin(username)) {
					
					String name	 		= request.getParameter("name");
					String ARname       =request.getParameter("ARname");
					String intro 		= request.getParameter("intro");
					String ARintro 		= request.getParameter("ARintro");
					String url			= request.getParameter("url");
					String phone		= request.getParameter("phone");
					String website		= request.getParameter("website");
					String address		= request.getParameter("address");
					String ARaddress		= request.getParameter("ARaddress");
					int admin			= Integer.parseInt(request.getParameter("Admin"));
					String[] location 	= new String[2];
					float lat			= 0;
					float lang			= 0;
					
				
					model.addAttribute("oldName"	, name);
					model.addAttribute("oldARName"	, ARname);
					model.addAttribute("oldIntro"	, intro);
					model.addAttribute("oldARIntro"	, ARintro);
					model.addAttribute("oldUrl"		, url);
					model.addAttribute("oldPhone"	, phone);
					model.addAttribute("oldWebsite"	, website);
					model.addAttribute("oldAddress"	, address);
					model.addAttribute("oldARaddress"	, ARaddress);
					
					boolean errors = false;
					
					if(!Validation.validateName(name)) {
						model.addAttribute("invalidName", "<p class=\"wrong-input \">"+t.write("Invalid Name")+"</p>");
						errors = true;
					}
					if(name.length() < 4) {
						model.addAttribute("shortName", "<p class=\"wrong-input \">"+t.write("name should be at least 4 characters")+ "</p>");
						errors = true;
					}
					/*
					if(!Validation.validateArStatement(ARname)) {
						model.addAttribute("invalidARName", "<p class=\"wrong-input \">"+t.write("Invalid Arabic Name")+"</p>");
						errors = true;
					}
					
					if(ARname.length() < 4) {
						model.addAttribute("shortARName", "<p class=\"wrong-input \">"+t.write("name should be at least 4 characters")+ "</p>");
						errors = true;
					}
					*/
					if(Validation.checkIfSomethingExists(place+"_name", place, name)) {
					model.addAttribute("nameExist", "<p class=\"wrong-input \">"+t.write("This place already exists")+"</p>");
					errors = true;
						
					}
					if(!Validation.validateText(intro)) {
						model.addAttribute("invalidIntro", "<p class=\"wrong-input \">"+t.write("Invalid characters in the intro")+"</p>");
						errors = true;
					}
					if(intro.length() < 25) {
						model.addAttribute("shortIntro", "<p class=\"wrong-input \">"+t.write("tha name should be at least 25 characters")+"</p>");
						errors = true;
					}
					/*
					if(!Validation.validateArStatement(ARintro)) {
						model.addAttribute("invalidARIntro", "<p class=\"wrong-input \">"+t.write("Invalid characters in the arabic intro")+"</p>");
						errors = true;
					}
					
					if(ARintro.length() < 25) {
						model.addAttribute("shortARIntro", "<p class=\"wrong-input \">"+t.write("tha name should be at least 25 characters")+"</p>");
						errors = true;
					}
					*/
					if(!Validation.validateURL(website)) {
						model.addAttribute("invalidWebsite", "<p class=\"wrong-input \">"+t.write("Invalid url")+"</p>");
						errors = true;
					}
					if(!Validation.validatePhone(phone)) {
						model.addAttribute("invalidPhone", "<p class=\"wrong-input \">"+t.write("Invalid Phone length: must be mobile number 11 characters or landline number 8 characters")+"</p>");
						errors = true;
					}
					if(!Validation.validateText(address)) {
						model.addAttribute("invalidaddress", "<p class=\"wrong-input \">"+t.write("Invalid Address")+"</p>");
						errors = true;
					}
					/*
					if(!Validation.validateArStatement(ARaddress)) {
						model.addAttribute("invalidARaddress", "<p class=\"wrong-input \">"+t.write("Invalid Arabic Address")+"</p>");
						errors = true;
					}
					*/
					
					if(!Validation.validateURL(url)) {
						model.addAttribute("invalidUrl", "<p class=\"wrong-input \">"+t.write("Invalid url")+"</p>");
						errors = true;
					}else {
						location 	= Validation.getLatAndLangFromUrl(url);
						try {
							lat		= Float.valueOf(location[0]);
							lang	= Float.valueOf(location[1]);
						} catch (Exception e) {
							model.addAttribute("invalidUrl", "<p class=\"wrong-input \">"+t.write("Invalid url")+"</p>");
							errors = true;
						}
						
						if(admin == 0) {
							model.addAttribute("invalidAdmin", "<p class=\"wrong-input \">"+t.write("Please Select the admin of the new hospital")+"</p>");
							errors = true;
						}
					}
					if(place.equalsIgnoreCase("clinic")) {
						String fees             =request.getParameter("fees");
						String doctorName		= request.getParameter("doctorName");
						String specialty		= request.getParameter("specialty");
						String ARdoctorName		= request.getParameter("ARdoctorName");
						String ARspecialty		= request.getParameter("ARspecialty");
						model.addAttribute("oldFees",fees);
						model.addAttribute("oldDoctorName"	, doctorName);
						model.addAttribute("oldSpecialty"	, specialty);
						model.addAttribute("oldARDoctorName"	, ARdoctorName);
						model.addAttribute("oldARSpecialty"	, ARspecialty);
						
						if(!Validation.validateFees(fees)) {
							model.addAttribute("invalidFees", "<p class=\"wrong-input \">"+t.write("Invalid Fees")+" </p>");
							errors = true;
						}
						
						if(!Validation.validateName(doctorName)) {
							model.addAttribute("invalidDoctorName", "<p class=\"wrong-input \">"+t.write("Invalid doctor Name")+"</p>");
							errors = true;
						}
						/*
						if(!Validation.validateArStatement(ARdoctorName)) {
							model.addAttribute("invalidARDoctorName", "<p class=\"wrong-input \">"+t.write("Invalid doctor Name in Arabic")+"</p>");
							errors = true;
						}
						*/
						if(doctorName.length() < 4) {
							model.addAttribute("shortDoctorName", "<p class=\"wrong-input \">"+t.write("tha name should be at least 4 characters")+"</p>");
							errors = true;
						}
						/*
						if(ARdoctorName.length() < 4) {
							model.addAttribute("shortARDoctorName", "<p class=\"wrong-input \">"+t.write("tha name should be at least 4 characters")+"</p>");
							errors = true;
						}
						*/
						if(!Validation.validateName(specialty)) {
							model.addAttribute("invalidSpeciality", "<p class=\"wrong-input \">"+t.write("Invalid Specialty")+"</p>");
							errors = true;
						}
						/*
						if(!Validation.validateName(ARspecialty)) {
							model.addAttribute("invalidARSpeciality", "<p class=\"wrong-input \">"+t.write("Invalid Specialty in Arabic")+"</p>");
							errors = true;
						}
						
						if(ARspecialty.length() < 4) {
							model.addAttribute("shortARSpecialityName", "<p class=\"wrong-input \">"+t.write("tha Specialty should be at least 4 characters")+"</p>");
							errors = true;
						}
						
						*/
						if(specialty.length() < 4) {
							model.addAttribute("shortSpecialityName", "<p class=\"wrong-input \">"+t.write("tha Specialty should be at least 4 characters")+"</p>");
							errors = true;
						}
						
							if(errors == false) {
								Clinic clinic =new Clinic();
								clinic.setClinicName(name);
								clinic.setAdminId(admin);
								clinic.setPhone(phone);
								clinic.setWebsite(website);
								clinic.setAddress(address);
								clinic.setFees(fees);
								clinic.setIntro(intro);
								clinic.setGoogle_maps_url(url);
								clinic.setLat(lat);
								clinic.setLang(lang);
								clinic.setDoctorName(doctorName);
								clinic.setSpecialty(specialty);
								ClinicDao.insertClinic(clinic);
								t.fileWeiter(doctorName, ARdoctorName,language.ar);
								t.fileWeiter(specialty, ARspecialty,language.ar);
								t.fileWeiter(name,ARname,language.ar);
								t.fileWeiter(intro,ARintro,language.ar);
								t.fileWeiter(address,ARaddress,language.ar);
								
								mav.setViewName("redirect:/HealthTrack/admin/"+username+"/clinics");
							}else {
								mav.setViewName("redirect/:HealthTrack/admin/login");
							}
						
					}
					
					if(errors == false) {
					
					 if(place.equalsIgnoreCase("hospital")){
						 
					String[] depts 		= request.getParameterValues("depts");
					
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
						t.fileWeiter(name,ARname,language.ar);
						t.fileWeiter(intro,ARintro,language.ar);
						t.fileWeiter(address,ARaddress,language.ar);
						
						Hospital H = HospitalDao.getHospitalById(admin);
						
						for(String dept: depts) {
								HospitalDao.insertDepartment(dept, H.getHospitalId());
						}
						mav.setViewName("redirect:/HealthTrack/profile/hospital/"+admin);
						
					}
					else if(place.equalsIgnoreCase("center")) {
						//String[] services 		= request.getParameterValues("services");
						Center center = new Center();
						center.setCenterName(name);
						center.setAdminId(admin);
						center.setPhone(phone);
						center.setWebsite(website);
						center.setAddress(address);
						center.setIntro(intro);
						center.setGoogleMapsUrl(url);
						center.setLat(lat);
						center.setLang(lang);
						CenterDao.insertCenter(center);
						t.fileWeiter(name,ARname,language.ar);
						t.fileWeiter(intro,ARintro,language.ar);
						t.fileWeiter(address,ARaddress,language.ar);
						mav.setViewName("redirect:/HealthTrack/admin/"+username+"/centers");
                       
						
					}
					
					else if(place.equalsIgnoreCase("Pharmacy")) {
						
						Pharmacy pharmacy = new Pharmacy();
						pharmacy.setPharmacyName(name);
						pharmacy.setAdminId(admin);
						pharmacy.setPhone(phone);
						pharmacy.setWebsite(website);
						pharmacy.setAddress(address);
						pharmacy.setIntro(intro);
						pharmacy.setGoogle_maps_url(url);
						pharmacy.setLat(lat);
						pharmacy.setLang(lang);
						PharmacyDao.insertPharmacy(pharmacy);
						t.fileWeiter(name,ARname,language.ar);
						t.fileWeiter(intro,ARintro,language.ar);
						t.fileWeiter(address,ARaddress,language.ar);
						mav.setViewName("redirect:/HealthTrack/admin/"+username+"/pharmacies");
					}
					
					
					}
					else {
						model.addAttribute("action","add");
						mav.addAllObjects(model);
						mav.setViewName("/admin/manage"+place);
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
	@RequestMapping(value="/HealthTrack/admin/{username}/hospital/addNewDepartment", method = RequestMethod.POST)
	public ModelAndView submitDept(@CookieValue(value="lang", defaultValue="en") String cookie,ModelMap model, ModelAndView mav, HttpServletRequest request)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException, ParseException, JSONException, IOException{
		Translator t = new Translator(cookie);
		model.addAttribute("lang", cookie);
		HttpSession session = request.getSession();
		boolean error =false;
		String username = (String) session.getAttribute("username");
		if(username == null) {
			mav.setViewName("/admin/login");
		}else {
			if(Validation.checkIfTheUserIsAdmin(username)) {
				
				int hospitalId 	= Integer.parseInt(request.getParameter("hospitalId"));
				String deptName = request.getParameter("dept");
				String ARdeptName = request.getParameter("ARdept");
				if(!Validation.validateName(ARdeptName)) {
					model.addAttribute("invalidARdeptName", "<p class=\"wrong-input \">"+t.write("Invalid department name in Arabic")+"</p>");
					error=true; //there is some action should done later
				}
				
				if((!deptName.equals("0")) & (error==false)) {
					HospitalDao.insertDepartment(deptName, hospitalId);
					t.translate2Arabic(deptName, ARdeptName);
			}
			mav.setViewName("redirect:/HealthTrack/admin/" + username + "/hospitals");
		}
		}
		return mav;
	}
	
	@RequestMapping(value="/HealthTrack/admin/{username}/hospital/deleteDepartment/{deptId}", method = RequestMethod.GET)
	public ModelAndView deleteDept(@CookieValue(value="lang", defaultValue="en") String cookie,Model model, ModelAndView mav, HttpServletRequest request, @PathVariable("deptId") int deptId )
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
		model.addAttribute("lang", cookie);
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
		if(username == null) {
			mav.setViewName("/admin/login");
		}else {
			if(Validation.checkIfTheUserIsAdmin(username)) {			
				HospitalDao.deleteSomthing("department" , "department_id" , deptId);
				mav.setViewName("redirect:/HealthTrack/admin/" + username + "/hospitals");
			}else {
				mav.setViewName("/user/login");
			}
			
		}

		return mav;
	}
	
	@RequestMapping(value="/HealthTrack/admin/{adminUsername}/{place}/{AdminId}/edit", method = RequestMethod.GET)
	public ModelAndView editPlace(@CookieValue(value="lang", defaultValue="en") String cookie,ModelMap model, ModelAndView mav, @PathVariable("adminUsername") String adminUsername
			, @PathVariable("place") String place
			, HttpSession session, @PathVariable("AdminId") int AdminId)
					throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		model.addAttribute("lang", cookie);	
		if(Validation.checkIfTheUserIsAdmin(adminUsername)) {
			String username = (String)session.getAttribute("username");
				if(username != null) {
					if(username.equalsIgnoreCase(adminUsername)) {
						model.addAttribute("action", "edit");
						model.addAttribute("AdminId", AdminId);
						mav.addAllObjects(model);
						mav.setViewName("/admin/manage" + place );
						
					}else {
						mav.setViewName("redirect/:HealthTrack/admin/login");
					}
			
	   		}else {
					mav.setViewName("/admin/login");
				}
	   		
		}
		
		return mav;
	}
	
	@RequestMapping(value="/HealthTrack/admin/hospital/{AdminId}/update", method = RequestMethod.POST)
	public ModelAndView updateHospital(@CookieValue(value="lang", defaultValue="en") String cookie,ModelMap model, ModelAndView mav , HttpSession session, HttpServletRequest request, @PathVariable("AdminId") int AdminId) 
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException, ParseException, JSONException, IOException {
		    model.addAttribute("lang", cookie);
		    Translator t = new Translator(cookie);
			String username = (String)session.getAttribute("username");
			if(username != null) {
				if(Validation.checkIfTheUserIsAdmin(username)) {
					
					int hospitalId		= Integer.parseInt((String)request.getParameter("hospitalId"));
					String name	 		= request.getParameter("name");
					String intro 		= request.getParameter("intro");
					String url			= request.getParameter("url");
					String phone		= request.getParameter("phone");
					String website		= request.getParameter("website");
					String address		= request.getParameter("address");
					int admin			= Integer.parseInt(request.getParameter("Admin"));
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
						model.addAttribute("invalidName", "<p class=\"wrong-input \">"+t.write("Invalid Name")+"</p>");
						errors = true;
					}
					if(name.length() < 4) {
						model.addAttribute("shortName", "<p class=\"wrong-input \">"+t.write("name should be at least 4 characters")+ "</p>");
						errors = true;
					}

					if(!Validation.validateText(intro)) {
						model.addAttribute("invalidIntro", "<p class=\"wrong-input \">"+t.write("Invalid characters in the intro")+"</p>");
						errors = true;
					}
					if(intro.length() < 25) {
						model.addAttribute("shortIntro", "<p class=\"wrong-input \">"+t.write("tha name should be at least 25 characters")+"</p>");
						errors = true;
					}
					if(!Validation.validateURL(website)) {
						model.addAttribute("invalidWebsite", "<p class=\"wrong-input \">"+t.write("Invalid url")+"</p>");
						errors = true;
					}
					if(!Validation.validatePhone(phone)) {
						model.addAttribute("invalidPhone", "<p class=\"wrong-input \">"+t.write("Invalid Phone length: must be mobile number 11 characters or landline number 8 characters")+"</p>");
						errors = true;
					}
					
					
					if(admin == 0) {
						model.addAttribute("invalidAdmin", "<p class=\"wrong-input \">"+t.write("Please Select the admin of the hospital")+"</p>");
						errors = true;
					}
					if(!Validation.validateURL(url)) {
						model.addAttribute("invalidUrl", "<p class=\"wrong-input \">"+t.write("Invalid url")+"</p>");
						errors = true;
					}else {
						location 	= Validation.getLatAndLangFromUrl(url);
						try {
							lat		= Float.valueOf(location[0]);
							lang	= Float.valueOf(location[1]);
						} catch (Exception e) {
							model.addAttribute("invalidUrl", "<p class=\"wrong-input \">"+t.write("Invalid url")+"</p>");
							errors = true;
						}
					}

					if(errors == false) {
						Hospital hospital = new Hospital();
						hospital.setHospitalId(hospitalId);
						hospital.setHospitalName(name);
						hospital.setAdminId(admin);
						hospital.setPhone(phone);
						hospital.setWebsite(website);
						hospital.setAddress(address);
						hospital.setIntro(intro);
						hospital.setGoogleMapsUrl(url);
						hospital.setLat(lat);
						hospital.setLang(lang);
						HospitalDao.updateHospital(hospital);
						mav.setViewName("redirect:/HealthTrack/admin/" + username + "/hospitals");
					}else {
						System.out.println("true");
						model.addAttribute("action","edit");
						model.addAttribute("AdminId", AdminId);
						mav.addAllObjects(model);
						mav.setViewName("/admin/managehospital");
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
	
	@RequestMapping(value="/HealthTrack/admin/{username}/{place}/delete/{placeId}", method = RequestMethod.GET)
	public ModelAndView deleteHospital(@CookieValue(value="lang", defaultValue="en") String cookie,Model model, ModelAndView mav, HttpServletRequest request, @PathVariable("placeId") String placeId
			, @PathVariable("place") String place)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
		model.addAttribute("lang", cookie);
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
		if(username == null) {
			mav.setViewName("/admin/login");
		}else {
			if(Validation.checkIfTheUserIsAdmin(username) && Validation.checkIfSomethingExists(place+"_id", place, placeId)) {			
				HospitalDao.deleteSomthing(place , place+"_id" , Integer.parseInt(placeId));
				mav.setViewName("redirect:/HealthTrack/admin/" + username + "/"+place+"s");
			}else {
				mav.setViewName("/user/login");
			}
			
		}

		return mav;
	}
	
	//******************************************************Centers*******************************************//
	
	@RequestMapping(value="/HealthTrack/admin/center/{AdminId}/update", method = RequestMethod.POST)
	public ModelAndView updateCenter(@CookieValue(value="lang", defaultValue="en") String cookie,ModelMap model, ModelAndView mav , HttpSession session, HttpServletRequest request, @PathVariable("AdminId") int AdminId) 
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException, ParseException, JSONException, IOException {
		    Translator t = new Translator(cookie);
		    model.addAttribute("lang", cookie);
			String username = (String)session.getAttribute("username");
			if(username != null) {
				if(Validation.checkIfTheUserIsAdmin(username)) {
					
					int centerId		= Integer.parseInt((String)request.getParameter("centerId"));
					String name	 		= request.getParameter("name");
					String intro 		= request.getParameter("intro");
					String url			= request.getParameter("url");
					String phone		= request.getParameter("phone");
					String website		= request.getParameter("website");
					String address		= request.getParameter("address");
					int admin			= Integer.parseInt(request.getParameter("AdminId"));
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
						model.addAttribute("invalidName", "<p class=\"wrong-input \">"+t.write("Invalid Name")+"</p>");
						errors = true;
					}
					if(name.length() < 4) {
						model.addAttribute("shortName", "<p class=\"wrong-input \">"+t.write("name should be at least 4 characters")+ "</p>");
						errors = true;
					}

					if(!Validation.validateText(intro)) {
						model.addAttribute("invalidIntro", "<p class=\"wrong-input \">"+t.write("Invalid characters in the intro")+"</p>");
						errors = true;
					}
					if(intro.length() < 25) {
						model.addAttribute("shortIntro", "<p class=\"wrong-input \">"+t.write("tha name should be at least 25 characters")+"</p>");
						errors = true;
					}
					if(!Validation.validateURL(website)) {
						model.addAttribute("invalidWebsite", "<p class=\"wrong-input \">"+t.write("Invalid url")+"</p>");
						errors = true;
					}
					if(!Validation.validatePhone(phone)) {
						model.addAttribute("invalidPhone", "<p class=\"wrong-input \">"+t.write("Invalid Phone length: must be mobile number 11 characters or landline number 8 characters")+"</p>");
						errors = true;
					}
					
					
					if(admin == 0) {
						model.addAttribute("invalidAdmin", "<p class=\"wrong-input \">"+t.write("Please Select the admin of the hospital")+"</p>");
						errors = true;
					}
					if(!Validation.validateURL(url)) {
						model.addAttribute("invalidUrl", "<p class=\"wrong-input \">"+t.write("Invalid url")+"</p>");
						errors = true;
					}else {
						location 	= Validation.getLatAndLangFromUrl(url);
						try {
							lat		= Float.valueOf(location[0]);
							lang	= Float.valueOf(location[1]);
						} catch (Exception e) {
							model.addAttribute("invalidUrl", "<p class=\"wrong-input \">"+t.write("Invalid url")+"</p>");
							errors = true;
						}
					
					}
					if(Validation.checkIfSomethingExists("center_name", "center", name)) {
						model.addAttribute("nameExist", "<p class=\"wrong-input \">"+t.write("This hospital already exists")+"</p>");
						errors = true;
					}
					

					if(errors == false) {
						Center center = new Center();
						center.setCenterId(centerId);
						center.setCenterName(name);
						center.setAdminId(admin);
						center.setPhone(phone);
						center.setWebsite(website);
						center.setAddress(address);
						center.setIntro(intro);
						center.setGoogleMapsUrl(url);
						center.setLat(lat);
						center.setLang(lang);
						CenterDao.updateCenter(center);
						
						mav.setViewName("redirect:/HealthTrack/admin/" + username + "/centers");
					}else {
						System.out.println("true");
						model.addAttribute("action","edit");
						model.addAttribute("AdminId",AdminId);
						mav.addAllObjects(model);
						mav.setViewName("/admin/center");
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
	
	
	@RequestMapping(value="/HealthTrack/admin/clinic/{AdminId}/update", method = RequestMethod.POST)
	public ModelAndView updateClinic(@CookieValue(value="lang", defaultValue="en") String cookie,ModelMap model, ModelAndView mav , HttpSession session, HttpServletRequest request, @PathVariable("AdminId") int AdminId) 
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException, ParseException, JSONException, IOException {
		    Translator t = new Translator(cookie);
		    model.addAttribute("lang", cookie);
			String username = (String)session.getAttribute("username");
			if(username != null) {
				if(Validation.checkIfTheUserIsAdmin(username)) {
					
					int clinicId		= Integer.parseInt((String)request.getParameter("clinicId"));
					String name	 		= request.getParameter("name");
					String intro 		= request.getParameter("intro");
					String url			= request.getParameter("url");
					String phone		= request.getParameter("phone");
					String website		= request.getParameter("website");
					String address		= request.getParameter("address");
					int admin			= Integer.parseInt(request.getParameter("Admin"));
					String[] location 	= new String[2];
					float lat			= 0
						, lang			= 0;
					String doctorName		= request.getParameter("doctorName");
					String specialty		= request.getParameter("specialty");
					model.addAttribute("oldDoctorName"	, doctorName);
					model.addAttribute("oldSpecialty"	, specialty);
				
					model.addAttribute("oldName"	, name);
					model.addAttribute("oldIntro"	, intro);
					model.addAttribute("oldUrl"		, url);
					model.addAttribute("oldPhone"	, phone);
					model.addAttribute("oldWebsite"	, website);
					model.addAttribute("oldAddress"	, address);
					
					boolean errors = false;
					
					if(!Validation.validateName(name)) {
						model.addAttribute("invalidName", "<p class=\"wrong-input \">"+t.write("Invalid Name")+"</p>");
						errors = true;
					}
					if(name.length() < 4) {
						model.addAttribute("shortName", "<p class=\"wrong-input \">"+t.write("the name should be at least 4 characters")+"</p>");
						errors = true;
					}
					if(!Validation.validateName(doctorName)) {
						model.addAttribute("invalidName", "<p class=\"wrong-input \">"+t.write("Invalid Name")+"</p>");
						errors = true;
					}
					
					if(doctorName.length() < 4) {
						model.addAttribute("shortName", "<p class=\"wrong-input \">"+t.write("the name should be at least 4 characters")+"</p>");
						errors = true;
					}
					if(!Validation.validateName(specialty)) {
						model.addAttribute("invalidName", "<p class=\"wrong-input \">"+t.write("Invalid Name")+"</p>");
						errors = true;
					}
					if(specialty.length() < 4) {
						model.addAttribute("shortName", "<p class=\"wrong-input \">"+t.write("the name should be at least 4 characters")+"</p>");
						
						errors = true;
					}
					if(Validation.checkIfSomethingExists("clinic_name", "clinic", name)) {
						model.addAttribute("nameExist", "<p class=\"wrong-input \">"+t.write("This hospital already exists")+"</p>");
						errors = true;
					}

					if(!Validation.validateText(intro)) {
						model.addAttribute("invalidIntro", "<p class=\"wrong-input \">"+t.write("Invalid characters in the intro")+"</p>");
						errors = true;
					}
					if(intro.length() < 25) {
						model.addAttribute("shortIntro", "<p class=\"wrong-input \">"+t.write("tha name should be at least 25 characters")+"</p>");
						errors = true;
					}
					if(!Validation.validateURL(website)) {
						model.addAttribute("invalidWebsite", "<p class=\"wrong-input \">"+t.write("Invalid url")+"</p>");
						errors = true;
					}
					if(!Validation.validatePhone(phone)) {
						model.addAttribute("invalidPhone", "<p class=\"wrong-input \">"+t.write("Invalid Phone length: must be mobile number 11 characters or landline number 8 characters")+"</p>");
						errors = true;
					}
					if(admin == 0) {
						model.addAttribute("invalidAdmin", "<p class=\"wrong-input \">"+t.write("Please Select the admin of the hospital")+"</p>");
						errors = true;
					}
					if(!Validation.validateURL(url)) {
						model.addAttribute("invalidUrl", "<p class=\"wrong-input \">"+t.write("Invalid url")+"</p>");
						errors = true;
					}else {
						location 	= Validation.getLatAndLangFromUrl(url);
						try {
							lat		= Float.valueOf(location[0]);
							lang	= Float.valueOf(location[1]);
						} catch (Exception e) {
							model.addAttribute("invalidUrl", "<p class=\"wrong-input \">"+t.write("Invalid url")+"</p>");
							errors = true;
						}
					}

					if(errors == false) {
						Clinic clinic = new Clinic();
						clinic.setClinicId(clinicId);
						clinic.setClinicName(name);
						clinic.setAdminId(admin);
						clinic.setPhone(phone);
						clinic.setWebsite(website);
						clinic.setAddress(address);
						clinic.setIntro(intro);
						clinic.setGoogle_maps_url(url);
						clinic.setLat(lat);
						clinic.setLang(lang);
						clinic.setDoctorName(doctorName);
						clinic.setSpecialty(specialty);
						ClinicDao.updateClinic(clinic);
						mav.setViewName("redirect:/HealthTrack/admin/" + username + "/clinics");
					}else {
						model.addAttribute("action","edit");
						model.addAttribute("AdminId", AdminId);
						mav.addAllObjects(model);
						mav.setViewName("/admin/manageclinic");
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
	@RequestMapping(value="/HealthTrack/admin/pharmacy/{AdminId}/update", method = RequestMethod.POST)
	public ModelAndView updatePharmacy(@CookieValue(value="lang", defaultValue="en") String cookie,ModelMap model, ModelAndView mav , HttpSession session, HttpServletRequest request, @PathVariable("AdminId") int AdminId) 
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException, ParseException, JSONException, IOException {
			Translator t = new Translator(cookie);
		    model.addAttribute("lang", cookie);
			String username = (String)session.getAttribute("username");
			if(username != null) {
				if(Validation.checkIfTheUserIsAdmin(username)) {
					
					int pharmacyId		= Integer.parseInt((String)request.getParameter("pharmacyId"));
					String name	 		= request.getParameter("name");
					String intro 		= request.getParameter("intro");
					String url			= request.getParameter("url");
					String phone		= request.getParameter("phone");
					String website		= request.getParameter("website");
					String address		= request.getParameter("address");
					int admin			= Integer.parseInt(request.getParameter("Admin"));
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
						model.addAttribute("invalidName", "<p class=\"wrong-input \">"+t.write("Invalid Name")+"</p>");
						errors = true;
					}
					if(name.length() < 4) {
						model.addAttribute("shortName", "<p class=\"wrong-input \">"+t.write("the name should be at least 4 characters")+"</p>");
						errors = true;
					}
					if(Validation.checkIfSomethingExists("pharmacy_name", "pharmacy", name)) {
						model.addAttribute("nameExist", "<p class=\"wrong-input \">"+t.write("This hospital already exists")+"</p>");
						errors = true;
					}
					if(!Validation.validateText(intro)) {
						model.addAttribute("invalidIntro", "<p class=\"wrong-input \">"+t.write("Invalid characters in the intro")+"</p>");
						errors = true;
					}
					if(intro.length() < 25) {
						model.addAttribute("shortIntro", "<p class=\"wrong-input \">"+t.write("tha name should be at least 25 characters")+"</p>");
						errors = true;
					}
					if(!Validation.validateURL(website)) {
						model.addAttribute("invalidWebsite", "<p class=\"wrong-input \">"+t.write("Invalid url")+"</p>");
						errors = true;
					}
					if(!Validation.validatePhone(phone)) {
						model.addAttribute("invalidPhone", "<p class=\"wrong-input \">"+t.write("Invalid Phone length: must be mobile number 11 characters or landline number 8 characters")+"</p>");
						errors = true;
					}
					if(admin == 0) {
						model.addAttribute("invalidAdmin", "<p class=\"wrong-input \">"+t.write("Please Select the admin of the hospital")+"</p>");
						errors = true;
					}
					if(!Validation.validateURL(url)) {
						model.addAttribute("invalidUrl", "<p class=\"wrong-input \">"+t.write("Invalid url")+"</p>");
						errors = true;
					}else {
						location 	= Validation.getLatAndLangFromUrl(url);
						try {
							lat		= Float.valueOf(location[0]);
							lang	= Float.valueOf(location[1]);
						} catch (Exception e) {
							model.addAttribute("invalidUrl", "<p class=\"wrong-input \">"+t.write("Invalid url")+"</p>");
							errors = true;
						}
					}

					if(errors == false) {
						Pharmacy pharmacy = new Pharmacy();
						pharmacy.setPharmacyId(pharmacyId);
						pharmacy.setPharmacyName(name);
						pharmacy.setAdminId(admin);
						pharmacy.setPhone(phone);
						pharmacy.setWebsite(website);
						pharmacy.setAddress(address);
						pharmacy.setIntro(intro);
						pharmacy.setGoogle_maps_url(url);
						pharmacy.setLat(lat);
						pharmacy.setLang(lang);
						PharmacyDao.updatePharmacy(pharmacy);
						mav.setViewName("redirect:/HealthTrack/admin/" + username + "/pharmacies");
					}else {
						System.out.println("true");
						model.addAttribute("action","edit");
						model.addAttribute("AdminId", AdminId);
						mav.addAllObjects(model);
						mav.setViewName("/admin/managepharmacy");
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
//**************************Services*******************************************
	@RequestMapping(value="/HealthTrack/admin/{adminUsername}/service/{serviceId}/edit", method = RequestMethod.GET)
	public ModelAndView editService(@CookieValue(value="lang", defaultValue="en") String cookie,ModelMap model, ModelAndView mav, @PathVariable("adminUsername") String adminUsername			
			, HttpSession session, @PathVariable("serviceId") int serviceId)
					throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		model.addAttribute("lang", cookie);
		if(Validation.checkIfTheUserIsAdmin(adminUsername)) {
			String username = (String)session.getAttribute("username");
				if(username != null) {
					if(username.equalsIgnoreCase(adminUsername)) {
						model.addAttribute("action", "edit");
						model.addAttribute("serviceId", serviceId);
						mav.addAllObjects(model);
						mav.setViewName("/admin/manageServices"  );
						
					}else {
						mav.setViewName("redirect/:HealthTrack/admin/login");
					}
			
	   		}else {
					mav.setViewName("/admin/login");
				}
	   		
		}
		
		return mav;
	}
	
	@RequestMapping(value="/HealthTrack/admin/service/{AdminId}/update", method = RequestMethod.POST)
	public ModelAndView updateService(@CookieValue(value="lang", defaultValue="en") String cookie,ModelMap model, ModelAndView mav , HttpSession session, HttpServletRequest request, @PathVariable("AdminId") int AdminId) 
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException, ParseException, JSONException, IOException {
		    Translator t=new Translator(cookie);
		    model.addAttribute("lang", cookie);
			String username = (String)session.getAttribute("username");
			if(username != null) {
				if(Validation.checkIfTheUserIsAdmin(username)) {
					
					int pharmacyId		= Integer.parseInt((String)request.getParameter("pharmacyId"));
					String name	 		= request.getParameter("name");
					String intro 		= request.getParameter("intro");
					String url			= request.getParameter("url");
					String phone		= request.getParameter("phone");
					String website		= request.getParameter("website");
					String address		= request.getParameter("address");
					int admin			= Integer.parseInt(request.getParameter("Admin"));
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
						model.addAttribute("invalidName", "<p class=\"wrong-input \">"+t.write("Invalid Name")+"</p>");
						errors = true;
					}
					if(name.length() < 4) {
						model.addAttribute("shortName", "<p class=\"wrong-input \">"+t.write("the name should be at least 4 characters")+"</p>");
						errors = true;
					}
					if(Validation.checkIfSomethingExists("pharmacy_name", "pharmacy", name)) {
						model.addAttribute("nameExist", "<p class=\"wrong-input \">"+t.write("This hospital already exists")+"</p>");
						errors = true;
					}
					if(!Validation.validateText(intro)) {
						model.addAttribute("invalidIntro", "<p class=\"wrong-input \">"+t.write("Invalid characters in the intr")+"o</p>");
						errors = true;
					}
					if(intro.length() < 25) {
						model.addAttribute("shortIntro", "<p class=\"wrong-input \">"+t.write("tha name should be at least 25 characters")+"</p>");
						errors = true;
					}
					if(!Validation.validateURL(website)) {
						model.addAttribute("invalidWebsite", "<p class=\"wrong-input \">"+t.write("Invalid url")+"</p>");
						errors = true;
					}
					if(!Validation.validatePhone(phone)) {
						model.addAttribute("invalidPhone", "<p class=\"wrong-input \">"+t.write("Invalid Phone length: must be mobile number 11 characters or landline number 8 characters")+"</p>");
						errors = true;
					}
					if(admin == 0) {
						model.addAttribute("invalidAdmin", "<p class=\"wrong-input \">"+t.write("Please Select the admin of the hospital")+"</p>");
						errors = true;
					}
					if(!Validation.validateURL(url)) {
						model.addAttribute("invalidUrl", "<p class=\"wrong-input \">"+t.write("Invalid url")+"</p>");
						errors = true;
					}else {
						location 	= Validation.getLatAndLangFromUrl(url);
						try {
							lat		= Float.valueOf(location[0]);
							lang	= Float.valueOf(location[1]);
						} catch (Exception e) {
							model.addAttribute("invalidUrl", "<p class=\"wrong-input \">"+t.write("Invalid url")+"</p>");
							errors = true;
						}
					}

					if(errors == false) {
						Pharmacy pharmacy = new Pharmacy();
						pharmacy.setPharmacyId(pharmacyId);
						pharmacy.setPharmacyName(name);
						pharmacy.setAdminId(admin);
						pharmacy.setPhone(phone);
						pharmacy.setWebsite(website);
						pharmacy.setAddress(address);
						pharmacy.setIntro(intro);
						pharmacy.setGoogle_maps_url(url);
						pharmacy.setLat(lat);
						pharmacy.setLang(lang);
						PharmacyDao.updatePharmacy(pharmacy);
						mav.setViewName("redirect:/HealthTrack/admin/" + username + "/pharmacies");
					}else {
						System.out.println("true");
						model.addAttribute("action","edit");
						model.addAttribute("AdminId", AdminId);
						mav.addAllObjects(model);
						mav.setViewName("/admin/managepharmacy");
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

//**********************************Booking ***********************************
	///HealthTrack/profile/booking/delete/{userId}/{bookingId}
	@RequestMapping(value="/HealthTrack/admin/{username}/booking/delete/{bookingId}", method = RequestMethod.GET)
	public ModelAndView deleteBooking(@CookieValue(value="lang", defaultValue="en") String cookie,Model model, ModelAndView mav, HttpServletRequest request
			, @PathVariable("bookingId") String bookingId)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
		model.addAttribute("lang", cookie);
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
		if(username == null) {
			mav.setViewName("/admin/login");
		}else {
			if(Validation.checkIfTheUserIsAdmin(username) && Validation.checkIfSomethingExists("booking_id", "booking" , bookingId)) {	
				//BookingDao.deleteBooking(bookingId);
				HospitalDao.deleteSomthing("booking" , "booking_id" , Integer.parseInt(bookingId));
				mav.setViewName("redirect:/HealthTrack/admin/" + username + "/daySlotBooking");
			}else {
				mav.setViewName("/user/login");
			}
			
		}

		return mav;
	}
	@RequestMapping(value="/HealthTrack/admin/{username}/user/delete/{userId}", method = RequestMethod.GET)
	public ModelAndView deleteUser(@CookieValue(value="lang", defaultValue="en") String cookie,Model model, ModelAndView mav, HttpServletRequest request
			, @PathVariable("userId") String userId)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
		model.addAttribute("lang", cookie);
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
		if(username == null) {
			mav.setViewName("/admin/login");
		}else {
			if(Validation.checkIfTheUserIsAdmin(username) && Validation.checkIfSomethingExists("user_id", "user" , userId)) {	
				HospitalDao.deleteSomthing("user" , "user_id" , Integer.parseInt(userId));
				mav.setViewName("redirect:/HealthTrack/admin/" + username + "/users");
			}else {
				mav.setViewName("/user/login");
			}
			
		}

		return mav;
	}
	@RequestMapping(value="/HealthTrack/admin/{username}/bannedUser/delete/{userId}", method = RequestMethod.GET)
	public ModelAndView deleteBannedUser(@CookieValue(value="lang", defaultValue="en") String cookie,Model model, ModelAndView mav, HttpServletRequest request
			, @PathVariable("userId") String userId)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
		model.addAttribute("lang", cookie);
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
		if(username == null) {
			mav.setViewName("/admin/login");
		}else {
			if(Validation.checkIfTheUserIsAdmin(username) && Validation.checkIfSomethingExists("user_id", "user" , userId)) {	
				HospitalDao.deleteSomthing("user" , "user_id" , Integer.parseInt(userId));
				mav.setViewName("redirect:/HealthTrack/admin/" + username + "/bannedUsers");
			}else {
				mav.setViewName("/user/login");
			}
			
		}

		return mav;
	}
	@RequestMapping(value="/HealthTrack/admin/{adminUsername}/user/{userId}/edit", method = RequestMethod.GET)
	public ModelAndView editUser(@CookieValue(value="lang", defaultValue="en") String cookie,ModelMap model, ModelAndView mav, @PathVariable("adminUsername") String adminUsername
			
			, HttpSession session, @PathVariable("userId") int userId)
					throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		model.addAttribute("lang", cookie);
			
		if(Validation.checkIfTheUserIsAdmin(adminUsername)) {
			String username = (String)session.getAttribute("username");
				if(username != null) {
					if(username.equalsIgnoreCase(adminUsername)) {
						model.addAttribute("action", "edit");
						model.addAttribute("userId", userId);
						mav.addAllObjects(model);
						mav.setViewName("/admin/manageUser"  );
						
					}else {
						mav.setViewName("redirect/:HealthTrack/admin/login");
					}
			
	   		}else {
					mav.setViewName("/admin/login");
				}
	   		
		}
		
		return mav;
	}
//***************************************************user**********************************************	
	@RequestMapping(value="/HealthTrack/user/ban/{adminId}/{userId}", method = RequestMethod.GET)
    public ModelAndView Ban(@CookieValue(value="lang", defaultValue="en") String cookie,@PathVariable("adminId") String adminId, @PathVariable("userId") int userId,ModelAndView mav, ModelMap model, HttpServletRequest request)
    		throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		model.addAttribute("lang", cookie);
		
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
		if(username == null) {
			mav.setViewName("/admin/login");
		}else {
			if(Validation.checkIfTheUserIsAdmin(username) && Validation.checkIfSomethingExists("user_id", "user" , adminId)) {	
				
					UserDao.upadateBan(1,userId);
				
				mav.setViewName("redirect:/HealthTrack/admin/" + username + "/users");
			}else {
				mav.setViewName("/user/login");
			}
		}
		
		return mav;
	}
	@RequestMapping(value="/HealthTrack/user/unban/{adminId}/{userId}", method = RequestMethod.GET)
    public ModelAndView UnBan(@CookieValue(value="lang", defaultValue="en") String cookie,@PathVariable("adminId") String adminId, @PathVariable("userId") int userId,ModelAndView mav, ModelMap model, HttpServletRequest request)
    		throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		model.addAttribute("lang", cookie);
		
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
		if(username == null) {
			mav.setViewName("/admin/login");
		}else {
			if(Validation.checkIfTheUserIsAdmin(username) && Validation.checkIfSomethingExists("user_id", "user" , adminId)) {					
				UserDao.upadateBan(0,userId);
				mav.setViewName("redirect:/HealthTrack/admin/" + username + "/users");
			}else {
				mav.setViewName("/user/login");
			}
		}
		
		return mav;
	}
	@RequestMapping(value="/HealthTrack/booking/confirm/{adminId}/{bookingId}", method = RequestMethod.GET)
    public ModelAndView Confirm(@CookieValue(value="lang", defaultValue="en") String cookie,@PathVariable("adminId") String adminId, @PathVariable("bookingId") int bookingId,ModelAndView mav, ModelMap model, HttpServletRequest request)
    		throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		model.addAttribute("lang", cookie);
		
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
		if(username == null) {
			mav.setViewName("/admin/login");
		}else {
			if(Validation.checkIfTheUserIsAdmin(username) && Validation.checkIfSomethingExists("user_id", "user" , adminId)) {	
				
					BookingDao.updateStatus(1, bookingId);
					
				
				
				mav.setViewName("redirect:/HealthTrack/admin/" + username + "/daySlotBooking");
			}else {
				mav.setViewName("/user/login");
			}
		}
		
		return mav;
	}
	@RequestMapping(value="/HealthTrack/booking/unconfirm/{adminId}/{bookingId}", method = RequestMethod.GET)
    public ModelAndView unConfirm(@CookieValue(value="lang", defaultValue="en") String cookie,@PathVariable("adminId") String adminId, @PathVariable("bookingId") int bookingId,ModelAndView mav, ModelMap model, HttpServletRequest request)
    		throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		model.addAttribute("lang", cookie);
		
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
		if(username == null) {
			mav.setViewName("/admin/login");
		}else {
			if(Validation.checkIfTheUserIsAdmin(username) && Validation.checkIfSomethingExists("user_id", "user" , adminId)) {					
					BookingDao.updateStatus(0, bookingId);					
				
				mav.setViewName("redirect:/HealthTrack/admin/" + username + "/daySlotBooking");
			}else {
				mav.setViewName("/user/login");
			}
		}
		
		return mav;
	}

	@RequestMapping(value="/HealthTrack/admin/user/insert", method = RequestMethod.POST)
	public ModelAndView insertUser(@CookieValue(value="lang", defaultValue="en") String cookie,ModelMap model, ModelAndView mav , HttpSession session, HttpServletRequest request
			) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException, NoSuchAlgorithmException, ParseException, JSONException, IOException {
		    Translator t= new Translator(cookie);
			model.addAttribute("lang", cookie);
			String username = (String)session.getAttribute("username");
			if(username != null) {
				if(Validation.checkIfTheUserIsAdmin(username)) {
					
					String firstName	 		= request.getParameter("firstName");
					String lastName		        = request.getParameter("lastName");
					String username1			= request.getParameter("userName");
					
					String ARfirstName	 		= request.getParameter("ARfirstName");
					String ARlastName		        = request.getParameter("ARlastName");
					String ARusername1			= request.getParameter("ARuserName");
					String phone		        = request.getParameter("phone");
					String Email		        = request.getParameter("email");
					String Type		            = request.getParameter("type");
					String ARType		            = request.getParameter("ARtype");
					String password             =(request.getParameter("password"));
					String ConfirmPassword      =request.getParameter("confirmPassword");
					//int admin			= Integer.parseInt(request.getParameter("Admin"));
					
					
				
					model.addAttribute("oldFirstName"	, firstName);
					model.addAttribute("oldLastName"	, lastName);
					model.addAttribute("oldUserName"	, username1);
					model.addAttribute("oldPhone"	, phone);
					model.addAttribute("oldEmail"	, Email);
					model.addAttribute("oldType"	, Type);
					model.addAttribute("oldPassword"	, password);
					
					boolean errors = false;
					
					if(!Validation.validateName(firstName)) {
						model.addAttribute("invalidFirstName", "<p class=\"wrong-input \">"+t.write("Invalid FirstName")+"</p>");
						errors = true;
					}
					if(firstName.length() < 4) {
						model.addAttribute("shortFirstName", "<p class=\"wrong-input \">"+t.write("the first name should be at least 4 characters")+"</p>");
						errors = true;
					}
					if(!Validation.validateName(lastName)) {
						model.addAttribute("invalidlastName", "<p class=\"wrong-input \">"+t.write("Invalid lastName")+"</p>");
						errors = true;
					}
					if(lastName.length() < 4) {
						model.addAttribute("shortlastName", "<p class=\"wrong-input \">"+t.write("tha last name should be at least 4 characters")+"</p>");
						errors = true;
					}
					if(!Validation.validateName(username1)) {
						model.addAttribute("invalidUserName", "<p class=\"wrong-input \">"+t.write("Invalid username")+"</p>");
						errors = true;
					}
					if(username1.length() < 4) {
						model.addAttribute("shortUserName", "<p class=\"wrong-input \">"+t.write("tha name should be at least 4 characters")+"</p>");
						errors = true;
					}
					if(Validation.checkIfSomethingExists("username", "user", username1)) {
					model.addAttribute("UsernameExist", "<p class=\"wrong-input \">"+t.write("This username already exists")+"</p>");
					errors = true;
						
					}
					
					if(!Validation.validateEmail(Email)) {
						model.addAttribute("invalidEmail", "<p class=\"wrong-input \">"+t.write("Invalid Email")+"</p>");
						errors = true;
					}
					if(!Validation.validatePhone(phone)) {
						model.addAttribute("invalidPhone", "<p class=\"wrong-input \">"+t.write("Invalid Phone length: must be mobile number 11 characters or landline number 8 characters")+"</p>");
						errors = true;
					}
					
					if(!Validation.validateName(Type)) {
						model.addAttribute("invalidType", "<p class=\"wrong-input \">"+t.write("Invalid Type")+"</p>");
						errors = true;
					}
					if(firstName.length() < 4) {
						model.addAttribute("shortType", "<p class=\"wrong-input \">"+t.write("tha name should be at least 4 characters")+"</p>");
						errors = true;
					}
					if(password.length()<6) {
						model.addAttribute("invalidPassword", "<p class=\"wrong-input\">"+t.write("Password shouldn't be less than 6 characters")+"</p>");
						errors = true;
					}
					if(!password.equals(ConfirmPassword)) {
						model.addAttribute("passwordNotMatch", "<p class=\"wrong-input\">"+t.write("Password doesn't match")+"</p>");
						errors = true;
					}
					
							if(errors == false) {
								String encryptedPassword = Validation.encryptePssword(password);							
								User user= new User();
								user.setType(Type);
								user.setUsername(username1);
								user.setPassword(encryptedPassword);
								user.setId(UserDao.insertUser(user));	
								if(Type.equals("person")) {
									Person person =new Person();
									person.setId(user.getId());
									person.setFirstName(firstName);
									person.setLastName(lastName);
									person.setEmail(Email);
									person.setPhone(phone);
									person.setVerified(0);
									PersonDao.insertPerson(person);
								}
								//UserDao.insertNewUser(user, person);
								mav.setViewName("redirect:/HealthTrack/admin/" + username + "/users");
							}
							else {
								model.addAttribute("action","add");
								mav.addAllObjects(model);
								mav.setViewName("/admin/manageUser");
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
	
	@RequestMapping(value="/HealthTrack/admin/user/{userId}/update", method = RequestMethod.POST)
	public ModelAndView updateUser(@CookieValue(value="lang", defaultValue="en") String cookie,ModelMap model, ModelAndView mav , HttpSession session, HttpServletRequest request, @PathVariable("userId") int userId) 
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException, ParseException, JSONException, IOException, NoSuchAlgorithmException {
			Translator t = new Translator(cookie);
		    model.addAttribute("lang", cookie);
			String username = (String)session.getAttribute("username");
			//User user =UserDao.getUserById(userId);
			if(username != null) {
				if(Validation.checkIfTheUserIsAdmin(username)) {
                    String username1			= request.getParameter("userName");		
					String Type		            = request.getParameter("type");
					String password             =(request.getParameter("password"));
					String ConfirmPassword      =request.getParameter("confirmPassword");
					String firstName	 		= request.getParameter("firstName");
					String lastName		        = request.getParameter("lastName");
					String phone		        = request.getParameter("phone");
					String Email		        = request.getParameter("email");
					
					
					model.addAttribute("oldFirstName"	, firstName);
					model.addAttribute("oldLastName"	, lastName);
					model.addAttribute("oldPhone"	, phone);
					model.addAttribute("oldEmail"	, Email);
					

					model.addAttribute("oldUserName"	, username1);				
					model.addAttribute("oldType"	, Type);
					model.addAttribute("oldPassword"	, password);
					
					boolean errors = false;
					/*
					
					if(!Validation.validateName(username1)) {
						model.addAttribute("invalidUserName", "<p class=\"wrong-input \">"+t.write("Invalid username")+"</p>");
						errors = true;
					}
					if(username1.length() < 4) {
						model.addAttribute("shortUserName", "<p class=\"wrong-input \">"+t.write("tha name should be at least 4 characters")+"</p>");
						errors = true;
					}
					

					if(!Validation.validateName(Type)) {
						model.addAttribute("invalidType", "<p class=\"wrong-input \">"+t.write("Invalid Type")+"</p>");
						errors = true;
					}
					if(Type.length() < 4) {
						model.addAttribute("shortType", "<p class=\"wrong-input \">"+t.write("tha name should be at least 4 characters")+"</p>");
						errors = true;
					}
					if(password.length()<6) {
						model.addAttribute("invalidPassword", "<p class=\"wrong-input\">"+t.write("Password shouldn't be less than 6 characters")+"</p>");
						errors = true;
					}
					if(!password.equals(ConfirmPassword)) {
						model.addAttribute("passwordNotMatch", "<p class=\"wrong-input\">"+t.write("Password doesn't match")+"</p>");
						errors = true;
					}
					*/
					
						
						/*
						
						if(!Validation.validateName(firstName)) {
							model.addAttribute("invalidFirstName", "<p class=\"wrong-input \">"+t.write("Invalid FirstName")+"</p>");
							errors = true;
						}
						if(firstName.length() < 4) {
							model.addAttribute("shortFirstName", "<p class=\"wrong-input \">"+t.write("the first name should be at least 4 characters")+"</p>");
							errors = true;
						}
						if(!Validation.validateName(lastName)) {
							model.addAttribute("invalidlastName", "<p class=\"wrong-input \">"+t.write("Invalid lastName")+"</p>");
							errors = true;
						}
						if(lastName.length() < 4) {
							model.addAttribute("shortlastName", "<p class=\"wrong-input \">"+t.write("tha last name should be at least 4 characters")+"</p>");
							errors = true;
						}
						
						if(!Validation.validateEmail(Email)) {
							model.addAttribute("invalidEmail", "<p class=\"wrong-input \">"+t.write("Invalid Email")+"</p>");
							errors = true;
						}
						if(!Validation.validatePhone(phone)) {
							model.addAttribute("invalidPhone", "<p class=\"wrong-input \">"+t.write("Invalid Phone length: must be mobile number 11 characters or landline number 8 characters")+"</p>");
							errors = true;
						}
						
					*/
					
					
					
					
					if(errors == false) {
						String encryptedPassword = Validation.encryptePssword(password);
						
						if(Type.equals("person")) {
						User user= new User();
						user.setType(Type);
						user.setUsername(username1);
						user.setPassword(encryptedPassword);
						user.setId(userId);
						UserDao.updateUser(user);
						
							Person person =new Person();
							person.setId(userId);
							person.setFirstName(firstName);
							person.setLastName(lastName);
							person.setEmail(Email);
							person.setPhone(phone);
							person.setVerified(0);
							PersonDao.updatePerson(person);
						}else {
							User user= new User();
							user.setType(Type);
							user.setUsername(username1);
							user.setPassword(encryptedPassword);
							user.setId(userId);
							UserDao.updateUser(user);
						}
						
						mav.setViewName("redirect:/HealthTrack/admin/" + username + "/users");
					}else {
						System.out.println("true");
						model.addAttribute("action","edit");
						//model.addAttribute("AdminId", AdminId);
						mav.addAllObjects(model);
						mav.setViewName("/admin/manageUser");
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

//***************************************Services***********************************************
	@RequestMapping(value="/HealthTrack/admin/service/insert", method = RequestMethod.POST)
	public ModelAndView insertService(@CookieValue(value="lang", defaultValue="en") String cookie,ModelMap model, ModelAndView mav , HttpSession session, HttpServletRequest request
			) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException, NoSuchAlgorithmException, ParseException, JSONException, IOException {
		    Translator t =new Translator(cookie);
		    model.addAttribute("lang", cookie);
			String username = (String)session.getAttribute("username");
			if(username != null) {
				if(Validation.checkIfTheUserIsAdmin(username)) {
					
					String serviceName	 	= request.getParameter("serviceName");
					int place               =Integer.parseInt(request.getParameter("place"));
					String fees		        = request.getParameter("fees");
					String Type		        = request.getParameter("type");
										
					boolean errors = false;					
					
					if(!Validation.validateFees(fees)) {
						model.addAttribute("invalidFees", "<p class=\"wrong-input \">"+t.write("Invalid Fees")+"</p>");
						errors = true;
					}
					
							if(errors == false) {
								if(place==1) {
									int departmentId = Integer.parseInt(request.getParameter("deptId"));
									Service service=new Service();
									service.setServiceName(serviceName);
									service.setDeptId(departmentId);
									service.setFees(fees);
									service.setType(Type);
									ServiceDao.insertServiceForHospital(service);
								}
								else if(place==2) {
									int centerId =Integer.parseInt( request.getParameter("centerId"));
									Service service=new Service();
									service.setServiceName(serviceName);
									service.setCenterId(centerId);
									service.setFees(fees);
									service.setType(Type);
									ServiceDao.insertServiceForCenter(service);
								}
								
								mav.setViewName("redirect:/HealthTrack/admin/" + username + "/services");
							}
							else {
								model.addAttribute("action","add");
								mav.addAllObjects(model);
								mav.setViewName("/admin/manageServices");
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
	
	@RequestMapping(value="/HealthTrack/admin/{username}/service/addNewService", method = RequestMethod.POST)
	public ModelAndView submitService(@CookieValue(value="lang", defaultValue="en") String cookie,ModelMap model, ModelAndView mav, HttpServletRequest request)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
		model.addAttribute("lang", cookie);
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
		if(username == null) {
			mav.setViewName("/admin/login");
		}else {
			if(Validation.checkIfTheUserIsAdmin(username)) {
				
				int hospitalId 	= Integer.parseInt(request.getParameter("hospitalId"));
				String deptName = request.getParameter("dept");
				
				if(!deptName.equals("0")) {
					HospitalDao.insertDepartment(deptName, hospitalId);
			}
			mav.setViewName("redirect:/HealthTrack/admin/" + username + "/hospitals");
		}
		}
		return mav;
	}
	
}	
