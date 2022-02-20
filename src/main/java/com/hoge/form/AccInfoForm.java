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
public class AccInfoForm {
	
	private int hostNo;
	private int hostingType;
	
	private int no;
	private String title;
	private int accommoNo;
	private int type;
	
	private int etcInfoNo;
	private int contentNo;
	private String content;

}
