package com.hoge.vo.other;

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
public class Transaction {
	
	private int no;
	private String type;
	private long amount;
	private int toHostNo;
	private int toUserNo;
	private int accommoBookingNo;
	private int activityBookingNo;
	@JsonFormat(pattern = "yyyy년 M월 d일")
	private Date createdDate;
	private long accumulatedMoney;
	
	

}
