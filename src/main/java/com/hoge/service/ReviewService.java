package com.hoge.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hoge.dto.AccReviewDto;
import com.hoge.dto.ActReviewDto;
import com.hoge.dto.AdminAccommoReviewDto;
import com.hoge.dto.AdminActivityReviewDto;
import com.hoge.dto.UserRevInfoDto;
import com.hoge.form.Criteria;
import com.hoge.mapper.ReviewMapper;
import com.hoge.vo.accommo.AccommoImage;
import com.hoge.vo.other.ReviewAccommo;

/**
 * 
 * @author 성하민
 *
 */
@Service
public class ReviewService {

	
	@Autowired
	private ReviewMapper reviewMapper;
	
	
	public List<AdminAccommoReviewDto> getAccommoReviewsByCriteria(Criteria criteria){
		return reviewMapper.getAccommoReviewsByCriteria(criteria);
	}
	
	
	
	public int getAccommoReviewsTotalRows(Criteria criteria) {
		return reviewMapper.getAccommoReviewsTotalRows(criteria);
	}
	
	public List<AdminActivityReviewDto> getActivityReviewsByCriteria(Criteria criteria){
		return reviewMapper.getActivityReviewsByCriteria(criteria);
	}
	
	
	
	public int getActivityReviewsTotalRows(Criteria criteria) {
		return reviewMapper.getActivityReviewsTotalRows(criteria);
	}
	
	

	//성하민 호스트페이지 메인에서 최근 3일 리뷰건수 가져오기
	public int getRecentReviewCountByActivityNo(int no) {
		return reviewMapper.getRecentReviewCountByActivityNo(no);
	}
	
	//성하민 호스트페이지 메인에서 최근 3일 리뷰데이터 가져오기
	public List<AdminActivityReviewDto> getRecentReviewListByActivityNo(Criteria criteria){
		return reviewMapper.getRecentReviewListByActivityNo(criteria);
	}
	
	//성하민 호스트페이지 메인에서 오늘 리뷰건수 가져오기
	public int getTodayReviewCountByActivityNo(int no) {
		return reviewMapper.getTodayReviewCountByActivityNo(no);
	}
	
	//성하민 호스트페이지 메인에서 최근 3일 리뷰건수 가져오기
	public int getRecentReviewCountByAccommoNo(int no) {
		return reviewMapper.getRecentReviewCountByAccommoNo(no);
	}
	
	//성하민 호스트페이지 메인에서 최근 3일 리뷰데이터 가져오기
	public List<AdminAccommoReviewDto> getRecentReviewListByAccommoNo(Criteria criteria){
		return reviewMapper.getRecentReviewListByAccommoNo(criteria);
	}
	
	//성하민 호스트페이지 메인에서 오늘 리뷰건수 가져오기
	public int getTodayReviewCountByAccommoNo(int no) {
		return reviewMapper.getTodayReviewCountByAccommoNo(no);
	}
	
	//이승준: 리뷰 인서트
	public void insertAccommoReview(ReviewAccommo accommoReviewInfo) {
		reviewMapper.insertAccommoReview(accommoReviewInfo);
	}
	
	//이승준: 리뷰 업데이트
	public void updateAccommReview(ReviewAccommo accommoReviewInfo) {
		reviewMapper.updateAccommReview(accommoReviewInfo);
	}
	
	 public AdminAccommoReviewDto getAccommoReviewsDtoByReviewNo(int no) {
		 return reviewMapper.getAccommoReviewsDtoByReviewNo(no);
	 }
	
	 public void answerUpdateAccommReview(ReviewAccommo reviewAccommo) {
		 reviewMapper.answerUpdateAccommReview(reviewAccommo);
	 }
	 
	 public ReviewAccommo getAccommoReviewByReviewNo(int no) {
		 return reviewMapper.getAccommoReviewByReviewNo(no);
	 }


	 // 유상효 숙소 디테일 리뷰 조회
	public List<AccReviewDto> getAccDetailReviews(int accNo) {
		return reviewMapper.getAccDetailReviews(accNo);
	}
	public List<AccReviewDto> getAccDetailReviews6(int accNo) {
		return reviewMapper.getAccDetailReviews6(accNo);
	}
	public AccReviewDto getAccDetailStar(int accNo) {
		return reviewMapper.getAccDetailStar(accNo);
	}
	public AccReviewDto getAccDetailReviewsTotal(int accNo) {
		return reviewMapper.getAccDetailReviewsTotal(accNo);
	}


	// 유상효 객실 디테일 리뷰 조회
	public List<ActReviewDto> getActDetailReviews(int actNo) {
		return reviewMapper.getActDetailReviews(actNo);
	}
	public List<ActReviewDto> getActDetailReviews6(int actNo) {
		return reviewMapper.getActDetailReviews6(actNo);
	}
	public ActReviewDto getActDetailStar(int actNo) {
		return reviewMapper.getActDetailStar(actNo);
	}
	public ActReviewDto getActDetailReviewsTotal(int actNo) {
		return reviewMapper.getActDetailReviewsTotal(actNo);
	}



	
}
