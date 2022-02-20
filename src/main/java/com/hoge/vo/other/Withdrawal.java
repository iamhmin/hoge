package com.hoge.vo.other;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

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
public class Withdrawal {

	private int no;
	private int hostNo;
	private String accountHolderName;
	private long accountNumber;
	private String bankName;
	private long amount;
	private String status;
	@JsonFormat(pattern = "yyyy년 M월 d일")
	private Date createdDate;
}
