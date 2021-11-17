package com.goott.pp.delivery.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.goott.pp.common.base.BaseController;
import com.goott.pp.delivery.service.DvrService;
import com.goott.pp.delivery.vo.DvrVO;

@Controller
@RequestMapping("/dvr")
public class DvrControllerImpl extends BaseController implements DvrController {
	@Autowired
	DvrService dvrService;
	@Autowired
	DvrVO dvrVO;

	@GetMapping("main.do")
	public String main() {
		return "main";
	}
	
	@GetMapping("/pages")
	
		public void htmlFinder() {
	}
	
	@GetMapping("/*Form.do")
	public void formFinder() {
	}

	@Override
    @ResponseBody
	@PostMapping("/dvrInfo2.do") 
	  public List<DvrVO> dvrInfo2(@RequestParam("id") String id) throws Exception{ 
		  List<DvrVO> dvrVO = dvrService.showDvrInfo(id); 
		  System.out.println("Controller dvr: "+dvrVO); 
		  return dvrVO; 
	  }

	@Override
	@PostMapping("/register.do")
	public ResponseEntity<String> regNewDvrInfo(@RequestParam Map<String, Object> dvrMap, HttpServletRequest request)
			throws Exception {
		String message = null;
		String contextPath = request.getContextPath();
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "text/html; charset=utf-8");
		System.out.println(dvrMap);
		try {
			dvrService.regNewDvrInfo(dvrMap);
			message = "<script>" + " alert('배송지가 정상적으로 등록되었습니다.');" + " location.href='" + contextPath
					+ "/pp/';" + " </script>";
		} catch (Exception e) {
			message = "<script>" + " alert('다시 시도해주세요.');" + " location.href='" + contextPath + "/mem/myMain';"
					+ " </script>";
		}

		return new ResponseEntity<String>(message, header, HttpStatus.OK);
	}

	@Override
	@ResponseBody
	@PostMapping("/modify.do")
	public void modDvrInfo(@RequestParam Map<String, Object> dvrMap)throws Exception{
		String checktype = (String) dvrMap.get("dvr_type");
		System.out.println(checktype);
		dvrService.modDvrInfoById(dvrMap);
	}
	
	@Override
	@ResponseBody
	@PostMapping("/drop.do")
	public void dropDvrInfo(@RequestParam("dcode") String dcode)throws Exception{
		dvrService.removeDvrInfoFromId(dcode);
	}

}
