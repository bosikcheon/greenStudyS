package com.spring.greenStudyS.controller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.greenStudyS.common.ARIAUtil;
import com.spring.greenStudyS.common.ProjectProvide;
import com.spring.greenStudyS.common.SecurityUtil;
import com.spring.greenStudyS.service.StudyService;
import com.spring.greenStudyS.vo.MailVO;
import com.spring.greenStudyS.vo.User2VO;

//@Slf4j
@Controller
@RequestMapping("/study")
public class StudyController {
	
	@Autowired
	StudyService studyService;
	
	@Autowired
	ProjectProvide projectProvide;
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@GetMapping("/ajaxForm")
	public String ajaxFormGet() {
		return "study/ajax/ajaxForm";
	}
	
	@ResponseBody
	@PostMapping("/ajaxTest1")
	public String ajaxTest1Post(int idx) {
		int res = ((int)(Math.random()*100) + 1) + idx;
		return res + "";
	}
	
	@ResponseBody
	@PostMapping(value="/ajaxTest2", produces="application/text; charset=utf-8")
	public String ajaxTest2Get(String str) {
		int res = ((int)(Math.random()*100) + 1);
	  str += "하세요 : " + res;
		System.out.println("str : " + str);
		return str;
	}
	
	@GetMapping("/ajaxTest3")
	public String ajaxTest3Get() {
		return "study/ajax/ajaxTest3";
	}

	@ResponseBody
	@PostMapping("/ajaxTest3")
	public String[] ajaxTest3Post(String dodo) {
//		String[] strArray = new String[100];
//		strArray = studyService.getCityStringArray(dodo);
//		return strArray;
		
		return studyService.getCityStringArray(dodo);
	}
	
	@GetMapping("/ajaxTest4")
	public String ajaxTest4Get() {
		return "study/ajax/ajaxTest4";
	}
	
	@ResponseBody
	@PostMapping("/ajaxTest4")
	public List<String> ajaxTest4Post(String dodo) {
//		List<String> vos = new ArrayList<String>();
//		vos = studyService.getCityArrayList(dodo);
//		return vos;
		return studyService.getCityArrayList(dodo);
	}
	
	@GetMapping("/ajaxTest5")
	public String ajaxTest5Get() {
		return "study/ajax/ajaxTest5";
	}
	
//	@ResponseBody
//	@PostMapping("/ajaxTest5")
//	public Map<Object, Object> ajaxTest5Post(String dodo) {
//		Map<Object, Object> map = new HashMap<Object, Object>();
//		
//		List<String> vos = new ArrayList<String>();
//		vos = studyService.getCityArrayList(dodo);
//		
//		map.put("city", vos);
//		return map;
//	}
	
	@ResponseBody
	@PostMapping("/ajaxTest5")
	public Map<Object, Object> ajaxTest5Post(String dodo) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("city", studyService.getCityArrayList(dodo));
		
