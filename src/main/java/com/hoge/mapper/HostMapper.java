package com.hoge.mapper;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.hoge.dto.AccListDto;
import com.hoge.dto.AccMainDto;
import com.hoge.dto.ActListDto;
import com.hoge.dto.ActMainDto;
import com.hoge.form.AccInfoForm;
import com.hoge.vo.accommo.AccommoImage;
import com.hoge.vo.accommo.Accommodation;
import com.hoge.vo.activities.Activity;
import com.hoge.vo.activities.ActivityImage;
import com.hoge.vo.other.Host;
import com.hoge.vo.other.PromotionDiscount;
import com.hoge.vo.other.PromotionOffer;
import com.hoge.vo.other.User;

/**
 * 유저 기능에 관한 메서드명을 정의하였다.
 * @author 유상효, 성하민
 *
 */
@Mapper
public interface HostMapper {
	
	// 유상효 호스트 등록
	void insertHostApply(Host host);
	// 유상효 숙소 등록
	void insertAcc(Accommodation acc);
	// 유상효 체험 등록
	void insertAct(Activity act);
	// 유상효 로그인세션에서 userNo 가져오기
	int getUserNoByUserId(String userId);
	// 유상효 로그인세션에서 userId를 받아와서 hostNo 가져오기(hostNo중 가장 큰 넘버를 가져온다)
	int getHostNoByUserId(String userId);
	// 유상효 호스트 상태 업데이트
	void userIsHostUpdate(int userNo);
	
	// 유상효 이미지 저장 & 이미지 불러오기
	void insertAccImage(AccommoImage accommoImage);
	void insertActImage(ActivityImage activityImage);
	List<AccommoImage> getAccImagesByAccNo(int accNo);
	List<AccommoImage> getAccImagesByHostNo(int hostNo);
	List<ActivityImage> getActImagesByActNo(int actNo);
	List<ActivityImage> getActImagesByHostNo(int hostNo);
	
	// 유상효 유저넘버로 호스팅리스트 찾기
	List<AccListDto> getAccListByUserNo(int userNo);
	List<ActListDto> getActListByUserNo(int userNo);
	
	// 유상효 호스트넘버로 정보 찾기
	AccMainDto getAccMainByHostNo(int hostNo);
	ActMainDto getActMainByHostNo(int hostNo);
	
	// 유상효 호스트넘버로 호스트수정
	void modifyHostByHostNo(Host host);
	void modifyAccByHostNo(Accommodation acc);
	void modifyActByHostNo(Activity act);
	void modifyAccImagesByHostNo(List<AccommoImage> accImages);
	void modifyActImagesByHostNo(List<ActivityImage> actImages);

	// 유상효 할인 프로모션 등록
	void addPromotionDiscount(PromotionDiscount promotionDiscount);
	
	// 유상효 증정 프로모션 등록
	void addPromotionOffer(PromotionOffer promotionOffer);
	
	// 유상효 프로모션 리스트
	List<PromotionDiscount> getPromotionDiscountByHostNo(int hostNo);
	List<PromotionDiscount> getPromotionDiscountByHostNoAndStatusY(int hostNo);
	List<PromotionDiscount> getPromotionDiscountByHostNoAndStatusW(int hostNo);
	List<PromotionDiscount> getPromotionDiscountByHostNoAndStatusN(int hostNo);
	List<PromotionDiscount> getPromotionDiscountByHostNoAndStatusD(int hostNo);
	List<PromotionOffer> getPromotionOfferByHostNo(int hostNo);
	List<PromotionOffer> getPromotionOfferByHostNoAndStatusY(int hostNo);
	List<PromotionOffer> getPromotionOfferByHostNoAndStatusW(int hostNo);
	List<PromotionOffer> getPromotionOfferByHostNoAndStatusN(int hostNo);
	List<PromotionOffer> getPromotionOfferByHostNoAndStatusD(int hostNo);
	
	// 유상효 프로모션 번호로 할인프로모션 조회
	PromotionDiscount getPromotionDiscountByPromotionNo(int no);
	
	// 유상효 프로모션 번호로 증정프로모션 조회
	PromotionOffer getPromotionOfferByPromotionNo(int no);
	
	// 유상효 할인프로모션 수정
	void modifyPromotionDiscount(PromotionDiscount promotionDiscount);
	
	// 유상효 증정프로모션 수정
	void modifyPromotionOffer(PromotionOffer promotionOffer);
	
	// 호스트 번호로 호스트객체 반환
	Host getHostByNo(int no);
	

	void insertAccomadation(Accommodation acc);

	void insertActivity(Activity act);
	

	
	
	//성하민
	void updateHost(Host host);
	
	// 유상효 부대시설 및 기타 안내 등록
	void addAccInfo(AccInfoForm form);
	void addAccInfoDetail(AccInfoForm form);
	void addActInfo(AccInfoForm form);
	void addActInfoDetail(AccInfoForm form);
	
	

}
