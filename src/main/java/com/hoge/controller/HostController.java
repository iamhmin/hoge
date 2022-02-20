package com.hoge.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Random;
import java.util.StringTokenizer;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import com.hoge.config.auth.LoginedUser;
import com.hoge.dto.AccMainDto;
import com.hoge.dto.ActListDto;
import com.hoge.dto.ActMainDto;
import com.hoge.dto.ActivityBookingHostDto;
import com.hoge.dto.AdminAccommoReviewDto;
import com.hoge.dto.AdminActivityReviewDto;
import com.hoge.dto.ChattingListDto;
import com.hoge.dto.ChattingMessageDto;
import com.hoge.dto.HostCalendar;
import com.hoge.dto.LabelDataDto;
import com.hoge.dto.RoomBookingDto;
import com.hoge.dto.RoomDto;
import com.hoge.dto.RoomListDto;
import com.hoge.form.AccHostModifyForm;
import com.hoge.form.AccInfoForm;
import com.hoge.form.ActHostModifyForm;
import com.hoge.form.Criteria;
import com.hoge.form.HostApplyForm;
import com.hoge.form.InsertRoomForm;
import com.hoge.form.ModifyPromotionDiscountForm;
import com.hoge.form.ModifyPromotionOfferForm;
import com.hoge.form.PromotionDiscountForm;
import com.hoge.form.PromotionOfferForm;
import com.hoge.form.RoomModifyForm;
import com.hoge.mapper.HostMapper;
import com.hoge.pagination.Pagination;
import com.hoge.pagination.PaginationPerPage5;
import com.hoge.service.AccommodationService;
import com.hoge.service.ActivityService;
import com.hoge.service.ChatRoomService;
import com.hoge.service.QnAService;
import com.hoge.service.ReviewService;
import com.hoge.service.StatisticsService;
import com.hoge.service.HostService;
import com.hoge.service.HostTransactionService;
import com.hoge.util.SessionUtils;
import com.hoge.vo.accommo.AccommoEtcInfo;
import com.hoge.vo.accommo.AccommoImage;
import com.hoge.vo.accommo.Accommodation;
import com.hoge.vo.accommo.Room;
import com.hoge.vo.accommo.RoomBooking;
import com.hoge.vo.accommo.RoomImage;
import com.hoge.vo.activities.Activity;
import com.hoge.vo.activities.ActivityImage;
import com.hoge.vo.activities.ActivityTimeTable;
import com.hoge.vo.other.ChatRoom;
import com.hoge.vo.other.Host;
import com.hoge.vo.other.HostQnA;
import com.hoge.vo.other.HostTransaction;
import com.hoge.vo.other.Message;
import com.hoge.vo.other.PromotionDiscount;
import com.hoge.vo.other.PromotionOffer;
import com.hoge.vo.other.ReviewAccommo;
import com.hoge.vo.other.User;
import com.hoge.vo.other.Withdrawal;

@Controller
@RequestMapping("/host")
public class HostController {
	
	@Autowired
	private HostService hostService;
	
	@Autowired
	private ChatRoomService chatRoomService;
	
	@Autowired
	private QnAService hostQnAService;
	
	@Autowired
	private HostTransactionService hostTransactionService;
	
	@Autowired
	private AccommodationService accommodationService;
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private ActivityService activityService;
	
	@Autowired
	private StatisticsService statisticsService;
	
	static final Logger logger = LogManager.getLogger(HostController.class);
	
	//성하민
		@GetMapping("/dailyHostSalesGraph")							// 요청핸들러 메소드에 @ResponseBody를 붙인다.
		public @ResponseBody List<LabelDataDto> getUserNumberGraph(@RequestParam String hostNo) {
			int no = Integer.parseInt(hostNo);
			List<LabelDataDto> result = statisticsService.getSalesPerDayByHostNo(no);
			logger.info("결과값:" + result);
			return result;
		}
		//성하민
		@GetMapping("/hostCalendar.do")							// 요청핸들러 메소드에 @ResponseBody를 붙인다.
		public @ResponseBody List<HostCalendar> gethostCalendar(@RequestParam int hostNo) {
			List<RoomBooking> bookings = hostService.getRoomBookingByHostNo(hostNo);
			List<HostCalendar> bookingList = new ArrayList<>();
			Random randomGenerator = new Random();
			if (bookings != null) {
				for(RoomBooking booking : bookings) {
					HostCalendar hostCalendar = new HostCalendar();
					int red = randomGenerator.nextInt(256);
					int green = randomGenerator.nextInt(256);
					int blue = randomGenerator.nextInt(256);
					// rgba(215, 215, 215, 0.3);
					String color = "rgba("+red+", "+green+","+blue+", 0.2)";
					String borderColor = "rgba("+red+", "+green+","+blue+", 1)";
					
					
					hostCalendar.setBackgroundcolor(color);
					hostCalendar.setTextColor("black");
					hostCalendar.setBordercolor(borderColor);
					hostCalendar.setTitle(booking.getRoomName()+"-"+booking.getRoomUserName()+" ("+booking.getRoomUserTel()+") 추가인원: "+booking.getExtraPeople()+"명");
					hostCalendar.setStart(booking.getCheckInDate());
					hostCalendar.setEnd(booking.getCheckOutDate());
					
					bookingList.add(hostCalendar);
				}
			}
			
			
			logger.info("결과값:" + bookingList);
			return bookingList;
		}
	
	
	//성하민
		@PostMapping(value = "/transactionList.do", produces = "application/json")
		public @ResponseBody HashMap<String, Object> getwithdrawalList(@RequestParam(name = "page", required = false, defaultValue="1") String page, 
				String hostNo) throws Exception {
			
			
			logger.info("페이지 :" + page);
			HashMap<String, Object> result = new HashMap<>();
			// 검색조건에 해당하는 총 데이터 갯수 조회
			int currentHostNo = Integer.parseInt(hostNo);
			int totalRecords = hostTransactionService.getHostTransactionCountByHostNo(currentHostNo);
			logger.info("토탈레코드 :" + totalRecords);
			// 현재 페이지번호와 총 데이터 갯수를 전달해서 페이징 처리에 필요한 정보를 제공하는 Pagination객체 생성
			Pagination pagination = new Pagination(page, totalRecords);
			
			int begin = pagination.getBegin();
			int end = pagination.getEnd();

			// 요청한 페이지에 대한 조회범위를 criteria에 저장
			
		
			List<HostTransaction> list = hostTransactionService.getHostTransactionByHostNo(currentHostNo, begin, end);
			
			logger.info("디티오 :" + list);
			logger.info("페이지네이션 :" + pagination);
			
			// 페이징
			result.put("pagination", pagination);
			
			// 게시글 화면 출력
			result.put("list", list);
			
			return result;
		}
		//성하민
		@PostMapping(value = "/getMainAccReviewList.do", produces = "application/json")
		public @ResponseBody HashMap<String, Object> getMainAccReviewList(@RequestParam(name = "page", required = false, defaultValue="1")
		String page, Criteria criteria) throws Exception {
			
			
			logger.info("페이지 :" + page);
			HashMap<String, Object> result = new HashMap<>();
			
			int totalRecords = reviewService.getRecentReviewCountByAccommoNo(criteria.getNo());
			logger.info("토탈레코드 :" + totalRecords);
			// 현재 페이지번호와 총 데이터 갯수를 전달해서 페이징 처리에 필요한 정보를 제공하는 Pagination객체 생성
			PaginationPerPage5 pagination = new PaginationPerPage5(page, totalRecords);
			
			criteria.setBeginIndex(pagination.getBegin());
			criteria.setEndIndex(pagination.getEnd());
			
			List<AdminAccommoReviewDto> list = reviewService.getRecentReviewListByAccommoNo(criteria);
			
			logger.info("디티오 :" + list);
			logger.info("페이지네이션 :" + pagination);
			
			// 페이징
			result.put("pagination", pagination);
			
			// 게시글 화면 출력
			result.put("list", list);
			
			return result;
		}
		//성하민
		@PostMapping(value = "/getMainActReviewList.do", produces = "application/json")
		public @ResponseBody HashMap<String, Object> getMainActReviewList(@RequestParam(name = "page", required = false, defaultValue="1")
		String page, Criteria criteria) throws Exception {
			
			
			logger.info("페이지 :" + page);
			HashMap<String, Object> result = new HashMap<>();
			
			int totalRecords = reviewService.getRecentReviewCountByActivityNo(criteria.getNo());
			logger.info("토탈레코드 :" + totalRecords);
			// 현재 페이지번호와 총 데이터 갯수를 전달해서 페이징 처리에 필요한 정보를 제공하는 Pagination객체 생성
			PaginationPerPage5 pagination = new PaginationPerPage5(page, totalRecords);
			
			criteria.setBeginIndex(pagination.getBegin());
			criteria.setEndIndex(pagination.getEnd());
			
			List<AdminActivityReviewDto> list = reviewService.getRecentReviewListByActivityNo(criteria);
			
			logger.info("디티오 :" + list);
			logger.info("페이지네이션 :" + pagination);
			
			// 페이징
			result.put("pagination", pagination);
			
			// 게시글 화면 출력
			result.put("list", list);
			
			return result;
		}
	
