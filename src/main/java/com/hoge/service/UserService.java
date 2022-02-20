package com.hoge.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.hoge.config.auth.LoginedUser;
import com.hoge.controller.AdminController;
import com.hoge.dto.AccommoListDto;
import com.hoge.dto.KakaoUserDto;
import com.hoge.dto.MyLoveDto;
import com.hoge.dto.UserRevInfoDto;
import com.hoge.exception.FindException;
import com.hoge.exception.LoginException;
import com.hoge.exception.UpdateException;
import com.hoge.form.CriteriaAdminUser;
import com.hoge.mapper.AccommodationMapper;
import com.hoge.mapper.HostMapper;
import com.hoge.mapper.ReviewMapper;
import com.hoge.mapper.TransactionMapper;
import com.hoge.mapper.UserMapper;
import com.hoge.util.SessionUtils;
import com.hoge.vo.accommo.AccommoImage;
import com.hoge.vo.accommo.RoomBooking;
import com.hoge.vo.other.ReviewAccommo;
import com.hoge.vo.other.Transaction;
import com.hoge.vo.other.User;
import com.hoge.vo.other.Wish;

/**
 * User에 관한 서비스 로직
 * @author 이승준
 *
 */
@Service
public class UserService {
	
	static final Logger logger = LogManager.getLogger(UserService.class);
	
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private HostMapper hostMapper;
	
	@Autowired
	private ReviewMapper reviewMapper;
	
	@Autowired
	private TransactionMapper transactionMapper;
	
	@Autowired
	private AccommodationMapper accommodationMapper;
	
	@Autowired
	private AccommodationService accommodationService;
	
	// 이승준 공용
	public List<User> getAllUsers() {
		return userMapper.getAllUsers();
	}
	
	// 이승준: 이메일 정보를 조회하여 유저정보를 리턴
	public User getUserByEmail(String email) {
		
		User savedUser = userMapper.getUserByEmail(email);
		
		if (savedUser == null) {
			throw new FindException("회원정보가 존재하지 않습니다.");
		}
		
		return savedUser;
	}
	
	// 이승준: 유저넘버 정보를 조회하여 유저정보를 리턴
	public User getUserByNo(int no) {
		
		User savedUser = userMapper.getUserByNo(no);
		
		if (savedUser == null) {
			throw new FindException("회원정보가 존재하지 않습니다.");
		}
		
		return savedUser;
	}
	
	// 이승준: 유저 아이디 정보를 조회하여 유저정보를 리턴
	public User getUserById(String id) {
		
		User savedUser = userMapper.getUserById(id);
		
		if (savedUser == null) {
			throw new FindException("회원정보가 존재하지 않습니다.");
		}
		
		return savedUser;
	}
	
	
	// 이승준: 유저 기본정보 업데이트 트랜젝션
	public void updateUser(User user) {
		
		/* TODO: 비번조회 승인으로 최종 저장
		 * User savedUser = (User) SessionUtils.getAttribute("LOGIN_USER");
		 * String authPwd = DigestUtils.sha512Hex(user.getPwd()); if
		 * (!authPwd.equals(savedUser.getPwd())) { throw new
		 * UpdateException("비밀번호가 일치하지 않습니다."); }
		 */
		
		userMapper.updateUser(user);
	}
	
	// 이승준: 회원탈퇴 N -> Y
	public void deleteUser(String pwd) {
		
		User savedUser = (User) SessionUtils.getAttribute("LOGIN_USER");
		
		String authPwd = DigestUtils.sha512Hex(pwd);
		if (!authPwd.equals(savedUser.getPwd())) {
			throw new UpdateException("비밀번호가 일치하지 않습니다.");
		}
		
		String deletedValue = "Y";
		
		savedUser.setDeleted(deletedValue);
		
		userMapper.updateUser(savedUser);
	}
	
	// 이승준: 유저 비밀번호 업데이트 트랜젝션
	public void userPwdUpdate(User user) {
	
		userMapper.updateUser(user);
	}
	
	// 이승준 로그인페이지
	public User login(String id, String pwd) {
		
		if (!StringUtils.hasText(id) || !StringUtils.hasText(pwd)) {
			throw new LoginException("<strong>아이디</strong> 또는 <strong>비밀번호</strong>를 입력하지 않았습니다.");
		}
		
		User savedUser = userMapper.getUserById(id);		
		
		if (savedUser == null) {
			throw new LoginException("회원정보가 존재하지 않습니다.");
		}
		
		if ("Y".equals(savedUser.getDeleted())) {
			throw new LoginException("탈퇴처리된 아이디입니다. 재가입해주세요.");
		}
		
		String authPwd = DigestUtils.sha512Hex(pwd);
		if (!authPwd.equals(savedUser.getPwd())) {
			throw new LoginException("비밀번호가 일치하지 않습니다.");
		}
		
		return savedUser;
	}
	
	// 이승준: 카카오톡 로그인페이지
	public User loginKakao(KakaoUserDto kakaoUser) {
		
		User savedUser = userMapper.getUserById(kakaoUser.getId());
		
		if (savedUser == null) {
			userMapper.insertUserKaKao(kakaoUser);
			savedUser = userMapper.getUserById(kakaoUser.getId());
		}
		
		return savedUser;
	}
	
	// 이승준: 회원가입 페이지
	public int userCheckById(String id) {
		return userMapper.userCheckByid(id);
	}
	
