package com.hoge.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.hoge.dto.LabelDataDto;



@Mapper
public interface StatisticsMapper {
	
	List<LabelDataDto> getRegisterCountPerDayDto();
	
	List<LabelDataDto> getSalesPerDayByHostNo(int no);
	
	
	List<LabelDataDto> getTransactionAmountPerDay();
	
	List<LabelDataDto> getProfitAmountPerMonth();
	
	
	int getTodayJoinCount();//오늘 가입한 회원수
	int getTodayLeftCount();//오늘 탈퇴한 회원수
	int getTodayAccommoReviewCount(); //오늘 숙소리뷰 카운트
	int getTodayActivityReviewCount(); //오늘 체험리뷰 카운트

	int getNotAnsweredUserQna();
	int getNotAnsweredHostQna();
	int getTodayTransactionCount();
	int getTodayCancelTransactionCount();

	int getAccommoWaitingCount();
	int getActivityWaitingCount();
	int getDiscountPromotionWaitingCount();
	int getOfferPromotionWaitingCount();
	
	long getCancelAmountThisMonth();
	long getDepositAmountThisMonth();
	long getWithdrawalAmountThisMonth();
	
	
	   
	
}
