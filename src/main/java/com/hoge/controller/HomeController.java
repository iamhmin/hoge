package com.hoge.controller;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.hoge.dto.AccMainDto;
import com.hoge.dto.ActMainDto;
import com.hoge.dto.HomeAccommoDto;
import com.hoge.dto.HomeActivityDto;
import com.hoge.service.HomeService;

/**
 * HOGE 웹사이트의 홈 컨트롤러
 * @author 이승준
 *
 */
@Controller
public class HomeController {
	
	static final Logger logger = LogManager.getLogger(HomeController.class);
	
	@Autowired
	private HomeService homeService;
	
	// 이승준: 홈 페이지로 리턴
	@GetMapping("/home")
	public String home(Model model) throws Exception {
		
		List<AccMainDto> newSixAccommoDtos = homeService.getNewSixAccommoMainImages();
		List<ActMainDto> newSixAcivityDtos = homeService.getNewSixActivityMainInfo();
		List<HomeAccommoDto> homePromotionDiscountDtos = homeService.getAccDiscountPromotionsForHome();
		List<HomeAccommoDto> homePromotionOfferDtos = homeService.getAccOfferPromotionsForHome();
		List<HomeActivityDto> activityPromotionDto = homeService.getActivityPromotion();
		
		model.addAttribute("newSixAccommoDtos", newSixAccommoDtos);
		model.addAttribute("newSixAcivityDtos", newSixAcivityDtos);
		if (!(homePromotionDiscountDtos.isEmpty())) {
			model.addAttribute("homePromotionDiscountDtos", homePromotionDiscountDtos);
		}
		model.addAttribute("homePromotionOfferDtos", homePromotionOfferDtos);
		model.addAttribute("activityPromotionDto", activityPromotionDto);
		
		List<HomeAccommoDto> accommoDtos = homeService.getAllAccommodation();
		model.addAttribute("accommoDtos", accommoDtos);
		
		logger.info("엑티브 모든체험:" + activityPromotionDto);
		
		return "home.tiles";
	}
	
	/*
	// 이승준: 홈 페이지로 리턴
	@GetMapping("/home")
	public String home(@RequestParam(name = "page", required = false, defaultValue = "1") String page, 
														Criteria criteria, Model model) throws Exception {
		
		List<AccMainDto> newSixAccommoDtos = homeService.getNewSixAccommoMainImages();
		List<HomeAccommoDto> homePromotionDiscountDtos = homeService.getAccDiscountPromotionsForHome();
		List<HomeAccommoDto> homePromotionOfferDtos = homeService.getAccOfferPromotionsForHome();
		
		model.addAttribute("newSixAccommoDtos", newSixAccommoDtos);
		model.addAttribute("homePromotionDiscountDtos", homePromotionDiscountDtos);
		model.addAttribute("homePromotionOfferDtos", homePromotionOfferDtos);
		
		// int totalRecords = homeService.getAllAccommodationTotalRows();
		// Pagination pagination = new Pagination(page, totalRecords, 3);
		// criteria.setBeginIndex(pagination.getBegin());
		// criteria.setEndIndex(pagination.getEnd());
		List<HomeAccommoDto> accommoDtos = homeService.getAllAccommodation(criteria);
		model.addAttribute("accommoDtos", accommoDtos);
		// model.addAttribute("pagination", pagination);
		
		logger.info("오퍼프로모션:" + homePromotionOfferDtos);
		return "home.tiles";
	}
	*/
}