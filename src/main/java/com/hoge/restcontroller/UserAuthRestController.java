package com.hoge.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hoge.dto.MailDto;
import com.hoge.service.SendEmailService;
import com.hoge.service.UserService;

@RestController
public class UserAuthRestController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private SendEmailService sendEmailService;
	
	// 이승준: 아이디 중복여부 체크
	@PostMapping("/register/checkId")
	public int register(@RequestParam("userId") String id) {
		
		return userService.userCheckById(id);
	}
}