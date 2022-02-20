package com.hoge.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.hoge.dto.AccommoListDto;
import com.hoge.dto.KakaoUserDto;
import com.hoge.dto.MyLoveDto;
import com.hoge.dto.UserRevInfoDto;
import com.hoge.form.CriteriaAdminUser;
import com.hoge.vo.other.User;
import com.hoge.vo.other.Wish;


/**
 * 유저 기능에 관한 메서드명을 정의하였다.
 * @author 이승준
 *
 */
@Mapper
public interface UserMapper {
	
	// 이승준: 테스트용, 모든 유저정보를 가져온다.
	List<User> getAllUsers();
	
	// 이승준: 유저번호에 맞는 유저정보를 가져온다.
	User getUserByNo(int no);
	
	// 이승준: 아이디에 맞는 유저정보를 가져온다.
	User getUserById(String id);
	
	// 이승준: 이메일에 맞는 유저정보를 가져온다.
	User getUserByEmail(String email);
	
	// 이승준: 유저정보를 업데이트한다.
	void updateUser(User user);
	
	// 이승준: 회원가입을 위한 메소드이다.
	void insertUser(User user);
	
	// (성하민 수정) 카카오 로그인을 통해 회원가입
	void insertUserKaKao(KakaoUserDto user);
	
	// 이승준: 아이디 중복여부체크 1: 중복 / 0: 정상
	int userCheckByid(String id);
	
	// 성하민
	int getUsersTotalRows(CriteriaAdminUser CAU);
	
	// 성하민
	List<User> searchUsers(CriteriaAdminUser CAU);

	// 이승준: 해당 유저가 예약한 간단한 예약정보를 가져오는 메소드.
	List<UserRevInfoDto> getMyRevListByNo(int no);

	// 이승준: 해당 유저가 정상적으로 다녀온 예약정보를 가져오는 메소드.
    List<UserRevInfoDto> getMyTourListByNo(int no);
    
    // 이승준: 해당 유저가 관심을 보이는 숙소 번호를 가져오는 메소드.
	List<Wish> getMyLoveListByNo(int userNo);
	
	// 이승준: 해당 유저가 관심을 보이는 숙소 정보 가져오는 메소드.
	AccommoListDto getAccommodationByNo(int accommoNo);
	
	// 이승준: 부킹넘버로 나의 예약정보 조회
	UserRevInfoDto getRevInfoByBookingNo(int roomBookingNo);
	
	// 이승준: 다녀온 여행 카운트
	int getTourListCnt(int userNo);

	void insertMyLovePage(MyLoveDto myLoveDto);
	void deleteMyLovePage(MyLoveDto myLoveDto);
	int getMyLoveListCnt(MyLoveDto myLoveDto);
}