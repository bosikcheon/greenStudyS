package com.spring.greenStudyS.controller;

import java.util.List;

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
import com.spring.greenStudyS.common.ProjectProvide;
import com.spring.greenStudyS.service.AdminService;
import com.spring.greenStudyS.service.MemberService;
import com.spring.greenStudyS.vo.MemberVO;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	AdminService adminService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	PagiNation pagiNation;
	
	@Autowired
	ProjectProvide projectProvide;
	
	@GetMapping("/adminMain")
	public String adminMainGet() {
		return "admin/adminMain";
	}
	
	@GetMapping("/adminRight")
	public String adminRightGet() {
		return "admin/adminRight";
	}
	
	@GetMapping("/adminLeft")
	public String adminLeftGet() {
		return "admin/adminLeft";
	}
	
	@GetMapping("/memberList")
	public String memberListGet(Model model, PageVO pageVO,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "10", required = false) int pageSize
		) {
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setSection("member");
		pageVO = pagiNation.getTotRecCnt(pageVO);
		
		List<MemberVO> vos = adminService.getMemberList(pageVO.getStartIndexNo(), pageSize);
		model.addAttribute("vos", vos);
		return "admin/member/memberList";
	}
	
	@GetMapping("/memberContent")
	public String memberContentGet(Model model, String mid) {
		MemberVO vo = memberService.getMemberIdCheck(mid);
		model.addAttribute("vo", vo);
		return "admin/member/memberContent";
	}
	
	// 선택된 회원등급 일관 변경( 11/25/33/42)
	@ResponseBody
	@PostMapping("/memberLevelSelectCheck")
	public String memberLevelSelectCheckPost(String idxSelectArray, int levelItem) {
		String[] idxSelectArrays = idxSelectArray.split("/");
		for(int i=0; i<idxSelectArrays.length; i++) {
			int idx = Integer.parseInt(idxSelectArrays[i]);
			adminService.setMemberLevelSelectCheck(idx, levelItem);
		}
		return "1";
	}
	
	// 탈퇴신청된 회원 영구삭제처리
	@ResponseBody
	@PostMapping("/memberDeleteOk")
	public String memberDeleteOkPost(int idx, String photo) {
		if(!photo.equals("noimage.jpg")) projectProvide.deleteFile(photo, "member");
		
		return adminService.setMemberDeleteOk(idx) + "";
	}
	
	
	
}
