package com.goott.pp.common.mappers;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goott.pp.board.vo.AtcVO;
import com.goott.pp.board.vo.CmtVO;
import com.goott.pp.common.file.vo.TestFileVO;
import com.goott.pp.common.paging.PagingDTO;



@Mapper
public interface BrdMapper {
	
		//게시판 시작 -------------------------------------------------------------------------
	
		//게시판 목록
		public List<AtcVO> selectAllBoardList();
		//게시판 글작성
		public void insertNewBoardList(AtcVO atcVO);
		//게시판 시퀀스(게시글번호)
		public int getNewatc_no();
		//게시판 글번호 찾기
		public AtcVO selectBoard(int atc_no);
		//게시판 수정
		public void updateBoard(AtcVO atcVO);
		//게시판 삭제
		public void deleteBoard(AtcVO atcVO);
		//게시판 페이징
		public List<AtcVO> selectBoardWithPaging(PagingDTO pagingDTO);
		//게시판 전체 개수
		public int selectTotalRecordCnt(PagingDTO pagingDTO);
		//게시판 조회수
		public void boardHits(int atc_no);
		
		//게시판 끝---------------------------------------------------------------------------
		
		//파일 시작---------------------------------------------------------------------------
		
		//게시판 업로드 파일
		public void insertFile(Map<String, Object> map); 
		//파일 조회
	 	public List<Map<String, Object>> selectFileList (int atc_no); 
		//파일 다운	로드
	 	public Map<String, Object> selectFileInfo(Map<String, Object> map); 
		//파일 수정
	 	public void updateFile(Map<String, Object> map); 
		//난수 찾기
	 	public List<TestFileVO> selectStoredFile(int atc_no); 
		//게시판 사진 삭제
	 	public void deleteFiles(int atc_no); 
		
		//파일 끝-----------------------------------------------------------------------------
		
		//댓글 시작-----------------------------------------------------------------------------
		
		//댓글 조회
		public List<CmtVO> readCmt(int atc_no);
		//댓글 작성
		public void writeCmt (Map<String, Object> commentMap);
		//댓글 수정
		public void updateCmt(Map<String, Object> cmtMap);
		//댓글 삭제
		public void deleteCmt(int cmt_no);
		//수정 할 댓글 조회
		public CmtVO selectCmt(int cmt_no);
		
		//댓글 끝-----------------------------------------------------------------------------
		
		//좋아요 시작---------------------------------------------------------------------------
		
		//좋아요 로그 찾기
		public int heartLogs(Map<String, Object> heartAddMap);
		//좋아요 로그  넣기
		public int heartAddLogs(Map<String, Object> heartAddMap);
		//좋아요 로그 지우기
		public void heartDelLogs(Map<String, Object> heartAddMap);
		//좋아요 증가
		public int heartsUP(int atc_no);
		//좋아요 감소
		public int heartsDOWN(int atc_no);
		
		//좋아요 끝----------------------------------------------------------------------------
		
		//신고 시작----------------------------------------------------------------------------
		
		//신고 로그 찾기
		public int reportLogs(Map<String, Object> reportAddMap);
		
		//신고 로그 남기기
		public int reportAddLogs(Map<String, Object> reportAddMap);
		
		//신고 끝----------------------------------------------------------------------------
		
}




