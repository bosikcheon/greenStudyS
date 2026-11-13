package com.spring.greenStudyS.service;

import java.util.List;

import com.spring.greenStudyS.vo.MemberVO;

public interface MemberService {

	MemberVO getMemberIdCheck(String mid);

	MemberVO getMemberNickCheck(String nickName);

	int setMemberJoin(MemberVO vo);

	void setMemberInforUpdate(MemberVO vo);

	List<MemberVO> getMemberList(int startIndexNo, int pageSize);

	int setMemberPwdChangeOk(String mid, String pwd);

	int setMemberUpdateOk(MemberVO vo);

	int setUserDel(String mid);

}
