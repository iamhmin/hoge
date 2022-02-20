package com.hoge.vo.other;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

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
public class PromotionOffer {

	private int no;
	private int hostNo;
	private String content; //증정 내용
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startingDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endingDate;
	private Date registeredDate;
	private String introContent; //기본적인 소개 내용
	private String status; // w(승인대기), Y(승인완료), N(승인거절), D(종료)
}
