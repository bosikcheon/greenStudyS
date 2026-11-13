package com.spring.greenStudyS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.greenStudyS.vo.MemberVO;

public interface MemberDAO {

	MemberVO getMemberIdCheck(@Param("mid") String mid);

	MemberVO getMemberNickCheck(@Param("nickName") String nickName);

	int setMemberJoin(@Param("vo") MemberVO vo);

	void setMemberInforUpdate(@Param("vo") MemberVO vo);

	List<MemberVO> getMemberList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	int getTotRecCnt();

	int setMemberPwdChangeOk(@Param("mid") String mid, @Param("pwd") String pwd);

	int setMemberUpdateOk(@Param("vo") MemberVO vo);

	int setUserDel(@Param("mid") String mid);

}
