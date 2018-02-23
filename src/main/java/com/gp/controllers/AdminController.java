package com.gp.controllers;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AdminController {
	
	@RequestMapping(value="/admin")
	public String admin(Model model){
		
		return "/admin/test";
	}
}
