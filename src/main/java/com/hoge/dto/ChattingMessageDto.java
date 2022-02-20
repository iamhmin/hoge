package com.hoge.dto;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * sender와 reciever의 정보를 반환하는 dto
 * @author 성하민
 *
 */
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChattingMessageDto {
	
	private int chatRoomNo;
	private int hostNo;
	private int hostingUserNo;
	private String hostName;
	private String hostImage;
	
	private int hostingType; // 1. 시설 2.체험
	private String tel;
	private String gradeName;
	
	private int sendingUserNo;
	private String sendingUserName;
	private String sendingUserImage;
	
	private String content;
	private String checked; //확인 여부
	@JsonFormat(pattern = "yyyy.MM.dd hh:mm")
	private Date sendingDate;

}
