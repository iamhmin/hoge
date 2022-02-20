package com.hoge.dto;

import java.sql.Date;

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
public class ActivityBookingBatchDto {
	
	private int activityBookingNo;
	private int userNo;
	private Date activityTime;
	private int status;
	private int activityTimeNo;
	private long taxIncludedPrice; 
	private long paidPrice;
	private int activityNo;
	private int hostNo;
	private String GradeName;
	private double commissionRate;
	

}
