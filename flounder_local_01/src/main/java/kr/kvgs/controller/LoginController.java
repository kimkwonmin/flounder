package kr.kvgs.controller;

import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.kvgs.entity.Fuser;
import kr.kvgs.entity.Member;
import kr.kvgs.mapper.BoardMapper;

@Controller  // 컨트롤러로 인식을한다.
public class LoginController {
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

	@Autowired // 외부에 만들어진 객체를 주입하여 연결하는 방법(의존성 주입 : DI)
	private BoardMapper mapper;

	@RequestMapping("/")
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		return "board/00_intro";
	}
	
	
	@RequestMapping("/login") // username, password -> User(X), Member(O)
	public String login(Member mvo, HttpSession session) {
		logger.info("LoginController list {}", mvo);
		logger.info("LoginController list email:{}, pw:{}", mvo.getM_email(), mvo.getM_pw());
		Member vo = mapper.login(mvo);
		if (vo != null) { // 회원인증에 성공
			session.setAttribute("mvo", vo);
			logger.info("LoginController Login Success email:{} name:{}", vo.getM_email(), vo.getM_name());
			return "board/02_info";
		} else
		{
			logger.info("LoginController Login Fail");
			session.invalidate(); // 세션을 무효화
			return "board/01_login";
		}
		
	}

	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate(); // 세션을 무효화
		return "board/02_info";
	}

}
