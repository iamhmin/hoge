package com.hoge.exception;

/**
 * AdminException을 발생시키기 위한 클래스
 * @author 성하민
 *
 */
public class AdminException extends CustomException {

	private static final long serialVersionUID = -5513532787464640888L;

	public AdminException(String message) {
		super(message);
	}
}
