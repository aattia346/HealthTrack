package com.gp.controllers;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.gp.user.Validation;

@RestController
public class DashboardController {

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
	public ModelAndView insertHospital(Model model, ModelAndView mav , HttpSession session, HttpServletRequest request) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		//validate and insert hospital
		String name = request.getParameter("name");
		
		return mav;
	}
}
