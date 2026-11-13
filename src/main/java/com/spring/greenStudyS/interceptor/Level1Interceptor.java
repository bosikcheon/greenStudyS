package com.spring.greenStudyS.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class Level1Interceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		// 관리자:0, 우수회원:1, 정회원:2, 준회원:3 , 비회원:999
		
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 999 : (int) session.getAttribute("sLevel");
		
		// 우수회원 처리
		if(level > 1) {
			if(level == 999) {
				request.getRequestDispatcher("/message/memberNo").forward(request, response);
			}
			else {
				request.getRequestDispatcher("/message/memberLevelNo").forward(request, response);
			}
			return false;
		}
		
		return true;
	}
	
}
