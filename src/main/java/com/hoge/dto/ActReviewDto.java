package com.hoge.dto;

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
public class ActReviewDto {
	
	private double average;
	
	private int total;
	private String content;
	private Date createdDate;
	
	private String userName;
	private String userImage;

}
