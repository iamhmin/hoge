package com.hoge.form;

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
public class Criteria {

	private int no; //사용자: 성하민
	private String opt; //사용자: 성하민
	private String value; //사용자: 성하민
	private String opt1; //사용자: 성하민
	private String value1; //사용자: 성하민
	private String value2; //사용자: 성하민
	private String grade; //사용자: 성하민
	private String accommoType; //사용자: 성하민
	private String hostStatus; //사용자: 성하민
	private String grade1; //사용자: 성하민
	private String accommoType1; //사용자: 성하민
	private String hostStatus1; //사용자: 성하민
	private String grade2; //사용자: 성하민
	private String accommoType2; //사용자: 성하민
	private String hostStatus2; //사용자: 성하민
	private int hostNo; //사용자:성하민
	private String bookedDate; //사용자:성하민
	private String order; //사용자:성하민
	private String status; //사용자:성하민
	
	private int accNo; //사용자:유상효, 성하민
	private int actNo; //사용자:유상효, 성하민
	
	private String addressValue;
	private String opt2;
	
	private String checkInBoxValue;
	private String opt3;
	private String checkOutBoxValue;
	private String opt4;
	private String startDate; //성하민 관리자 매출관리
	private String endDate; //성하민 관리자 매출관리
	private String maxStandardNumberValue;
	private String checkInDate;
	private String checkOutDate;
	private int beginIndex;  //사용자: 성하민
	private int endIndex;  //사용자: 성하민
	
	// TODO: 이승준 추후에 동적으로 바꿔야함
	private String accommoType3;
	private String accommoType4;
}