		//성하민
		@PostMapping(value = "/getMainBookingList.do", produces = "application/json")
		public @ResponseBody HashMap<String, Object> getMainBookingList(@RequestParam(name = "page", required = false, defaultValue="1") String page, Criteria criteria) throws Exception {
			
			
			logger.info("페이지 :" + page);
			HashMap<String, Object> result = new HashMap<>();
			
			int totalRecords = hostService.getRecentBookingCountByAccommoNo(criteria.getNo());
			logger.info("토탈레코드 :" + totalRecords);
			// 현재 페이지번호와 총 데이터 갯수를 전달해서 페이징 처리에 필요한 정보를 제공하는 Pagination객체 생성
			PaginationPerPage5 pagination = new PaginationPerPage5(page, totalRecords);
			
			criteria.setBeginIndex(pagination.getBegin());
			criteria.setEndIndex(pagination.getEnd());
			
			
			
			List<RoomBooking> list = hostService.getRecentBookingListByAccommoNo(criteria);
			
			logger.info("디티오 :" + list);
			logger.info("페이지네이션 :" + pagination);
			
			// 페이징
			result.put("pagination", pagination);
			
			// 게시글 화면 출력
			result.put("list", list);
			
			return result;
		}
		//성하민
		@PostMapping(value = "/getMainActBookingList.do", produces = "application/json")
		public @ResponseBody HashMap<String, Object> getMainActBookingList(@RequestParam(name = "page", required = false, defaultValue="1") String page, Criteria criteria) throws Exception {
			
			
			logger.info("페이지 :" + page);
			HashMap<String, Object> result = new HashMap<>();
			
			int totalRecords = activityService.getRecentBookingCountByActivityNo(criteria.getNo());
			logger.info("토탈레코드 :" + totalRecords);
			// 현재 페이지번호와 총 데이터 갯수를 전달해서 페이징 처리에 필요한 정보를 제공하는 Pagination객체 생성
			PaginationPerPage5 pagination = new PaginationPerPage5(page, totalRecords);
			
			criteria.setBeginIndex(pagination.getBegin());
			criteria.setEndIndex(pagination.getEnd());
			
			
			
			List<ActivityBookingHostDto> list = activityService.getRecentBookingListByActivityNo(criteria);
			
			logger.info("디티오 :" + list);
			logger.info("페이지네이션 :" + pagination);
			
			// 페이징
			result.put("pagination", pagination);
			
			// 게시글 화면 출력
			result.put("list", list);
			
			return result;
		}
		
		@PostMapping(value = "/withdrawalList.do", produces = "application/json")
		public @ResponseBody HashMap<String, Object> TransactionList(@RequestParam(name = "page", required = false, defaultValue="1") String page, String hostNo) throws Exception {
			
			
			logger.info("페이지 :" + page);
			HashMap<String, Object> result = new HashMap<>();
			// 검색조건에 해당하는 총 데이터 갯수 조회
			int currentHostNo = Integer.parseInt(hostNo);
			int totalRecords = hostService.getWithdrawalCountByHostNo(currentHostNo);
			logger.info("토탈레코드 :" + totalRecords);
			// 현재 페이지번호와 총 데이터 갯수를 전달해서 페이징 처리에 필요한 정보를 제공하는 Pagination객체 생성
			PaginationPerPage5 pagination = new PaginationPerPage5(page, totalRecords);
			
			int begin = pagination.getBegin();
			int end = pagination.getEnd();
			
			// 요청한 페이지에 대한 조회범위를 criteria에 저장
			List<Withdrawal> list = hostService.getHostWithdrawalListByHostNo(currentHostNo, begin, end);
			
			logger.info("디티오 :" + list);
			logger.info("페이지네이션 :" + pagination);
			
			// 페이징
			result.put("pagination", pagination);
			
			// 게시글 화면 출력
			result.put("list", list);
			
			return result;
		}
		
