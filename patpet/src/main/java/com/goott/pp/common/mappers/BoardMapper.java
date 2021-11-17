package com.goott.pp.common.mappers;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goott.pp.board.vo.AtcVO;
import com.goott.pp.board.vo.CmtVO;

@Mapper
public interface BoardMapper {
	/* 게시판 시작---------------------------------------------*/

	int selectArticleSeq();
	
	// 게시판 전체 개수
	int selectCountArticles(String atc_type);
	
	// 게시판 페이징
	List<AtcVO> selectPagingArticles(Map<String, Object> map);

	// QnA리스트
	List<AtcVO> selectMyQnAList(String id);

	// 게시판 글번호 찾기
	AtcVO selectArticle(int atc_no);
	
	// 게시판 글작성
	int insertNewArticle(AtcVO atcVO);
	
	void insertNewArticle2(Map<String, Object> regMap);

	// 게시판 수정
	int updateArticle(AtcVO atcVO);
	
	// 조회수
	int updateHitsUp(int atc_no);

	// 좋아요
	int updateHeartsUP(int atc_no);

	int updateHeartsDOWN(int atc_no);

	//게시글 상품교환
	int updateGiftCodeFromArticle(Map<String, Object> map);
	
	// 게시판 삭제
	int deleteArticle(int atc_no);

	/* 게시판 끝---------------------------------------------*/
	
	/* 댓글 시작---------------------------------------------*/

	// 댓글 조회
	List<CmtVO> selectComments(Map<String, Object> cmtMap);
	
	// 댓글 수
	int selectCountComments(int atc_no);

	// 댓글 작성
	int insertComment(CmtVO cmtVO);
	
	int insertComment2(Map<String, Object> cmtMap);

	// 댓글 수정
	int updateComment(CmtVO cmtVO);
	
	// 댓글 상품교환
	int updateGiftCodeFromComment(Map<String, Object> map);

	// 댓글 삭제
	int deleteComment(int cmt_no);

	/* 댓글 끝---------------------------------------------*/

	/* 좋아요 시작---------------------------------------------*/

	int heartLogs(Map<String, Object> heartMap);

	int heartNewLogs(Map<String, Object> heartMap);

	int heartDelLogs(Map<String, Object> heartMap);

	/* 좋아요 끝---------------------------------------------*/

	/* 신고 시작---------------------------------------------*/
	
	int reportLogs(Map<String, Object> heartMap);

	int reportNewLogs(Map<String, Object> heartMap);

	AtcVO selectArticle2(Map<String, String> map);

	int updateArticle2(Map<String, Object> map);

	List<CmtVO> selectComments2(int atc_no);

	
	
	/* 신고 끝---------------------------------------------*/
	
	
	//Q&A 글 개수
	int selectCountBoards(String atc_type);
	
	//Q&A게시판 페이징
	List<AtcVO> selectPagingBoards(Map<String, Object> brdMap);
	
	//상세보기
	AtcVO selectBoard(int atc_no);
	
	//글 작성
	int insertNewBoard(AtcVO atcVO);
	
	//게시판 수정
	int updateBoard(AtcVO atcVO);
	
	//게시글 삭제
	int deleteBoard(int atc_no);
	
}