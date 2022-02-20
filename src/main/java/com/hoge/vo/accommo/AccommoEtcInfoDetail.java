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
public class AccommoEtcInfoDetail {
	
	private int etcInfoNo;
	private int contentNo;
	private String content;
}
