package com.goott.pp.board2;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.goott.pp.board.vo.AtcVO;
import com.goott.pp.board.vo.CmtVO;
import com.goott.pp.common.mappers.BoardMapper;

@Service("brdService2")
public class BrdServiceImpl2 implements BrdService2 {
	@Autowired
	BoardMapper bMapper;
	
	private int getNewArticleSeq() {
		return bMapper.selectArticleSeq();
	}
	
	@Override
	public List<AtcVO> getArticlesWithPaging(Map<String, Object> map) {
		return bMapper.selectPagingArticles(map);
	}
	
	@Override
	public List<AtcVO> getMyQnAList(String id) {
		return bMapper.selectMyQnAList(id);
	}

	@Override
	public int getTotalArticles(String atc_type) {
		return bMapper.selectCountArticles(atc_type);
	}

	@Override
	public AtcVO getArticle(int atc_no) {
		return bMapper.selectArticle(atc_no);
	}
	
	@Override
	public AtcVO getArticle2(Map<String, String> map) {
		return bMapper.selectArticle2(map);
	}

	@Override
	public int writeNewArticle(AtcVO atcVO) {
		int atcNO = getNewArticleSeq();
		atcVO.setAtc_no(atcNO);
		bMapper.insertNewArticle(atcVO);
		return atcNO;
	}
	
	@Override
	public int modifyArticle(AtcVO atcVO) {
		return bMapper.updateArticle(atcVO);
	}
	
	@Override
	public int modifyArticle2(Map<String, Object> map) {
		return bMapper.updateArticle2(map);
	}
	
	@Override
	public int addHitsArticle(int atc_no) {
		return bMapper.updateHitsUp(atc_no);
	}

	@Override
	public int deleteArticle(int atc_no) {
		return bMapper.deleteArticle(atc_no);
	}

	/* ~~~~~~~~~~~~~~~ 코멘트에용 ~~~~~~~~~~~~~~~~ */

	@Override
	public List<CmtVO> commentsInArticle(Map<String, Object> cmtMap) {
		return bMapper.selectComments(cmtMap);
	}
	
	@Override
	public List<CmtVO> commentsInArticle2(int atc_no) {
		return bMapper.selectComments2(atc_no);
	}
	
	@Override
	public int getCountComments(int atc_no) {
		return bMapper.selectCountComments(atc_no);
	}

	@Override
	public int writeNewComment(CmtVO cmtVO) {
		return bMapper.insertComment(cmtVO);
	}
	
	@Override
	public int writeNewComment2(Map<String, Object> cmtMap) {
		return bMapper.insertComment2(cmtMap);
	}

	@Override
	public int updateComment(CmtVO cmtVO) {
		return bMapper.updateComment(cmtVO);
	}

	@Override
	public int deleteComment(int cmt_no) {
		return bMapper.deleteComment(cmt_no);
	}

	/* ~~~~~~~~~~~~~~~ 좋아용 ~~~~~~~~~~~~~~~~ */

	@Override
	public int heartLog(Map<String, Object> logMap) {
		int result = bMapper.heartLogs(logMap);
		int atc_no = Integer.parseInt((String) logMap.get("atcNO"));
		
		if(result!=1) {
			bMapper.heartNewLogs(logMap);
			bMapper.updateHeartsUP(atc_no);
		}else{
			bMapper.heartDelLogs(logMap);
			bMapper.updateHeartsDOWN(atc_no);
		}
		return 1;
	}

	/* ~~~~~~~~~~~~~~~ 좋아용 ~~~~~~~~~~~~~~~~ */
	
	@Override
	public int reportLog(Map<String, Object> logMap) {
		int result = bMapper.reportLogs(logMap);
		if(result!=1) {
			bMapper.reportNewLogs(logMap);
		}
		return 1;
	}
}