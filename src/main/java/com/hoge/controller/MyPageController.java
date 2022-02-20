package com.hoge.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.hoge.config.auth.LoginedUser;
import com.hoge.dto.AccListDto;
import com.hoge.dto.AccommoListDto;
import com.hoge.dto.ActListDto;
import com.hoge.dto.ChattingListDto;
import com.hoge.dto.ChattingMessageDto;
import com.hoge.dto.MyLoveDto;
import com.hoge.dto.UserRevInfoDto;
import com.hoge.form.UserUpdateForm;
import com.hoge.pagination.PaginationPerPage5;
import com.hoge.service.AdminTransactionService;
import com.hoge.service.ChatRoomService;
import com.hoge.service.HostService;
import com.hoge.service.QnAService;
import com.hoge.service.ReviewService;
import com.hoge.service.UserService;
import com.hoge.util.SessionUtils;
import com.hoge.vo.other.ChatRoom;
import com.hoge.vo.other.Message;
import com.hoge.vo.other.ReviewAccommo;
import com.hoge.vo.other.Transaction;
import com.hoge.vo.other.User;
import com.hoge.vo.other.UserQnA;

/**
 * 마이페이지 컨트롤러
 * @author 이승준, 성하민, 유상효
 *
 */
@Controller
@RequestMapping("/mypage")
public class MyPageController {
	
	static final Logger logger = LogManager.getLogger(AdminController.class);
	
	@Autowired
	private ChatRoomService chatRoomService;
	
	@Autowired
	private QnAService qnAService;
	
	@Autowired
	private HostService hostService;
	
	@Autowired
	private UserService userService;
	
	@Autowired 
	private ReviewService reviewService;
	
	@Autowired 
	private AdminTransactionService adminTransactionService;
	
	// 이승준: 마이페이지 예약정보 페이지로 리턴
	@GetMapping("/myrevlist")
	public String myRevListInit(@LoginedUser User savedUser, Model model) { 
		
		List<UserRevInfoDto> myRevList = userService.getMyRevListByNo(savedUser.getNo());
		if (!(myRevList.isEmpty())) {
			model.addAttribute("myRevList", myRevList);
		}
		
		int cnt = userService.getTourListCnt(savedUser.getNo());
		model.addAttribute("cnt", cnt);
			
		return "mypage/myRevList.mytiles";
	}
	
	// 이승준: 마이페이지 예약 취소정보 조회
	@GetMapping("/myrevlist/cancelrev")							
	public @ResponseBody UserRevInfoDto getRevInfoByBookingNo(@RequestParam(name = "roomBookingNo",required = false) int roomBookingNo) {
		
		UserRevInfoDto myRevInfoByBookingNo = userService.getRevInfoByBookingNo(roomBookingNo);
		
		return myRevInfoByBookingNo;
	}
	
	// 이승준: 마이페이지 예약 취소 진행
	@PostMapping("/myrevlist/cancelrev")							
	public String cancelMyRev(@LoginedUser User savedUser, int roomBookingNo, String cancelReason) {
		
		System.out.println(roomBookingNo);
		System.out.println(cancelReason);
		
		Transaction latestTransaction = adminTransactionService.getlatestTransaction(); // 가장 최근 트랜잭션
		long accumulatedMoney = latestTransaction.getAccumulatedMoney(); // 마지막 누적액
		
		userService.canceleReservation(savedUser, roomBookingNo, cancelReason, accumulatedMoney);
		
		return "redirect:/mypage/myrevlist";
	}
	
	@GetMapping("/myrevlist/updatereview")
	public String updateReview (@RequestParam(name = "cleanlinessStar") double cleanlinessStar,
								@RequestParam(name = "communicationStar") double communicationStar, 
								@RequestParam(name = "accuracyStar") double accuracyStar,
								@RequestParam(name = "locationStar") double locationStar,
								@RequestParam(name = "content") String content,
								@RequestParam(name = "no") int no) {
	
		ReviewAccommo accommoReviewInfo = new ReviewAccommo();
		accommoReviewInfo.setCleanlinessStar(cleanlinessStar);
		accommoReviewInfo.setCommunicationStar(communicationStar);
		accommoReviewInfo.setAccuracyStar(accuracyStar);
		accommoReviewInfo.setLocationStar(locationStar);
		accommoReviewInfo.setContent(content);
		accommoReviewInfo.setNo(no);
		
		reviewService.updateAccommReview(accommoReviewInfo);
		
		return "redirect:/mypage/myrevlist";
	}
	
	@GetMapping("/myrevlist/deletereview")
	public String deleteReview (@RequestParam(name = "cleanlinessStar") double cleanlinessStar,
								@RequestParam(name = "communicationStar") double communicationStar, 
								@RequestParam(name = "accuracyStar") double accuracyStar,
								@RequestParam(name = "locationStar") double locationStar,
								@RequestParam(name = "content") String content,
								@RequestParam(name = "no") int no) {
	
		ReviewAccommo accommoReviewInfo = new ReviewAccommo();
		accommoReviewInfo.setCleanlinessStar(cleanlinessStar);
		accommoReviewInfo.setCommunicationStar(communicationStar);
		accommoReviewInfo.setAccuracyStar(accuracyStar);
		accommoReviewInfo.setLocationStar(locationStar);
		accommoReviewInfo.setContent(content);
		accommoReviewInfo.setNo(no);
		accommoReviewInfo.setDeleted("Y");
		
		reviewService.updateAccommReview(accommoReviewInfo);
		
		return "redirect:/mypage/myrevlist";
    }
	
