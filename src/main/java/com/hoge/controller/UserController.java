package com.hoge.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.hoge.service.UserService;
import com.hoge.vo.other.User;

/**
 * 테스트용 유저 컨트롤러 - 필요없을 시 삭제
 * @author 이승준
 *
 */
@RestController
@RequestMapping("/testApi/users")
public class UserController {
	@Autowired
	private UserService userService;

	@GetMapping
	public List<User> users() {
		return userService.getAllUsers();
	}
	
	
	
}
