package com.hoge.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.hoge.dto.AccMainDto;
import com.hoge.dto.AccommoListDto;
import com.hoge.dto.AdminAccommoListDto;
import com.hoge.dto.MapArea;
import com.hoge.dto.ReserveAccommoDto;
import com.hoge.dto.RoomBookingBatchDto;
import com.hoge.dto.RoomBookingDto;
import com.hoge.dto.RoomDto;
import com.hoge.dto.RoomListDto;
import com.hoge.dto.UserRevInfoDto;
import com.hoge.form.Criteria;
import com.hoge.vo.accommo.AccommoImage;
import com.hoge.vo.accommo.Accommodation;
import com.hoge.vo.accommo.Room;
import com.hoge.vo.accommo.RoomBooking;
import com.hoge.vo.accommo.RoomImage;

@Mapper
public interface AccommodationMapper {
	
	// list페이지
	// 염주환 listDtos
	List<AccommoListDto> searchAccommoListDtos(Criteria criteria);
	// 염주환 지도 위치에 맞는 accommoListDto
	List<AccommoListDto> searchMapAreaAccommoListDtos(@Param("mapArea") MapArea mapArea, @Param("criteria") Criteria criteria);
	// 염주환 페이지네이션을 위함
	int getAccommodationsTotalRows(Criteria criteria);				// list
	// 염주환 지도 위치에 맞는 페이지네이션을 위함
	int getMapAreaAccommodationsTotalRows(MapArea mapArea);			// list
	// 염주환 숙소list 사진
	List<AccommoImage> getAccommoImagesByAccommoNo(int no);			// list
	
	Accommodation getAccommodationByNo(int no);						// 예약페이지
	Room getRoomByNo(int no);										// 예약페이지

	
	// 예약페이지
	// 염주환 예약페이지 숙소 관련 정보
	ReserveAccommoDto getReserveAccommoDto(@Param("accommoNo") int accommoNo, @Param("roomNo") int roomNo);
	// 염주환 roombooking insert
	void insertRoomBooking(@Param("roomBooking") RoomBooking roomBooking, @Param("userNo") int userNo, @Param("no") int no, @Param("tid") String tid);
	// 염주환 roombooking, availability, transactions에 같은 no 넣기 위함
	int getRoomBookingNoSeq();
	// 염주환 availability insert
	void insertRoomAvailability(@Param("no") int no, @Param("sqlDate") java.sql.Date sqlDate);
	// 염주환 AccumulatedMoney 금액 추가하기 위함
	long getAccumulatedMoney();
	// 염주환 transactions insert
	void insertTransactions(@Param("amount") long amount, @Param("accumulated") long accumulated, @Param("userNo") int userNo, @Param("no") int no);
	// 염주환 user usedPnt
	void updateUserPnt(@Param("userNo") int userNo, @Param("usedPnt") long usedPnt);
	
	// 예약취소
	// 이승준
	// void upadateRefundUserPnt(@Param("userNo") int refundtoUserNo, @Param("usedPnt") long refundPoint);
	void deleteRoomAvailavility(int roomBookingNo);
	
	// 예약완료페이지
	// 염주환 예약정보 가져오기
	RoomBooking getRoomBookingByUserNO(int userNo);
	
	// 유상효 객실 등록
	void insertRoom(Room room);
	// 유상효 객실사진 등록
	void insertRoomImage(RoomImage roomImage);
	// 유상효 accNo로 객실리스트 찾기
	List<RoomListDto> getRoomListByAccNo(int accNo);
	List<RoomListDto> getAccInfoType1ByAccNo(int accNo);
	List<RoomListDto> getAccInfoType2ByAccNo(int accNo);
	// 유상효  roomNo로 객실이미지 찾기
	List<RoomImage> getRoomImagesByRoomNo(int roomNo);
	// 유상효 roomNo로 객실정보 가져오기
	RoomDto getRoomByRoomNo(int roomNo);
	// 유상효 객실 수정
	void roomModify(Room room);
	
	
	//성하민 예약정보 변경
	void updateRoomBooking(RoomBooking roomBooking);
	
	//성하민 방 예약정보 가져오기
	RoomBooking getRoomBookingByRoomBookingNo(int no);
	
	//성하민 호스트번호로 방 예약정보 가져오기
	List<RoomBooking> getRoomBookingByHostNo(int no);
	
	//성하민 방 예약+호스트정보+grade 정보 가져오기
	List<RoomBookingBatchDto> getRoomBookingBatchDto();
	
	//성하민 관리자페이지에서 숙소정보 가져오기
	List<AdminAccommoListDto> getAccommoListForAdmin(Criteria criteria);
	
	//성하민 관리자페이지에서 숙소 개수 가져오기
	int getAccommoCountForAdmin(Criteria criteria);
	
	//성하민 호스트페이지에서 채팅에서 이용가능룸 정보 가져오기
	List<RoomDto> getAvailableRoomInfo(Criteria criteria);

	//성하민 호스트페이지에서 예약된 룸정보 가져오기
	List<RoomBookingDto> getBookedRoomInfo(Criteria criteria);
	
	// 유상효 숙소번호로 숙소정보 조회
	AccMainDto getAccDetailByAccNo(int accNo);
	
	// 유상효  날짜 검색으로 룸리스트 가져오기
	List<RoomListDto> getRoomListByDate(Criteria criteria);
	
	
	//성하민 호스트페이지 메인에서 최근 3일 예약건수 가져오기
	int getRecentBookingCountByAccommoNo(int no);
	
	//성하민 호스트페이지 메인에서 최근 3일 예약데이터 가져오기
	List<RoomBooking> getRecentBookingListByAccommoNo(Criteria criteria); 
	
	//성하민 호스트페이지 메인에서 오늘 예약건수 가져오기
	int getTodayBookingCountByAccommoNo(int no);
	
	//성하민 호스트페이지 메인에서 오늘 체크아웃 가져오기
	List<RoomBooking> getTodayCheckOutByAccommoNo(int no);
	
	//성하민 호스트페이지 메인에서 오늘 체크인가져오기
	List<RoomBooking> getTodayCheckInByAccommoNo(int no);
	
	
	
	
	
	
}
