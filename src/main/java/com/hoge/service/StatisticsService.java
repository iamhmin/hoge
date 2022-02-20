package com.hoge.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hoge.dto.LabelDataDto;
import com.hoge.mapper.StatisticsMapper;

/**
 * 
 * @author 성하민
 *
 */
@Service
public class StatisticsService {

	
	@Autowired
	private StatisticsMapper statisticsMapper;
	
	public List<LabelDataDto> getRegisterCountPerDayDto(){
		return statisticsMapper.getRegisterCountPerDayDto();
	}
	
	public List<LabelDataDto> getTransactionAmountPerDay(){
		return statisticsMapper.getTransactionAmountPerDay();
	}
	
	 public List<LabelDataDto> getSalesPerDayByHostNo(int no){
		 return statisticsMapper.getSalesPerDayByHostNo(no);
	 }
	 
	 public List<LabelDataDto> getProfitAmountPerMonth(){
		 return statisticsMapper.getProfitAmountPerMonth();
	 }

	 	public int getTodayJoinCount() {
	 		return  statisticsMapper.getTodayJoinCount();
	 		
	 	}
		public int getTodayLeftCount() {
			
			return statisticsMapper.getTodayLeftCount();//오늘 탈퇴한 회원수
		}
		public int getTodayAccommoReviewCount() {
			return  statisticsMapper.getTodayAccommoReviewCount();	
		}
		
		public int getTodayActivityReviewCount() {
			return statisticsMapper.getTodayActivityReviewCount();
			
		}
		
		public int getNotAnsweredUserQna() {
			return statisticsMapper.getNotAnsweredUserQna();
			
		}
		
		public int getNotAnsweredHostQna() {
			return statisticsMapper.getNotAnsweredHostQna();
			
		}
		
		public int getTodayTransactionCount() {
			return statisticsMapper.getTodayTransactionCount();
			
		}
		
		public int getTodayCancelTransactionCount() {
			return statisticsMapper.getTodayCancelTransactionCount();
		}
		
		public int getAccommoWaitingCount() {
			return statisticsMapper.getAccommoWaitingCount();
		}
		
		public int getActivityWaitingCount() {
			return statisticsMapper.getActivityWaitingCount();
		}
		
		public int getDiscountPromotionWaitingCount() {
			return statisticsMapper.getDiscountPromotionWaitingCount();
		}
		
		public int getOfferPromotionWaitingCount() {
			return statisticsMapper.getOfferPromotionWaitingCount();
			
		}
		
		
		
		public long getCancelAmountThisMonth() {
			return statisticsMapper.getCancelAmountThisMonth();
			
		}
		public long getDepositAmountThisMonth() {
			return statisticsMapper.getDepositAmountThisMonth();
			
		}
		public long getWithdrawalAmountThisMonth() {
			return statisticsMapper.getWithdrawalAmountThisMonth();
			
		}
	 
		
	
}
