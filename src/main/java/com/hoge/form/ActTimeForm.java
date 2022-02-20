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
public class ActTimeForm {
	
	private int no;
	private int hostNo;
	private int hostingType;
	private int activityNo;
	private String inputTime;
	private String date;
	private String time;

}
