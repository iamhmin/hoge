package com.hoge.dto;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import com.hoge.vo.accommo.AccommoImage;
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
public class MyTourListDto {

	private int no;
	private String name;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date checkIn;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date checkOut;
	private String roomName;
	private long price;
	private double xce;
	private double yce;
	private List<AccommoImage> accommoImages;
	private List<ActivityImage> activityImages;
	
}
