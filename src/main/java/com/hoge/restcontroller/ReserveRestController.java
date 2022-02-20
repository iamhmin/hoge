package com.hoge.restcontroller;

import java.net.URL;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;

import org.apache.tomcat.util.json.JSONParser;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.hoge.dto.ActivityPriceDto;
import com.hoge.dto.PriceDto;
import com.hoge.dto.PromotionDiscountDto;
import com.hoge.service.AccommodationService;
import com.hoge.service.PromotionService;
import com.hoge.vo.accommo.Room;
import com.hoge.vo.other.PromotionDiscount;

@RestController
public class ReserveRestController {
	
	@Autowired
	private AccommodationService accommodationService;
	@Autowired
	private PromotionService promotionService;
	
	// 염주환
	@GetMapping("/getAccommoPrice")
	public PriceDto getAccommoPrice(String checkIn, String checkOut, int roomNo, int number, int point) throws Exception {
		// 두 날짜 사이의 날짜list 생성
		List<Date> dateList = new ArrayList<>();
		DateFormat df = new SimpleDateFormat("yyyyMMdd");
		
		Date d1 = df.parse(checkIn);
		Date d2 = df.parse(checkOut);
		
		Calendar c1 = Calendar.getInstance();
		Calendar c2 = Calendar.getInstance();
		c1.setTime(d1);
		c1.add(Calendar.DATE, +1);
		c2.setTime(d2);
		
		int inYear = c1.get(Calendar.YEAR);
		int outYear = c2.get(Calendar.YEAR);
		
		while (c1.compareTo(c2) != 1) {
			System.out.println("날짜" + c1.get(Calendar.DATE));
			dateList.add(c1.getTime());
			c1.add(Calendar.DATE, 1);
		}
		
		// 공휴일 날짜 List에 담기
		JSONParser parser = new JSONParser(new URL("http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getRestDeInfo?solYear="+inYear+"&ServiceKey=1irZIYQbfl88iS1EiVAwaM7fW30u69nAf7PYWisL91H/f8lNcpcbqX5lO38L0mL1jhD8yRBduof7dNNoz6joiA==&_type=json&numOfRows=50").openStream());
		
		Map<String, Object> object = parser.parseObject();
		// System.out.println(object);
		Map<String, Object> response = (Map<String, Object>) object.get("response");
		Map<String, Object> body = (Map<String, Object>) response.get("body");
		Map<String, Object> items = (Map<String, Object>) body.get("items");
		List<Map<String, Object>>itemList = (List<Map<String, Object> >) items.get("item");
		
		List<Date> holidayList = new ArrayList<>();
		for (Map<String, Object> item : itemList) {
			String locdate = String.valueOf(item.get("locdate"));
			Date d3 = df.parse(locdate);
			Calendar c3 = Calendar.getInstance();
			c3.setTime(d3);
			// System.out.println(c3.get(Calendar.DATE));
			holidayList.add(c3.getTime());
		}
		
		// checkIn, checkOut 연도가 다를 경우 List에 추가 작업
		if (inYear != outYear) {
			parser = new JSONParser(new URL("http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getRestDeInfo?solYear="+outYear+"&ServiceKey=1irZIYQbfl88iS1EiVAwaM7fW30u69nAf7PYWisL91H/f8lNcpcbqX5lO38L0mL1jhD8yRBduof7dNNoz6joiA==&_type=json&numOfRows=50").openStream());
			
			object = parser.parseObject();
			// System.out.println(object);
			response = (Map<String, Object>) object.get("response");
			body = (Map<String, Object>) response.get("body");
			items = (Map<String, Object>) body.get("items");
			itemList = (List<Map<String, Object> >) items.get("item");
			
			for (Map<String, Object> item : itemList) {
				String locdate = String.valueOf(item.get("locdate"));
				Date d3 = df.parse(locdate);
				Calendar c3 = Calendar.getInstance();
				c3.setTime(d3);
				// System.out.printf("%tF\n", c3.getTime());
				holidayList.add(c3.getTime());
			}
		}
		
		Date peakStart = df.parse("20220715");
		Date peakEnd = df.parse("20220814");
		Calendar calendar = Calendar.getInstance();
		int dayOfWeek = 0;
		
		// 방 정보 조회
		Room room = accommodationService.getRoomDetail(roomNo);
		
		// 진행중인 가격할인 프로모션 조회
		List<PromotionDiscount> promotionDiscounts = promotionService.getPromotionDiscountDetail(room.getAccommoNo(), d1, d2);

		List<PromotionDiscountDto> promotionDiscountDtos = new ArrayList<>();
		PriceDto priceDto = new PriceDto();

		ListIterator<Date> iter = dateList.listIterator();
		// 주말, 공휴일, 평일 구분하기, 진행중인 프로모션 요일별 며칠이나 있는지
		if (!promotionDiscounts.isEmpty()) {
			for (PromotionDiscount promotion : promotionDiscounts) {
				PromotionDiscountDto promotionDiscountDto = new PromotionDiscountDto();
				// System.out.println(iter.hasNext());
				if (iter.hasNext()) {
					while(iter.hasNext()) {
						Date date = iter.next();
						// System.out.println(date);
						// 프로모션 진행중
						if ((date.equals(promotion.getStartingDate()) || date.after(promotion.getStartingDate())) &&
								(date.equals(promotion.getEndingDate()) || date.before(promotion.getEndingDate()))) {
							if ((date.equals(peakStart) || date.after(peakStart)) && (date.equals(peakStart) || (date.before(peakEnd)))) {
								// System.out.println("peak" + date.getDate());
								priceDto.setPeakSeasonNumber(priceDto.getPeakSeasonNumber()+1);
								promotionDiscountDto.setDiscountPeakSeasonsNumber(promotionDiscountDto.getDiscountPeakSeasonsNumber()+1);
								iter.remove();
							} else {
								calendar.setTime(date);
								dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
								if (dayOfWeek == 7 || dayOfWeek == 1) {
									// System.out.println("weekend" + date.getDate());
									priceDto.setWeekendNumber(priceDto.getWeekendNumber()+1);
									promotionDiscountDto.setDiscountWeekendNumber(promotionDiscountDto.getDiscountWeekendNumber()+1);
									iter.remove();
								} else {
									boolean isHoliday = false;
									for (Date holiday : holidayList) {
										if (date.compareTo(holiday) == 0) {
											// System.out.println("holiday" + date.getDate());
											priceDto.setWeekendNumber(priceDto.getWeekendNumber()+1);
											promotionDiscountDto.setDiscountWeekendNumber(promotionDiscountDto.getDiscountWeekendNumber()+1);
											isHoliday = true;
											iter.remove();
											break;
										}
									}
									if (isHoliday == false) {
										// System.out.println("weekday" + date.getDate());
										priceDto.setWeekdayNumber(priceDto.getWeekdayNumber()+1);
										promotionDiscountDto.setDiscountWeekdayNumber(promotionDiscountDto.getDiscountWeekdayNumber()+1);
										iter.remove();
									}
								}
							}
						}
					}
					BeanUtils.copyProperties(promotion, promotionDiscountDto);
					promotionDiscountDtos.add(promotionDiscountDto);
				} else {
					while(iter.hasPrevious()) {
						Date date = iter.previous();
						// System.out.println(date);
						// 프로모션 진행중
						if ((date.equals(promotion.getStartingDate()) || date.after(promotion.getStartingDate())) &&
								(date.equals(promotion.getEndingDate()) || date.before(promotion.getEndingDate()))) {
							if ((date.equals(peakStart) || date.after(peakStart)) && (date.equals(peakStart) || (date.before(peakEnd)))) {
								// System.out.println("peak" + date.getDate());
								priceDto.setPeakSeasonNumber(priceDto.getPeakSeasonNumber()+1);
								promotionDiscountDto.setPeakSeasonDiscountRate(promotionDiscountDto.getPeakSeasonDiscountRate()+1);
								iter.remove();
							} else {
								calendar.setTime(date);
								dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
								if (dayOfWeek == 7 || dayOfWeek == 1) {
									// System.out.println("weekend" + date.getDate());
									priceDto.setWeekendNumber(priceDto.getWeekendNumber()+1);
									promotionDiscountDto.setDiscountWeekendNumber(promotionDiscountDto.getDiscountWeekendNumber()+1);
									iter.remove();
								} else {
									boolean isHoliday = false;
									for (Date holiday : holidayList) {
										if (date.compareTo(holiday) == 0) {
											// System.out.println("holiday" + date.getDate());
											priceDto.setWeekendNumber(priceDto.getWeekendNumber()+1);
											promotionDiscountDto.setDiscountWeekendNumber(promotionDiscountDto.getDiscountWeekendNumber()+1);
											isHoliday = true;
											iter.remove();
											break;
										}
									}
									if (isHoliday == false) {
										// System.out.println("weekday" + date.getDate());
										priceDto.setWeekdayNumber(priceDto.getWeekdayNumber()+1);
										promotionDiscountDto.setDiscountWeekdayNumber(promotionDiscountDto.getDiscountWeekdayNumber()+1);
										iter.remove();
									}
								}
							}
						}
					}
					BeanUtils.copyProperties(promotion, promotionDiscountDto);
					promotionDiscountDtos.add(promotionDiscountDto);
				}
			}
		}
		if (iter.hasNext()) {
			while(iter.hasNext()) {
				Date date = iter.next();
				if ((date.equals(peakStart) || date.after(peakStart)) && (date.equals(peakStart) || date.before(peakEnd))) {
					// System.out.println("peak" + date.getDate());
					priceDto.setPeakSeasonNumber(priceDto.getPeakSeasonNumber()+1);
				} else {
					calendar.setTime(date);
					dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
					if (dayOfWeek == 7 || dayOfWeek == 1) {
						// System.out.println("weekend" + date.getDate());
						priceDto.setWeekendNumber(priceDto.getWeekendNumber()+1);
					} else {
						boolean isHoliday = false; 
						for (Date holiday : holidayList) {
							if (date.compareTo(holiday) == 0) {
								// System.out.println("holiday" + date.getDate());
								priceDto.setWeekendNumber(priceDto.getWeekendNumber()+1);
								isHoliday = true;
								break;
							}
						}
						if (isHoliday == false) {
						// System.out.println("weekday" + date.getDate());
						priceDto.setWeekdayNumber(priceDto.getWeekdayNumber()+1);
						}
					}
				}
			}
		} else {
			while(iter.hasPrevious()) {
				Date date = iter.previous();
				if ((date.equals(peakStart) || date.after(peakStart)) && (date.equals(peakStart) || date.before(peakEnd))) {
					// System.out.println("peak" + date.getDate());
					priceDto.setPeakSeasonNumber(priceDto.getPeakSeasonNumber()+1);
				} else {
					calendar.setTime(date);
					dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
					if (dayOfWeek == 7 || dayOfWeek == 1) {
						// System.out.println("weekend" + date.getDate());
						priceDto.setWeekendNumber(priceDto.getWeekendNumber()+1);
					} else {
						boolean isHoliday = false; 
						for (Date holiday : holidayList) {
							if (date.compareTo(holiday) == 0) {
								// System.out.println("holiday" + date.getDate());
								priceDto.setWeekendNumber(priceDto.getWeekendNumber()+1);
								isHoliday = true;
								break;
							}
						}
						if (isHoliday == false) {
						// System.out.println("weekday" + date.getDate());
						priceDto.setWeekdayNumber(priceDto.getWeekdayNumber()+1);
						}
					}
				}
			}
		}
		
		long roomPrice = (room.getWeekdaysPrice() * priceDto.getWeekdayNumber()) +
				(room.getWeekendPrice() * priceDto.getWeekendNumber()) +
				(room.getPeakSeasonPrice() * priceDto.getPeakSeasonNumber());
		
		long totalPrice = roomPrice;
		long discountAmount = 0;
		
		System.out.println(priceDto);
		
		for (PromotionDiscountDto promotion : promotionDiscountDtos) {
			discountAmount +=
					(long) ((room.getWeekdaysPrice() * promotion.getDiscountWeekdayNumber() * (promotion.getWeekdaysDiscountRate())) +
					(room.getWeekendPrice() * promotion.getDiscountWeekendNumber() * (promotion.getWeekendDiscountRate())) +
					(room.getPeakSeasonPrice() * promotion.getDiscountPeakSeasonsNumber() * (promotion.getPeakSeasonDiscountRate())));
			totalPrice -= discountAmount;
			
			System.out.println(promotion);
		}
		
		// number 숫자는 인원 초과
		number -= room.getStandardNumber();
		if (number < 0) { number = 0; }
		totalPrice += (number * room.getPricePerPerson());
		totalPrice -= point;
		
		priceDto.setUsePoint(point);
		priceDto.setRoomPrice(roomPrice);
		priceDto.setSurcharge(number * room.getPricePerPerson());
		priceDto.setTotalPrice(totalPrice);
		priceDto.setDiscountAmount(discountAmount);
		priceDto.setExtraPeople(number);
		priceDto.setPromotionDiscounts(promotionDiscountDtos);
		
		
		return priceDto;
	}
	
	// 염주환
	@GetMapping("/getActivityPrice")
	public ActivityPriceDto getAccommoPrice(long pricePer, int number, int point) {
		ActivityPriceDto activityPriceDto = new ActivityPriceDto();
		activityPriceDto.setPrice(pricePer*number);
		activityPriceDto.setTotalPrice((pricePer*number)-point);
		return activityPriceDto;
	}
	
}
