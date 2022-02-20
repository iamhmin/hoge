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
public class MapArea {
	
	private String number;
	private String checkIn;
	private String checkOut;
	private String page;
	private String accommoType;
	private double swLat;
	private double swLng;
	private double neLat;
	private double neLng;

}
