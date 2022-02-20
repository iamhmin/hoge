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
public class ActHostModifyForm {
	
	private int hostNo;
	private int hostingType; // 1. 시설 2.체험
	private String hostName;
	private String tel;
	private String accountHolderName;
	private String bankName;
	private int accountNumber;
	private MultipartFile hostMainImage;
	
	private int actNo;
	private String actName;
	private String actIntroTitle;
	private String actIntroContent;
	private int actMaximumNumber;
	private int actPricePerPerson;
	private String actAddress;

}
