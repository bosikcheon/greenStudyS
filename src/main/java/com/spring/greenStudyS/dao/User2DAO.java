package com.spring.greenStudyS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.greenStudyS.vo.User2VO;

public interface User2DAO {

	List<User2VO> getUserList();

	void setUserJoin(User2VO vo);
	//void setUserJoin(@Param("vo") User2VO vo);

	int setUserInput(@Param("vo") User2VO vo);

}
