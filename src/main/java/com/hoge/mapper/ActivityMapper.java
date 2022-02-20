package com.hoge.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.hoge.dto.ActMainDto;
import com.hoge.dto.ActivityBookingBatchDto;
import com.hoge.dto.ActivityBookingDto;
import com.hoge.dto.ActivityBookingHostDto;
import com.hoge.dto.ActivityListDto;
import com.hoge.dto.AdminAccommoListDto;
import com.hoge.dto.AdminActivityListDto;
import com.hoge.dto.MapArea;
import com.hoge.form.ActTimeForm;
import com.hoge.form.ActivityReserveForm;
import com.hoge.form.Criteria;
import com.hoge.vo.accommo.RoomBooking;
import com.hoge.vo.activities.Activity;
import com.hoge.vo.activities.ActivityBooking;
import com.hoge.vo.activities.ActivityImage;
import com.hoge.vo.activities.ActivityTimeTable;
import com.hoge.vo.other.Transaction;

@Mapper
public interface ActivityMapper {
	
	// 염주환 체험 디테일
	Activity getActivityByNo(int no);
	// 염주환 예약페이지 조회
	List<ActivityTimeTable> getActivityTimeTableByActivityNo(int activitNo);
	// 염주환 booking, transaction 같은 시퀀스번호
	int getActivityBookingNoSeq();
	// 염주환 activitybooking insert
	void insertActivityBooking(@Param("activityReserveForm") ActivityReserveForm activityReserveForm, @Param("activityBookingNo") int activityBookingNo);
	// 염주환 activityTimes update
	void updateActivityTimes(@Param("activityReserveForm") ActivityReserveForm activityReserveForm);
	void updateActivityTimesClosed(@Param("activityReserveForm") ActivityReserveForm activityReserveForm);
	// 염주환 transaction insert
	void insertTransaction(@Param("transaction") Transaction transaction);
	
	// 염주환 list
	List<ActivityListDto> getActivityListDto(@Param("mapArea") MapArea mapArea, @Param("criteria") Criteria criteria);
	int getActivitiesTotalRows(MapArea mapArea);
	
	// 염주환 예약 완료 페이지
	// 염주환 예약 정보
	ActivityBookingDto getActivityBooking(int userNo);
	// 염주환 체험 이미지
	List<ActivityImage> getActivityImageList(int activitNo);
	
	// 유상효 타임테이블 등록
	void addTime(ActTimeForm form);
	
	//유상효 타임테이블 리스트
	List<ActivityTimeTable> getTimeTableByActNo(int actNo);
	List<ActivityTimeTable> getTimeTableByActNoAndStatusN(int actNo);
	List<ActivityTimeTable> getTimeTableByActNoAndStatusY(int actNo);
	
	// 유상효 타임테이블no로 타임테이블 조회
	ActivityTimeTable getTimeTableByTimeNo(int no);
	
	// 유상효 체험 타임테이블 수정
	void modifyTimeTable(ActTimeForm form);
	
	// 유상효
	ActMainDto getActDetailByActNo(int actNo);
	
	// 유상효 체험 번호로 체험 인포 조회하기
	List<ActMainDto> getActInfoType1ByActNo(int actNo);
	List<ActMainDto> getActInfoType2ByActNo(int actNo);
	List<ActMainDto> getActInfoType3ByActNo(int actNo);
	
	
	//성하민 관리자페이지에서 체험정보 가져오기
	List<AdminActivityListDto> getActivityListForAdmin(Criteria criteria);
	
	//성하민 관리자페이지에서 체험 개수 가져오기
	int getActivityCountForAdmin(Criteria criteria);
	
	//성하민 
	void closeActivityTime();

	//성하민 호스트페이지 메인에서 최근 3일 예약건수 가져오기
		int getRecentBookingCountByActivityNo(int no);
		
		//성하민 호스트페이지 메인에서 최근 3일 예약데이터 가져오기
		List<ActivityBookingHostDto> getRecentBookingListByActivityNo(Criteria criteria); 
		
		//성하민 호스트페이지 메인에서 오늘 예약건수 가져오기
		int getTodayBookingCountByActivityNo(int no);
	
		void updateActivityBookingStatusByBookingNo(int no);
		
		List<ActivityBookingBatchDto> getActivityBookingBatchDto();
}
