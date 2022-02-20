package com.hoge.dto;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.hoge.vo.accommo.AccommoImage;
import com.hoge.vo.other.ReviewAccommo;

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
public class UserRevInfoDto {
	private int userNo;
	private String roomUserName;
	private String roomUserTel;
	private int extraPeople; //초과 인원 수
	
	private int roomBookingNo;
	private int roomBookingStatus;
	private int accommoNo;
    private String accommoName;
    private int roomNo;
    private String roomName;
    private String accommoRegionDepth1;
    private String accommoRegionDepth2;
    
    @JsonFormat(pattern = "yyyy-MM-dd")
	private Date checkInDate; 
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date checkOutDate;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date bookingMadeDate;
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date canceledDate; 
	private String cancelReason;
	private String payment; //결제 타입
	private long roomTaxIncludedPrice;
	private long usedPnt;
	private long paidPrice;
	
    private List<AccommoImage> accommoImages;
    
    private int reviewStatus;
    private ReviewAccommo myReview;
    
	
	 
	
}