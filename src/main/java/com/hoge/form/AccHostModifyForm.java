package com.hoge.form;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

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
public class AccHostModifyForm {
	
	private int hostNo;
	private int hostingType; // 1. 시설 2.체험
	private String hostName;
	private String tel;
	private String accountHolderName;
	private String bankName;
	private int accountNumber;
	private MultipartFile hostMainImage;
	
	private String accNo;
	private String accType;
	private String accName;
	private String accWebAddress;
	private String accIntroTitle;
	private String accIntroContent;
	private String accAddress;
	private String accCheckInTime;
	private String accCheckOutime;
	
}