	@GetMapping("/myrevlist/insertreview")
	public String insertAccommoReview(@LoginedUser User savedUser, 
							 		  @RequestParam(name = "accommoNo") int accommoNo,
							 		  @RequestParam(name = "cleanlinessStar") double cleanlinessStar,
								      @RequestParam(name = "communicationStar") double communicationStar,
									  @RequestParam(name = "accuracyStar") double accuracyStar,
									  @RequestParam(name = "locationStar") double locationStar,
									  @RequestParam(name = "content") String content,
								      @RequestParam(name = "roomBookingNo") int roomBookingNo) {
		
		UserRevInfoDto revInfo = userService.getRevInfoByBookingNo(roomBookingNo);
		
		
		ReviewAccommo accommoReviewInfo = new ReviewAccommo();
			accommoReviewInfo.setUserNo(savedUser.getNo());
			accommoReviewInfo.setAccommoNo(accommoNo);
			accommoReviewInfo.setCleanlinessStar(cleanlinessStar);
			accommoReviewInfo.setCommunicationStar(communicationStar);
			accommoReviewInfo.setAccuracyStar(accuracyStar);
			accommoReviewInfo.setLocationStar(locationStar);
			accommoReviewInfo.setContent(content);
			accommoReviewInfo.setCheckInDate(revInfo.getCheckInDate());
			accommoReviewInfo.setCheckOutDate(revInfo.getCheckOutDate());
			accommoReviewInfo.setRoomNo(revInfo.getRoomNo());
		
		reviewService.insertAccommoReview(accommoReviewInfo);
		
		return "redirect:/mypage/myrevlist";
	}
	
	// 이승준: 마이페이지 위시리스트 리턴
	@GetMapping("/mylovelist")
	public String myLoveListInit(@LoginedUser User savedUser, Model model) { 
		
		List<AccommoListDto> myLoveList = userService.getMyLoveList(savedUser.getNo()); 
		
		for (AccommoListDto myLovePage : myLoveList) {
			
			MyLoveDto myLoveDto = new MyLoveDto();
			myLoveDto.setUserNo(savedUser.getNo());
			myLoveDto.setAccommoNo(myLovePage.getNo());
			
			int cnt = userService.getMyLoveListCnt(myLoveDto);
			myLovePage.setCnt(cnt);
		}
		
		if (!(myLoveList.isEmpty())) {
			model.addAttribute("myLoveList", myLoveList);
		}
		
		return "mypage/myLoveList.mytiles";
	}
	
	// 염주환: 마이페이지 다녀온페이지 리턴
	@GetMapping("/mytourlist")
	public String myTourListInit() { 
		
		return "mypage/myTourList.mytiles";
	}
	
	// 이승준: 회원정보 업데이트 페이지 리턴
	@GetMapping("/userupdate")
	public String userUpdateInit() {
		
		return "mypage/userUpdate.mytiles";
	}
	
	// 이승준: 회원 기본정보 업데이트
	@PostMapping("/userupdate")
	public String userUpdate(UserUpdateForm form) throws IOException {
		
		User savedUser = (User) SessionUtils.getAttribute("LOGIN_USER");
		savedUser.setName(form.getName());
		savedUser.setEmail(form.getEmail());
		savedUser.setTel(form.getTel());
		
		String saveDirectory = "C:\\final-workspace\\finalproject-chanel5\\src\\main\\webapp\\resources\\images\\userprofiles";
		MultipartFile myProfile = form.getMyProfile();
	    System.out.println(myProfile);
		if (myProfile != null) {		
			String fileName = myProfile.getOriginalFilename();
			savedUser.setImage(fileName);
			InputStream in = myProfile.getInputStream();
			FileOutputStream out = new FileOutputStream(new File(saveDirectory, fileName));
			FileCopyUtils.copy(in, out);
		} 
		
		userService.updateUser(savedUser);
		
		return "mypage/userUpdate.mytiles";
	}
	
	// 이승준: 회원탈퇴
	@PostMapping("/userdelete")
	public String deleteUser(String pwd) {
		
		userService.deleteUser(pwd);
		
		SessionUtils.sessionInvlidate();
		
		return "redirect:../home";
	}
	
	// 이승준: 회원 비밀번호 업데이트
	@PostMapping("/userpwdupdate")
	public String userPwdUpdate(String changePwd) {
		
		User savedUser = (User) SessionUtils.getAttribute("LOGIN_USER");
		String authPwd = DigestUtils.sha512Hex(changePwd);
		savedUser.setPwd(authPwd);
		userService.userPwdUpdate(savedUser);
		
		SessionUtils.sessionInvlidate();
		
		return "redirect:../login";
	}
	
