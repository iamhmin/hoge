package com.hoge.dto;

import java.util.Date;
import java.util.List;

import com.hoge.vo.other.PromotionDiscount;

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
public class PromotionDiscountDto {
	
	private int no;
	private double weekdaysDiscountRate;
	private double weekendDiscountRate;
	private double peakSeasonDiscountRate;
	private Date startingDate;
	private Date endingDate;
	private String introContent;
	private int discountWeekdayNumber;
	private int discountWeekendNumber;
	private int discountPeakSeasonsNumber;
}
