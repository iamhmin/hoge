package com.hoge.vo.accommo;

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
public class RoomBooking {

	private int no;
	private int roomNo;
	private String roomName;
	private int userNo;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date checkInDate; 
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date checkOutDate;
	private int status;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date bookingMadeDate; 
	private Date canceledDate; 
	private String cancelReason;
	private String payment; //결제 타입
	private long taxIncludedPrice; 
	private long usedPnt;
	private long paidPrice;
	private String roomUserName;
	private String roomUserTel;
	private int extraPeople; //초과 인원 수
	private String TID;
	private String accommoName;
	

}