	//성하민
	@GetMapping("/chat")
	public @ResponseBody HashMap<String, Object> chat(@RequestParam(name = "no",required = false) int no) {
		HashMap<String, Object> result = new HashMap<>();
		System.out.println(no);
		List<ChattingListDto> chatList = chatRoomService.getChattingListDtobyUserNo(no);
		
		String chatListString = Integer.toString(chatList.get(0).getChatRoomNo());
		
		for (int i = 1; i<chatList.size(); i++) {
			chatListString += ","+ Integer.toString(chatList.get(i).getChatRoomNo());
			
		}
		System.out.println(chatListString);
		result.put("chatList", chatList);
		
		result.put("chatListString", chatListString);
		return result;
	}
	
	//성하민
	@GetMapping("/chatListString.do'")
	public @ResponseBody String chatListString(@RequestParam(name = "no",required = false) int no) {
		System.out.println("들어왔음");
		
//		List<ChattingListDto> chatList = chatRoomService.getChattingListDtobyUserNo(no);
//		String chatListString = Integer.toString(chatList.get(0).getChatRoomNo());
//		
//		for (int i = 1; i<chatList.size(); i++) {
//			chatListString += ","+ Integer.toString(chatList.get(i).getChatRoomNo());
//			
//		}
//		System.out.println(chatListString);
		String result = "헤헤";
		return result;
	}
	
	//성하민
	@GetMapping("/chat-enter.do")							// 요청핸들러 메소드에 @ResponseBody를 붙인다.
	public @ResponseBody List<ChattingMessageDto> enter(@RequestParam(name = "no",required = false) int no) {
		System.out.println("백으로 들어온 방번호:" +no);
		List<ChattingMessageDto> msgList = chatRoomService.getMessagesByChatRoomNo(no);
		
		System.out.println(msgList);
		return msgList;
	}
		
	//성하민
		@GetMapping("/qna")
		public ModelAndView qna(String page, ModelAndView mv) {
			mv.setViewName("mypage/qna.mytiles");
			
			User user = (User) SessionUtils.getAttribute("LOGIN_USER");
			
			int totalRecords = qnAService.getUserQnACountByUserNo(user.getNo());
					// 현재 페이지번호와 총 데이터 갯수를 전달해서 페이징 처리에 필요한 정보를 제공하는 Pagination객체 생성
			
			
			PaginationPerPage5 pagination = new PaginationPerPage5(page, totalRecords);
					
			int begin = pagination.getBegin();
			int end = pagination.getEnd();

			
			List<UserQnA> qnaList = qnAService.getUserQnAListByUserNo(user.getNo(), begin, end);
			mv.addObject("qnaList", qnaList);
			mv.addObject("pagination", pagination);
			mv.addObject("totalRecords", totalRecords);
		
			return mv;
		}
		

		@PostMapping("/qna-insert.do")
		public String save(UserQnA userQnA) throws IOException {
			System.out.println(userQnA.getNo() +"유저넘버:" + userQnA.getUserNo());
			qnAService.insertUserQnA(userQnA);
			
			return "redirect:qna";
		}
			
	
		
		@PostMapping("/checkMessage")
		public void checkMessage(@RequestBody ChatRoom chatRoom) throws IOException {
			User savedUser = (User) SessionUtils.getAttribute("LOGIN_USER");
			int chatRoomNo = chatRoom.getNo();
			System.out.println("읽음처리:"+chatRoomNo);
			chatRoomService.changeMypageUnreadToZero(chatRoomNo, savedUser.getNo());
		}
		
		@PostMapping("/message.do")
		public void save(@RequestBody Message message) throws IOException {
			
			System.out.println(message);
			
			chatRoomService.insertMessage(message); //새로운 메시지 삽입
			
			ChatRoom chatRoom = chatRoomService.getChatRoomByChatRoomNo(message.getChatRoomNo()); //방번호로 채팅방 가져옴
			
			chatRoom.setLastMessage(message.getContent()); //채팅방의 마지막 메시지를 새로운 메시지로 삽입
			chatRoom.setLastMessageSenderNo(message.getSendingUserNo());
			chatRoom.setLastMessageChecked(message.getChecked());
			chatRoom.setHostUnreadCount(chatRoom.getHostUnreadCount()+1);
			
			chatRoomService.updateChatRoom(chatRoom); //채팅방 업데이트
		}
		
		// 유상효 호스팅리스트페이지(호스트마이페이지) 호출
		@GetMapping("/hostingList")
		public String hostingList(Model model) {
			User user = (User) SessionUtils.getAttribute("LOGIN_USER"); // 로그인 세션으로 유저정보 불러오기
		    //int userNo = hostService.getUserNoByUserId(user.getId());
			
			List<AccListDto> accDto = hostService.getAccListByUserNo(user.getNo());
			model.addAttribute("accListDto", accDto);
			
			List<ActListDto> actDto = hostService.getActListByUserNo( user.getNo());
			model.addAttribute("actListDto", actDto);
			
			
			return "/mypage/hostingList.tiles";
		}
		
		
}
