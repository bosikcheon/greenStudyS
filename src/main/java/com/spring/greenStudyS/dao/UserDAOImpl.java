package com.spring.greenStudyS.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.greenStudyS.vo.UserVO;

@Repository("userDAO")
public class UserDAOImpl implements UserDAO {
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public List<UserVO> getUserList(UserVO vo) {
		return sqlSession.selectList("userNS.getUserList", vo);
	}

	@Override
	public List<UserVO> getUserSearch(String mid) {
		return sqlSession.selectList("userNS.getUserSearch", mid);
	}

	@Override
	public int setUserDelete(int idx) {
		return sqlSession.delete("userNS.setUserDelete", idx);
	}

	@Override
	public void setUserJoin(UserVO vo) {
		sqlSession.insert("userNS.setUserJoin", vo);
	}
	
}