		@PostMapping(value = "/get-room-info.do", produces = "application/json")
		public @ResponseBody HashMap<String, Object> bookingList(@RequestBody Criteria criteria) throws Exception {
			
			
			List<RoomDto> availableRoomList = hostService.getAvailableRoomInfo(criteria);
			List<RoomBookingDto> bookedRoomList = hostService.getBookedRoomInfo(criteria);
			HashMap<String, Object> result = new HashMap<>();
			// 페이징
			result.put("availableRoomList", availableRoomList);
			
			// 게시글 화면 출력
			result.put("bookedRoomList", bookedRoomList);
			
			return result;
		}
		
	
	
	

	@PostMapping("/message.do")
	public void save(@RequestBody Message message) throws IOException {
		
		System.out.println("프론트에서 넘어온 메시지:" +message);
		
		chatRoomService.insertMessage(message); //새로운 메시지 삽입
		
		ChatRoom chatRoom = chatRoomService.getChatRoomByChatRoomNo(message.getChatRoomNo()); //방번호로 채팅방 가져옴
		
		chatRoom.setLastMessage(message.getContent()); //채팅방의 마지막 메시지를 새로운 메시지로 삽입
		chatRoom.setLastMessageSenderNo(message.getSendingUserNo());
		chatRoom.setLastMessageChecked(message.getChecked());
		chatRoom.setUserUnreadCount(chatRoom.getUserUnreadCount()+1);
		
		chatRoomService.updateChatRoom(chatRoom); //채팅방 업데이트
	}
	
	@PostMapping("/checkMessage")
	public void checkMessage(@RequestBody ChatRoom chatRoom) throws IOException {
		User savedUser = (User) SessionUtils.getAttribute("LOGIN_USER");
		int chatRoomNo = chatRoom.getNo();
		System.out.println("읽음처리:"+chatRoomNo);
		
		chatRoomService.changeHostPageUnreadToZero(chatRoomNo, savedUser.getNo());
	}
	
	
	// 유상효 호스트등록폼 호출
	@GetMapping("/applyForm")
	public String ApplyForm() {
		//SessionUtils.addAttribute("세션아이디", "세션값");
		return "form/applyForm.tiles";
	}
	
	// 유상효 hostApply 입력
	@PostMapping(value = "/insertHostApply")
	public String insertHostApply(HostApplyForm form) throws IOException {
		
		// 숙소 사진 저장
		String saveDirectory1 = "C:\\final-workspace\\finalproject-chanel5\\src\\main\\webapp\\resources\\images\\accommodation";
		List<AccommoImage> accImages = new ArrayList<AccommoImage>();
		List<MultipartFile> accFiles = form.getAccImages();
		for (MultipartFile multipartFile1 : accFiles) {
			if (!multipartFile1.isEmpty()) {
				String fileName1 = multipartFile1.getOriginalFilename();
				AccommoImage accImage = new AccommoImage();
				accImage.setImage(fileName1);
				accImages.add(accImage);
				InputStream in1 = multipartFile1.getInputStream();
				FileOutputStream out1 = new FileOutputStream(new File(saveDirectory1, fileName1));
				FileCopyUtils.copy(in1, out1);
			}
		}
		
		// 체험 사진 저장
		String saveDirectory2 = "C:\\final-workspace\\finalproject-chanel5\\src\\main\\webapp\\resources\\images\\activities";
		List<ActivityImage> actImages = new ArrayList<ActivityImage>();
		List<MultipartFile> actFiles = form.getActImages();
		for (MultipartFile multipartFile2 : actFiles) {
			if (!multipartFile2.isEmpty()) {
				String fileName2 = multipartFile2.getOriginalFilename();
				ActivityImage actImage = new ActivityImage();
				actImage.setImage(fileName2);
				actImages.add(actImage);
				InputStream in2 = multipartFile2.getInputStream();
				FileOutputStream out2 = new FileOutputStream(new File(saveDirectory2, fileName2));
				FileCopyUtils.copy(in2, out2);
			}
		}
		
		// 호스트 정보 담기
		Host host = new Host();
		host.setHostingType(form.getHostingType());
		host.setName(form.getHostName());
		host.setTel(form.getTel());
		host.setAccountHolderName(form.getAccountHolderName());
		host.setBankName(form.getBankName());
		host.setAccountNumber(form.getAccountNumber());
		// 메인사진 저장
		String hostImageSave = "C:\\final-workspace\\finalproject-chanel5\\src\\main\\webapp\\resources\\images\\hostMainImage";
		MultipartFile hostfile = form.getHostMainImage();
		if (!hostfile.isEmpty()) {
			String fileName = hostfile.getOriginalFilename();
			host.setMainImage(fileName);
			InputStream in = hostfile.getInputStream();
			FileOutputStream out = new FileOutputStream(new File(hostImageSave, fileName));
			FileCopyUtils.copy(in, out);
		}
		
		// 숙소 정보 담기
		Accommodation acc = new Accommodation();
		acc.setType(form.getAccType());
		acc.setName(form.getAccName());
		acc.setWebAddress(form.getAccWebAddress());
		acc.setIntroTitle(form.getAccIntroTitle());
		acc.setIntroContent(form.getAccIntroContent());
		String accMainAddress = form.getAccMainAddress();
		String accDetailAddress = form.getAccDetailAddress();
		acc.setAddress(accMainAddress + " " + accDetailAddress);
		acc.setCheckInTime(form.getAccCheckInTime());
		acc.setCheckOutime(form.getAccCheckOutime());
		acc.setXce(form.getXce());
		acc.setYce(form.getYce());
		
		StringTokenizer accDepth = new StringTokenizer(form.getAccMainAddress());
		acc.setRegionDepth1(accDepth.nextToken());
		acc.setRegionDepth2(accDepth.nextToken());
		acc.setRegionDepth3(accDepth.nextToken());
		
		
		// 체험 정보 담기
		Activity act = new Activity();
		act.setName(form.getActName());
		act.setIntroTitle(form.getActIntroTitle());
		act.setIntroContent(form.getActIntroContent());
		act.setMaximumNumber(form.getActMaximumNumber());
		act.setPricePerPerson(form.getActPricePerPerson());
		String actMainAddress = form.getActMainAddress();
		String actDetailAddress = form.getActDetailAddress();
		act.setAddress(actMainAddress + " " + actDetailAddress);
		act.setXce(form.getXce());
		act.setYce(form.getYce());
		
		StringTokenizer actDepth = new StringTokenizer(form.getActMainAddress());
		act.setRegionDepth1(actDepth.nextToken());
		act.setRegionDepth2(actDepth.nextToken());
		act.setRegionDepth3(actDepth.nextToken());
		
		logger.info("숙소정보" + acc);
		logger.info("체험정보" + act);
		
		int userNo = form.getUserNo();
		hostService.hostApply(host, acc, act, accImages, actImages);
		hostService.userIsHostUpdate(userNo);
		return "redirect:../mypage/hostingList";
	}
	
