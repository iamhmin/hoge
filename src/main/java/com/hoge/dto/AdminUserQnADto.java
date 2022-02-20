package com.hoge.dto;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * sender와 reciever의 정보를 반환하는 dto
 * @author 성하민
 *
 */
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AdminUserQnADto {
	
	private int questionNo;
	private int userNo;
	private String userName;
	private String userId;
	private String category;
	private String title;
	private String content;
	private String answered;
	@JsonFormat(pattern = "yyyy년 M월 d일")
	private Date questionDate;
	private String answerContent;
	@JsonFormat(pattern = "yyyy년 M월 d일")
	private Date answerUpdateDate;
	private String answerModified; //답변 수정 여부
	

	

}
