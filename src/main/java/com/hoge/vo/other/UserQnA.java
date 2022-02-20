package com.hoge.vo.other;

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
public class UserQnA {

	private int no;
	private int userNo;
	private String category;
	private String title;
	private String content;
	private String answered;
	private Date questionDate;
	private String answerContent;
	private Date answerUpdateDate;
	private String answerModified; //답변 수정 여부
	
	
}
