package com.hoge.vo.activities;

import java.util.Date;

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
public class ActivityBooking {

	private int no;
	private int activityTimeNo;
	private int userNo;
	private int numberOfPeople;
	private int status;
	private Date bookingMadeDate; 
	private Date canceledDate; 
	private String cancelReason;
	private String payment; //결제 타입
	private long taxIncludedPrice; 
	private long usedPnt;
	private long paidPrice;
	private String participantName;
	private String participantTel;
	

}
