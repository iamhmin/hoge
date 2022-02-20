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
public class AdminAccommoReviewDto {
	
	private int no;
	private int userNo;
	private int hostNo;
	private int accommoNo;
	private String accommoName;
	private String userName;
	
	private double cleanlinessStar;
	private double communicationStar;
	private double accuracyStar;
	private double locationStar;
	
	private String content;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date createdDate;
	private String deleted;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date updatedDate;
	
	private String answered;
	private String answerContent;
	private String answerDeleted;
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	private String answerCreatedDate;
	

}
