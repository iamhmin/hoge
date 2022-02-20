package com.hoge.dto;

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
public class WithdrawalHostDto {

	private int withdrawalNo;
	private int hostNo;
	private String hostName;
	private String accountHolderName;
	private long accountNumber;
	private String bankName;
	private long amount;
	private String status;
	@JsonFormat(pattern = "yyyy.MM.dd")
	private Date createdDate;
}
