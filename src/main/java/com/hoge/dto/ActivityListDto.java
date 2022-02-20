package com.hoge.dto;

import java.util.List;

import com.hoge.vo.activities.ActivityImage;

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
public class ActivityListDto {

	private int no;
	private int availableNumber;
	private long pricePerPerson;
	private String name;
	private double star;
	private String regionDepth1;
	private String regionDepth2;
	private String introTitle;
	private double xce;
	private double yce;
	private List<ActivityImage> activityImages; 
}