	// 이승준: 회원가입 페이지
	public User register(User newUser) {
		
		userMapper.insertUser(newUser);
		
		return newUser;
	}
	
	// 성하민 관리자페이지
	public int getUsersTotalRows(CriteriaAdminUser CAU) {
		return userMapper.getUsersTotalRows(CAU);
	}
	
	// 성하민 관리자페이지
	public List<User> searchUsers(CriteriaAdminUser CAU) {
		return userMapper.searchUsers(CAU);
	}
	
	// 이승준: 나의예약정보
	public List<UserRevInfoDto> getMyRevListByNo(int userNo) {
		
		List<UserRevInfoDto> userRevInfoList = userMapper.getMyRevListByNo(userNo);
		int reviewStatus = 0; // 0: 리뷰없음 1: 리뷰있음
		ReviewAccommo myReview = new ReviewAccommo();
		
		for (UserRevInfoDto userRevInfo : userRevInfoList) {
			List<AccommoImage> accommoImages = hostMapper.getAccImagesByAccNo(userRevInfo.getAccommoNo());
			userRevInfo.setAccommoImages(accommoImages);
			userRevInfo.setUserNo(userNo);
			
			reviewStatus = reviewMapper.reviewCheck(userRevInfo);
			myReview = reviewMapper.selectAccommoReview(userRevInfo);
			
			userRevInfo.setReviewStatus(reviewStatus);
			userRevInfo.setMyReview(myReview);
		}
		
		return userRevInfoList;
	}
	
	// 이승준: 나의투어정보
	public List<UserRevInfoDto> getMyTourListByNo(int userNo) {
		
		List<UserRevInfoDto> userTourInfoList = userMapper.getMyTourListByNo(userNo);
		
		for (UserRevInfoDto userTourInfo : userTourInfoList) {
			List<AccommoImage> accommoImages = hostMapper.getAccImagesByAccNo(userTourInfo.getAccommoNo());
			userTourInfo.setAccommoImages(accommoImages);
		}
		
		return userTourInfoList;
	}
	
	// 이승준: 나의위시리스트
	public List<AccommoListDto> getMyLoveList(int userNo) {
		
		List<Wish> accommoNoList = userMapper.getMyLoveListByNo(userNo);
		
		List<AccommoListDto> myLoveList = new ArrayList<>();
		
		for (Wish accommoNo : accommoNoList) {
			myLoveList.add(userMapper.getAccommodationByNo(accommoNo.getAccommoNo()));
		}
		
		for (AccommoListDto myLovePage : myLoveList) {
			List<AccommoImage> accommoImages = hostMapper.getAccImagesByAccNo(myLovePage.getNo());
			myLovePage.setAccommoImages(accommoImages);
		}
		
		logger.info(myLoveList);
		
		return myLoveList;
	}

	public UserRevInfoDto getRevInfoByBookingNo(int roomBookingNo) {
		return userMapper.getRevInfoByBookingNo(roomBookingNo);
	}

	public void canceleReservation(@LoginedUser User savedUser, int roomBookingNo, String cancelReason, long accumulatedMoney) {
		
		RoomBooking myRevInfoByBookingNo = accommodationMapper.getRoomBookingByRoomBookingNo(roomBookingNo); // 고객부킹정보
		myRevInfoByBookingNo.setCancelReason(cancelReason);
		myRevInfoByBookingNo.setStatus(2);
		
		int refundtoUserNo = myRevInfoByBookingNo.getUserNo(); // 환불받을사람번호
		long refundPrice = myRevInfoByBookingNo.getPaidPrice(); //환불 해야할 금액
		long refundPoint = myRevInfoByBookingNo.getUsedPnt(); // 환불 해야할 포인트
		
		// 트랜젝션 환불처리
		Transaction transaction = new Transaction();
		transaction.setAmount(refundPrice);
		transaction.setToUserNo(refundtoUserNo);
		transaction.setAccumulatedMoney(accumulatedMoney - refundPrice); 
		// transaction.setAccommoBookingNo(roomBookingNo);
		transactionMapper.insertUserTransaction(transaction);
		
		// 포인트 환불
		savedUser.setPnt(savedUser.getPnt() + refundPoint);
		userMapper.updateUser(savedUser);
		// accommodationMapper.upadateRefundUserPnt(refundtoUserNo, refundPoint);
		
		if (myRevInfoByBookingNo.getPayment().equals("카드")) {
			// booking status 변경 1>2, (cancelReason, cancelDate) update
			accommodationMapper.updateRoomBooking(myRevInfoByBookingNo);
			// booking roomAvailability 삭제
			accommodationMapper.deleteRoomAvailavility(roomBookingNo);
		} else {
			accommodationService.kakaoPayCancele(myRevInfoByBookingNo, roomBookingNo);
		}
		
		
	}

	public int getTourListCnt(int userNo) {
		return userMapper.getTourListCnt(userNo);
	}

	public void insertMyLovePage(MyLoveDto myLoveDto) {
		userMapper.insertMyLovePage(myLoveDto);
	}
	
	public void deleteMyLovePage(MyLoveDto myLoveDto) {
		userMapper.deleteMyLovePage(myLoveDto);
	}
	
	public int getMyLoveListCnt(MyLoveDto myLoveDto) {
		return userMapper.getMyLoveListCnt(myLoveDto);
	}
	
	public List<Wish> getMyLoveListByNo(int userNo) {
		return userMapper.getMyLoveListByNo(userNo);
	}
}