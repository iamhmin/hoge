package com.hoge.dto;

import java.util.List;

import com.hoge.vo.accommo.RoomImage;

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
public class RoomListDto {
	
	private int no;
	private int accommoNo;
	private String name;
	private long weekdaysPrice;
	private long weekendPrice;
	private long peakSeasonPrice;
	private int standardNumber;
	private int maximumNumber;
	private long pricePerPerson;
	private String amenity;
	private String feature;
	private List<RoomImage> roomImages;
	
	private String infoTitle1;
	private String infoContent1;
	
	private String infoTitle2;
	private String infoContent2;
}
