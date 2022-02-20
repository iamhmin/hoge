package com.hoge.form;

import java.util.Date;

import com.hoge.vo.accommo.Accommodation;

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
public class CriteriaAdminQnA {

	private String answered;
	private String category;
	private String grade;
	private String approval;
	private int hostType;
	private String opt;
	private String value;
	private int beginIndex;
	private int endIndex;
	

	
}
