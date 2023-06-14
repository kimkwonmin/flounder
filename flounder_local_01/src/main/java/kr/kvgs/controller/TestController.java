package kr.kvgs.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.kvgs.entity.Community;
import kr.kvgs.entity.DetectDis;
import kr.kvgs.entity.Member;
import kr.kvgs.mapper.BoardMapper;


@Controller  // 컨트롤러로 인식을한다.
public class TestController {
	private static final Logger logger = LoggerFactory.getLogger(TestController.class);
	@Autowired
	private BoardMapper mapper;

	
	   @RequestMapping("/00")
	   public String test00() {
			logger.info(" TestController : {}.", "test00");
			
			return "board/00_intro";
	   }

	   @RequestMapping("/01")
	   public String test01() {
			logger.info(" TestController : {}.", "test01");
			
			return "board/01_login";
	   }

	   @RequestMapping("/02")
	   public String test02() {
			logger.info(" TestController : {}.", "test02");
			
			return "board/02_info";
	   }
	   
	   @RequestMapping("/03")
	   public String test03() {
			logger.info(" TestController : {}.", "test03");
			
			return "board/03_detect";
	   }
	   
	   @RequestMapping("/04")
	   public String test04() {
			logger.info(" TestController : {}.", "test04");
			
			return "board/04_search";
	   }
	   
	   @RequestMapping("/05")
		public String test05(Model model) {
			logger.info(" TestController : {}.", "test05");
			
			List<Community> list_comm = mapper.getCommunity();
			model.addAttribute("list_comm", list_comm);
			
			return "board/05_share";
		}

	   
	   @RequestMapping("/06")
	   public String test06() {
			logger.info(" TestController : {}.", "test06");
			
			return "board/06_share_detail";
	   }
	   
	   @RequestMapping("/07")
		public String test07(Model model, HttpSession session) {
			logger.info("BoardController history");
			Member mvo;
			
			mvo = (Member) session.getAttribute("mvo");
			logger.info(" history email : {}, name : {}", mvo.getM_email(), mvo.getM_name());
			
			List<DetectDis> list_detect = mapper.getHistory(mvo);
			model.addAttribute("list_detect", list_detect);
			
			return "board/07_history";
		}
	   
	   @RequestMapping("/08")
	   public String test08() {
			logger.info(" TestController : {}.", "test08");
			
			return "board/08_history_detail";
	   }

	   @RequestMapping("/09")
	   public String test09() {
			logger.info(" TestController : {}.", "test09");
			
			return "board/09_search_detail";
	   }
	   @RequestMapping("/99")
	   public String test99() {
			logger.info(" TestController : {}.", "test99");
			
			return "board/99_template";
	   }

	   @RequestMapping("/51")
	   public String test51() {
			logger.info(" TestController : {}.", "test51");
			
			return "board/51_img_file_up";
	   }

	   @RequestMapping("/52")
	   public String test52() {
			logger.info(" TestController : {}.", "test52");
			
			return "board/52_FileUpload_drag";
	   }
	   
	   @RequestMapping("/53")
	   public String test53() {
			logger.info(" TestController : {}.", "test53");
			
			return "board/53_detect_reg";
	   }
	   
	   @RequestMapping("/writer")
	   public String testwriter() {
			logger.info(" TestController : {}.", "test00");
			
			return "board/10_share_writer";
	   }

	   
}
