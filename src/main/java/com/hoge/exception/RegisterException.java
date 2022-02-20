package com.hoge.exception;

/**
 * LoginException을 발생시키기 위한 클래스
 * @author 이승준
 *
 */
public class RegisterException extends CustomException {

	private static final long serialVersionUID = -5513532787102860888L;

	public RegisterException(String message) {
		super(message);
	}
}