	//성하민 호스트 메인페이지
	@GetMapping("/main")
	public String hostMain(@RequestParam(name = "hostNo") int hostNo, @RequestParam(name = "hostingType") int hostingType, Model model) {
		if (hostingType == 1) {
			AccMainDto accMainDto = hostService.getAccMainByHostNo(hostNo);
			model.addAttribute("accMainDto", accMainDto);
			List<RoomBooking> todayCheckOutList = hostService.getTodayCheckOutByAccommoNo(accMainDto.getAccNo());
			List<RoomBooking> todayCheckInList = hostService.getTodayCheckInByAccommoNo(accMainDto.getAccNo());
			List<RoomListDto> roomList = accommodationService.getRoomListByAccNo(accMainDto.getAccNo());
			model.addAttribute("roomList", roomList);
			System.out.println("todayCheckOutList:" +todayCheckOutList);
			System.out.println("todayCheckInList:" +todayCheckInList);
			
			//성하민 호스트페이지 메인에서 오늘 예약건수 가져오기
			int todayBookingCount = hostService.getTodayBookingCountByAccommoNo(accMainDto.getAccNo());
			int todayReviewCount = reviewService.getTodayReviewCountByAccommoNo(accMainDto.getAccNo());
			Host savedHost = hostService.getHostByNo(hostNo);
			model.addAttribute("todayReviewCount", todayReviewCount);
			model.addAttribute("todayBookingCount", todayBookingCount);
			model.addAttribute("todayCheckOutList", todayCheckOutList);
			model.addAttribute("todayCheckInList", todayCheckInList);
			model.addAttribute("roomList", roomList);
			model.addAttribute("savedHost", savedHost);
					
		
			
		return "hostpage/accMain.hosttiles";
		} else {
			ActMainDto actMainDto = hostService.getActMainByHostNo(hostNo);
			List<ActivityTimeTable> actTimeList = activityService.getActivityTimeListByActivityNo(actMainDto.getActNo());
			Host savedHost = hostService.getHostByNo(hostNo);
			int todayReviewCount = reviewService.getTodayReviewCountByActivityNo(actMainDto.getActNo());
			int todayBookingCount = activityService.getTodayBookingCountByActivityNo(actMainDto.getActNo());
			model.addAttribute("todayBookingCount", todayBookingCount);
			model.addAttribute("todayReviewCount", todayReviewCount);
			model.addAttribute("actMainDto", actMainDto);
			model.addAttribute("actTimeList", actTimeList);
			model.addAttribute("savedHost", savedHost);
		return "hostpage/actMain.hosttiles";
		}
	}
	
	// 성하민 호스트 예약관리 페이지
	@GetMapping("/booking-calendar")
	public String hostBookingCalendar(@RequestParam(name = "hostNo") int hostNo, @RequestParam(name = "hostingType") int hostingType, Model model) {
		if (hostingType == 1) {
			AccMainDto accMainDto = hostService.getAccMainByHostNo(hostNo);
			model.addAttribute("accMainDto", accMainDto);
			Host savedHost = hostService.getHostByNo(hostNo);
			model.addAttribute("savedHost", savedHost);
			
			return "hostpage/accBookingCalendar.hosttiles";
		} else {
			ActMainDto actMainDto = hostService.getActMainByHostNo(hostNo);
			model.addAttribute("actMainDto", actMainDto);
			Host savedHost = hostService.getHostByNo(hostNo);
			model.addAttribute("savedHost", savedHost);
			return "hostpage/actBookingCalendar.hosttiles";
		}
	}
	
	//성하민
		@GetMapping("/review-answer.do")							// 요청핸들러 메소드에 @ResponseBody를 붙인다.
		public @ResponseBody AdminAccommoReviewDto reviewdetail(@RequestParam(name = "no",required = true) int no) {
			AdminAccommoReviewDto reviewDto = reviewService.getAccommoReviewsDtoByReviewNo(no);
			return reviewDto;
		}
		
		
		
		@PostMapping("/review-answer-insert")
		public String reviewAnswer(int hostNo, int hostingType, String answerContent, int reviewNo) throws IOException {
			ReviewAccommo review = reviewService.getAccommoReviewByReviewNo(reviewNo);
			review.setAnswerContent(answerContent);
			reviewService.answerUpdateAccommReview(review);
			
			return "redirect:review?page=1&hostNo="+hostNo+"&hostingType="+hostingType;
		}
		
	
	// 성하민 호스트 리뷰관리 페이지
	@GetMapping("/review")
	public String review(String page, int hostNo, int hostingType, Model model) {
		if (hostingType == 1) {

			Criteria criteria = new Criteria();
			criteria.setOpt("호스트번호");
			String hostNoString = Integer.toString(hostNo);
			criteria.setValue(hostNoString);
			int totalrecords = reviewService.getAccommoReviewsTotalRows(criteria);
			
			Pagination pagination = new Pagination(page, totalrecords);
			
			criteria.setBeginIndex(pagination.getBegin());
			criteria.setEndIndex(pagination.getEnd());
			
			List<AdminAccommoReviewDto> reviewList = reviewService.getAccommoReviewsByCriteria(criteria);
			
			model.addAttribute("pagination", pagination);
			model.addAttribute("reviewList", reviewList);
			AccMainDto accMainDto = hostService.getAccMainByHostNo(hostNo);
			model.addAttribute("accMainDto", accMainDto);
			Host savedHost = hostService.getHostByNo(hostNo);
			model.addAttribute("savedHost", savedHost);
			
			return "hostpage/review.hosttiles";
		} else {
			ActMainDto actMainDto = hostService.getActMainByHostNo(hostNo);
			model.addAttribute("actMainDto", actMainDto);
			Host savedHost = hostService.getHostByNo(hostNo);
			model.addAttribute("savedHost", savedHost);
			return "hostpage/review.hosttiles";
		}
	}
	
