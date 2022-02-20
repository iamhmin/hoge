package com.hoge.exception;

/**
 * CustomException을 발생시키기 위한 클래스
 * @author 이승준
 *
 */
public class CustomException extends RuntimeException {

	private static final long serialVersionUID = 7921081264408280333L;

	public CustomException(String message) {
		super(message);
	}
}
