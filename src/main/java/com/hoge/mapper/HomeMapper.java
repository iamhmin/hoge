package com.hoge.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.hoge.dto.AccMainDto;
import com.hoge.dto.ActMainDto;
import com.hoge.dto.HomeAccommoDto;
import com.hoge.dto.HomeActivityDto;
import com.hoge.vo.accommo.AccommoImage;

/**
 * 홈 기능에 관한 메서드명을 정의하였다.
 * @author 이승준
 *
 */
@Mapper
public interface HomeMapper {
	
	List<HomeActivityDto> getDiscountPromotionNo();
	List<HomeActivityDto> getOfferPromotionNo();
	
	List<AccMainDto> getNewSixAccommoMainImages();
	List<ActMainDto> getNewSixActivityMainInfo();
	
	AccommoImage getAccMainImage(int discountProMotionNo);
	AccommoImage getAccMainImageByOfferNo(int offerProMotionNo);
	
	HomeAccommoDto getMinMaxByHostNo(int hostNo);
	
	List<HomeAccommoDto> getAllAccommodation();
	
	int getAllAccommodationTotalRows();
	
	List<HomeActivityDto> getActivityPromotion();
}