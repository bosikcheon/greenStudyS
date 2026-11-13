package com.spring.greenStudyS.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {

	@RequestMapping(value = "/message/{msgFlag}", method = RequestMethod.GET)
	public String messageGet(@PathVariable String msgFlag, Model model,
			@RequestParam(name="mid", defaultValue = "", required = false) String mid
		) {
		
		if(msgFlag.equals("guestInputOk")) {
			model.addAttribute("message", "방명록에 글이 작성 되었습니다.");
			model.addAttribute("url", "/guest/guestList");
		}
		else if(msgFlag.equals("guestInputNo")) {
			model.addAttribute("message", "방명록에 글 작성 실패~~~");
			model.addAttribute("url", "/guest/guestInput");
		}
		else if(msgFlag.equals("guestAdminCheckOk")) {
			model.addAttribute("message", "관리자 인증 성공");
			model.addAttribute("url", "/guest/guestList");
		}
		else if(msgFlag.equals("guestAdminCheckNo")) {
			model.addAttribute("message", "관리자 인증 실패~~");
			model.addAttribute("url", "/guest/guestAdminCheck");
		}
		else if(msgFlag.equals("fileUploadOk")) {
			model.addAttribute("message", "파일 업로드 성공");
			model.addAttribute("url", "/study/fileUpload");
		}
		else if(msgFlag.equals("fileUploadNo")) {
			model.addAttribute("message", "파일 업로드 실패~~");
			model.addAttribute("url", "/study/fileUpload");
		}
		else if(msgFlag.equals("mailSendOk")) {
			model.addAttribute("message", "메일을 발송하였습니다.");
			model.addAttribute("url", "/study/mailForm");
		}
		else if(msgFlag.equals("mailSendNo")) {
			model.addAttribute("message", "메일 전송 오류~~");
			model.addAttribute("url", "/study/mailForm");
		}
		else if(msgFlag.equals("idDuplicateError")) {
			model.addAttribute("message", "아이디가 중복되었습니다.");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("nickNameDuplicateError")) {
			model.addAttribute("message", "닉네임이 중복되었습니다.");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("nickNameError")) {
			model.addAttribute("message", "닉네임이 중복되었습니다.");
			model.addAttribute("url", "/member/memberUpdate");
		}
		else if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("message", "회원 가입 되었습니다.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("memberJoinNo")) {
			model.addAttribute("message", "회원 가입 실패~~");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("memberLoginOk")) {
			model.addAttribute("message", mid + "님 로그인 되었습니다.");
			model.addAttribute("url", "/member/memberMain");
		}
		else if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("message", "로그인 실패~~");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("memberLogout")) {
			model.addAttribute("message", mid + "님 로그아웃되었습니다.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("memberUpdateOk")) {
			model.addAttribute("message", "회원님 정보가 수정되었습니다.");
			model.addAttribute("url", "/member/memberMain");
		}
		else if(msgFlag.equals("memberUpdateNo")) {
			model.addAttribute("message", "회원님 정보 수정 실패!!");
			model.addAttribute("url", "/member/memberUpdate");
		}
		else if(msgFlag.equals("adminNo")) {
			model.addAttribute("message", "로그인후 사용하세요.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("memberNo")) {
			model.addAttribute("message", "로그인후 사용하세요.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("memberLevelNo")) {
			model.addAttribute("message", "회원등급을 확인하세요.");
			model.addAttribute("url", "/member/memberMain");
		}
		
		
		return "include/message";
	}
	
}
