package com.spring.greenStudyS.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.greenStudyS.dao.User2DAO;
import com.spring.greenStudyS.vo.User2VO;

@Service
public class User2ServiceImpl implements User2Service {

	@Autowired
	User2DAO user2DAO;

	@Override
	public List<User2VO> getUserList() {
		return user2DAO.getUserList();
	}

	@Override
	public void setUserJoin(User2VO vo) {
		user2DAO.setUserJoin(vo);
	}

	@Override
	public int setUserInput(User2VO vo) {
		return user2DAO.setUserInput(vo);
	}

}
