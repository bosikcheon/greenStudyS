package com.spring.greenStudyS.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.greenStudyS.common.PageVO;
import com.spring.greenStudyS.common.PagiNation;
import com.spring.greenStudyS.service.GuestService;
import com.spring.greenStudyS.vo.GuestVO;
import com.spring.greenStudyS.vo.User2VO;

//@Slf4j
@Controller
@RequestMapping("/guest")
public class GuestController {

	@Autowired
	GuestService guestService;
	
	@Autowired
	PagiNation pagiNation;
		
	/*
	@GetMapping("/guestList")
	public String guestListGet(Model model,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "3", required = false) int pageSize
		) {
		
		int totRecCnt = guestService.getTotRecCnt();	// 전체 레코드 건수
		int totPage = (totRecCnt % pageSize) == 0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		List<GuestVO> vos = guestService.getGuestList(startIndexNo, pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("totRecCnt", totRecCnt);
		model.addAttribute("totPage", totPage);
		model.addAttribute("curScrStartNo", curScrStartNo);
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
		
		return "guest/guestList";
	}
	*/
	
	@GetMapping("/guestList")
	public String guestListGet(Model model, PageVO pageVO,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "3", required = false) int pageSize
		) {
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setSection("guest");
		pageVO = pagiNation.getTotRecCnt(pageVO);
		
		List<GuestVO> vos = guestService.getGuestList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "guest/guestList";
	}
	
	@GetMapping("/guestInput")
	public String guestInputGet() {
		return "guest/guestInput";
	}
	
	@PostMapping("/guestInput")
	public String guestInputPost(GuestVO vo, HttpServletRequest request) {
		vo.setHostIp(request.getRemoteAddr());
		int res = guestService.setGuestInput(vo);
		if(res != 0) return "redirect:/message/guestInputOk";
		else return "redirect:/message/guestInputNo";
	}
	
	@GetMapping("/guestAdminCheck")
	public String guestAdminCheckGet() {
		return "guest/guestAdminCheck";
	}
	
	@GetMapping("/guestAdminLogout")
	public String guestAdminLogoutGet(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/guest/guestList";
	}
	
	@PostMapping("/guestAdminCheck")
	public String guestAdminCheckPost(String mid, String pwd,
			HttpServletRequest request
		) {
		if(!mid.equals("admin")) return "redirect:/message/guestAdminCheckNo";
		
		User2VO vo = guestService.getGuestAdmin();
		System.out.println("vo : " + vo);
		if(vo != null && vo.getPwd().equals(pwd)) {
			HttpSession session = request.getSession();
			session.setAttribute("sMid", "ADMINOK");
			return "redirect:/message/guestAdminCheckOk";
		}
		else return "redirect:/message/guestAdminCheckNo";
	}
	
	@ResponseBody
	@PostMapping("/guestDelete")
	public String guestDeletePost(int idx) {
		return guestService.setGuestDelete(idx) + "";
	}
	
}
