package com.goott.pp.subs.restcontroller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
//import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.goott.pp.common.base.BaseController;
import com.goott.pp.subs.service.SubsService;
import com.goott.pp.subs.vo.SubsVO;

@RestController
@RequestMapping("/subs")
public class SubsRestControllerImpl extends BaseController{
	@Autowired
	SubsService subsService;
	@Autowired
	SubsVO subs;
	
	@GetMapping({ "/all", "/delete", "/new", "/my", "/modify", "/info3" })
	public @ModelAttribute Object jspFinder() {
		return null;
	}

	@GetMapping("/{mem_id}")
	public SubsVO subsInfoById(@PathVariable("mem_id") String id) {
		return subsService.selectSubsInfoById(id);
	}

	@GetMapping("/all/{mem_id}")
	public List<SubsVO> subsListById(@PathVariable("mem_id") String id){
		return subsService.showAllSubsById(id);
	}

	@PostMapping("/new")
	public ResponseEntity<String> newSubs(@RequestBody Map<String, Object> map){
		System.out.println("컨트롤러어엉어ㅓㅇ어ㅓㅇ어ㅓ");
		System.out.println(map.get("grade")+", "+map.get("mem_id")+", "+map.get("months"));
		return subsService.addNewSubs(map) == 1 ? new ResponseEntity<>("successRegister", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@PutMapping("/{subs_code}")
	public ResponseEntity<String> modSubs(@PathVariable("subs_code") int code, @RequestBody Map<String, Object> map) {
		return subsService.modSubsInfo(map) == 1 ? new ResponseEntity<>("successModify", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@PatchMapping("/{mem_id}/{subs_code}")
	public ResponseEntity<String> cancelSubs(@PathVariable Map<String, Object> map) {
		System.out.println(map.get("mem_id")+","+map.get("subs_code"));
		return subsService.cancelSubs(map) == 1 ? new ResponseEntity<>("successCancel", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
