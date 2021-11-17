package com.goott.pp.board1;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
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
@RequestMapping("/board1")
public class BrdRestController1 {
	@Autowired
	BrdService1 brdService;
	
	//jsp페이지를 찾기 못하기 때문에 찾게 해주는 기능
	@GetMapping({"qna"})
	private @ModelAttribute Object jspFinder() {
		return null;
	}
	
	//게시판 페이징
	@GetMapping(value = "/qna/{type}/{page}", produces = "application/json; charset=utf-8")
	private Map<String, Object> boardListPaging(@PathVariable Map<String, Object> brdMap){
		System.out.println("컨트롤러 접속1");
		
		PagingDTO2 paging = new PagingDTO2();
		String page = (String) brdMap.get("page");
		String atcType = (String) brdMap.get("type");
		paging.setCurrentPageNo(Integer.parseInt(page));
		
		System.out.println("atcType");
		System.out.println("컨트롤러 접속2");
		
		int countBoards = brdService.getTotalBoards(atcType);
		PagingCreatorDTO2 pagingcreator = new PagingCreatorDTO2(paging, countBoards, 10);
		
		System.out.println("컨트롤러 접속3");
		
		List<AtcVO> brdList = brdService.getBoardWithPaging(brdMap);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", brdList);
		resultMap.put("page", pagingcreator);
		
		return resultMap;
	}
	
	//게시판 상세
	@GetMapping("/brd/{atcNO}")
	private ResponseEntity<AtcVO> viewBoard(@PathVariable("atcNO") int atc_no){
		return new ResponseEntity<>(brdService.getBoard(atc_no), HttpStatus.OK);
	}
	
	//게시판 작성
	@PostMapping("/brd/new")
	private ResponseEntity<String> NewBoard(@RequestBody AtcVO atcVO){
		int result = brdService.writeNewBoard(atcVO);
		return new ResponseEntity<>("" + result,HttpStatus.OK);
	}
	
	//게시판 수정
	@PutMapping("/brd/{atcNO}")
	private ResponseEntity<String> modifyBoard(@PathVariable("atcNO")int atc_no, @RequestBody AtcVO atcVO){
		System.out.println(atcVO.toString());
		return brdService.modifyBoard(atcVO) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//게시판 삭제
	@DeleteMapping("/brd/{atcNO}")
	private ResponseEntity<String> deleteBoard(@PathVariable("atcNO") int atc_no){
		return brdService.deleteBoard(atc_no) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
			  : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//댓글 리스트 불러오기
	@GetMapping(value = "/cmts/{atc_no}/{page}", produces = "application/json; charset=utf-8")
	private List<CmtVO> commentList(@PathVariable Map<String, Object> cmtMap){
		System.out.println("댓글 목록 불러옵니다용: " + cmtMap.get("atc_no") +", "+ cmtMap.get("page"));
		return brdService.commentListBrd(cmtMap);
	}
}
