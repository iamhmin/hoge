package com.hoge.config.auth;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.core.MethodParameter;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import com.hoge.util.SessionUtils;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class LoginedUserArgumentResolver implements HandlerMethodArgumentResolver{
	
	private final HttpSession httpSession;

	static final Logger logger = LogManager.getLogger(LoginedUserArgumentResolver.class);
	
	@Override
	public boolean supportsParameter(MethodParameter parameter) {
//		logger.info("@LoginedUser 어노테이션을 가지고 있는가? " + parameter.hasParameterAnnotation(LoginedUser.class));
//		logger.info("매개변수의 클래스이름: " + parameter.getParameterType().getName());
//		logger.info("매개변수의 이름: " + parameter.getParameterName());
		
		return parameter.hasParameterAnnotation(LoginedUser.class);
	}

	@Override
	public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer,
			NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
		// logger.info("@LoginedUser이 부착된 매개변수다. HttpSession객체에 저장된 인증된 사용자정보를 매개변수로 전달한다.");
		// HttpSession객체에 "LOGIN_USER"라는 속성명으로 저장된 사용자정보를 반환한다.
		return httpSession.getAttribute("LOGIN_USER");
	}
}
