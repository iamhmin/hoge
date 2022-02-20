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
public class ChatRoom {

	private int no;
	private int hostNo;
	private int userNo;
	private Date updatedDate;
	private String lastMessage;
	private int lastMessageSenderNo;
	private int userUnreadCount;
	private int hostUnreadCount;
	private String lastMessageChecked;
	
}
