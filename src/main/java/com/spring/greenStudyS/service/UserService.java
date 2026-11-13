package com.spring.greenStudyS.service;

import java.util.List;

import com.spring.greenStudyS.vo.UserVO;

public interface UserService {

	List<UserVO> getUserList(UserVO vo);

	List<UserVO> getUserSearch(String mid);

	int setUserDelete(int idx);

	void setUserJoin(UserVO vo);

}
