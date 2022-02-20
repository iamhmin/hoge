package com.hoge.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

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
public class PromotionDto {

	private int no;
	private int hostNo;
	
	private int accommoNo;
	private String accommoName;
	private int activityNo;
	private String activityName;
	
	private double weekdaysDiscountRate;
	private double weekendDiscountRate;
	private double peakSeasonDiscountRate;
	
	private String offerContent; //증정 내용
	
	@JsonFormat(pattern = "yyyy.MM.dd")
	private Date startingDate;
	@JsonFormat(pattern = "yyyy.MM.dd")
	private Date endingDate;
	@JsonFormat(pattern = "yyyy.MM.dd")
	private Date registeredDate;
	private String introContent;
	private String status; // w(승인대기), Y(승인완료), N(승인거절), D(종료)
	
	
	
	
}

	

