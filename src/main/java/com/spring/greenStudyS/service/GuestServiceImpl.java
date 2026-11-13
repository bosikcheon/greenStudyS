package com.spring.greenStudyS.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.greenStudyS.dao.GuestDAO;
import com.spring.greenStudyS.vo.GuestVO;
import com.spring.greenStudyS.vo.User2VO;

@Service
public class GuestServiceImpl implements GuestService {

	@Autowired
	GuestDAO guestDAO;

	@Override
	public List<GuestVO> getGuestList(int startIndexNo, int pageSize) {
		return guestDAO.getGuestList(startIndexNo, pageSize);
	}

	@Override
	public int setGuestInput(GuestVO vo) {
		return guestDAO.setGuestInput(vo);
	}

	@Override
	public User2VO getGuestAdmin() {
		return guestDAO.getGuestAdmin();
	}

	@Override
	public int setGuestDelete(int idx) {
		return guestDAO.setGuestDelete(idx);
	}

	@Override
	public int getTotRecCnt() {
		return guestDAO.getTotRecCnt();
	}

	
}
