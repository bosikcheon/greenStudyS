package com.spring.greenStudyS.service;

import java.util.List;

import com.spring.greenStudyS.vo.MemberVO;

public interface AdminService {

	void setMemberLevelSelectCheck(int idx, int levelItem);

	List<MemberVO> getMemberList(int startIndexNo, int pageSize);

	int setMemberDeleteOk(int idx);


}
