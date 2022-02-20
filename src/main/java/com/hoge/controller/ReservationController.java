package com.hoge.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hoge.config.auth.LoginedUser;
import com.hoge.dto.ActivityBookingDto;
import com.hoge.dto.ReserveAccommoDto;
import com.hoge.form.AccommoReserveForm;
import com.hoge.form.ActivityReserveForm;
import com.hoge.service.AccommodationService;
import com.hoge.service.ActivityService;
import com.hoge.vo.accommo.AccommoImage;
import com.hoge.vo.accommo.Room;
import com.hoge.vo.accommo.RoomBooking;
import com.hoge.vo.activities.Activity;
import com.hoge.vo.activities.ActivityBooking;
import com.hoge.vo.activities.ActivityImage;
import com.hoge.vo.activities.ActivityTimeTable;
import com.hoge.vo.other.KakaoPayApprovalVO;
import com.hoge.vo.other.User;

@Controller
@RequestMapping("/reserve")
public class ReservationController {
	
	@Autowired
	private AccommodationService accommodationService;
	@Autowired
	private ActivityService activityService;
	
	// 염주환
	@GetMapping("/accommo")
	public String accommoForm(@RequestParam("no") int no, @RequestParam("roomNo") int roomNo,
			@RequestParam("checkIn") @DateTimeFormat(pattern = "yyyy-MM-dd") Date checkIn,
			@RequestParam("checkOut") @DateTimeFormat(pattern = "yyyy-MM-dd") Date checkOut,
			@LoginedUser User user, Model model) {
		
		ReserveAccommoDto reserveAccommoDto = accommodationService.getReserveAccommoDto(no, roomNo);
		
		model.addAttribute("accommo", reserveAccommoDto);
		model.addAttribute("checkIn", checkIn);
		model.addAttribute("checkOut", checkOut);
		model.addAttribute("user", user);
		return "form/accommoReserveForm.tiles";
	}
	
	// 염주환
	@Transactional
	@PostMapping("/accommo/insert")
	public String save(AccommoReserveForm form, @LoginedUser User user) throws IOException {
		if (form.getRoomUserName() == "" && form.getRoomUserTel() == "") {
			form.setRoomUserName(user.getName()); form.setRoomUserTel(user.getTel());
		}
		RoomBooking roomBooking = new RoomBooking();
		BeanUtils.copyProperties(form, roomBooking);
		accommodationService.addNewBooking(roomBooking, user.getNo(), form.getTid());
		
		return "redirect:/reserve/accommo/complete";
	}
	
	@PostMapping("/accommo/kakaoPay")
	public String kakaoPay(AccommoReserveForm form) {
		return "redirect:" + accommodationService.kakaoPayReady(form);
	}
	
	@GetMapping("/accommo/kakaoPaySuccess")
    public String kakaoPaySuccess(@RequestParam("roomNo") int roomNo, @RequestParam("checkInDate") String checkInDate,
    		@RequestParam("checkOutDate") String checkOutDate, @RequestParam("payment") String payment,
    		@RequestParam("taxIncludedPrice") long taxIncludedPrice, @RequestParam("usedPnt") long usedPnt,
    		@RequestParam("paidPrice") long paidPrice, @RequestParam("roomUserName") String roomUserName, 
    		@RequestParam("roomUserTel") String roomUserTel, @RequestParam("extraPeople") int extraPeople, 
    		@RequestParam("pg_token") String pg_token, @LoginedUser User user) throws IOException, ParseException {
		
		SimpleDateFormat recvSimpleFormat = new SimpleDateFormat("E MMM dd HH:mm:ss z yyyy", Locale.ENGLISH);
		KakaoPayApprovalVO info = accommodationService.kakaoPayInfo(pg_token);
		
		AccommoReserveForm form = new AccommoReserveForm();
		form.setRoomNo(roomNo);
		form.setCheckInDate(recvSimpleFormat.parse(checkInDate));
		form.setCheckOutDate(recvSimpleFormat.parse(checkOutDate));
		form.setPayment(payment);
		form.setTaxIncludedPrice(taxIncludedPrice);
		form.setUsedPnt(usedPnt);
		form.setPaidPrice(paidPrice);
		form.setRoomUserName(roomUserName);
		form.setRoomUserTel(roomUserTel);
		form.setExtraPeople(extraPeople);
		form.setTid(info.getTid());
		
		return save(form, user);
    }
	
