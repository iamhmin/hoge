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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.hoge.dto.AccommoListDto;
import com.hoge.dto.AccommoPagination;
import com.hoge.dto.MapArea;
import com.hoge.dto.MergeAccommoListDto;
import com.hoge.dto.PriceDto;
import com.hoge.dto.PromotionDiscountDto;
import com.hoge.form.Criteria;
import com.hoge.pagination.Pagination;
import com.hoge.service.AccommodationService;
import com.hoge.service.PromotionService;
import com.hoge.vo.other.PromotionDiscount;

@RestController
@RequestMapping("/rest/accommo")
public class AccommoRestController {
	
	@Autowired
	private AccommodationService accommodationService;
	@Autowired
	private PromotionService promotionService;
	
	// 염주환
	@GetMapping("/mapArea")
	public AccommoPagination list(MapArea mapArea) throws Exception {
		
		AccommoPagination accommoPagination = new AccommoPagination();
		
		int totalRecords = accommodationService.getTotalRows(mapArea);
		
		Pagination pagination = new Pagination(mapArea.getPage(), totalRecords, 5);

		Criteria criteria = new Criteria();
		
		criteria.setBeginIndex(pagination.getBegin());
		criteria.setEndIndex(pagination.getEnd());
		criteria.setAccommoType(mapArea.getAccommoType());
		
		List<AccommoListDto> accommoListDtos = accommodationService.searchAccommoListDto(mapArea, criteria);
		
		List<MergeAccommoListDto> merges = new ArrayList<>();
		
		if (mapArea.getCheckIn() != "" & mapArea.getCheckOut() != "") {
			merges = getMergeAccommoListDto(accommoListDtos, mapArea.getCheckIn(), mapArea.getCheckOut());
		} else {
			for (AccommoListDto dto : accommoListDtos) {
				MergeAccommoListDto merge = new MergeAccommoListDto();
				BeanUtils.copyProperties(dto, merge);
				merge.setAverageStar(Math.round(((dto.getCleanlinessStar()+dto.getCommunicationStar()+dto.getAccuracyStar()+dto.getLocationStar()))/4*10)/10.0);
				merge.setMinPrice(dto.getMinWeekdaysPrice());
				merge.setMaxPrice(dto.getMaxWeekendPrice());
				merges.add(merge);
			}
		}
		
		for (MergeAccommoListDto dto : merges) {
			System.out.println(dto);
		}
		accommoPagination.setAccommos(merges);
		accommoPagination.setPagination(pagination);
		
		return accommoPagination;
	}
	
	
	
