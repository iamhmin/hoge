package com.hoge.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Random;

import javax.swing.text.html.parser.DTD;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

import com.hoge.dto.AccListDto;
import com.hoge.dto.AccMainDto;
import com.hoge.dto.ActListDto;
import com.hoge.dto.ActMainDto;
import com.hoge.dto.RoomBookingDto;
import com.hoge.dto.RoomDto;
import com.hoge.form.AccInfoForm;
import com.hoge.form.Criteria;
import com.hoge.mapper.AccommodationMapper;
import com.hoge.mapper.HostMapper;
import com.hoge.mapper.WithdrawalMapper;
import com.hoge.util.SessionUtils;
import com.hoge.vo.accommo.AccommoImage;
import com.hoge.vo.accommo.Accommodation;
import com.hoge.vo.accommo.RoomBooking;
import com.hoge.vo.activities.Activity;
import com.hoge.vo.activities.ActivityImage;
import com.hoge.vo.other.Host;
import com.hoge.vo.other.PromotionDiscount;
import com.hoge.vo.other.PromotionOffer;
import com.hoge.vo.other.User;
import com.hoge.vo.other.Withdrawal;

/**
 * 
 * @author 성하민, 유상효
 *
 */
@Service
public class HostService {
	
	@Autowired
	private HostMapper hostMapper;
	
	@Autowired
	private WithdrawalMapper withdrawalMapper;
	
	@Autowired
	private AccommodationMapper accommoMapper;
	
	
	public long getWithdrawalwaitingAmountByHostNo(int no) {
		return withdrawalMapper.getWithdrawalwaitingAmountByHostNo(no);
	}
	
	//성하민 호스트 예약관리
	public List<RoomBooking> getRoomBookingByHostNo(int no) {
		return accommoMapper.getRoomBookingByHostNo(no);
	}
	
	
  
	// 유상효 호스트 등록
	public void hostApply(Host host, Accommodation acc, Activity act, List<AccommoImage> accImages, List<ActivityImage> actImages) {
		User user = (User) SessionUtils.getAttribute("LOGIN_USER"); // 로그인 세션으로 유저정보 불러오기
	    // int getUserNo = hostMapper.getUserNoByUserId(user.getId());
	    host.setUserNo(user.getNo());
	    
	    int hostType = host.getHostingType();
	    if (hostType == 1) {
	    	hostMapper.insertHostApply(host);
	    	acc.setHostNo(host.getNo()); // 호스트 시퀀스 들고오기
	    	hostMapper.insertAcc(acc);
	    	for (AccommoImage accImage : accImages) {
	    		accImage.setAccommoNo(acc.getNo()); // 숙소 시퀀스 들고오기
	    		hostMapper.insertAccImage(accImage);
	    	}
	    	
	    } else {
	    	hostMapper.insertHostApply(host);
	    	act.setHostNo(host.getNo()); // 호스트 시퀀스 들고오기
	    	hostMapper.insertAct(act);
	    	for (ActivityImage actImage : actImages) {
	    		actImage.setActivityNo(act.getNo()); // 체험 시퀀스 들고오기
	    		hostMapper.insertActImage(actImage);
	    	}
	    }
	}
	
	// 유저 상태 업데이트
	public void userIsHostUpdate(int userNo) {
		hostMapper.userIsHostUpdate(userNo);
	}
	
	// 호스트 수정(숙소)
	public void accHostModify(Host host, Accommodation acc) {
		hostMapper.modifyHostByHostNo(host);
		hostMapper.modifyAccByHostNo(acc);
	}
	
	// 호스트 수정(체험)
	public void actHostModify(Host host, Activity act) {
		hostMapper.modifyHostByHostNo(host);
		hostMapper.modifyActByHostNo(act);
	}
	
	// 유저 아이디로 유저번호 반환
	public int getUserNoByUserId(String userId) {
		int userNo = hostMapper.getUserNoByUserId(userId);
		return userNo;
	}
	
	
	// 숙소 리스트 가져오기
	public List<AccListDto> getAccListByUserNo(int userNo) {
		return hostMapper.getAccListByUserNo(userNo);
	}
	// 체험 리스트 가져오기
	public List<ActListDto> getActListByUserNo(int userNo) {
		return hostMapper.getActListByUserNo(userNo);
	}
	
	// 숙소 정보 가져오기
	public AccMainDto getAccMainByHostNo(int hostNo) {
		return hostMapper.getAccMainByHostNo(hostNo);
	}
	public List<AccommoImage> getAccImagesByHostNo(int hostNo) {
		return hostMapper.getAccImagesByHostNo(hostNo);
	}
	
	// 체험 정보 가져오기
	public ActMainDto getActMainByHostNo(int hostNo) {
		return hostMapper.getActMainByHostNo(hostNo);
	}
	public List<ActivityImage> getActImagesByHostNo(int hostNo) {
		return hostMapper.getActImagesByHostNo(hostNo);
	}
	
	
	
  // 성하민
	public Host getHostByNo(int no) {
		return hostMapper.getHostByNo(no);

	}

	//성하민 출금신청 하기
	public void insertWithdrawal(Withdrawal withdrawal) {
		System.out.println("서비스 메소드로 들어온 값:"+withdrawal);
		withdrawalMapper.insertWithdrawal(withdrawal);
	}

	//성하민 출금신청 목록 가져오기
	public List<Withdrawal> getHostWithdrawalListByHostNo(int no, int begin, int end){
		return withdrawalMapper.getHostWithdrawalListByHostNo(no, begin, end);
	}
	
