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
public class RoomBookingBatchDto {
	
	private int roomBookingNo;
	private int userNo;
	private Date checkOutDate;
	private int roomBookingStatus;
	private int roomNo;
	private long roomTaxIncludedPrice;
	private long roomPaidPrice;
	private int accommoNo;
	private int hostNo;
	private String GradeName;
	private double commissionRate;
	

}
