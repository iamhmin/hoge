package com.hoge.service;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.hoge.dto.MailDto;
import com.hoge.mapper.UserMapper;
import com.hoge.vo.other.User;

/**
 * 인증메일 서비스
 * @author 이승준
 *
 */
@Service
public class SendEmailService {
	
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private JavaMailSender mailSender;
	
    // 이승준: 임시비밀번호를 포함한 이메일생성
    public MailDto createMailAndChangePassword(String id, String email){
    	User savedUser = userService.getUserByEmail(email);
    	String str = getTempPassword();
        MailDto mailDto = new MailDto();
        mailDto.setAddress(savedUser.getEmail());
        mailDto.setTitle(savedUser.getName() + "님의 임시패스워드 안내.. :)");
        mailDto.setMessage("안녕하세요. 임시패스워드 안내 관련 이메일 입니다." 
        				+ "[" + savedUser.getName() + "]" +"님의 임시 비밀번호는 " + str + " 입니다."
        				+ "로그인 하신 후 패스워드를 수정해주시기 바랍니다.");
        
        // 임시비번 암호화
        String authPwd = DigestUtils.sha512Hex(str);
    	savedUser.setPwd(authPwd);
        userMapper.updateUser(savedUser);
        
        return mailDto;
    }
    
    // 이승준: 이메일 전송
    public void mailSend(MailDto mailDto){
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(mailDto.getAddress());
        message.setSubject(mailDto.getTitle());
        message.setText(mailDto.getMessage());

        mailSender.send(message);
        System.out.println("이멜 전송 완료!");
    }
    
    // 이승준: 난수 생성
    public String getTempPassword(){
        char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
                'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };

        String str = "";

        int idx = 0;
        for (int i = 0; i < 10; i++) {
            idx = (int) (charSet.length * Math.random());
            str += charSet[idx];
        }
        return str;
    }
		
}