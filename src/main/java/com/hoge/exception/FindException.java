package com.hoge.exception;

/**
 * FindException을 발생시키기 위한 클래스
 * @author 이승준
 *
 */
public class FindException extends CustomException {

	private static final long serialVersionUID = 6450733893561710764L;

	public FindException(String message) {
		super(message);
	}
}
