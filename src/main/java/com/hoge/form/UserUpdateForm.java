package com.hoge.form;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UserUpdateForm {

	private String name;
	private String email;
	private String tel;
	private MultipartFile myProfile;
}