	// 유상효 호스트 수정폼 호출
	@GetMapping("/modify")
	public String hostModify(@RequestParam(name = "hostNo") int hostNo, @RequestParam(name = "hostingType") int hostingType, Model model) {
		if (hostingType == 1) {
			AccMainDto accMainDto = hostService.getAccMainByHostNo(hostNo);
			model.addAttribute("accMainDto", accMainDto);
			List<AccommoImage> accImages = hostService.getAccImagesByHostNo(hostNo);
			model.addAttribute("accImages", accImages);
		return "form/accModifyForm.hosttiles";
		} else {
			ActMainDto actMainDto = hostService.getActMainByHostNo(hostNo);
			model.addAttribute("actMainDto", actMainDto);
			List<ActivityImage> actImages = hostService.getActImagesByHostNo(hostNo);
			model.addAttribute("actImages", actImages);
		return "form/actModifyForm.hosttiles";
		}
	}
	
	// 유상효 숙소호스트 수정
	@PostMapping("/accHostModify")
	public String accHostModify(AccHostModifyForm form) throws IOException {
		
		Host host = new Host();
		host.setNo(form.getHostNo());
		host.setName(form.getHostName());
		host.setTel(form.getTel());
		host.setAccountHolderName(form.getAccountHolderName());
		host.setBankName(form.getBankName());
		host.setAccountNumber(form.getAccountNumber());
		String hostImageSave = "C:\\final-workspace\\finalproject-chanel5\\src\\main\\webapp\\resources\\images\\hostMainImage";
		MultipartFile hostfile = form.getHostMainImage();
		if (!hostfile.isEmpty()) {
			String fileName = hostfile.getOriginalFilename();
			host.setMainImage(fileName);
			InputStream in = hostfile.getInputStream();
			FileOutputStream out = new FileOutputStream(new File(hostImageSave, fileName));
			FileCopyUtils.copy(in, out);
		}
		
		Accommodation acc = new Accommodation();
		acc.setHostNo(form.getHostNo());
		acc.setType(form.getAccType());
		acc.setName(form.getAccName());
		acc.setWebAddress(form.getAccWebAddress());
		acc.setAddress(form.getAccAddress());
		acc.setCheckInTime(form.getAccCheckInTime());
		acc.setCheckOutime(form.getAccCheckOutime());
		acc.setIntroTitle(form.getAccIntroTitle());
		acc.setIntroContent(form.getAccIntroContent());
		
		hostService.accHostModify(host, acc);
		logger.info("호스트 :" + host);
		logger.info("숙소 :" + acc);
		
		
		return "redirect:/host/main?hostNo="+form.getHostNo()+"&hostingType="+form.getHostingType();
	}
	
	// 유상효 체험호스트 수정
	@PostMapping("/actHostModify")
	public String actHostModify(ActHostModifyForm form) throws IOException {
		
		Host host = new Host();
		host.setNo(form.getHostNo());
		host.setName(form.getHostName());
		host.setTel(form.getTel());
		host.setAccountHolderName(form.getAccountHolderName());
		host.setBankName(form.getBankName());
		host.setAccountNumber(form.getAccountNumber());
		String hostImageSave = "C:\\final-workspace\\finalproject-chanel5\\src\\main\\webapp\\resources\\images\\hostMainImage";
		MultipartFile hostfile = form.getHostMainImage();
		if (!hostfile.isEmpty()) {
			String fileName = hostfile.getOriginalFilename();
			host.setMainImage(fileName);
			InputStream in = hostfile.getInputStream();
			FileOutputStream out = new FileOutputStream(new File(hostImageSave, fileName));
			FileCopyUtils.copy(in, out);
		}
		
		Activity act = new Activity();
		act.setHostNo(form.getHostNo());
		act.setName(form.getActName());
		act.setAddress(form.getActAddress());
		act.setMaximumNumber(form.getActMaximumNumber());
		act.setPricePerPerson(form.getActPricePerPerson());
		act.setIntroTitle(form.getActIntroTitle());
		act.setIntroContent(form.getActIntroContent());
		
		hostService.actHostModify(host, act);
		
		return "redirect:/host/main?hostNo="+form.getHostNo()+"&hostingType="+form.getHostingType();
	}
	
	
	
	// 유상효 객실 관리페이지
	@GetMapping("/mainRoom")
	public String mainRoom(@RequestParam(name = "hostNo") int hostNo, @RequestParam(name = "hostingType") int hostingType, Model model) {
		AccMainDto accMainDto = hostService.getAccMainByHostNo(hostNo);
		model.addAttribute("accMainDto", accMainDto);
		
		List<RoomListDto> roomDto = accommodationService.getRoomListByAccNo(accMainDto.getAccNo());
		model.addAttribute("roomListDto", roomDto);
			
	return "accommo/mainRoom.hosttiles";
	}
	
	// 유상효 객실등록폼 호출
	@GetMapping("insertRoom")
	public String roomInsertForm(@RequestParam(name = "hostNo") int hostNo, Model model) {
			AccMainDto accMainDto = hostService.getAccMainByHostNo(hostNo);
			model.addAttribute("accMainDto", accMainDto);
		return "form/insertRoomForm.hosttiles";
	}
	
	// 유상효 객실등록
	@PostMapping(value = "/insertRooms")
	public String insertRooms(InsertRoomForm form) throws IOException {
		// 객실 사진 저장
		String saveDirectory = "C:\\final-workspace\\finalproject-chanel5\\src\\main\\webapp\\resources\\images\\room";
		List<RoomImage> roomImages = new ArrayList<RoomImage>();
		List<MultipartFile> roomFiles = form.getRoomImages();
		for (MultipartFile multipartFile : roomFiles) {
			if (!multipartFile.isEmpty()) {
				String fileName = multipartFile.getOriginalFilename();
				RoomImage roomImage = new RoomImage();
				roomImage.setImage(fileName);
				roomImages.add(roomImage);
				InputStream in = multipartFile.getInputStream();
				FileOutputStream out = new FileOutputStream(new File(saveDirectory, fileName));
				FileCopyUtils.copy(in, out);
			}
		}
		// 객실 정보 담기
		Room room = new Room();
		BeanUtils.copyProperties(form, room);
		accommodationService.insertRoom(room, roomImages);
		// 객실 등록후 객실메인페이지로 리다이렉트
		return "redirect:mainRoom?hostNo="+form.getHostNo()+"&hostingType="+form.getHostingType();
	}
	
