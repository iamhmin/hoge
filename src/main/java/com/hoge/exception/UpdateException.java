package com.hoge.exception;

/**
 * FindException을 발생시키기 위한 클래스
 * @author 이승준
 *
 */
public class UpdateException extends CustomException {

	private static final long serialVersionUID = 5417052090947671970L;

	public UpdateException(String message) {
		super(message);
	}
}
