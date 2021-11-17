package com.goott.pp.board2;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.goott.pp.board.vo.AtcVO;
import com.goott.pp.board.vo.CmtVO;
import com.goott.pp.common.paging.PagingCreatorDTO2;
import com.goott.pp.common.paging.PagingDTO2;

@RestController
@RequestMapping("/board")
public class BrdRestController  {
	@Autowired
	BrdService2 brdService;

	@GetMapping({ "list", "view", "post", "all", "list2", "list3", "modify", "comment", "layout" })
	private @ModelAttribute Object jspFinder() {
		return null;
	}
	
	@GetMapping(value = "/all/{type}/{page}", produces = "application/json; charset=utf-8")
	private Map<String, Object> articleListPaging(@PathVariable Map<String, Object> atcMap) {
		PagingDTO2 paging = new PagingDTO2();
		String page = (String) atcMap.get("page");
		String atcType = (String) atcMap.get("type");
		paging.setCurrentPageNo(Integer.parseInt(page));

		int countArticles = brdService.getTotalArticles(atcType);
		PagingCreatorDTO2 pagingcreator = new PagingCreatorDTO2(paging, countArticles, 10);

		List<AtcVO> atcList = brdService.getArticlesWithPaging(atcMap);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", atcList);
		resultMap.put("page", pagingcreator);

		return resultMap;
	}
	
	@GetMapping("/all/QNA/{memId}")
	private List<AtcVO> getMyQnAList(@PathVariable("memId") String id){
		return brdService.getMyQnAList(id);
	}

	@GetMapping("/atc/{atcNO}")
	private ResponseEntity<AtcVO> viewArticle(@PathVariable("atcNO") int atcNO) {
		return new ResponseEntity<>(brdService.getArticle(atcNO), HttpStatus.OK);
	}
	
	@GetMapping("/atc/{type}/{memId}")
	private ResponseEntity<AtcVO> viewArticle2(@PathVariable Map<String, String> map) {
		return new ResponseEntity<>(brdService.getArticle2(map), HttpStatus.OK);
	}

	@PostMapping("/atc/new")
	private ResponseEntity<String> registerNewArticle(@RequestBody AtcVO atcVO) {
		int result = brdService.writeNewArticle(atcVO);
		return new ResponseEntity<>("" + result, HttpStatus.OK);
	}
	
	@PostMapping("/atc/{atcNO}/reports/{memId}")
	private ResponseEntity<String> reportArticle(@PathVariable Map<String, Object> map) {
		return brdService.reportLog(map) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@PutMapping("/atc/{atcNO}")
	private ResponseEntity<String> modifyArticle(@PathVariable("atcNO") int atc_no, @RequestBody AtcVO atcVO) {
		return brdService.modifyArticle(atcVO) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PutMapping("/atc/{type}/{atcNO}")
	private ResponseEntity<String> modifyArticle2(@PathVariable Map<String, Object> map,@RequestBody Map<String, Object> map2) {
		return brdService.modifyArticle2(map2) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@PatchMapping("/atc/{atcNO}/hearts/{memId}")
	private ResponseEntity<String> heartRegister(@PathVariable Map<String, Object> map) {
		return brdService.heartLog(map) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@PatchMapping("/atc/{atcNO}/hits")
	private ResponseEntity<String> hits(@PathVariable("atcNO") int atc_no) {
		return brdService.addHitsArticle(atc_no) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@DeleteMapping("/atc/{atcNO}")
	private ResponseEntity<String> deleteArticle(@PathVariable("atcNO") int atc_no) {
		return brdService.deleteArticle(atc_no) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	/* #######################댓글처리######################### */

	@GetMapping(value="/cmts/{atc_no}/{page}", produces = "application/json; charset=utf-8")
	private List<CmtVO> commentList(@PathVariable Map<String, Object> cmtMap) {
		return brdService.commentsInArticle(cmtMap);
	}
	
	@GetMapping(value="/cmts/{atcNO}", produces = "application/json; charset=utf-8")
	private List<CmtVO> commentList2(@PathVariable("atcNO") int atc_no) {
		return brdService.commentsInArticle2(atc_no);
	}
	
	@GetMapping("/cmts/count/{atcNO}")
	private String getCountComments(@PathVariable("atcNO") int atc_no) {
		return "" + brdService.getCountComments(atc_no);
	}

	@PostMapping("/cmt/new")
	private ResponseEntity<String> writeNewComment(@RequestBody CmtVO cmtVO) {
		return brdService.writeNewComment(cmtVO) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping(value="/guestCmt", produces =  "application/json; charset=utf-8" )
	private ResponseEntity<String> writeNewComment2(@RequestBody Map<String, Object> cmtMap) {
		return brdService.writeNewComment2(cmtMap) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@PutMapping("/cmt/{cmtNO}")
	private ResponseEntity<String> updateComment(@PathVariable("cmtNO") int cmt_no,
			@RequestBody CmtVO cmtVO) {
		return brdService.updateComment(cmtVO) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@DeleteMapping("/cmt/{cmtNO}")
	private ResponseEntity<String> deleteComment(@PathVariable("cmtNO") int cmt_no) {
		return brdService.deleteComment(cmt_no) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}