package com.goott.pp.board1;

import java.util.List;
import java.util.Map;

import com.goott.pp.board.vo.AtcVO;
import com.goott.pp.board.vo.CmtVO;

public interface BrdService1 {
	
	//게시판 페이징
	public List<AtcVO> getBoardWithPaging(Map<String, Object> brdMap);
	
	//게시판 글 개수
	public int getTotalBoards(String atc_type);
	
	//상세보기
	public AtcVO getBoard(int atc_no);
	
	//글작성
	public int writeNewBoard(AtcVO atcVO);
	
	//수정
	public int modifyBoard(AtcVO atcVO);
	
	//삭제
	public int deleteBoard(int atc_no);
	
	//댓글 리스트
	public List<CmtVO> commentListBrd(Map<String, Object>cmtMap);
}
