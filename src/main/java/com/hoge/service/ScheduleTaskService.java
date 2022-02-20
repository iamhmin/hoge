package com.hoge.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hoge.dto.ActivityBookingBatchDto;
import com.hoge.dto.AdminHostQnADto;
import com.hoge.dto.AdminUserQnADto;
import com.hoge.dto.RoomBookingBatchDto;
import com.hoge.form.CriteriaAdminQnA;
import com.hoge.form.CriteriaAdminUser;
import com.hoge.mapper.AccommodationMapper;
import com.hoge.mapper.ActivityMapper;
import com.hoge.mapper.HostMapper;
import com.hoge.mapper.PromotionMapper;
import com.hoge.mapper.QnAMapper;
import com.hoge.mapper.UserMapper;
import com.hoge.vo.accommo.RoomBooking;
import com.hoge.vo.other.Host;
import com.hoge.vo.other.HostQnA;
import com.hoge.vo.other.User;
import com.hoge.vo.other.UserQnA;


@Service
public class ScheduleTaskService {
	
	@Autowired UserMapper userMapper;
	@Autowired HostMapper hostMapper;
	@Autowired AccommodationMapper accommodationMapper;
	@Autowired ActivityMapper activityMapper;
	@Autowired PromotionMapper promotionMapper;
	
	public List<RoomBookingBatchDto> getRoomBookingBatchDto() {
		return accommodationMapper.getRoomBookingBatchDto();
	}
	
	public List<ActivityBookingBatchDto> getActivityBookingBatchDto() {
		return activityMapper.getActivityBookingBatchDto();
	}
	
	/*
	 * 체험 예약 상태를 종료로 바꾸는 메소드
	 */
	public void completeActBookingState(int bookingNo) {
		activityMapper.updateActivityBookingStatusByBookingNo(bookingNo);
		
	}
	
	/*
	 * 예약 상태를 종료로 바꾸는 메소드
	 */
	public void completeAccBookingState(int bookingNo) {
		RoomBooking roomBooking = accommodationMapper.getRoomBookingByRoomBookingNo(bookingNo);
		roomBooking.setStatus(0);
		accommodationMapper.updateRoomBooking(roomBooking);
	}
	
	/*
	 * 호스트에게 호스트 등급이 적용된 금액을 보냄(실제 이체 아님)
	 */
	public void sendHostBookingPayment(int hostNo, long amount) {
		Host host = hostMapper.getHostByNo(hostNo);
		host.setAccumulatedMoney(host.getAccumulatedMoney()+amount);
		hostMapper.updateHost(host);
		
	}
	
	/*
	 * 유저에게 실제 지불액에 대한 포인트를 보냄(1percent)
	 */
	public void addUserPoint(int userNo, long pnt) {
		User user = userMapper.getUserByNo(userNo);
		user.setPnt(user.getPnt()+pnt);
		userMapper.updateUser(user);
	}
	
	public void closeActivityTime() {
		activityMapper.closeActivityTime();
	}
	
	public void closePromotion() {
		promotionMapper.closeDiscountPromotion();
		promotionMapper.closeOfferPromotion();
	}

	
	
}


