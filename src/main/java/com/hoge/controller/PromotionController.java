package com.hoge.controller;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.hoge.dto.HomeAccommoDto;
import com.hoge.service.HomeService;
import com.hoge.service.HostService;

@Controller
public class PromotionController {
	
	static final Logger logger = LogManager.getLogger(HomeController.class);
	
	@Autowired
	private HomeService homeService;
	
	// 유상효 프로모션 리스트
	@GetMapping("/home/promotion")
	public String promotionList(Model model) throws Exception {
		
		List<HomeAccommoDto> accDiscountPromotions = homeService.getAccDiscountPromotionsForHome();
		model.addAttribute("accDiscountPromotions", accDiscountPromotions);
		List<HomeAccommoDto> accOfferPromotions = homeService.getAccOfferPromotionsForHome();
		model.addAttribute("accOfferPromotions", accOfferPromotions);
		List<HomeAccommoDto> actDiscountPromotions = homeService.getActDiscountPromotions();
		model.addAttribute("actDiscountPromotions", actDiscountPromotions);
		List<HomeAccommoDto> actOfferPromotions = homeService.getActOfferPromotions();
		model.addAttribute("actOfferPromotions", actOfferPromotions);
		
		return "promotion/promotionList.tiles";
	}

}
