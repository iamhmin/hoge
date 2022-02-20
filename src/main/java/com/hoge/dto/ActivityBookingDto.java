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
public class ActivityBookingDto {

	 private Date activityTime;
	 private int numberOfPeople;
	 private long paidPrice;
	 private Date bookingMadeDate;
	 private int no;
	 private int activityNo;
}
