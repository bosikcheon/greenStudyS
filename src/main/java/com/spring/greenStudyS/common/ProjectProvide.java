package com.spring.greenStudyS.common;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class ProjectProvide {
	
	@Autowired
	JavaMailSender mailSender;	
	
	// aJax에서의 파일 처리
	public int fileUpload(MultipartFile fName, String path, String name) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		
		int res = 0;
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/"+path+"/");
		String uid = UUID.randomUUID().toString().substring(0, 8);
		String oFileName = fName.getOriginalFilename();
		String file = oFileName.substring(0,oFileName.lastIndexOf(".")) + "_" + uid  + oFileName.substring(oFileName.lastIndexOf("."));
		
		FileOutputStream fos = null;
		try {
			fos = new FileOutputStream(realPath+file);
			if(fName.getBytes().length != -1)	{
				fos.write(fName.getBytes());
				res = 1;
			}
		} catch (IOException e) {
			System.out.println("파일 업로드 실패~~" + e.getMessage());
		} finally {
			try {
				fos.close();
			} catch (IOException e) {}
		}
		//System.out.println("파일업로드 사용자 : " + name);
		log.info("파일업로드 사용자 : {}", name);
		return res;
	}
	
	// 일반 파일처리
	public String fileUploadFile(MultipartFile fName, String path, String name) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/"+path+"/");
		String uid = UUID.randomUUID().toString().substring(0, 8);
		String oFileName = fName.getOriginalFilename();
		String file = oFileName.substring(0,oFileName.lastIndexOf(".")) + "_" + uid  + oFileName.substring(oFileName.lastIndexOf("."));
		
		FileOutputStream fos = null;
		try {
			fos = new FileOutputStream(realPath+file);
			if(fName.getBytes().length != -1)	{
				fos.write(fName.getBytes());
			}
		} catch (IOException e) {
			System.out.println("파일 업로드 실패~~" + e.getMessage());
		} finally {
			try {
				fos.close();
			} catch (IOException e) {}
		}
		return file;
	}
	
	
	public String mailSend(String email, String title, String flag) throws MessagingException {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		
		// 메일 전송을 위한 객체 : MimeMessage(), MimeMessageHelper()
		String content = "";
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		// 메세지 보관함 정리(작업)
		messageHelper.setTo(email);
		messageHelper.setSubject(title);
		messageHelper.setText(content);
		
		// 메세지 보관함에 발신자의 필요한 정보를 추가로 포함시킨다.(예 발신자가 비번을 요청할떼?
		
		content = content.replace("\n", "<br>");
		content += "<br><hr><h3>"+flag+"</h3><hr><br>";
		content += "<p><img src=\"cid:main.jpg\" width='500px'></p>";
		content += "<p>방문하기 : <a href='http://49.142.157.251:9090/cjgreen'>그린아카데미</a></p>";
		content += "<hr>";
		
		messageHelper.setText(content, true);
		
		//FileSystemResource file = new FileSystemResource("D:\\greenStudy\\springFramework\\works\\greenStudyS\\src\\main\\webapp\\resources\\images\\main.jpg");
		FileSystemResource file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/main.jpg"));
		messageHelper.addInline("main.jpg", file);
		
		mailSender.send(message);
		
		return "redirect:/message/mailSendOk?sw=emailKey";
	}

	public void deleteFile(String photo, String path) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/"+path+"/");
		File file = new File(realPath + photo);
		if(file.exists()) file.delete();
	}
	
}
