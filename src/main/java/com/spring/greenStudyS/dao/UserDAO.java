package com.spring.greenStudyS.dao;

import java.util.List;

import com.spring.greenStudyS.vo.UserVO;

public interface UserDAO {

	List<UserVO> getUserList(UserVO vo);

	List<UserVO> getUserSearch(String mid);

	int setUserDelete(int idx);

	void setUserJoin(UserVO vo);

	
	
}
