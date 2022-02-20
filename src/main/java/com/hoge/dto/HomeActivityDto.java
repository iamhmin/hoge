package com.hoge.dto;

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
public class HomeActivityDto {
	
	private int promotionNo;
	private int activityNo;
	private String introContent;
	private String activityName;
	private int deadlineDate;
	private String depth1;
	private String depth2;
	private String mainImage;
}
