package com.hoge.vo.activities;

import java.util.Date;
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
public class Activity {

	private int no;
	private int hostNo;
	private String name;
	private String introTitle;
	private String introContent;
	private int maximumNumber;
	private long pricePerPerson;
	private double star;
	private String address;
	private String regionDepth1;
	private String regionDepth2;
	private String regionDepth3;
	private double xce;
	private double yce;
	private Date registeredDate;

}
