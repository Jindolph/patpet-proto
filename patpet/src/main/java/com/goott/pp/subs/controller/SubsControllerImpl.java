//package com.goott.pp.subs.controller;
//
//import java.util.List;
//import java.util.Map;
//
//import javax.servlet.http.HttpServletRequest;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpHeaders;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.bind.annotation.RestController;
//
//import com.goott.pp.common.base.BaseController;
//import com.goott.pp.subs.service.SubsService;
//import com.goott.pp.subs.vo.SubsVO;
//
//@RestController
//@RequestMapping("/subs")
//public class SubsControllerImpl extends BaseController implements SubsController {
//	@Autowired
//	SubsService subsService;
//	@Autowired
//	SubsVO subs;
//	@GetMapping(value = "/all/{mem_id}", produces = "application/json; charset=UTF-8")
//	public List<SubsVO> subsListById(@PathVariable("mem_id") String id) {
//		return subsService.showAllSubsById(id);
//	}
//
//}
