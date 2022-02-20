package com.hoge.dto;

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
public class HogeUserDto {

	private String id;
	private String name;
	private String pwd;
	private String email;
	private String tel;
	private String gender;
}