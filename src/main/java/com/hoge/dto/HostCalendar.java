package com.hoge.dto;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

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
public class HostCalendar {
	
	private String title;
	private String backgroundcolor;
	private String textColor;
	private String bordercolor;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date start;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date end;
}
