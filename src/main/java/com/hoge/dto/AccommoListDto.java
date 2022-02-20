package com.hoge.dto;

import java.util.List;

import com.hoge.vo.accommo.AccommoImage;

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
public class AccommoListDto {
	
	private int no;
	private int hostNo;
	private String type;
	private String name;
	private double cleanlinessStar;
	private double communicationStar;
	private double accuracyStar;
	private double locationStar;
	private String address;
	private String regionDepth1;
	private String regionDepth2;
	private String regionDepth3;
	private double xce;
	private double yce;
	private long minWeekdaysPrice;
	private long maxWeekdaysPrice;
	private long minWeekendPrice;
	private long maxWeekendPrice;
	private long minPeakSeasonPrice;
	private long maxPeakSeasonPrice;
	private long minNumber;
	private long maxNumber;
	private List<AccommoImage> accommoImages;
	private int cnt;

}