		return map;
	}
	
	@GetMapping("/ajaxTest6")
	public String ajaxTest6Get(Model model) {
		List<String> midVos = studyService.userMidList();
		model.addAttribute("midVos", midVos);
		
		List<User2VO> genderVos = studyService.userGenderSearch();
		model.addAttribute("genderVos", genderVos);
		
		return "study/ajax/ajaxTest6";
	}
	
	@ResponseBody
	@PostMapping("/ajaxTest6")
	public String ajaxTest6Post(String mid) {
		User2VO vo = studyService.userMidSearch(mid);
		String str = "<h3>회원 정보</h3>";
		str += "회원 고유번호 : " +vo.getIdx() + "<br/>";
		str += "회원 아이디 : " +vo.getMid() + "<br/>";
		str += "회원 성명 : " +vo.getName() + "<br/>";
		str += "회원 나이 : " +vo.getAge() + "<br/>";
		str += "회원 성별 : " +vo.getGender() + "<br/>";
		str += "회원 주소 : " +vo.getAddress() + "<br/>";
		return str;
	}
	
	@ResponseBody
	@PostMapping("/ajaxTest6_2")
	public User2VO ajaxTest6_2Post(String mid) {
		return studyService.userMidSearch(mid);
	}
	
	@ResponseBody
	@PostMapping("/ajaxTest6_3")
	public List<User2VO> ajaxTest6_3Post(String gender) {
		return studyService.userGenderList(gender);
	}
	
	@GetMapping("/fileUpload")
	public String fileUploadGet() {
		return "study/fileUpload/fileUploadForm";
	}
	
	@PostMapping("/fileUpload")
	public String fileUploadPost(MultipartFile fName, String name, HttpServletRequest request) throws IOException {
		//String realPath = request.getRealPath("");
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/fileUpload/");
		String uid = UUID.randomUUID().toString().substring(0, 8);
		String oFileName = fName.getOriginalFilename();
		String file = oFileName.substring(0,oFileName.lastIndexOf(".")) + "_" + uid  + oFileName.substring(oFileName.lastIndexOf("."));
		
		FileOutputStream fos = new FileOutputStream(realPath+file);
		
		fos.write(fName.getBytes());
		
		fos.close();
		
		return "redirect:/message/fileUploadOk";
	}
	
	@PostMapping("/fileUpload2")
	public String fileUpload2Post(MultipartFile fName, String name) {
		//int res = studyService.fileUpload(fName, name, request);	// studyService 사용
		int res = projectProvide.fileUpload(fName, "fileUpload", name);	// projectProvide 사용
		
		if(res != 0) return "redirect:/message/fileUploadOk";
		else return "redirect:/message/fileUploadNo";
	}
	
	@GetMapping("/mailForm")
	public String mailFormGet() {
		return "study/mail/mailForm";
	}
	
	@PostMapping("/mailForm")
	public String mailFormPost(HttpServletRequest request, MailVO vo) throws MessagingException {
		String toMail = vo.getToMail();
		String title = vo.getTitle();
		String content = vo.getContent();
		
		// 메일 전송을 위한 객체 : MimeMessage(), MimeMessageHelper()
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		// 메세지 보관함 정리(작업)
		messageHelper.setTo(toMail);
		messageHelper.setSubject(title);
		messageHelper.setText(content);
		
		// 메세지 보관함에 발신자의 필요한 정보를 추가로 포함시킨다.
		content = content.replace("\n", "<br>");
		content += "<br><hr><h3>GreenStudyS에서 보냅니다.</h3><hr><br>";
		content += "<p><img src=\"cid:main.jpg\" width='500px'></p>";
		content += "<p>방문하기 : <a href='http://49.142.157.251:9090/cjgreen'>그린아카데미</a></p>";
		content += "<hr>";
		
		messageHelper.setText(content, true);
		
		//FileSystemResource file = new FileSystemResource("D:\\greenStudy\\springFramework\\works\\greenStudyS\\src\\main\\webapp\\resources\\images\\main.jpg");
		FileSystemResource file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/main.jpg"));
		messageHelper.addInline("main.jpg", file);
		
		// 첨부파일 보내기
		file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/11.jpg"));
		messageHelper.addInline("11.jpg", file);
		file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/12.jpg"));
		messageHelper.addAttachment("12.jpg", file);
		
		mailSender.send(message);
		
		return "redirect:/message/mailSendOk";
	}
	
	@PostMapping("/mailFormOk")
	public String mailFormOkPost(MailVO vo) {
		// 체크 사항 충분하게 체크한다.
		// 체크 완료후 메일버시스 호출한다.
		//projectProvide.mailSend("cjsk1126@naver.com", "비밀번호 변경요청", "1234") {}
		
		int res = 0;
		
		try {
			projectProvide.mailSend(vo.getToMail(), vo.getTitle(), "메일연습");
			res = 1;
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		if(res != 0) return "redirect:/message/mailSendOk";
		else return "redirect:/message/mailSendNo";
	}
	
	// 비밀번호 암호화
	@GetMapping("/passForm")
	public String passFormGet() {
		return "study/password/passwordForm";
	}
	
	// sha256 비밀번호 암호화
	@ResponseBody
	@PostMapping(value="/passwordSha256", produces="application/text; charset=utf-8")
	public String passwordSha256Post(String pwd) {
		UUID uid = UUID.randomUUID();
		String salt = uid.toString().substring(0,8);
		
		SecurityUtil security = new SecurityUtil();
		String encPwd = security.encryptSHA256(salt + pwd);
		
		pwd = "salt키 : " + salt + " / 암호화된 비밀번호 : " + encPwd;
		
		return pwd;
	}
	
	// aria 비밀번호 암호화
	@ResponseBody
	@PostMapping(value="/passwordAria", produces="application/text; charset=utf-8")
	public String passwordAriaPost(String pwd) throws InvalidKeyException, UnsupportedEncodingException {
		UUID uid = UUID.randomUUID();
		String salt = uid.toString().substring(0,8);
		
		String encPwd = ARIAUtil.ariaEncrypt(salt + pwd);
		String decPwd = ARIAUtil.ariaDecrypt(encPwd);
		
		pwd = "salt키 : " + salt + " / 암호화된 비밀번호 : " + encPwd + 
				  "<br/> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;" + decPwd.substring(8);
		
		return pwd;
	}
	
	// bCryptPasswordEncoder 비밀번호 암호화
	@ResponseBody
	@PostMapping(value="/passwordEncoder", produces="application/text; charset=utf-8")
	public String passwordEncoderPost(String pwd) throws InvalidKeyException, UnsupportedEncodingException {
		String encPwd = passwordEncoder.encode(pwd);
		
		pwd = "암호화된 비밀번호 : " + encPwd;
		
		return pwd;
	}
	
}
