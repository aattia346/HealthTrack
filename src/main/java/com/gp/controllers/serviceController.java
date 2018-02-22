package com.gp.controllers;

import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.gp.service.serviceClass;
import com.gp.service.serviceDao;
import com.gp.user.User;


@RestController
public class serviceController {
	
	
	@RequestMapping(value="/HealthTrack/addservice")
	public ModelAndView addservice(ModelAndView mav) {
		mav.setViewName("user/hospital_admin/addservice");
		return mav;
	}
	
	@RequestMapping(value = "/HealthTrack/insert", method = RequestMethod.POST)
    public ModelAndView  insert(HttpServletRequest request, serviceClass s, ModelMap model, ModelAndView mav)throws InstantiationException,
    IllegalAccessException, ClassNotFoundException, SQLException, NoSuchAlgorithmException {
		
		//int phone = Integer.parseInt(phoneAsString);
	   	String username = request.getParameter("state");
	   	String fees = request.getParameter("fees");
		String rating = request.getParameter("rating"); 
		s.setstatus(username);
	     s.setfees(fees);
	     s.setrating(rating);
	    serviceDao.insertservice(s);
	   	mav.setViewName("user/hospital_admin/ViewServices");
	   	return mav;
	}
	
	
	@RequestMapping(value="/HealthTrack/view")
	public ModelAndView viewservice()throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
	List<serviceClass> service =serviceDao.getAllRecords();
	 
	  
		return new ModelAndView( "user/hospital_admin/ViewServices","List",service);
	}
	
	@RequestMapping(value="/HealthTrack/deleteservice/{id}", method=RequestMethod.GET)
	public ModelAndView deleteservice(@PathVariable int id)throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		serviceClass s=serviceDao.getserviceById(id);
		
		serviceDao.delete(s);
		serviceDao.update(s);
	
		return new ModelAndView( "user/hospital_admin/ViewServices");
	}
	
	@RequestMapping(value="/HealthTrack/editservice/{id}")
	public ModelAndView editservice(@PathVariable int id,ModelMap model, HttpServletRequest request,serviceClass service)throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		serviceClass s =serviceDao.getserviceById(id);
		HttpSession session = request.getSession();		
	   		session.setAttribute("id", id);
		return new ModelAndView("user/hospital_admin/editserviceform","command",s);
	}
	

	@RequestMapping(value="/HealthTrack/editservice/update", method=RequestMethod.POST)
	public ModelAndView editsave(ModelMap model, HttpServletRequest request,ModelAndView mav)throws InstantiationException,
    IllegalAccessException, ClassNotFoundException, SQLException, NoSuchAlgorithmException  {
		HttpSession session = request.getSession();
		int id=(int) session.getAttribute("id");
		serviceClass s =serviceDao.getserviceById(id);
		String username = request.getParameter("state");
	   	String fees = request.getParameter("fees");
		String rating = request.getParameter("rating"); 
		s.setstatus(username);
	     s.setfees(fees);
	     s.setrating(rating);
		System.out.println(s.getId());
		 // System.out.println(s.getserviceId());
		    System.out.println(s.getfees());
		    System.out.println(s.getrating());
		//serviceDao.insertservice(s);
	serviceDao.update(s);
		
		System.out.println(s.getserviceId());
		  mav.setViewName("user/hospital_admin/ViewServices");
		return   mav;
     }
	

}
