package com.spring.greenStudyS.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.greenStudyS.service.UserService;
import com.spring.greenStudyS.vo.UserVO;

//@Slf4j
@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	UserService userService;
	
	@GetMapping("/userList/{orderList}")
	public String userListGet(Model model, @PathVariable String orderList, UserVO vo) {
		String[] temp = orderList.split("Order");
		vo.setFieldName(temp[0]);
		vo.setOrderName(temp[1]);
		
		List<UserVO> vos = userService.getUserList(vo);
		
		model.addAttribute("vos", vos);
		model.addAttribute("orderList", orderList);
		
		return "user/userList";
	}
	
	@PostMapping("/userList/{orderList}")
	public String userListPost(Model model, @PathVariable String orderList, UserVO vo) {
		userService.setUserJoin(vo);	// 회원가입
		
		vo.setFieldName("idx");
		vo.setOrderName("desc");
		
		List<UserVO> vos = userService.getUserList(vo);
		model.addAttribute("vos", vos);
		model.addAttribute("orderList", "idxOrderDesc");
		return "user/userList";
	}
	
	@GetMapping("/userSearch")
	public String userSearchGet(Model model, String mid) {
		List<UserVO> vos = userService.getUserSearch(mid);
		
		model.addAttribute("vos", vos);
		model.addAttribute("orderList", "idxOrderDesc");
		
		return "user/userList";
	}
	
	@ResponseBody
	@PostMapping("/userDelete")
	public String userDeleteGet(int idx) {
		return userService.setUserDelete(idx) + "";
	}
}
