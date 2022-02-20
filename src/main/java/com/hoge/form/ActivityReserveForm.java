package com.hoge.form;

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
public class ActivityReserveForm {
	
	private int activityTimeNo;
	private int activityNo; 
	private int userNo;
	private int numberOfPeople;
	private String payment;
	private long taxIncludedPrice;
	private long usedPnt;
	private long paidPrice;
	private String tid;
	private String bookingName;
	private String bookingTel;

}
