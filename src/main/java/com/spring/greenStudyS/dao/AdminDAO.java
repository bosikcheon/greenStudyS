package com.spring.greenStudyS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.greenStudyS.vo.MemberVO;

public interface AdminDAO {

	void setMemberLevelSelectCheck(@Param("idx") int idx, @Param("levelItem")int levelItem);

	List<MemberVO> getMemberList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	int setMemberDeleteOk(@Param("idx") int idx);

}
