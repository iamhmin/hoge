package com.hoge.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hoge.dto.AdminAccommoListDto;
import com.hoge.dto.AdminActivityListDto;
import com.hoge.form.Criteria;
import com.hoge.mapper.AccommodationMapper;
import com.hoge.mapper.ActivityMapper;
@Service
public class AdminService {

	@Autowired
	private AccommodationMapper accommodationMapper;
	@Autowired
	private ActivityMapper activityMapper;

	//성하민 관리자페이지에서 숙소정보 가져오기
	public List<AdminAccommoListDto> getAccommoListForAdmin(Criteria criteria){
		return accommodationMapper.getAccommoListForAdmin(criteria);
	}
	
	//성하민 관리자페이지에서 숙소 개수 가져오기
	public int getAccommoCountForAdmin(Criteria criteria) {
		return accommodationMapper.getAccommoCountForAdmin(criteria);
	}
	
	//성하민 관리자페이지에서 체험정보 가져오기
	public List<AdminActivityListDto> getActivityListForAdmin(Criteria criteria){
		return activityMapper.getActivityListForAdmin(criteria);
	}
	
	//성하민 관리자페이지에서 체험 개수 가져오기
	public int getActivityCountForAdmin(Criteria criteria) {
		return activityMapper.getActivityCountForAdmin(criteria);
	}
	

}
