package com.goott.pp.board1;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.goott.pp.board.vo.AtcVO;
import com.goott.pp.board.vo.CmtVO;
import com.goott.pp.common.mappers.BoardMapper;

@Service("brdService1")
public class BrdServiceImpl1 implements BrdService1 {

	@Autowired 
	BoardMapper brdMapper;
	
	private int getNewBoardSeq() {
		return brdMapper.selectArticleSeq();
	}
	
	//페이징
	@Override
	public List<AtcVO> getBoardWithPaging(Map<String, Object> brdMap) {
		System.out.println("서비스 시작");
		System.out.println("brdMap: " + brdMap.get("type")+", " + brdMap.get("page"));
		return brdMapper.selectPagingBoards(brdMap);
	}
	
	//게시물 개수
	@Override
	public int getTotalBoards(String atc_type) {
		System.out.println("글 개수 서비스 시작");
		System.out.println(atc_type);
		return brdMapper.selectCountBoards(atc_type);
	}
	
	//게시글 상세보기
	@Override
	public AtcVO getBoard(int atc_no) {
		return brdMapper.selectBoard(atc_no);
	}
	
	//게시글 작성
	@Override
	public int writeNewBoard(AtcVO atcVO) {
		int atcNO = getNewBoardSeq();
		atcVO.setAtc_no(atcNO);
		brdMapper.insertNewBoard(atcVO);
		return atcNO;
	}
	
	//게시글 수정
	@Override 
	public int modifyBoard(AtcVO atcVO) {
		return brdMapper.updateBoard(atcVO);
	}
	
	//게시글 삭제
	@Override
	public int deleteBoard(int atc_no) {
		return brdMapper.deleteBoard(atc_no);
	}
	
	//댓글 리스트
	@Override
	public List<CmtVO> commentListBrd(Map<String, Object>cmtMap){
		System.out.println("서비스에서 실행됬습니다!: " + cmtMap.get("atc_no")+","+ cmtMap.get("page"));
		return brdMapper.selectComments(cmtMap);
	} 
}