	@GetMapping("/accommo/complete")
    public String complete(@LoginedUser User user, Model model) {
		RoomBooking roomBooking = accommodationService.getRoomBooking(user.getNo());
		System.out.println(roomBooking);
		Room room = accommodationService.getRoomDetail(roomBooking.getRoomNo());
		System.out.println(room);
		List<AccommoImage> images = accommodationService.getAccommoImages(room.getAccommoNo());
		System.out.println(images);
		
		model.addAttribute("book", roomBooking);
		System.out.println(roomBooking);
		model.addAttribute("room", room);
		model.addAttribute("images", images);
		model.addAttribute("user", user);
		
		return "accommo/completePayment.tiles";
	}
	
	// 염주환
	@GetMapping("/activity")
	public String activityForm(@RequestParam("no") int no, @RequestParam("activityTimeNo") int activityTimeNo,
			@LoginedUser User user, Model model) {
		
		Activity activity = activityService.getActivityDetail(no);
		List<ActivityTimeTable> activityTimes = activityService.getActivityTimeListByActivityNo(activity.getNo());
		
		for(ActivityTimeTable time : activityTimes) {
			System.out.println(time);
		}
		
		model.addAttribute("activityTimes", activityTimes);
		model.addAttribute("activityTimeNo", activityTimeNo);
		model.addAttribute("activity", activity);
		model.addAttribute("user", user);
		
		return "form/activityReserveForm.tiles";
	}
		
	// 염주환
	@Transactional
	@PostMapping("/activity/insert")
	public String save(ActivityReserveForm activityReserveForm, @LoginedUser User user) throws IOException {
		activityReserveForm.setBookingName(user.getName());
		activityReserveForm.setBookingTel(user.getTel());
		activityService.addNewBooking(activityReserveForm);
		
		return "redirect:/reserve/activity/complete";
	}
	
	@PostMapping("/activity/kakaoPay")
	public String activityKakaoPay(ActivityReserveForm form) {
		return "redirect:" + activityService.kakaoPayReady(form);
	}
	
	@GetMapping("/activity/kakaoPaySuccess")
    public String kakaoPaySuccess(@RequestParam("activityTimeNo") int activityTimeNo, @RequestParam("activityNo") int activityNo, 
    		@RequestParam("userNo") int userNo, @RequestParam("numberOfPeople") int numberOfPeople, 
    		@RequestParam("payment") String payment, @RequestParam("taxIncludedPrice") int taxIncludedPrice, 
    		@RequestParam("usedPnt") int usedPnt, @RequestParam("paidPrice") int paidPrice, 
    		@RequestParam("pg_token") String pg_token, @LoginedUser User user) throws IOException, ParseException {
		
		KakaoPayApprovalVO info = activityService.kakaoPayInfo(pg_token);
		ActivityReserveForm form = new ActivityReserveForm();
		form.setActivityTimeNo(activityTimeNo);
		form.setActivityNo(activityNo);
		form.setUserNo(userNo);
		form.setNumberOfPeople(numberOfPeople);
		form.setPayment(payment);
		form.setTaxIncludedPrice(taxIncludedPrice);
		form.setUsedPnt(usedPnt);
		form.setPaidPrice(paidPrice);
		form.setTid(info.getTid());
		
		return save(form, user);
    }
	
	@GetMapping("/activity/complete")
    public String activityComplete(@LoginedUser User user, Model model) {
		ActivityBookingDto book = activityService.getActivityBookingDetail(user.getNo());
		Activity activity = activityService.getActivityDetail(book.getActivityNo());
		List<ActivityImage> images = activityService.getActiviyImages(book.getActivityNo());
		model.addAttribute("book", book);
		model.addAttribute("activity", activity);
		model.addAttribute("images", images);
		model.addAttribute("user", user);
		
		return "activities/completePayment.tiles";
	}
}