	// 염주환
	public List<MergeAccommoListDto> getMergeAccommoListDto(List<AccommoListDto> accommoListDtos, String checkIn, String checkOut) throws Exception {
		// 두 날짜 사이의 날짜 list 생성
		List<Date> dateList = new ArrayList<>();
		DateFormat df1 = new SimpleDateFormat("yyyy-MM-dd");
		DateFormat df = new SimpleDateFormat("yyyyMMdd");
		
		Date date1 = df1.parse(checkIn);
		Date date2 = df1.parse(checkOut);
		
		Calendar c1 = Calendar.getInstance();
		Calendar c2 = Calendar.getInstance();
		c1.setTime(date1);
		c1.add(Calendar.DATE, +1);
		c2.setTime(date2);
		
		
		int inYear = c1.get(Calendar.YEAR);
		int outYear = c2.get(Calendar.YEAR);
		
		while (c1.compareTo(c2) != 1) {
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
		
		List<PromotionDiscountDto> promotionDiscountDtos = null;
		PriceDto priceDto = null;
		List<MergeAccommoListDto> mergeAccommoListDtos = new ArrayList<>();
		boolean isHoliday;
		
		// 진행중인 가격할인 프로모션 조회
		for (AccommoListDto dto : accommoListDtos) {
			List<PromotionDiscount> promotionDiscounts = promotionService.getPromotionDiscountDetail(dto.getNo(), date1, date2);

			promotionDiscountDtos = new ArrayList<>();
			priceDto = new PriceDto();
	
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
									promotionDiscountDto.setDiscountPeakSeasonsNumber(promotionDiscountDto.getDiscountPeakSeasonsNumber()+1);
									iter.remove();
								} else {
									calendar.setTime(date);
									dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
									if (dayOfWeek == 7 || dayOfWeek == 1) {
										// System.out.println("weekend" + date.getDate());
										promotionDiscountDto.setDiscountWeekendNumber(promotionDiscountDto.getDiscountWeekendNumber()+1);
										iter.remove();
									} else {
										isHoliday = false;
										for (Date holiday : holidayList) {
											if (date.compareTo(holiday) == 0) {
												// System.out.println("holiday" + date.getDate());
												promotionDiscountDto.setDiscountWeekendNumber(promotionDiscountDto.getDiscountWeekendNumber()+1);
												isHoliday = true;
												iter.remove();
												break;
											}
										}
										if (isHoliday == false) {
											// System.out.println("weekday" + date.getDate());
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
									promotionDiscountDto.setPeakSeasonDiscountRate(promotionDiscountDto.getPeakSeasonDiscountRate()+1);
									iter.remove();
								} else {
									calendar.setTime(date);
									dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
									if (dayOfWeek == 7 || dayOfWeek == 1) {
										// System.out.println("weekend" + date.getDate());
										promotionDiscountDto.setDiscountWeekendNumber(promotionDiscountDto.getDiscountWeekendNumber()+1);
										iter.remove();
									} else {
										isHoliday = false;
										for (Date holiday : holidayList) {
											if (date.compareTo(holiday) == 0) {
												// System.out.println("holiday" + date.getDate());
												promotionDiscountDto.setDiscountWeekendNumber(promotionDiscountDto.getDiscountWeekendNumber()+1);
												isHoliday = true;
												iter.remove();
												break;
											}
										}
										if (isHoliday == false) {
											// System.out.println("weekday" + date.getDate());
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
							isHoliday = false; 
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
							isHoliday = false; 
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
			
			//System.out.println(priceDto);
			
			
			MergeAccommoListDto merge = new MergeAccommoListDto();
			BeanUtils.copyProperties(dto, merge);
			
			long minPrice = (dto.getMinWeekdaysPrice() * priceDto.getWeekdayNumber()) +
					(dto.getMinWeekendPrice() * priceDto.getWeekendNumber()) +
					(dto.getMinPeakSeasonPrice() * priceDto.getPeakSeasonNumber());
			
			
			for (PromotionDiscountDto promotion : promotionDiscountDtos) {
				minPrice +=
						(long) ((dto.getMinWeekdaysPrice() * promotion.getDiscountWeekdayNumber() * (1-promotion.getWeekdaysDiscountRate())) +
						(dto.getMinWeekendPrice() * promotion.getDiscountWeekendNumber() * (1-promotion.getWeekendDiscountRate())) +
						(dto.getMinPeakSeasonPrice() * promotion.getDiscountPeakSeasonsNumber() * (1-promotion.getPeakSeasonDiscountRate())));
			}
			

			long maxPrice = (dto.getMaxWeekdaysPrice() * priceDto.getWeekdayNumber()) +
					(dto.getMaxWeekendPrice() * priceDto.getWeekendNumber()) +
					(dto.getMaxPeakSeasonPrice() * priceDto.getPeakSeasonNumber());
			
			for (PromotionDiscountDto promotion : promotionDiscountDtos) {
				maxPrice +=
						(long) ((dto.getMaxWeekdaysPrice() * promotion.getDiscountWeekdayNumber() * (1-promotion.getWeekdaysDiscountRate())) +
						(dto.getMaxWeekendPrice() * promotion.getDiscountWeekendNumber() * (1-promotion.getWeekendDiscountRate())) +
						(dto.getMaxPeakSeasonPrice() * promotion.getDiscountPeakSeasonsNumber() * (1-promotion.getPeakSeasonDiscountRate())));
			}
			
			merge.setMinPrice(minPrice);
			merge.setMaxPrice(maxPrice);
			merge.setAverageStar(Math.round(((dto.getCleanlinessStar()+dto.getCommunicationStar()+dto.getAccuracyStar()+dto.getLocationStar()))/4*10)/10.0);
			
			if (!promotionDiscountDtos.isEmpty()) {
				merge.setIsDiscountPromotion(true);
			};
			
			merge.setIsOfferPromotion(promotionService.getIsOfferPromotion(dto.getNo(), date1, date2));
			
			mergeAccommoListDtos.add(merge);
			// System.out.println(merge);
		}
		
		return mergeAccommoListDtos;
	}
	

}
