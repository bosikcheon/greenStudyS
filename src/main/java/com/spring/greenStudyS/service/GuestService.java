package com.spring.greenStudyS.service;

import java.util.List;

import com.spring.greenStudyS.vo.GuestVO;
import com.spring.greenStudyS.vo.User2VO;

public interface GuestService {

	//List<GuestVO> getGuestList();
	List<GuestVO> getGuestList(int startIndexNo, int pageSize);

	int setGuestInput(GuestVO vo);

	User2VO getGuestAdmin();

	int setGuestDelete(int idx);

	int getTotRecCnt();


	
}
