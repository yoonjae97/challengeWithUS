package com.smart.home.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.smart.home.dto.ChallengesDTO;
import com.smart.home.service.ChallengesService;

@Controller
@RequestMapping("/yj")
public class ChallengesController {
	
	@Autowired
	ChallengesService service;
	
	@GetMapping("ChallengesList")
	public String ChallengesList(Model model) {
		model.addAttribute("list", service.ChallengesList());
		return "yj/dataList";
	}
}











