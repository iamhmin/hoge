package com.hoge.service;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hoge.dto.AccMainDto;
import com.hoge.dto.ActMainDto;
import com.hoge.dto.HomeAccommoDto;
import com.hoge.dto.HomeActivityDto;
import com.hoge.mapper.HomeMapper;
import com.hoge.mapper.PromotionMapper;
import com.hoge.vo.accommo.AccommoImage;

/**
 * User에 관한 서비스 로직
 * @author 이승준
 *
 */
@Service
public class HomeService {
	
	static final Logger logger = LogManager.getLogger(HomeService.class);
	
	@Autowired
	private HomeMapper homeMapper;
	
	@Autowired
	private PromotionMapper promotionMapper;
	
	public int getAllAccommodationTotalRows() {
		return homeMapper.getAllAccommodationTotalRows();
	}

	public List<HomeAccommoDto> getAllAccommodation() {
		return homeMapper.getAllAccommodation();
	}
	
	public List<AccMainDto> getNewSixAccommoMainImages() {
		return homeMapper.getNewSixAccommoMainImages();
	}
	
	public List<ActMainDto> getNewSixActivityMainInfo() {
		return homeMapper.getNewSixActivityMainInfo();
	}

	public List<HomeAccommoDto> getAccDiscountPromotionsForHome() {
		
		List<HomeAccommoDto> homePromotionDiscountDtos = promotionMapper.getAccDiscountPromotionsForHome();
		
		for (HomeAccommoDto homePromotionDiscountDto : homePromotionDiscountDtos) {
			// logger.info(homePromotionDiscountDto);
			AccommoImage accommoImage = new AccommoImage();
			accommoImage = homeMapper.getAccMainImage(homePromotionDiscountDto.getNo());
			if (accommoImage != null) {
				homePromotionDiscountDto.setMainImage(accommoImage.getImage());
			}
			
			HomeAccommoDto minMaxDto = new HomeAccommoDto();
			minMaxDto = homeMapper.getMinMaxByHostNo(homePromotionDiscountDto.getHostNo());
			homePromotionDiscountDto.setMinPrice(minMaxDto.getMinPrice());
			homePromotionDiscountDto.setMaxPrice(minMaxDto.getMaxPrice());
			homePromotionDiscountDto.setMinNumber(minMaxDto.getMinNumber());
			homePromotionDiscountDto.setMaxNumber(minMaxDto.getMaxNumber());
		}
		
		return homePromotionDiscountDtos;
	}
	
	public List<HomeAccommoDto> getAccOfferPromotionsForHome() {
			
		List<HomeAccommoDto> homePromotionOfferDtos = promotionMapper.getAccOfferPromotionsForHome();
			
		for (HomeAccommoDto homePromotionOfferDto : homePromotionOfferDtos) {
				
			AccommoImage accommoImage = new AccommoImage();
			accommoImage = homeMapper.getAccMainImageByOfferNo(homePromotionOfferDto.getNo());
			homePromotionOfferDto.setMainImage(accommoImage.getImage());
				
			// logger.info(homePromotionOfferDto);
		}
				
		return homePromotionOfferDtos;
	}
	
	public List<HomeActivityDto> getActivityPromotion() {
		
		// List<HomeActivityDto> disCountPromotionNos = homeMapper.getDiscountPromotionNo();
		// List<HomeActivityDto> offerPromotionNos = homeMapper.getOfferPromotionNo();
				
		return homeMapper.getActivityPromotion();
	}
	
	// 유상효 체험 할인 프로모션 조회
	public List<HomeAccommoDto> getActDiscountPromotions() {
		return promotionMapper.getActDiscountPromotion();
	}
	// 유상효 체험 증정 프로모션 조회
	public List<HomeAccommoDto> getActOfferPromotions() {
		return promotionMapper.getActOfferPromotion();
	}
}