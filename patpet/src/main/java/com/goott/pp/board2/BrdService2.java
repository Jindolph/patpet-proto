package com.goott.pp.board2;

import java.util.List;
import java.util.Map;

import com.goott.pp.board.vo.AtcVO;
import com.goott.pp.board.vo.CmtVO;

public interface BrdService2 {
	List<AtcVO> getArticlesWithPaging(Map<String, Object> map);
	
	List<AtcVO> getMyQnAList(String id);

	int getTotalArticles(String atc_type);

	AtcVO getArticle(int atc_no);

	int writeNewArticle(AtcVO atcVO);

	int addHitsArticle(int atc_no);

	int modifyArticle(AtcVO atcVO);

	int deleteArticle(int atc_no);

	/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~코멘트에용~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
	
	List<CmtVO> commentsInArticle(Map<String, Object> cmtMap);
	
	int getCountComments(int atc_no);

	int writeNewComment(CmtVO cmtVO);
	
	int writeNewComment2(Map<String, Object> cmtMap);

	int updateComment(CmtVO cmtVO);

	int deleteComment(int cmt_no);

	/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~좋아용~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
	
	int heartLog(Map<String, Object> logMap);

	/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~신고~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
	
	int reportLog(Map<String, Object> logMap);

	AtcVO getArticle2(Map<String, String> map);

	int modifyArticle2(Map<String, Object> map);

	List<CmtVO> commentsInArticle2(int atc_no);
}