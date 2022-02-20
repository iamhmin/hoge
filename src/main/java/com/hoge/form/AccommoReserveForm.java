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
public class AccommoReserveForm {
	
	private int roomNo;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date checkInDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date checkOutDate;
	private String payment;
	private long taxIncludedPrice; 
	private long usedPnt;
	private long paidPrice;
	private String roomUserName;
	private String roomUserTel;
	private int extraPeople;
	private String tid;

}
