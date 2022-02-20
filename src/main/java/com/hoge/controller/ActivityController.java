package com.hoge.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hoge.dto.AccMainDto;
import com.hoge.dto.AccReviewDto;
import com.hoge.dto.ActMainDto;
import com.hoge.dto.ActReviewDto;
import com.hoge.dto.RoomListDto;
import com.hoge.form.ActTimeForm;
import com.hoge.form.Criteria;
import com.hoge.service.ActivityService;
import com.hoge.service.HostService;
import com.hoge.service.ReviewService;
import com.hoge.vo.activities.ActivityImage;
import com.hoge.vo.activities.ActivityTimeTable;
import com.hoge.vo.other.PromotionDiscount;
import com.hoge.vo.other.PromotionOffer;

@Controller
@RequestMapping("/activity")
public class ActivityController {
	
	static final Logger logger = LogManager.getLogger(AccommodationController.class);
	
	@Autowired
	private ActivityService activityService;
	
	@Autowired
	private HostService hostService;
	
	@Autowired
	private ReviewService reviewService;
	
	// 유상효 체험 타임테이블 페이지 호출
	@GetMapping("/mainTime")
	public String mainTime(@RequestParam(name = "hostNo") int hostNo, @RequestParam(name = "hostingType") int hostingType, @RequestParam(name = "status", defaultValue = "A") String status, Model model) {
		AccMainDto accMainDto = hostService.getAccMainByHostNo(hostNo);
		model.addAttribute("accMainDto", accMainDto);
		ActMainDto actMainDto = hostService.getActMainByHostNo(hostNo);
		model.addAttribute("actMainDto", actMainDto);
		
		if (status.equals("A")) {
			List<ActivityTimeTable> timeList = activityService.getTimeTableByActNo(actMainDto.getActNo());
			model.addAttribute("timeList", timeList);
		} else if (status.equals("N")) {
			List<ActivityTimeTable> timeList = activityService.getTimeTableByActNoAndStatusN(actMainDto.getActNo());
			model.addAttribute("timeList", timeList);
		} else if (status.equals("Y")) {
			List<ActivityTimeTable> timeList = activityService.getTimeTableByActNoAndStatusY(actMainDto.getActNo());
			model.addAttribute("timeList", timeList);
		}
		
		return "activities/mainTime.hosttiles";
	}
	
	// 유상효 체험 타임테이블 등록폼 호출
	@GetMapping("/addTimeTable")
	public String addTimeTable(@RequestParam(name = "hostNo") int hostNo, @RequestParam(name = "hostingType") int hostingType, Model model) {
		AccMainDto accMainDto = hostService.getAccMainByHostNo(hostNo);
		model.addAttribute("accMainDto", accMainDto);
		ActMainDto actMainDto = hostService.getActMainByHostNo(hostNo);
		model.addAttribute("actMainDto", actMainDto);
		
		return "form/actTimeForm.hosttiles";
	}
	
	// 유상효 체험 타임테이블 입력
	@PostMapping("/addTime")
	public String addTime(ActTimeForm form) {
		
		String a = form.getDate(); // 날짜 데이터 받고
		String b = form.getTime(); // 시간 데이터 받고
		String c = a +" "+ b + ":00"; // 원하는 String 형식으로 만든다음에
		
		form.setInputTime(c); // form에 넣어주고, TO_DATE()로 형변환해서 DB에 입력
		logger.info("time입력값 :" + form);
		activityService.addTime(form);
		
		return "redirect:/activity/mainTime?hostNo="+form.getHostNo()+"&hostingType="+form.getHostingType();
	}
	
	// 유상효 체험 타임테이블 수정폼 호출
	@GetMapping("/modifyTime")
	public String modifyTimeForm(@RequestParam(name = "hostNo") int hostNo, @RequestParam(name = "hostingType") int hostingType, @RequestParam(name = "no") int no, Model model) {
		AccMainDto accMainDto = hostService.getAccMainByHostNo(hostNo);
		model.addAttribute("accMainDto", accMainDto);
		ActMainDto actMainDto = hostService.getActMainByHostNo(hostNo);
		model.addAttribute("actMainDto", actMainDto);
		ActivityTimeTable activityTimeTable = activityService.getTimeTableByTimeNo(no);
		model.addAttribute("activityTimeTable", activityTimeTable);
		
		return "form/modifyTimeForm.hosttiles";
	}
	
	
	// 유상효 체험 타임테이블 수정
	@PostMapping("/modifyTimeTable")
	public String modifyTimeTable(ActTimeForm form) {
		
		String a = form.getDate(); // 날짜 데이터 받고
		String b = form.getTime(); // 시간 데이터 받고
		String c = a +" "+ b + ":00"; // 원하는 String 형식으로 만든다음에
		
		form.setInputTime(c); // form에 넣어주고, TO_DATE()로 형변환해서 DB에 입력
		logger.info("time입력값 :" + form);
		activityService.modifyTimeTable(form);
		
		return "redirect:/activity/mainTime?hostNo="+form.getHostNo()+"&hostingType="+form.getHostingType();
	}
	
	// 유상효 체험 디테일 페이지
	@GetMapping("/detail")
	public String actDetail(@RequestParam(name = "actNo") int actNo, Model model) throws Exception {
		ActMainDto actMainDto = activityService.getActDetailByActNo(actNo);
		int hostNo = actMainDto.getHostNo();
		model.addAttribute("actMainDto", actMainDto);
		List<ActivityImage> actImages = hostService.getActImagesByHostNo(hostNo);
		model.addAttribute("actImages", actImages);
		
		List<ActivityTimeTable> timeTableList = activityService.getTimeTableByActNo(actNo);
		model.addAttribute("timeTableList", timeTableList);
		List<ActMainDto> actInfoType1 = activityService.getActInfoType1(actNo);
		model.addAttribute("actInfoType1", actInfoType1);
		List<ActMainDto> actInfoType2 = activityService.getActInfoType2(actNo);
		model.addAttribute("actInfoType2", actInfoType2);
		List<ActMainDto> actInfoType3 = activityService.getActInfoType3(actNo);
		model.addAttribute("actInfoType3", actInfoType3);
		
		List<PromotionDiscount> promotionDiscountList = hostService.getPromotionDiscountByHostNoAndStatusY(hostNo);
		model.addAttribute("promotionDiscountList", promotionDiscountList);
		List<PromotionOffer> promotionOfferList = hostService.getPromotionOfferByHostNoAndStatusY(hostNo);
		model.addAttribute("promotionOfferList", promotionOfferList);
		
		List<ActReviewDto> getActDetailReviews = reviewService.getActDetailReviews(actNo);
		model.addAttribute("getActDetailReviews", getActDetailReviews);
		List<ActReviewDto> getActDetailReviews6 = reviewService.getActDetailReviews6(actNo);
		model.addAttribute("getActDetailReviews6", getActDetailReviews6);
		ActReviewDto getActDetailStar = reviewService.getActDetailStar(actNo);
		model.addAttribute("getActDetailStar", getActDetailStar);
		ActReviewDto getActDetailReviewsTotal = reviewService.getActDetailReviewsTotal(actNo);
		model.addAttribute("getActDetailReviewsTotal", getActDetailReviewsTotal);
		
		logger.info("결과값:" );
		
		return "activities/actDetail.tiles";
	}
	
	
	// 염주환 list
	@GetMapping("/list")
	public String list(@RequestParam(name = "page", required = false, defaultValue = "1") String page,
			Criteria criteria, Model model) throws Exception {
		
		model.addAttribute("criteria", criteria);
		
		return "activities/list.tiles";
	}
	
	
	
	
}