	// 유상효 객실수정폼 호출
	@GetMapping("roomModify")
	public String roomModifyForm(@RequestParam(name = "hostNo") int hostNo, @RequestParam(name = "hostingType") int hostingType, @RequestParam(name = "roomNo") int roomNo, Model model) {
		AccMainDto accMainDto = hostService.getAccMainByHostNo(hostNo);
		model.addAttribute("accMainDto", accMainDto);
		
		RoomDto roomDto = accommodationService.getRoomByRoomNo(roomNo);
		roomDto.setHostNo(hostNo);
		roomDto.setHostingType(hostingType);
		model.addAttribute("roomDto", roomDto);
		
		List<RoomImage> roomImages = accommodationService.getRoomImages(roomNo);
		model.addAttribute("roomImages", roomImages);
		
	return "form/roomModifyForm.hosttiles";
	}
	
	// 유상효 객실수정
	@PostMapping("/roomModify")
	public String roomModify(RoomModifyForm form) throws IOException {
		
		logger.info("폼입력값 :" + form);
		Room room = new Room();
		room.setNo(form.getNo());
		room.setAccommoNo(form.getAccommoNo());
		room.setName(form.getName());
		room.setWeekdaysPrice(form.getWeekdaysPrice());
		room.setWeekendPrice(form.getWeekendPrice());
		room.setPeakSeasonPrice(form.getPeakSeasonPrice());
		room.setStandardNumber(form.getStandardNumber());
		room.setMaximumNumber(form.getMaximumNumber());
		room.setPricePerPerson(form.getPricePerPerson());
		room.setAmenity(form.getAmenity());
		room.setFeature(form.getFeature());
		
		logger.info("룸입력값 :" + room);
		accommodationService.roomModify(room);
		
		return "redirect:mainRoom?hostNo="+form.getHostNo()+"&hostingType="+form.getHostingType();
	}
	
	// 유상효 프로모션 관리페이지
	@GetMapping("/mainPromotion")
	public String mainPromotion(@RequestParam(name = "hostNo") int hostNo, @RequestParam(name = "hostingType") int hostingType, @RequestParam(name = "status", defaultValue = "A") String status, Model model) {
		AccMainDto accMainDto = hostService.getAccMainByHostNo(hostNo);
		model.addAttribute("accMainDto", accMainDto);
		ActMainDto actMainDto = hostService.getActMainByHostNo(hostNo);
		model.addAttribute("actMainDto", actMainDto);
		
		if (status.equals("A")) {
			List<PromotionDiscount> promotionDiscountList = hostService.getPromotionDiscountByHostNo(hostNo);
			model.addAttribute("promotionDiscountList", promotionDiscountList);
			List<PromotionOffer> promotionOfferList = hostService.getPromotionOfferByHostNo(hostNo);
			model.addAttribute("promotionOfferList", promotionOfferList);
		} else if (status.equals("Y")) {
			List<PromotionDiscount> promotionDiscountList = hostService.getPromotionDiscountByHostNoAndStatusY(hostNo);
			model.addAttribute("promotionDiscountList", promotionDiscountList);
			List<PromotionOffer> promotionOfferList = hostService.getPromotionOfferByHostNoAndStatusY(hostNo);
			model.addAttribute("promotionOfferList", promotionOfferList);
		} else if (status.equals("W")) {
			List<PromotionDiscount> promotionDiscountList = hostService.getPromotionDiscountByHostNoAndStatusW(hostNo);
			model.addAttribute("promotionDiscountList", promotionDiscountList);
			List<PromotionOffer> promotionOfferList = hostService.getPromotionOfferByHostNoAndStatusW(hostNo);
			model.addAttribute("promotionOfferList", promotionOfferList);
		} else if (status.equals("N")) {
			List<PromotionDiscount> promotionDiscountList = hostService.getPromotionDiscountByHostNoAndStatusN(hostNo);
			model.addAttribute("promotionDiscountList", promotionDiscountList);
			List<PromotionOffer> promotionOfferList = hostService.getPromotionOfferByHostNoAndStatusN(hostNo);
			model.addAttribute("promotionOfferList", promotionOfferList);
		} else if (status.equals("D")) {
			List<PromotionDiscount> promotionDiscountList = hostService.getPromotionDiscountByHostNoAndStatusD(hostNo);
			model.addAttribute("promotionDiscountList", promotionDiscountList);
			List<PromotionOffer> promotionOfferList = hostService.getPromotionOfferByHostNoAndStatusD(hostNo);
			model.addAttribute("promotionOfferList", promotionOfferList);
		}
		
		logger.info("model 출력값 :" + model);
			
	return "hostpage/promotion.hosttiles";
	}
	
	// 유상효 할인 프로모션폼 호출
	@GetMapping("/addPromotionDiscount")
	public String addPromotionDiscountForm(@RequestParam(name = "hostNo") int hostNo, @RequestParam(name = "hostingType") int hostingType, Model model) {
		AccMainDto accMainDto = hostService.getAccMainByHostNo(hostNo);
		model.addAttribute("accMainDto", accMainDto);
		ActMainDto actMainDto = hostService.getActMainByHostNo(hostNo);
		model.addAttribute("actMainDto", actMainDto);
		
		return "form/addPromotionDiscountForm.hosttiles";
	}
	
	// 유상효 할인 프로모션 등록
	@PostMapping("/addPromotionDiscount")
	public String addPromotionDiscount(PromotionDiscountForm form) {
		
		logger.info("form입력값 :" + form);
		
		java.util.Date utilStarting = form.getStartingDate();
		java.sql.Date sqlStarting = new java.sql.Date(utilStarting.getTime());
		
		java.util.Date utilEnding = form.getEndingDate();
		java.sql.Date sqlEnding = new java.sql.Date(utilEnding.getTime());
		
		PromotionDiscount promotionDiscount = new PromotionDiscount();
		promotionDiscount.setHostNo(form.getHostNo());
		promotionDiscount.setWeekdaysDiscountRate(form.getWeekdaysDiscountRate());
		promotionDiscount.setWeekendDiscountRate(form.getWeekendDiscountRate());
		promotionDiscount.setPeakSeasonDiscountRate(form.getPeakSeasonDiscountRate());
		promotionDiscount.setStartingDate(sqlStarting);
		promotionDiscount.setEndingDate(sqlEnding); // 날짜시간 오라클 입력
		promotionDiscount.setIntroContent(form.getIntroContent());
		
		logger.info("프로모션입력값 :" + promotionDiscount);
		
		hostService.addPromotionDiscount(promotionDiscount);
		return "redirect:mainPromotion?hostNo="+form.getHostNo()+"&hostingType="+form.getHostingType();
	}
	
