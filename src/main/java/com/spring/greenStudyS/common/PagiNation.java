package com.spring.greenStudyS.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.spring.greenStudyS.dao.BoardDAO;
import com.spring.greenStudyS.dao.MemberDAO;
import com.spring.greenStudyS.service.GuestService;

@Component
public class PagiNation {
	
	@Autowired
	GuestService guestService;
	
	@Autowired
	MemberDAO memberDAO;
	
	@Autowired
	BoardDAO boardDAO;

	public PageVO getTotRecCnt(PageVO vo) {
		int totRecCnt = 0;
		
		if(vo.getSection().equals("guest")) {
			totRecCnt = guestService.getTotRecCnt();	// 전체 레코드 건수
		}
		else if(vo.getSection().equals("member")) {
			totRecCnt = memberDAO.getTotRecCnt();
		}
		else if(vo.getSection().equals("board")) {
			totRecCnt = boardDAO.getTotRecCnt();
		}
		
		
		int totPage = (totRecCnt % vo.getPageSize()) == 0 ? (totRecCnt / vo.getPageSize()) : (totRecCnt / vo.getPageSize()) + 1;
		int startIndexNo = (vo.getPag() - 1) * vo.getPageSize();
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (vo.getPag() - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
	  vo.setPag(vo.getPag());
		vo.setPageSize(vo.getPageSize());
		vo.setTotRecCnt(totRecCnt);
		vo.setTotPage(totPage);
		vo.setStartIndexNo(startIndexNo);
		vo.setCurScrStartNo(curScrStartNo);
		vo.setBlockSize(blockSize);
		vo.setCurBlock(curBlock);
		vo.setLastBlock(lastBlock);
		vo.setSearch(vo.getSearch());
		vo.setSearchStr(vo.getSearchStr());
		vo.setSearchString(vo.getSearchString());
		vo.setPart(vo.getPart());
		
		return vo;
	}
	
}
