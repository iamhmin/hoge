package com.hoge.vo.other;

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
public class Message {

	private int chatRoomNo;
	private int sendingUserNo;
	private String content;
	private String checked; //확인 여부
	private Date sendingDate;
	
}
