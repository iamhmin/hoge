package com.hoge.dto;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
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
public class AdminActivityReviewDto {
	
	private int no;
	private int userNo;
	private int hostNo;
	private int activityNo;
	private String activityName;
	
	private double star;
	
	
	private String content;
	@JsonFormat(pattern = "yyyy년 M월 d일")
	private Date createdDate;
	private String deleted;
	@JsonFormat(pattern = "yyyy년 M월 d일")
	private Date updatedDate;
	
	private String answered;
	private String answerContent;
	private String answerDeleted;
	
	@JsonFormat(pattern = "yyyy년 M월 d일")
	private String answerCreatedDate;
	

}
