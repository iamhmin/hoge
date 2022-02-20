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
public class RoomBookingDto {
	
	private int hostNo;
	private int hostingType;
	private int no;
	private int roomBookingStatus;
	private String roomBookingName;
	private String roomBookingTel;
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
	private Date bookedDate;
	private int extraPeople; 
	
}
