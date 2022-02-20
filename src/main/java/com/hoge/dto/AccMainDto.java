package com.hoge.dto;

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
public class AccMainDto {
	
	private int hostNo;
	private int hostingType;
	private String hostName;
	private String tel;
	private String accountHolderName;
	private String bankName;
	private int accountNumber;
	private String mainImage;
	
	private int accNo;
	private String accType;
	private String accName;
	private String accWebAddress;
	private String accIntroTitle;
	private String accIntroContent;
	private String accAddress;
	private String accCheckInTime;
	private String accCheckOutime;
	private String dept1;
	private String dept2;
	
}
