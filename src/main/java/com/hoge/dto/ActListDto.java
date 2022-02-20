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
public class ActListDto {
	
	private String actName;
	private int actNo;
	private int hostingType;
	private String mainImage;
	private int hostNo;
	private String actIntroTitle;

}
