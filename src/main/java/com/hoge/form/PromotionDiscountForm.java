package com.hoge.form;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

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
public class PromotionDiscountForm {
	
	private int hostingType;
	private int no;
	private int hostNo;
	private double weekdaysDiscountRate;
	private double weekendDiscountRate;
	private double peakSeasonDiscountRate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startingDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endingDate;
	private Date registeredDate;
	private String introContent;

}
