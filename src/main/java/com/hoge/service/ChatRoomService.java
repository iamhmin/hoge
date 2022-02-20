package com.hoge.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hoge.dto.ChattingListDto;
import com.hoge.dto.ChattingMessageDto;
import com.hoge.mapper.ChatRoomMapper;
import com.hoge.vo.other.ChatRoom;
import com.hoge.vo.other.Message;

/**
 * ChatRoom관련 로직
 * @author 성하민
 *
 */
@Service
public class ChatRoomService {
	
	@Autowired
	private ChatRoomMapper chatRoomMapper;
	
	//성하민
	public List<ChatRoom> getChatRoomsbyUserNo(int no) {
		
		//게스트 유저 번호로 chatroom 조회, 마이페이지 채팅구현 
		return chatRoomMapper.getChatRoomsbyUserNo(no);
	}
	
	//성하민
	public List<ChatRoom> getChatRoomsbyHostNo(int no) {
		//호스트 번호로 chatroom 조회, 호스프 페이지 채팅 구현
		return chatRoomMapper.getChatRoomsbyHostNo(no);
	}
	
	
	//성하민
	public List<ChattingMessageDto> getMessagesByChatRoomNo(int no){
		return chatRoomMapper.getMessagesByChatRoomNo(no);
	}
	
	

	//성하민
	public List<ChattingListDto> getChattingListDtobyHostNo(int no) {
		return chatRoomMapper.getChattingListDtobyHostNo(no);
	}
	// //호스트 번호로 chatroom 조회, 호스프 페이지 채팅 구현
	
	
	//성하민
	public List<ChattingListDto> getChattingListDtobyUserNo(int no) {
		return chatRoomMapper.getChattingListDtobyUserNo(no);
	}
	// //호스트 번호로 chatroom 조회, 마이 페이지 채팅 구현
	
	
	public void insertMessage(Message message) {
		chatRoomMapper.insertMessage(message);
	}
	
	
	
	public void updateChatRoom(ChatRoom chatRoom) {
		chatRoomMapper.updateChatRoom(chatRoom);
	}
	
	public ChatRoom getChatRoomByChatRoomNo(int no) {
		return chatRoomMapper.getChatRoomByChatRoomNo(no);
		
	}
	
	//마이페이지에서 로그인유저가 속한 채팅방에서 유저가 보낸 메시지를 제외하고 메시지를 전부 읽음처리 하는 메소드
	public void changeMypageUnreadToZero(int chatRoomNo, int userNo) {
		chatRoomMapper.updateMessages(chatRoomNo, userNo); //메시지 읽음처리
		
		ChatRoom chatRoom = chatRoomMapper.getChatRoomByChatRoomNo(chatRoomNo);
		chatRoom.setUserUnreadCount(0);
		System.out.println("바뀐카운트:" + chatRoom);
		chatRoomMapper.updateChatRoomCount(chatRoom);
		
	}
	
	public void changeHostPageUnreadToZero(int chatRoomNo, int userNo) {
		System.out.println("읽음처리중..."+chatRoomNo+userNo+"들어옴");
		chatRoomMapper.updateMessages(chatRoomNo, userNo); //메시지 읽음처리
		
		ChatRoom chatRoom = chatRoomMapper.getChatRoomByChatRoomNo(chatRoomNo);
		chatRoom.setHostUnreadCount(0);
		System.out.println("바뀐카운트:" + chatRoom);
		chatRoomMapper.updateChatRoomCount(chatRoom);
		
	}
	

	public void insertChatRoom(ChatRoom chatRoom) {
		chatRoomMapper.insertChatRoom(chatRoom);
		
	}
	
	
	
}
