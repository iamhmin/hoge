package com.hoge.dto;

import java.util.List;

import com.hoge.pagination.Pagination;

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
public class ActivityPagination {
	
	private Pagination pagination;
	private List<ActivityListDto> activities;
}
