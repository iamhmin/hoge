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
public class HostApplyForm {
	
	// first 호스트
	private int hostingType; // 1. 시설 2.체험
	private String hostName;
	private String tel;
	private String accountHolderName;
	private String bankName;
	private int accountNumber;
	private MultipartFile hostMainImage;
	
	// second 숙소
	private String accType;
	private String accName;
	private String accWebAddress;
	private String accIntroTitle;
	private String accIntroContent;
	private String accMainAddress;
	private String accDetailAddress;
	private String accCheckInTime;
	private String accCheckOutime;
	
	private String accRegionDepth1;
	private String accRegionDepth2;
	private String accRregionDepth3;
	
	// 숙소 사진
	private List<MultipartFile> accImages;
	
	// third 체험
	private String actName;
	private String actIntroTitle;
	private String actIntroContent;
	private int actMaximumNumber;
	private int actPricePerPerson;
	private String actMainAddress;
	private String actDetailAddress;
	
	private String actRegionDepth1;
	private String actRegionDepth2;
	private String actRegionDepth3;
	
	// 체험 사진
	private List<MultipartFile> actImages;
	
	private int userNo;

	// 염주환 좌표
	private double xce;
	private double yce;

}