	public int getWithdrawalCountByHostNo(int no) {
		return withdrawalMapper.getWithdrawalCountByHostNo(no);
	}
	
	
	// 유상효 할인 프로모션 등록
	public void addPromotionDiscount(PromotionDiscount promotionDiscount) {
		hostMapper.addPromotionDiscount(promotionDiscount);
	}
	
	// 유상효 증정 프로모션 등록
	public void addPromotionOffer(PromotionOffer promotionOffer) {
		hostMapper.addPromotionOffer(promotionOffer);
	}
	
	// 유상효 프로모션 리스트
	public List<PromotionDiscount> getPromotionDiscountByHostNo(int hostNo) {
		return hostMapper.getPromotionDiscountByHostNo(hostNo);
	}
	public List<PromotionDiscount> getPromotionDiscountByHostNoAndStatusY(int hostNo) {
		return hostMapper.getPromotionDiscountByHostNoAndStatusY(hostNo);
	}
	public List<PromotionDiscount> getPromotionDiscountByHostNoAndStatusW(int hostNo) {
		return hostMapper.getPromotionDiscountByHostNoAndStatusW(hostNo);
	}
	public List<PromotionDiscount> getPromotionDiscountByHostNoAndStatusN(int hostNo) {
		return hostMapper.getPromotionDiscountByHostNoAndStatusN(hostNo);
	}
	public List<PromotionDiscount> getPromotionDiscountByHostNoAndStatusD(int hostNo) {
		return hostMapper.getPromotionDiscountByHostNoAndStatusD(hostNo);
	}
	
	public List<PromotionOffer> getPromotionOfferByHostNo(int hostNo) {
		return hostMapper.getPromotionOfferByHostNo(hostNo);
	}
	public List<PromotionOffer> getPromotionOfferByHostNoAndStatusY(int hostNo) {
		return hostMapper.getPromotionOfferByHostNoAndStatusY(hostNo);
	}
	public List<PromotionOffer> getPromotionOfferByHostNoAndStatusW(int hostNo) {
		return hostMapper.getPromotionOfferByHostNoAndStatusW(hostNo);
	}
	public List<PromotionOffer> getPromotionOfferByHostNoAndStatusN(int hostNo) {
		return hostMapper.getPromotionOfferByHostNoAndStatusN(hostNo);
	}
	public List<PromotionOffer> getPromotionOfferByHostNoAndStatusD(int hostNo) {
		return hostMapper.getPromotionOfferByHostNoAndStatusD(hostNo);
	}
	
	// 유상효 프로모션 번호로 할인프로모션 조회
	public PromotionDiscount getPromotionDiscountByPromotionNo(int no) {
		return hostMapper.getPromotionDiscountByPromotionNo(no);
	}
	
	// 유상효 프로모션 번호로 증정프로모션 조회
	public PromotionOffer getPromotionOfferByPromotionNo(int no) {
		return hostMapper.getPromotionOfferByPromotionNo(no);
	}
	
	// 유상효 할인프로모션 수정
	public void modifyPromotionDiscount(PromotionDiscount promotionDiscount) {
		hostMapper.modifyPromotionDiscount(promotionDiscount);
	}
	
	// 유상효 증정프로모션 수정
	public void modifyPromotionOffer(PromotionOffer promotionOffer) {
		hostMapper.modifyPromotionOffer(promotionOffer);
	}
	

	//성하민 호스트페이지에서 채팅에서 이용가능룸 정보 가져오기
		public List<RoomDto> getAvailableRoomInfo(Criteria criteria){
			return accommoMapper.getAvailableRoomInfo(criteria);
		}

		//성하민 호스트페이지에서 예약된 룸정보 가져오기
		public List<RoomBookingDto> getBookedRoomInfo(Criteria criteria){
			return accommoMapper.getBookedRoomInfo(criteria);
		}
		

		//성하민 호스트페이지 메인에서 최근 3일 예약건수 가져오기
		public int getRecentBookingCountByAccommoNo(int no) {
			return accommoMapper.getRecentBookingCountByAccommoNo(no);
		}
		
		//성하민 호스트페이지 메인에서 최근 3일 예약데이터 가져오기
		public List<RoomBooking> getRecentBookingListByAccommoNo(Criteria criteria){
			return accommoMapper.getRecentBookingListByAccommoNo(criteria);
		}
		
		//성하민 호스트페이지 메인에서 오늘 예약건수 가져오기
		public int getTodayBookingCountByAccommoNo(int no) {
			return accommoMapper.getTodayBookingCountByAccommoNo(no);
		}


		// 유상효 숙소 부대시설 및 기타 안내 등록
		public void addAccInfo(AccInfoForm form) {
			hostMapper.addAccInfo(form);
			form.setEtcInfoNo(form.getNo()); // info 시퀀스 넣어주기
			hostMapper.addAccInfoDetail(form);
		}
		
		// 유상효 숙체험 부대시설 및 기타 안내 등록
		public void addActInfo(AccInfoForm form) {
			hostMapper.addActInfo(form);
			form.setEtcInfoNo(form.getNo()); // info 시퀀스 넣어주기
			hostMapper.addActInfoDetail(form);
		}
		
		
		
		

		//성하민 호스트페이지 메인에서 오늘 체크아웃 가져오기
		public List<RoomBooking> getTodayCheckOutByAccommoNo(int no){
			return accommoMapper.getTodayCheckOutByAccommoNo(no);
		}
		
		//성하민 호스트페이지 메인에서 오늘 체크인가져오기
		public List<RoomBooking> getTodayCheckInByAccommoNo(int no){
			return accommoMapper.getTodayCheckInByAccommoNo(no);
			
		}
		
		
		public void updateHost(Host host) {
			hostMapper.updateHost(host);
		}

		



		

}
