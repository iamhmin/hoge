package com.hoge.dto;

import java.util.List;

import com.hoge.vo.accommo.AccommoImage;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MergeAccommoListDto {
	
	private int no;
	private String type;
	private String name;
	private double averageStar;
	private String regionDepth1;
	private String regionDepth2;
	private long minPrice;
	private long maxPrice;
	private long minNumber;
	private long maxNumber;
	private double xce;
	private double yce;
	private Boolean isDiscountPromotion = false;
	private Boolean isOfferPromotion;
	private List<AccommoImage> accommoImages;
}


