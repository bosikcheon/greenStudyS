package com.spring.greenStudyS.controller;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.greenStudyS.common.PageVO;
import com.spring.greenStudyS.common.PagiNation;
import com.spring.greenStudyS.common.ProjectProvide;
import com.spring.greenStudyS.service.MemberService;
import com.spring.greenStudyS.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	ProjectProvide projectProvide;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	PagiNation pagiNation;
	
	
	@GetMapping("/memberLogin")
	public String memberLoginGet(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		
		if(cookies != null) {
			for(int i=0; i<cookies.length; i++) {
				cookies[i].setPath("/");
				if(cookies[i].getName().equals("cMid")) {
					request.setAttribute("mid", cookies[i].getValue());
					break;
				}
			}
		}
		
		return "member/memberLogin";
	}
	
	@PostMapping("/memberLogin")
	public String memberLoginPost(HttpSession session,
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam(name="mid", defaultValue = "hkd1234", required = false) String mid,
			@RequestParam(name="pwd", defaultValue = "1234", required = false) String pwd,
			@RequestParam(name="idSave", defaultValue = "", required = false) String idSave
		) {
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		if(vo != null && vo.getUserDel().equals("NO") && passwordEncoder.matches(pwd, vo.getPwd())) {
			// 세션처리
			String strLevel = "";
			if(vo.getLevel() == 0) strLevel = "관리자";
			else if(vo.getLevel() == 1) strLevel = "우수회원";
			else if(vo.getLevel() == 2) strLevel = "정회원";
			else if(vo.getLevel() == 3) strLevel = "준회원";
			
			session.setAttribute("sMid", mid);
			session.setAttribute("sNickName", vo.getNickName());
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("strLevel", strLevel);
			
			// 쿠키 저장/삭제
			if(idSave.equals("on")) {
				Cookie cookieMid = new Cookie("cMid", mid);
				cookieMid.setPath("/");
				cookieMid.setMaxAge(60*60*24*7);		// 쿠키의 만료시간을 7일로 지정
				response.addCookie(cookieMid);
			}
			else {
				Cookie[] cookies = request.getCookies();
				if(cookies != null) {
					for(int i=0; i<cookies.length; i++) {
						if(cookies[i].getName().equals("cMid")) {
							cookies[i].setPath("/");
							cookies[i].setMaxAge(0);
							response.addCookie(cookies[i]);
							break;
						}
					}
				}
			}
			
			// 기타처리(방문카운트 증가, 포인트, 하루동안 5회까지 방문시 각 방문마다 10point씩 지급한다.
			if(!LocalDateTime.now().toString().substring(0,10).equals(vo.getLastDate().substring(0,10))) {
				vo.setTodayCnt(0);
			}
			//vo.setTodayCnt(vo.getTodayCnt()+1);
		
			// 방문포인트는 1일 5회까지 가능(1회방문시 10point씩 부여한다.)
			vo.setPoint(vo.getTodayCnt() <= 5 ? 10 : 0);
			
			// 조건에 대한 처리가 완료되면 변경된 모든 내용들을 업데이트 처리한다.
			memberService.setMemberInforUpdate(vo);
			
			return "redirect:/message/memberLoginOk?mid="+mid;
		}
		else return "redirect:/message/memberLoginNo";	
		
	}
	
	@GetMapping("/memberLogout")
	public String memberLogoutGet(HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		session.invalidate();
		return "redirect:/message/memberLogout?mid=" + mid;
	}
	
	@GetMapping("/memberJoin")
	public String memberJoinGet() {
		return "member/memberJoin";
	}
	
	@PostMapping("/memberJoin")
	public String memberJoinPost(MultipartFile fName, MemberVO vo) {
		// 아이디/닉네임 중복체크
		if(memberService.getMemberIdCheck(vo.getMid()) != null) return "redirect:/message/idDuplicateError";
		if(memberService.getMemberNickCheck(vo.getNickName()) != null) return "redirect:/message/nickNameDuplicateError";
		
		// 비밀번호 암호화
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		// 회원 사진 처리
		if(!fName.getOriginalFilename().equals("")) vo.setPhoto(projectProvide.fileUploadFile(fName, "member", ""));
		else vo.setPhoto("noimage.jpg");
		
		System.out.println("vo : " + vo);
		
		int res = memberService.setMemberJoin(vo);
		
		if(res != 0) return "redirect:/message/memberJoinOk";
		else return "redirect:/message/memberJoinNo";
	}
	
	// 회원 가입시 이메일로 인증번호받은후 인증키 확인하기
	@ResponseBody
	@PostMapping("/memberEmailCheck")
	public String memberEmailCheckPost(HttpSession session, String email) throws MessagingException {
		UUID uid = UUID.randomUUID();
		String emailKey = uid.toString().substring(0, 8);
		String key = "인증키 : <font color='red'><b>" + emailKey + "</b></font>";
		
		projectProvide.mailSend(email, "이메일 인증키 입니다.", key);
		
		session.setAttribute("sEmailKey", emailKey);
				
		return "1";
	}
	
	// 회원 가입시 이메일로 인증번호받은후 인증키 확인하기
	@ResponseBody
	@PostMapping("/memberEmailCheckOk")
	public String memberEmailCheckOkPost(HttpSession session, String checkKey) throws MessagingException {
		String emailKey = (String) session.getAttribute("sEmailKey");
		if(emailKey.equals(checkKey)) {
			session.removeAttribute("sEmailKey");
			return "1";
		}
		else return "0";
	}
	
	@ResponseBody
	@GetMapping("/memberIdCheck")
	public String memberIdCheckGet(String mid) {
		MemberVO vo = memberService.getMemberIdCheck(mid);
		if(vo == null) return "0";
		else return "1";
	}
	
	@ResponseBody
	@PostMapping("/memberNickCheck")
	public String memberNickCheckPost(String nickName) {
		MemberVO vo = memberService.getMemberNickCheck(nickName);
		if(vo == null) return "0";
		else return "1";
	}
	
	@GetMapping("/memberMain")
	public String memberMainGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		MemberVO vo = memberService.getMemberIdCheck(mid);
		model.addAttribute("vo", vo);
		return "member/memberMain";
	}
	
	@GetMapping("/memberList")
	public String memberListGet(Model model, PageVO pageVO,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "3", required = false) int pageSize
		) {
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setSection("member");
		pageVO = pagiNation.getTotRecCnt(pageVO);
		
		List<MemberVO> vos = memberService.getMemberList(pageVO.getStartIndexNo(), pageSize);
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "member/memberList";
	}
	
	@GetMapping("/memberContent")
	public String memberContentGet(Model model, String mid) {
		MemberVO vo = memberService.getMemberIdCheck(mid);
		model.addAttribute("vo", vo);
		
		return "member/memberContent";
	}
	
	@GetMapping("/memberPwdCheck/{pwdFlag}")		// p:비밀번호 변경, u:회원정보수정
	public String memberPwdCheckGet(Model model, @PathVariable String pwdFlag) {
		model.addAttribute("pwdFlag", pwdFlag);
		
		return "member/memberPwdCheck";
	}
	
	@ResponseBody
	@PostMapping("/memberPwdCheckOk")		// p:비밀번호 변경, u:회원정보수정
	public String memberPwdCheckPost(String pwd, String mid) {
		MemberVO vo = memberService.getMemberIdCheck(mid);
		if(vo != null && passwordEncoder.matches(pwd, vo.getPwd())) return "1"; 
		return "0";
	}
	
	@ResponseBody
	@PostMapping("/memberPwdChangeOk")
	public String memberPwdChangeOkPost(String pwd, String mid) {
		return memberService.setMemberPwdChangeOk(mid, passwordEncoder.encode(pwd)) + "";
	}
	
	@GetMapping("/memberUpdate")
	public String memberUpdateGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		MemberVO vo = memberService.getMemberIdCheck(mid);
		model.addAttribute("vo", vo);
		
		return "member/memberUpdate";
	}
	
	@PostMapping("/memberUpdate")
	public String memberUpdatePost(MemberVO vo, MultipartFile fName, HttpSession session) {
		// 닉네임 변경유무...(닉네임 중복체크)
		String nickName = (String) session.getAttribute("sNickName");
		if(memberService.getMemberNickCheck(vo.getNickName()) != null && !nickName.equals(vo.getNickName())) {
			return "redirect:/message/nickNameError";
		}
		
		if(fName.getOriginalFilename() != null && !fName.getOriginalFilename().equals("")) { 
			vo.setPhoto(projectProvide.fileUploadFile(fName, "member", null));
		}
		
		// 처리된 결과를 DB에 저장하기
		int res = memberService.setMemberUpdateOk(vo);
		
		if(res != 0) {
			session.setAttribute("sNickName", vo.getNickName());
			return "redirect:/message/memberUpdateOk";
		}
		else return "redirect:/message/memberUpdateNo";
	}
	
	@ResponseBody
	@PostMapping("/userDel")
	public String userDelPost(HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		int res = memberService.setUserDel(mid);
		
		if(res != 0) {
			session.invalidate();
			return "1";
		}
		else return "0";
	}
	
}
