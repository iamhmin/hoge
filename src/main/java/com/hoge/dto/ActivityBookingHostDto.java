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
public class ActivityBookingHostDto {

	private int no;
	private int activityTimeNo;
	@JsonFormat(pattern = "yyyy-MM-dd hh:mm")
	private Date activityTime;
	private int userNo;
	private String userName;
	private int numberOfPeople;
	private int status;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date bookingMadeDate; 
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date canceledDate; 
	private String cancelReason;
	private String payment; //결제 타입
	private String participantName;
	private String participantTel;
	

}
