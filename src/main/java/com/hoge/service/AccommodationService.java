package com.hoge.service;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.hoge.dto.AccMainDto;
import com.hoge.dto.AccommoListDto;
import com.hoge.dto.MapArea;
import com.hoge.dto.ReserveAccommoDto;
import com.hoge.dto.RoomDto;
import com.hoge.dto.RoomListDto;
import com.hoge.form.Criteria;
import com.hoge.form.AccommoReserveForm;
import com.hoge.mapper.AccommodationMapper;
import com.hoge.vo.accommo.AccommoImage;
import com.hoge.vo.accommo.Accommodation;
import com.hoge.vo.accommo.Room;
import com.hoge.vo.accommo.RoomBooking;
import com.hoge.vo.accommo.RoomImage;
import com.hoge.vo.other.KakaoPayApprovalVO;
import com.hoge.vo.other.KakaoPayReadyVO;

@Service
public class AccommodationService {
	
	@Autowired
	private AccommodationMapper accommoMapper;
	
	// 염주환
	public Accommodation getAccommodationDetail(int no) {
		return accommoMapper.getAccommodationByNo(no);
	}
	
	// 염주환
	public Room getRoomDetail(int no) {
		return accommoMapper.getRoomByNo(no);
	}
	
	// 염주환
	public int getTotalRows(Criteria criteria) {
		return accommoMapper.getAccommodationsTotalRows(criteria);
	}
	
	// 염주환
	public int getTotalRows(MapArea mapArea) {
		return accommoMapper.getMapAreaAccommodationsTotalRows(mapArea);
	}
	
	// 염주환
	public List<AccommoListDto> searchAccommoListDto(Criteria criteria) {
		return accommoMapper.searchAccommoListDtos(criteria);
	}
	
	 // 염주환 지도영역에 맞는 listDto
    public List<AccommoListDto> searchAccommoListDto(MapArea mapArea, Criteria criteria) {
    	List<AccommoListDto> dtos = accommoMapper.searchMapAreaAccommoListDtos(mapArea, criteria);
    	for (AccommoListDto dto : dtos) {
    		dto.setAccommoImages(accommoMapper.getAccommoImagesByAccommoNo(dto.getNo()));
    	}
    	return dtos;
	}
	
	// 염주환
	public List<AccommoImage> getAccommoImages(int accommoNo) {
		return accommoMapper.getAccommoImagesByAccommoNo(accommoNo);
	}
	
	// 염주환
	public ReserveAccommoDto getReserveAccommoDto(int accommoNo, int roomNo) {
		return accommoMapper.getReserveAccommoDto(accommoNo, roomNo);
	}
	
	// 염주환
	@Transactional
	public void addNewBooking(RoomBooking roomBooking, int userNo, String tid) {
		int no = accommoMapper.getRoomBookingNoSeq();
		
		System.out.println(userNo);
		List<Date> dateList = new ArrayList<>();
		
		Calendar c1 = Calendar.getInstance();
		Calendar c2 = Calendar.getInstance();
		
		c1.setTime(roomBooking.getCheckInDate());
		c2.setTime(roomBooking.getCheckOutDate());
		c2.add(Calendar.DATE, -1);
		
		Calendar c3 = Calendar.getInstance();
		Calendar c4 = Calendar.getInstance();
		c3.setTime(roomBooking.getCheckInDate());
		c3.add(Calendar.HOUR_OF_DAY , 10); 
		c4.setTime(roomBooking.getCheckOutDate());
		c4.add(Calendar.HOUR_OF_DAY , 10); 
		Date newCheckOutDate = new Date(c4.getTimeInMillis());
		Date newCheckInDate = new Date(c3.getTimeInMillis());
		roomBooking.setCheckInDate(newCheckInDate);
		roomBooking.setCheckOutDate(newCheckOutDate);
		
		while (c1.compareTo(c2) != 1) {
			dateList.add(c1.getTime());
			c1.add(Calendar.DATE, 1);
		}
	
		accommoMapper.insertRoomBooking(roomBooking, userNo, no, tid);
		
		java.sql.Date sqlDate = null;
		
		for (Date date : dateList) {
			sqlDate = new java.sql.Date(date.getTime());
			accommoMapper.insertRoomAvailability(no, sqlDate);
		}
		
		long amount = roomBooking.getPaidPrice();
		long accumulatedMoney = accommoMapper.getAccumulatedMoney();
		accumulatedMoney += roomBooking.getPaidPrice();
		accommoMapper.insertTransactions(amount, accumulatedMoney, userNo, no);
		accommoMapper.updateUserPnt(userNo, roomBooking.getUsedPnt());
		
	}

	
	
	// 유상효 객실 등록
	public void insertRoom(Room room, List<RoomImage> roomImages) {
		accommoMapper.insertRoom(room);
		for (RoomImage roomImage : roomImages) {
			roomImage.setRoomNo(room.getNo());
			accommoMapper.insertRoomImage(roomImage);
		}
	}
	
	// 유상효 AccNo로 객실 정보 가져오기
	public List<RoomListDto> getRoomListByAccNo(int accNo) {
		List<RoomListDto> roomDtos = accommoMapper.getRoomListByAccNo(accNo);
		for (RoomListDto roomDto : roomDtos) {
			List<RoomImage> roomImages = accommoMapper.getRoomImagesByRoomNo(roomDto.getNo());
			roomDto.setRoomImages(roomImages);
		}
		return roomDtos;
	}
	
