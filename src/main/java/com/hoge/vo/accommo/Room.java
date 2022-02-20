package com.hoge.vo.accommo;

import java.util.List;

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
public class Room {

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
	
}
