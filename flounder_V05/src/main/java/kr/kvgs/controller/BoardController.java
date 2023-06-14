package kr.kvgs.controller;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.kvgs.entity.Community;
import kr.kvgs.entity.DetectDis;
import kr.kvgs.entity.Dis_search;
import kr.kvgs.entity.HistoryDetail;
import kr.kvgs.entity.Member;
import kr.kvgs.entity.Reply;
import kr.kvgs.entity.ShareDetail;
import kr.kvgs.mapper.BoardMapper;


@Controller
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	@Autowired
	private BoardMapper mapper;
	
	@RequestMapping("/community")
	public String community(Model model) {
		logger.info("BoardController getCommunity");
		
		List<Community> list_comm = mapper.getCommunity();
		model.addAttribute("list_comm", list_comm);
		
		return "board/05_share";
	}

	@RequestMapping("/history")
	public String history(Model model, HttpSession session) {
		logger.info("BoardController history");
		Member mvo;
		
		mvo = (Member) session.getAttribute("mvo");
		logger.info(" history email : {}, name : {}", mvo.getM_email(), mvo.getM_name());
		
		List<DetectDis> list_detect = mapper.getHistory(mvo);
		model.addAttribute("list_detect", list_detect);
		
		return "board/07_history";
	}
	
	@RequestMapping("/search")
	public String search(String str_search, Model model, HttpSession session) {
				
		logger.info("BoardController search str_search {}", str_search);
		
//		str_search = "바이러스";
		List<Dis_search> list_search= mapper.getSearch(str_search);
		model.addAttribute("list_search", list_search);
		
		return "board/04_search";
	}
	
	@RequestMapping("/search_detail")
	public String search_detail(int ds_id, Model model, HttpSession session) {
				
		logger.info("BoardController search str_search {}", ds_id);
		
		String search_url = mapper.getDsDetail(ds_id);
		model.addAttribute("search_url", search_url);
		
		return "board/09_search_detail";
	}
	
	@RequestMapping("/share_detail")
	public String share_detail(int c_id, Model model) {
				
		logger.info("***** BoardController shareDetail *****{}", c_id);
		
		ShareDetail sd_one = mapper.getShareDetail(c_id);
		logger.info("***** BoardController return ***** {}, {}", 
				sd_one.getTitle() , sd_one.getC_id());
		
		model.addAttribute("share_detail", sd_one);
		
		logger.info("***** pppppppppppppppppppppppp *****{}", sd_one.getC_id());
		
		// 댓글 뿌려주는 리스트 형식 만들기 
		List<Reply> reply = mapper.getReply(c_id);
		model.addAttribute("reply", reply);
		
		return "board/06_share_detail";
	}
	
	@RequestMapping("/history_detail")
	public String history_detail(int dd_id, Model model) {
				
		logger.info("***** BoardController shareDetail *****{}", dd_id);
		
		HistoryDetail history_detail = mapper.getHistoryDetail(dd_id);
		logger.info("***** BoardController return *****{}", dd_id);
		
		model.addAttribute("history_detail", history_detail);
		
		return "board/08_history_detail";
	}

	@RequestMapping("/history_remove")
	public String history_remove(int dd_id)
	{
		mapper.history_remove(dd_id);
		return "redirect:/history";
	}
	
	@RequestMapping("/remove")
	public String remove(int c_id) { // ?num=n
		mapper.remove(c_id);
		return "redirect:/community"; //
	}

	@GetMapping("/modify")
	public String modify(int c_id, Model model) {
				
		Community mo = mapper.get(c_id);
		
		System.out.println("확인1 >> "+c_id);
		System.out.println("확인2 >> "+mo);
		
		model.addAttribute("mo", mo);
		
		return "board/11_modify";
	}
	
	
	@PostMapping("/modify")
	public String modify(Community com, RedirectAttributes rttr, MultipartFile file, HttpServletRequest request) { // num, title, content
		logger.info("**** BoardController modify *** {} ", file.getOriginalFilename());
		
		String fileName = file.getOriginalFilename(); 
        long fileSize = file.getSize();
        
        String imagePath = request.getServletContext().getRealPath("/");
		String fileExt = fileName.substring(fileName.lastIndexOf("."), fileName.length());
		
		UUID uuid = UUID.randomUUID();
		String uniqueName = uuid.toString();
		
        String fileFullPath = imagePath + "resources\\DATA\\Share_Img\\" + uniqueName + fileExt;
        String fileSaveDB = "/DATA/Share_Img/" + uniqueName + fileExt;
		
        File UploadFolder = new File(imagePath);
        
        logger.info("#############title, c_text################ : {}, {}", com.getTitle(), com.getC_text());
        
        try{
    		if( !UploadFolder.exists() ) {
    			logger.info("BoardController getFile imagePath : {} not exist", imagePath);
    			UploadFolder.mkdir();
    		}
        
			logger.info("BoardController getFile FullPath : {}, FileSize : {}", fileFullPath, fileSize);
	        File destination = new File(fileFullPath);
	        file.transferTo(destination);
        }catch (Exception e){
        	logger.info("에러 : " + e.getMessage());
        }finally {
        	
        }

        com.setImg_path(fileSaveDB); 
        
		// Model --> request 경량화 버전으로 forward방식 사용해서 페이지 이동할 때 jsp에 값을 담아서 보내주는 거 --> el표현식 사용해서 데이터 꺼내기
		// RedirectAttributes --> redirect방식으로 페이지 이동할 때 redirect 이동 url에 데이터를 잠깐 보내줘야 할 때 사용하는 객체
		mapper.modify(com); // --> update구문을 실행하면 return type은 무조건 int!!!!!!!
		rttr.addAttribute("c_id", com.getC_id()); // --> select할 때 c_id가 필요하니까 rttr에 c_id만 담아서 보내주기
		
		return "redirect:/share_detail"; // --> 다시 select 해주는 건 share_detail
	}
	
	@RequestMapping("/write")
	public String comm_write(Community com, RedirectAttributes rttr, MultipartFile file, HttpServletRequest request)
	{
		
		String fileName = file.getOriginalFilename(); 
        long fileSize = file.getSize();
        
        String imagePath = request.getServletContext().getRealPath("/");
		String fileExt = fileName.substring(fileName.lastIndexOf("."), fileName.length());
		
		UUID uuid = UUID.randomUUID();
		String uniqueName = uuid.toString();
		
        String fileFullPath = imagePath + "resources\\DATA\\Share_Img\\" + uniqueName + fileExt;
        String fileSaveDB = "/DATA/Share_Img/" + uniqueName + fileExt;
		
        File UploadFolder = new File(imagePath);
        
        logger.info("#############title, c_text################ : {}, {}", com.getTitle(), com.getC_text());
        
        try{
    		if( !UploadFolder.exists() ) {
    			logger.info("BoardController getFile imagePath : {} not exist", imagePath);
    			UploadFolder.mkdir();
    		}
        
			logger.info("BoardController getFile FullPath : {}, FileSize : {}", fileFullPath, fileSize);
	        File destination = new File(fileFullPath);
	        file.transferTo(destination);
        }catch (Exception e){
        	logger.info("에러 : " + e.getMessage());
        }finally {
        	
        }

        com.setImg_path(fileSaveDB);
		
		mapper.comm_write(com);
		return "redirect:/community";
	}
	
    // 파일전송 요청을 처리하기 위한 컨트롤러
    @RequestMapping("/dd_register")	
    public String dd_register(DetectDis vo, MultipartFile file, HttpServletRequest request, Model model){
		logger.info("BoardController dd_register dd_email : {}, dd_comment : {}", vo.getDd_email(), vo.getDd_comment());
    	
        String fileName = file.getOriginalFilename(); 
        long fileSize = file.getSize();
        
        String imagePath = request.getServletContext().getRealPath("/");
		String fileExt = fileName.substring(fileName.lastIndexOf("."), fileName.length());
		
		UUID uuid = UUID.randomUUID();
		String uniqueName = uuid.toString();
		
        String fileFullPath = imagePath + "resources\\DATA\\DetectImg\\" + uniqueName + fileExt;
        String fileSaveDB = "/DATA/DetectImg/" + uniqueName + fileExt;
		
		logger.info("BoardController dd_register fileFullPath : {}, fileSaveDB : {}", fileFullPath, fileSaveDB);

		File UploadFolder = new File(imagePath);
        try{
    		if( !UploadFolder.exists() ) {
    			logger.info("BoardController getFile imagePath : {} not exist", imagePath);
    			UploadFolder.mkdir();
    		}
        
			logger.info("BoardController getFile FullPath : {}, FileSize : {}", fileFullPath, fileSize);
	        File destination = new File(fileFullPath);
	        file.transferTo(destination);
        }catch (Exception e){
        	logger.info("에러 : " + e.getMessage());
        }finally {
        	
        }

        vo.setOrg_img(fileSaveDB);
		int iRet = mapper.dd_insert(vo);
        
        return "redirect:/history";
    }	
    
    @RequestMapping("/reply")
	public String reply(Reply re, RedirectAttributes rttr) {
    	
    	mapper.reply_insert(re);
    	rttr.addAttribute("c_id", re.getC_id());
		// model.addAttribute("c_id", re.getC_id());
		
		// 댓글을 적은 해당 게시글 가져오기
		/*Community cm = mapper.get(re.getC_id());
		model.addAttribute("", cm); */
		
		return "redirect:/share_detail";
	}
    
    @RequestMapping("/detect")
    public String detect() {
    	logger.info(" BoardController : {}.", "detect");
    	return "board/03_detect";
    }

	@GetMapping("/detect_reg") 
	public String detect_reg(String dis_name, String org_image, String pred_image, Model model, HttpServletRequest request) {
    	logger.info("BoardController org_img : {}, pred_img : {}", org_image, pred_image);
        String imagePath = request.getServletContext().getRealPath("/");
    	logger.info("BoardController imagePath : {}", imagePath);

    	model.addAttribute("dis_name", dis_name);		
    	model.addAttribute("org_image", org_image);		
		model.addAttribute("pred_image", pred_image);		
    	return "board/53_detect_reg";
	}
	
	
	

    // 파일전송 요청을 처리하기 위한 컨트롤러
    @RequestMapping("/dd_register2")	
    public String dd_register2(DetectDis vo, HttpServletRequest request, Model model){
        logger.info("BoardController dd_register2 dd_email : {}, dd_comment : {}", vo.getDd_email(), vo.getDd_comment());
        logger.info("****** dd_register2 dd_email : {}, dd_comment : {}", vo.getDt_img(), vo.getOrg_img());
		int iRet = mapper.dd_insert(vo);
        
        return "redirect:/history";
    }	
    
	
	
}