	// 유상효 roomNo로 객실 정보 가져오기
	public RoomDto getRoomByRoomNo(int roomNo) {
		return accommoMapper.getRoomByRoomNo(roomNo);
	}
	
	// 유상효 roomNo로 객실 사진 가져오기
	public List<RoomImage> getRoomImages(int roomNo) {
		return accommoMapper.getRoomImagesByRoomNo(roomNo);
	}
	
	// 유상효 객실 수정
	public void roomModify(Room room) {
		accommoMapper.roomModify(room);
	}
	
	
	// 카카오페이 API
	private static final String HOST = "https://kapi.kakao.com";
    
	private KakaoPayReadyVO kakaoPayReadyVO;
    private KakaoPayApprovalVO kakaoPayApprovalVO;

    // 염주환
    public String kakaoPayReady(AccommoReserveForm form) {
 
    	RestTemplate restTemplate = new RestTemplate();
    	 
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + "c277cac726afbf7195ddff52bb03e946");
        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
        
        // 서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME");
        params.add("partner_order_id", "partner_order_id");
        params.add("partner_user_id", "partner_user_id");
        params.add("item_name", "HUGE");
        params.add("quantity", "1");
        params.add("total_amount", Long.toString(form.getPaidPrice()));
        params.add("tax_free_amount", Long.toString(form.getPaidPrice()));
        params.add("approval_url", "http://localhost/reserve/accommo/kakaoPaySuccess?roomNo="+form.getRoomNo()+"&checkInDate="+form.getCheckInDate()+"&checkOutDate="+form.getCheckOutDate()+"&payment="+form.getPayment()+"&taxIncludedPrice="+form.getTaxIncludedPrice()+"&usedPnt="+form.getUsedPnt()+"&paidPrice="+form.getPaidPrice()+"&roomUserName="+form.getRoomUserName()+"&roomUserTel="+form.getRoomUserTel()+"&extraPeople="+form.getExtraPeople());
        // TODO 염주환
        params.add("cancel_url", "http://localhost/kakaoPayCancel");
        // TODO 염주환
        params.add("fail_url", "http://localhost/kakaoPaySuccessFail");
 
         HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
 
        try {
            kakaoPayReadyVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/ready"), body, KakaoPayReadyVO.class);
            
            return kakaoPayReadyVO.getNext_redirect_pc_url();
 
        } catch (RestClientException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (URISyntaxException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        return "/pay";
        
    }
    
    // 염주환
    public KakaoPayApprovalVO kakaoPayInfo(String pg_token) {
    	 
        RestTemplate restTemplate = new RestTemplate();
 
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + "c277cac726afbf7195ddff52bb03e946");
        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
 
        // 서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME");
        params.add("tid", kakaoPayReadyVO.getTid());
        params.add("partner_order_id", "partner_order_id");
        params.add("partner_user_id", "partner_user_id");
        params.add("pg_token", pg_token);
        
        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
        
        try {
            kakaoPayApprovalVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/approve"), body, KakaoPayApprovalVO.class);
   
            return kakaoPayApprovalVO;
        
        } catch (RestClientException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (URISyntaxException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        return null;
    }
    
    // 염주환 예약완료페이지를 위한 booking 정보
    public RoomBooking getRoomBooking(int userNo) {
    	RoomBooking roomBooking = accommoMapper.getRoomBookingByUserNO(userNo);
    	return roomBooking;
    }

    // 유상효 숙소번호로 숙소정보 조회
	public AccMainDto getAccDetailByAccNo(int accNo) {
		return accommoMapper.getAccDetailByAccNo(accNo);
	}

	// 유상효 날짜 검색으로 룸리스트 가져오기
	public List<RoomListDto> getRoomListByDate(Criteria criteria) {
		List<RoomListDto> roomDtos = accommoMapper.getRoomListByDate(criteria);
		for (RoomListDto roomDto : roomDtos) {
			List<RoomImage> roomImages = accommoMapper.getRoomImagesByRoomNo(roomDto.getNo());
			roomDto.setRoomImages(roomImages);
		}
		return roomDtos;
	}
	
	// 유상효 accNo로 info type1 가져오기
	public List<RoomListDto> getRoomInfoType1(int accNo) {
		return accommoMapper.getAccInfoType1ByAccNo(accNo);
	}
	// 유상효 accNo로 info type2 가져오기
	public List<RoomListDto> getRoomInfoType2(int accNo) {
		return accommoMapper.getAccInfoType2ByAccNo(accNo);
	}
	
	
	// 염주환
    public String kakaoPayCancele(RoomBooking myRevInfoByBookingNo, int roomBookingNo) {
 
    	RestTemplate restTemplate = new RestTemplate();
    	 
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + "c277cac726afbf7195ddff52bb03e946");
        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
        
        // 서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME");
        params.add("tid", myRevInfoByBookingNo.getTID());
        params.add("cancel_amount", Long.toString(myRevInfoByBookingNo.getPaidPrice()));
        params.add("cancel_tax_free_amount", Long.toString(myRevInfoByBookingNo.getPaidPrice()));
 
        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
 
        try {
        	kakaoPayApprovalVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/cancel"), body, KakaoPayApprovalVO.class);
            
            accommoMapper.updateRoomBooking(myRevInfoByBookingNo);
            accommoMapper.deleteRoomAvailavility(roomBookingNo);
            
            return "redirect:/mypage/myrevlist";
 
        } catch (RestClientException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (URISyntaxException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        return "/pay";
        
    }
    
    
    
   
}
