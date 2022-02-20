package com.hoge.dto;

import java.util.Date;

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
public class HomeAccommoDto {
	
	private int no;
	private int hostNo;
	private String introContent;
	private double weekdaysDiscountRate;
	private double weekendDiscountRate;
	private double peakSeasonDiscountRate;
	@JsonFormat(pattern = "yyyy.MM.dd")
	private Date startingDate;
	@JsonFormat(pattern = "yyyy.MM.dd")
	private Date endingDate;
	private int accommoNo;
	private String accommoType;
	private String accommoName;
	private String accommoRegionDepth1;
	private String accommoRegionDepth2;
	private int deadlineDate;
	private String mainImage;
	private long minPrice;
	private long maxPrice;
	private int minNumber;
	private int maxNumber;
	
	private String offerContent;
	private int actNo;
	private String actName;
	private String actRegionDepth1;
	private String actRegionDepth2;
	
}
