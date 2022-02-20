package com.hoge.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.hoge.dto.ActivityListDto;
import com.hoge.dto.ActivityPagination;
import com.hoge.dto.MapArea;
import com.hoge.form.Criteria;
import com.hoge.pagination.Pagination;
import com.hoge.service.ActivityService;

@RestController
@RequestMapping("/rest/activity")
public class ActivityRestController {
	
	@Autowired
	private ActivityService activityService;
	
	@GetMapping("/mapArea")
	public ActivityPagination list(MapArea mapArea) throws Exception {
//		System.out.println("================================");
//		System.out.println(mapArea.getCheckIn());
//		System.out.println(mapArea.getPage());
//		System.out.println(mapArea.getNeLat());
//		System.out.println("================================");
		ActivityPagination activityPagination = new ActivityPagination();
		
		int totalRecords = activityService.getTotalRows(mapArea);
		//System.out.println(totalRecords);
		
		Pagination pagination = new Pagination(mapArea.getPage(), totalRecords, 5);
		
		Criteria criteria = new Criteria();
		
		criteria.setBeginIndex(pagination.getBegin());
		criteria.setEndIndex(pagination.getEnd());
		
		List<ActivityListDto> dtos = activityService.getActivityDtos(mapArea, criteria);
		
		for (ActivityListDto dto : dtos) {
			System.out.println(dto);
		}
		
		activityPagination.setPagination(pagination);
		activityPagination.setActivities(dtos);
		
		return activityPagination;
	}
	
}
