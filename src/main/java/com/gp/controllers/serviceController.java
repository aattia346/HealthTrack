package com.gp.controllers;

import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.gp.service.serviceClass;
import com.gp.service.serviceDao;
import com.gp.user.Service;


@RestController
public class serviceController {
	
	
	@RequestMapping(value="/HealthTrack/addservice")
	public ModelAndView addservice(ModelAndView mav) {
		mav.setViewName("user/hospital_admin/addservice");
		return mav;
	}
	
	@RequestMapping(value = "/HealthTrack/insert")
    public ModelAndView  insert(HttpServletRequest request, Service s, ModelMap model, ModelAndView mav)throws InstantiationException,
    IllegalAccessException, ClassNotFoundException, SQLException, NoSuchAlgorithmException, ParseException {
		
		//int phone = Integer.parseInt(phoneAsString);
	   	String servicename = request.getParameter("Name");
	   	String fees = request.getParameter("fees");
	  // 	String lastUpdate =request.getParameter("lastUpdate");
	  	String  sqlDatetill= request.getParameter("available");
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date available_from1 = format.parse(sqlDatetill);	
		String  sqlDateto= request.getParameter("available2");
		Date available_to = format.parse(sqlDateto);		
		serviceDao.insertservice(servicename, fees,available_from1,available_to );
	   
	   	mav.setViewName("user/hospital_admin/ViewServices");
	   	return mav;
	}
	
	
	@RequestMapping(value="/HealthTrack/view")
	public ModelAndView viewservice()throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
	List<Service> service =serviceDao.getAllRecords();
	 
	  
		return new ModelAndView( "user/hospital_admin/ViewServices","List",service);
	}
	
	@RequestMapping(value="/HealthTrack/deleteservice/{id}", method=RequestMethod.GET)
	public ModelAndView deleteservice(@PathVariable int id)throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		Service s=serviceDao.getserviceById(id);
		
		serviceDao.delete(s);
		serviceDao.update(s);
	
		return new ModelAndView( "user/hospital_admin/ViewServices");
	}
	
	@RequestMapping(value="/HealthTrack/editservice/{id}")
	public ModelAndView editservice(@PathVariable int id,ModelMap model, HttpServletRequest request,serviceClass service)throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		Service s =serviceDao.getserviceById(id);
		HttpSession session = request.getSession();		
	   		session.setAttribute("id", id);
		return new ModelAndView("user/hospital_admin/editserviceform","command",s);
	}
	

	@RequestMapping(value="/HealthTrack/editservice/update", method=RequestMethod.POST)
	public ModelAndView editsave(ModelMap model, HttpServletRequest request,ModelAndView mav)throws InstantiationException,
    IllegalAccessException, ClassNotFoundException, SQLException, NoSuchAlgorithmException, ParseException  {
		HttpSession session = request.getSession();
		int id=(int) session.getAttribute("id");
		Service s =serviceDao.getserviceById(id);
		String servicename = request.getParameter("Name");
	   	String fees = request.getParameter("fees");
		String  sqlDatetill= request.getParameter("available");
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date available_from1 = format.parse(sqlDatetill);	
		String  sqlDateto= request.getParameter("available2");
		Date available_to = format.parse(sqlDateto);	
		s.setServiceName(servicename);
		s.setAvailable_from(available_from1);
		s.setAvailable_to(available_to);
	    s.setFees(fees);
		System.out.println(s.getId());
	    serviceDao.update(s);
		
		//System.out.println(s.getserviceId());
		  mav.setViewName("user/hospital_admin/ViewServices");
		return   mav;
     }
	

}
