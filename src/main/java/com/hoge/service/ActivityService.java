package com.hoge.service;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.hoge.config.auth.LoginedUser;
import com.hoge.dto.ActMainDto;
import com.hoge.dto.ActivityBookingDto;
import com.hoge.dto.ActivityBookingHostDto;
import com.hoge.dto.ActivityListDto;
import com.hoge.dto.MapArea;
import com.hoge.form.AccommoReserveForm;
import com.hoge.form.ActTimeForm;
import com.hoge.form.ActivityReserveForm;
import com.hoge.form.Criteria;
import com.hoge.mapper.AccommodationMapper;
import com.hoge.mapper.ActivityMapper;
import com.hoge.vo.activities.Activity;
import com.hoge.vo.activities.ActivityBooking;
import com.hoge.vo.activities.ActivityImage;
import com.hoge.vo.activities.ActivityTimeTable;
import com.hoge.vo.other.KakaoPayApprovalVO;
import com.hoge.vo.other.KakaoPayReadyVO;
import com.hoge.vo.other.Transaction;
import com.hoge.vo.other.User;

@Service
public class ActivityService {
	
	@Autowired
	private ActivityMapper activityMapper;
	@Autowired
	private AccommodationMapper accommoMapper;
	
	// 염주환
	public Activity getActivityDetail(int no) {
		return activityMapper.getActivityByNo(no);
	}
	
	public List<ActivityTimeTable> getActivityTimeListByActivityNo(int activityNo) {
		return activityMapper.getActivityTimeTableByActivityNo(activityNo);
	}
	
	public void addNewBooking(ActivityReserveForm activityReserveForm) {
		int activityBookingNo = activityMapper.getActivityBookingNoSeq();
		activityMapper.insertActivityBooking(activityReserveForm, activityBookingNo);
		activityMapper.updateActivityTimes(activityReserveForm);
		activityMapper.updateActivityTimesClosed(activityReserveForm);
		
		long accumulatedMoney = accommoMapper.getAccumulatedMoney();
		Transaction transaction = new Transaction();
		transaction.setAmount(activityReserveForm.getPaidPrice());
		transaction.setActivityBookingNo(activityBookingNo);
		transaction.setAccumulatedMoney(accumulatedMoney + activityReserveForm.getPaidPrice());
		activityMapper.insertTransaction(transaction);
		
		accommoMapper.updateUserPnt(activityReserveForm.getUserNo(), activityReserveForm.getUsedPnt());
	}
	
	// 카카오페이 API
	private static final String HOST = "https://kapi.kakao.com";
    
	private KakaoPayReadyVO kakaoPayReadyVO;
    private KakaoPayApprovalVO kakaoPayApprovalVO;

    // 염주환
    public String kakaoPayReady(ActivityReserveForm form) {
 
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
        params.add("approval_url", "http://localhost/reserve/activity/kakaoPaySuccess?activityTimeNo="+form.getActivityTimeNo()+"&activityNo="+form.getActivityNo()+"&userNo="+form.getUserNo()+"&numberOfPeople="+form.getNumberOfPeople()+"&payment="+form.getPayment()+"&taxIncludedPrice="+form.getTaxIncludedPrice()+"&usedPnt="+form.getUsedPnt()+"&paidPrice="+form.getPaidPrice());
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
    
    // 염주환
    public ActivityBookingDto getActivityBookingDetail(int userNo) {
    	return activityMapper.getActivityBooking(userNo);
    };
    
    // 염주환
    public List<ActivityImage> getActiviyImages(int activitNo) {
    	return activityMapper.getActivityImageList(activitNo);
    }
    
    
    // 유상효 타임테이블 등록
	public void addTime(ActTimeForm form) {
		activityMapper.addTime(form);
	}
	
	// 유상효 타임테이블 리스트
	public List<ActivityTimeTable> getTimeTableByActNo(int actNo) {
		return activityMapper.getTimeTableByActNo(actNo);
	}
	public List<ActivityTimeTable> getTimeTableByActNoAndStatusN(int actNo) {
		return  activityMapper.getTimeTableByActNoAndStatusN(actNo);
	}
	public List<ActivityTimeTable> getTimeTableByActNoAndStatusY(int actNo) {
		return  activityMapper.getTimeTableByActNoAndStatusY(actNo);
	}
	
	// 유상효 타임테이블no로 타임테이블 조회
	public ActivityTimeTable getTimeTableByTimeNo(int no) {
		return activityMapper.getTimeTableByTimeNo(no);
	}
	
	// 유상효 체험 타임테이블 수정
	public void modifyTimeTable(ActTimeForm form) {
		activityMapper.modifyTimeTable(form);
	}
	
	// 염주환
	public int getTotalRows(MapArea mapArea) {
		return activityMapper.getActivitiesTotalRows(mapArea);
	}
	
	public List<ActivityListDto> getActivityDtos(MapArea mapArea, Criteria criteria) {
		List<ActivityListDto> dtos = activityMapper.getActivityListDto(mapArea, criteria);
		for (ActivityListDto dto : dtos) {
			dto.setActivityImages(activityMapper.getActivityImageList(dto.getNo()));
		}
		return dtos;
	}
	
	// 유상효 체험번호로 체험정보 조회
	public ActMainDto getActDetailByActNo(int actNo) {
		return activityMapper.getActDetailByActNo(actNo);
	}
	

	// 유상효 actNo로 info type1 가져오기
	public List<ActMainDto> getActInfoType1(int actNo) {
		return activityMapper.getActInfoType1ByActNo(actNo);
	}

	// 유상효 actNo로 info type2 가져오기
	public List<ActMainDto> getActInfoType2(int actNo) {
		return activityMapper.getActInfoType2ByActNo(actNo);
	}

	// 유상효 actNo로 info type3 가져오기
	public List<ActMainDto> getActInfoType3(int actNo) {
		return activityMapper.getActInfoType3ByActNo(actNo);
	}
	

	//성하민 호스트페이지 메인에서 최근 3일 예약건수 가져오기
		public int getRecentBookingCountByActivityNo(int no) {
			return activityMapper.getRecentBookingCountByActivityNo(no);
		}
		
		//성하민 호스트페이지 메인에서 최근 3일 예약데이터 가져오기
		public List<ActivityBookingHostDto> getRecentBookingListByActivityNo(Criteria criteria){
			return activityMapper.getRecentBookingListByActivityNo(criteria);
		}
		
		//성하민 호스트페이지 메인에서 오늘 예약건수 가져오기
		public int getTodayBookingCountByActivityNo(int no) {
			return activityMapper.getTodayBookingCountByActivityNo(no);
		}
	
	
}
