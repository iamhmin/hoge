package com.hoge.vo.accommo;

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
public class AccommoEtcInfo {
	
	private int no;
	private String title;
	private int accommoNo;
	private int type;
}
