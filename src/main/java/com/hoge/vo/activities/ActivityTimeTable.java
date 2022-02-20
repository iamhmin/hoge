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
public class ActivityTimeTable {

	private int no;
	private int activityNo;
	private Date time;
	private int soFarBookedNumberOfPeople;
	private String closed; //체험 마감 여부
	
	
}
