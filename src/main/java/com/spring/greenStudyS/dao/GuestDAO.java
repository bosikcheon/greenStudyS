package com.spring.greenStudyS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.greenStudyS.vo.GuestVO;
import com.spring.greenStudyS.vo.User2VO;

public interface GuestDAO {

	//List<GuestVO> getGuestList();
	List<GuestVO> getGuestList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	int setGuestInput(@Param("vo") GuestVO vo);

	User2VO getGuestAdmin();

	int setGuestDelete(@Param("idx") int idx);

	int getTotRecCnt();



}
