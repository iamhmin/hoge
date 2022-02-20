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
public class ReserveAccommoDto {
	
	private int no;
	private int hostNo;
	private String accommoName;
	private int roomNo;
	private String roomName;
	private int standardNumber;
	private int maximumNumber;

}