	// 유상효 증정 프로모션폼 호출
	@GetMapping("/addPromotionOffer")
	public String addPromotionOfferForm(@RequestParam(name = "hostNo") int hostNo, @RequestParam(name = "hostingType") int hostingType, Model model) {
		AccMainDto accMainDto = hostService.getAccMainByHostNo(hostNo);
		model.addAttribute("accMainDto", accMainDto);
		ActMainDto actMainDto = hostService.getActMainByHostNo(hostNo);
		model.addAttribute("actMainDto", actMainDto);
		
		return "form/addPromotionOfferForm.hosttiles";
	}
	
	// 유상효 증정 프로모션 등록
	@PostMapping("/addPromotionOffer")
	public String addPromotionOffer(PromotionOfferForm form) {
		
		logger.info("form입력값 :" + form);
		
		java.util.Date utilStarting = form.getStartingDate();
		java.sql.Date sqlStarting = new java.sql.Date(utilStarting.getTime());
		
		java.util.Date utilEnding = form.getEndingDate();
		java.sql.Date sqlEnding = new java.sql.Date(utilEnding.getTime());
		
		PromotionOffer promotionOffer = new PromotionOffer();
		promotionOffer.setHostNo(form.getHostNo());
		promotionOffer.setContent(form.getContent());
		promotionOffer.setIntroContent(form.getIntroContent());
		promotionOffer.setStartingDate(sqlStarting);
		promotionOffer.setEndingDate(sqlEnding);
		
		hostService.addPromotionOffer(promotionOffer);
		return "redirect:mainPromotion?hostNo="+form.getHostNo()+"&hostingType="+form.getHostingType();
	}
	
	// 유상효 할인 프로모션 수정폼 호출
	@GetMapping("modifyPromotionDiscount")
	public String modifyPromotionDiscount(@RequestParam(name = "hostNo") int hostNo, @RequestParam(name = "hostingType") int hostingType, @RequestParam(name = "no") int no, Model model) {
		AccMainDto accMainDto = hostService.getAccMainByHostNo(hostNo);
		model.addAttribute("accMainDto", accMainDto);
		ActMainDto actMainDto = hostService.getActMainByHostNo(hostNo);
		model.addAttribute("actMainDto", actMainDto);
		PromotionDiscount promotionDiscount = hostService.getPromotionDiscountByPromotionNo(no);
		model.addAttribute("promotionDiscount", promotionDiscount);
		
		return "form/modifyPromotionDiscountForm.hosttiles";
	}
	
	// 유상효 할인 프로모션 수정
	@PostMapping("/modifyPromotionDiscount")
	public String modifyPromotionDiscount(ModifyPromotionDiscountForm form) {
		
		logger.info("form입력값 :" + form);
		
		java.util.Date utilStarting = form.getStartingDate();
		java.sql.Date sqlStarting = new java.sql.Date(utilStarting.getTime());
		
		java.util.Date utilEnding = form.getEndingDate();
		java.sql.Date sqlEnding = new java.sql.Date(utilEnding.getTime());
		
		PromotionDiscount promotionDiscount = new PromotionDiscount();
		promotionDiscount.setNo(form.getNo());
		promotionDiscount.setHostNo(form.getHostNo());
		promotionDiscount.setWeekdaysDiscountRate(form.getWeekdaysDiscountRate());
		promotionDiscount.setWeekendDiscountRate(form.getWeekendDiscountRate());
		promotionDiscount.setPeakSeasonDiscountRate(form.getPeakSeasonDiscountRate());
		promotionDiscount.setStartingDate(sqlStarting);
		promotionDiscount.setEndingDate(sqlEnding);
		promotionDiscount.setIntroContent(form.getIntroContent());
		
		logger.info("프로모션입력값 :" + promotionDiscount);
		
		hostService.modifyPromotionDiscount(promotionDiscount);
		
		return "redirect:mainPromotion?hostNo="+form.getHostNo()+"&hostingType="+form.getHostingType();
	}
		
	// 유상효 증정 프로모션 수정폼 호출
	@GetMapping("modifyPromotionOffer")
	public String modifyPromotionOffer(@RequestParam(name = "hostNo") int hostNo, @RequestParam(name = "hostingType") int hostingType, @RequestParam(name = "no") int no, Model model) {
		AccMainDto accMainDto = hostService.getAccMainByHostNo(hostNo);
		model.addAttribute("accMainDto", accMainDto);
		ActMainDto actMainDto = hostService.getActMainByHostNo(hostNo);
		model.addAttribute("actMainDto", actMainDto);
		PromotionOffer promotionOffer = hostService.getPromotionOfferByPromotionNo(no);
		model.addAttribute("promotionOffer", promotionOffer);
		
		return "form/modifyPromotionOfferForm.hosttiles";
	}
	
	// 유상효 증정 프로모션 수정
	@PostMapping("/modifyPromotionOffer")
	public String modifyPromotionOffer(ModifyPromotionOfferForm form) {
		
		logger.info("form입력값 :" + form);
		
		java.util.Date utilStarting = form.getStartingDate();
		java.sql.Date sqlStarting = new java.sql.Date(utilStarting.getTime());
		
		java.util.Date utilEnding = form.getEndingDate();
		java.sql.Date sqlEnding = new java.sql.Date(utilEnding.getTime());
		
		PromotionOffer promotionOffer = new PromotionOffer();
		promotionOffer.setNo(form.getNo());
		promotionOffer.setHostNo(form.getHostNo());
		promotionOffer.setContent(form.getContent());
		promotionOffer.setIntroContent(form.getIntroContent());
		promotionOffer.setStartingDate(sqlStarting);
		promotionOffer.setEndingDate(sqlEnding);
		
		logger.info("프로모션입력값 :" + promotionOffer);
		
		hostService.modifyPromotionOffer(promotionOffer);
		
		return "redirect:mainPromotion?hostNo="+form.getHostNo()+"&hostingType="+form.getHostingType();
	}
	
	// 유상효 숙소 부대시설 및 기타 안내 등록 페이지 호출
	@GetMapping("/addAccInfo")
	public String addAccInfoForm(@RequestParam(name = "hostNo") int hostNo, @RequestParam(name = "hostingType") int hostingType, Model model) {
		AccMainDto accMainDto = hostService.getAccMainByHostNo(hostNo);
		model.addAttribute("accMainDto", accMainDto);
		ActMainDto actMainDto = hostService.getActMainByHostNo(hostNo);
		model.addAttribute("actMainDto", actMainDto);
		
		return "form/addAccInfoForm.hosttiles";
	}
	
