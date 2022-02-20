package com.hoge.exception;

/**
 * LoginException을 발생시키기 위한 클래스
 * @author 이승준
 *
 */
public class LoginException extends CustomException {

	private static final long serialVersionUID = 5417052090947671970L;

	public LoginException(String message) {
		super(message);
	}
}
