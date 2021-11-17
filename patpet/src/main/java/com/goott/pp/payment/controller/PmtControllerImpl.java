package com.goott.pp.payment.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.goott.pp.common.base.BaseController;
import com.goott.pp.payment.service.PmtService;
import com.goott.pp.payment.vo.PmtVO;

@Controller
@RequestMapping("/pmt")
public class PmtControllerImpl extends BaseController implements PmtController {
	@Autowired
	PmtService pmtService;
	@Autowired
	PmtVO pmt;

	@Override
	@ResponseBody
	@PostMapping("/pmtInfo.do") 
	  public List<PmtVO> pmtInfo(@RequestParam("id") String id) throws Exception{ 
		System.out.println("Controller pmt id:"+id);  
		List<PmtVO> pmtVO = pmtService.showPmtInfo(id); 
		System.out.println("Controller pmt list:"+pmtVO);
		  return pmtVO; 
	  }
	
	@Override
	@ResponseBody
	@PostMapping("/register.do")
	public void addNewPmt(@RequestParam Map<String, Object> pmtMap, HttpServletRequest request) throws Exception{
		System.out.println(pmtMap.get("pmt_card")+","+pmtMap.get("pmt_cnum")+","+pmtMap.get("mem_id"));
		pmtService.addNewInfo(pmtMap);
	}
	
	@Override
	@ResponseBody
	@PostMapping("/modify.do")
	public void modPmtInfo(@RequestParam Map<String, Object> pmtMap)throws Exception{
		String checktype = (String) pmtMap.get("pmt_type");
		pmtService.modPmtInfoById(pmtMap);
	}
	
	@Override
	@ResponseBody
	@PostMapping("/drop.do")
	public void dropPmtInfo(@RequestParam("pcode") String pcode)throws Exception{
		pmtService.removePmtInfoFromId(pcode);
	}
	

}