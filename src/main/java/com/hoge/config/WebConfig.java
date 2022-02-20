package com.hoge.config;

import java.util.List;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.hoge.config.auth.LoginedUserArgumentResolver;

import lombok.RequiredArgsConstructor;

@Configuration
@RequiredArgsConstructor
public class WebConfig implements WebMvcConfigurer {
    private final LoginedUserArgumentResolver loginUserArgumentResolver;
    
    @Override
    public void addArgumentResolvers(
    		List<org.springframework.web.method.support.HandlerMethodArgumentResolver> argumentResolvers) {
    	argumentResolvers.add(loginUserArgumentResolver);
    }

}