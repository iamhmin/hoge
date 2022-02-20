package com.hoge.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.hoge.config.auth.LoginedUser;
import com.hoge.dto.MyLoveDto;
import com.hoge.dto.MyTourListDto;
import com.hoge.service.MyPageService;
import com.hoge.service.UserService;
import com.hoge.vo.other.User;

@RestController
@RequestMapping("/rest/mypage")
public class MyPageRestController {
	
	@Autowired
	MyPageService myPageService;
	
	@Autowired
	UserService userService;
	
	@GetMapping("/mytourlist")
	public List<MyTourListDto> list(@LoginedUser User user) {
		List<MyTourListDto> dtos = myPageService.getMyTourListAccommos(user.getNo());
		List<MyTourListDto> dtos2 = myPageService.getMyTourListActivities(user.getNo());
		dtos.addAll(dtos2);
		
		return dtos;
	}
	
	@GetMapping("/mylovelist/insertlovelist")
	public void insertMyLovePage(@LoginedUser User savedUser, int accommoNo) { 
		
		MyLoveDto myLoveDto = new MyLoveDto();
		myLoveDto.setUserNo(savedUser.getNo());
		myLoveDto.setAccommoNo(accommoNo);
		int cherk = userService.getMyLoveListCnt(myLoveDto);
		if (cherk == 1) { 
			userService.deleteMyLovePage(myLoveDto);
		} 
		if (cherk == 0) {
			userService.insertMyLovePage(myLoveDto);
		}
	}

}
