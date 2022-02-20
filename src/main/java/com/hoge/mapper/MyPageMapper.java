package com.hoge.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.hoge.dto.MyTourListDto;

@Mapper
public interface MyPageMapper {
	
	List<MyTourListDto> getMyTourListAccommoDtos(int userNo);
	List<MyTourListDto> getMyTourListActivities(int userNo);

}
