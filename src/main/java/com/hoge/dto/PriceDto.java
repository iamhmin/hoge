package com.hoge.dto;

import java.util.List;


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
public class PriceDto {

	private int weekdayNumber;
	private int weekendNumber;
	private int peakSeasonNumber;
	private long roomPrice; // 기본 객실 요금
	private long surcharge; // 추가 요금(인당 계산된 금액)
	private long totalPrice; // 포인트까지 적용된 가격
	private long discountAmount; // 할인 금액
	private int usePoint; // 포인트
	private int extraPeople; // 추가 인원
	private List<PromotionDiscountDto> promotionDiscounts;
	
}
