package com.hoge.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hoge.dto.MyTourListDto;
import com.hoge.mapper.AccommodationMapper;
import com.hoge.mapper.ActivityMapper;
import com.hoge.mapper.MyPageMapper;

@Service
public class MyPageService {
	
	@Autowired
	MyPageMapper myPageMapper;
	@Autowired
	AccommodationMapper accommoMapper;
	@Autowired
	ActivityMapper activityMapper;
	
	public List<MyTourListDto> getMyTourListAccommos(int userNo) {
		List<MyTourListDto> dtos = myPageMapper.getMyTourListAccommoDtos(userNo);
		for (MyTourListDto dto : dtos) {
			dto.setAccommoImages(accommoMapper.getAccommoImagesByAccommoNo(dto.getNo()));
		}
		return dtos;
	}
	
	public List<MyTourListDto> getMyTourListActivities(int userNo) {
		List<MyTourListDto> dtos = myPageMapper.getMyTourListActivities(userNo);
		for (MyTourListDto dto : dtos) {
			dto.setActivityImages(activityMapper.getActivityImageList(dto.getNo()));
		}
		return dtos;
	}

}