	// 유상효 부대시설 및 기타 안내 등록
	@PostMapping("/addAccInfo")
	public String addAccInfo(AccInfoForm form) {
		hostService.addAccInfo(form);
		return "redirect:/host/main?hostNo="+form.getHostNo()+"&hostingType="+form.getHostingType();
	}
	
	// 유상효 체험 부대시설 및 기타 안내 등록 페이지 호출
	@GetMapping("/addActInfo")
	public String addActInfoForm(@RequestParam(name = "hostNo") int hostNo, @RequestParam(name = "hostingType") int hostingType, Model model) {
		AccMainDto accMainDto = hostService.getAccMainByHostNo(hostNo);
		model.addAttribute("accMainDto", accMainDto);
		ActMainDto actMainDto = hostService.getActMainByHostNo(hostNo);
		model.addAttribute("actMainDto", actMainDto);
		
		return "form/addActInfoForm.hosttiles";
	}
	
	// 유상효 부대시설 및 기타 안내 등록
	@PostMapping("/addActInfo")
	public String addActInfo(AccInfoForm form) {
		hostService.addActInfo(form);
		return "redirect:/host/main?hostNo="+form.getHostNo()+"&hostingType="+form.getHostingType();
	}
	
	
		
	
	public ModelAndView MainReq() {
		return null;	
	}
	
	//성하민
	@GetMapping("/qna")
	public ModelAndView qna(String page, ModelAndView mv, int hostNo, int hostingType) {
		if (hostingType == 1) {
			AccMainDto accMainDto = hostService.getAccMainByHostNo(hostNo);
			mv.addObject("accMainDto", accMainDto);
		} else {
			ActMainDto actMainDto = hostService.getActMainByHostNo(hostNo);
			mv.addObject("actMaintDto", actMainDto);
		}
		
		Host savedHost = hostService.getHostByNo(hostNo);
		mv.setViewName("hostpage/qna.hosttiles");
		
		
		int totalRecords = hostQnAService.getHostQnACountByHostNo(hostNo);
				// 현재 페이지번호와 총 데이터 갯수를 전달해서 페이징 처리에 필요한 정보를 제공하는 Pagination객체 생성
		
		
		PaginationPerPage5 pagination = new PaginationPerPage5(page, totalRecords);
				
		int begin = pagination.getBegin();
		int end = pagination.getEnd();

		
		List<HostQnA> qnaList = hostQnAService.getHostQnAListByHostNo(hostNo, begin, end);
		mv.addObject("qnaList", qnaList);
		mv.addObject("pagination", pagination);
		mv.addObject("totalRecords", totalRecords);
		mv.addObject("savedHost", savedHost);
	
		return mv;
	}
	
	//성하민
	@GetMapping("/sales")
	public ModelAndView sales (ModelAndView mv, int hostNo, int hostingType) {
		if (hostingType == 1) {
			AccMainDto accMainDto = hostService.getAccMainByHostNo(hostNo);
			mv.addObject("accMainDto", accMainDto);
		} else {
			ActMainDto actMainDto = hostService.getActMainByHostNo(hostNo);
			mv.addObject("actMaintDto", actMainDto);
		}
		
		
		System.out.println(hostNo);
		Host savedHost = hostService.getHostByNo(hostNo);
		long appliedAmount = hostService.getWithdrawalwaitingAmountByHostNo(hostNo);
		long possibleAmount = savedHost.getAccumulatedMoney()-appliedAmount;
		mv.addObject("savedHost", savedHost);
		mv.addObject("appliedAmount", appliedAmount);
		mv.addObject("possibleAmount", possibleAmount);
		
		mv.setViewName("hostpage/sales.hosttiles");
	
		return mv;
	}
	
	
	@GetMapping("/chat")
	public ModelAndView chat(ModelAndView mv, int hostNo, int hostingType) {
		mv.setViewName("hostpage/chat.hosttiles");
		List<ChattingListDto> chatList = chatRoomService.getChattingListDtobyHostNo(hostNo);
		
		Host savedHost = hostService.getHostByNo(hostNo);
		
		String chatListString = Integer.toString(chatList.get(0).getChatRoomNo());
		
		for (int i = 1; i<chatList.size(); i++) {
			chatListString += ","+ Integer.toString(chatList.get(i).getChatRoomNo());
			
		}
		System.out.println(chatListString);
		
		mv.addObject("chatListString", chatListString);
		mv.addObject("chatList", chatList);
		mv.addObject("savedHost", savedHost);
		
		if (hostingType == 1) {
			AccMainDto accMainDto = hostService.getAccMainByHostNo(hostNo);
			mv.addObject("accMainDto", accMainDto);
		} else {
			ActMainDto actMainDto = hostService.getActMainByHostNo(hostNo);
			mv.addObject("actMaintDto", actMainDto);
		}
		
		
		return mv;
	}

	//성하민
	@GetMapping("/chat-enter.do")							// 요청핸들러 메소드에 @ResponseBody를 붙인다.
	public @ResponseBody List<ChattingMessageDto> enter(@RequestParam(name = "no",required = false) int no) {
		System.out.println("호스트 컨트롤러 서버로 들어온 채팅방번호:"+no);
		List<ChattingMessageDto> msgList = chatRoomService.getMessagesByChatRoomNo(no);
		System.out.println("호스트 컨트롤러 서버로 들어온 번호로 찾은 메시지:"+msgList);
		return msgList;
	}
	
	
	@PostMapping("/qna-insert.do")
	public String save(HostQnA hostQnA, int hostNo, int hostingType) throws IOException {
		hostQnA.setHostNo(hostNo);
		hostQnAService.insertHostQnA(hostQnA);
		
		return "redirect:qna?page=1&hostNo="+hostNo+"&hostingType="+hostingType;
	}
	
	@PostMapping("/withdrawal")
	public String saveWithdrawal(Withdrawal withdrawal, int hostingType) throws IOException {
		System.out.println(withdrawal.getHostNo());
		System.out.println("넘어온 값:" +withdrawal);
		
		hostService.insertWithdrawal(withdrawal);
		return "redirect:sales?hostNo="+withdrawal.getHostNo()+"&hostingType="+hostingType;
	}
	
	
}
