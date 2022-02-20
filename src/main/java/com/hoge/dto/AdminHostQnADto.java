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
 * 
 * @author 성하민
 *
 */
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AdminHostQnADto {
	
	private int questionNo;
	private int userNo;
	private int hostNo;
	private String hostName;
	private String hostType;
	private String hostStatus;
	private String statusDetail;
	private String gradeName;
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
