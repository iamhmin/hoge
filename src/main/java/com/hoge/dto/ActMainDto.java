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
public class ActMainDto {
	
	private int hostNo;
	private int hostingType;
	private String hostName;
	private String tel;
	private String accountHolderName;
	private String bankName;
	private int accountNumber;
	private String mainImage;
	
	private int actNo;
	private String actName;
	private String actIntroTitle;
	private String actIntroContent;
	private int actMaximumNumber;
	private int actPricePerPerson;
	private String actAddress;
	private String dept1;
	private String dept2;
	private String amenity;
	private String feature;
	
	private String infoTitle1;
	private String infoContent1;
	
	private String infoTitle2;
	private String infoContent2;
	
	private String infoTitle3;
	private String infoContent3;

}
