package com.hoge.vo.other;

import java.util.Date;

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
public class User {

	private int no;
	private String id;
	private String isHost;
	private String name;
	private String pwd;
	private String email;
	private String tel;
	private Date registeredDate;
	private String deleted;
	private long pnt;
	private String image;
	private String gender;
	private String reportedCount;
	
}
