package com.goott.pp.payment.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goott.pp.common.mappers.PmtMapper;
import com.goott.pp.payment.vo.PmtVO;

@Service
@Transactional
public class PmtServiceImpl implements PmtService {
	@Autowired
	PmtMapper pmtMapper;
	@Autowired
	PmtVO pmt;


	@Override
	public List<PmtVO> showPmtInfo(String id) throws Exception {
		System.out.println("Service pmt id:"+id);
		List<PmtVO> pmtVO = pmtMapper.selectPmtById(id);
		System.out.println("Service pmt list:"+pmtVO);
		return pmtVO;
	}
	
	@Override
	public void addNewInfo(Map<String,Object> pmtMap) throws Exception{
		String flag = (String) pmtMap.get("pmt_type");
		
		if(flag.equals("Y")) {
			System.out.println("service y:"+flag);
		pmtMapper.updatePmtType(pmtMap);
		pmtMapper.insertPmtById(pmtMap);
		}else {
			System.out.println("service n:"+flag);
			pmtMapper.insertPmtById(pmtMap);
		}
		
	}
	
	@Override
	public void modPmtInfoById(Map<String, Object> pmtMap) throws Exception {

		String checktype = (String) pmtMap.get("pmt_type");
		System.out.println(checktype);
		
		if(checktype.equals("Y")) {
		pmtMapper.updatePmtType(pmtMap);
		pmtMapper.updatePmtInfo(pmtMap);
		}else {
			pmtMapper.updatePmtInfo(pmtMap);
		}

	}
	
	@Override
	public void removePmtInfoFromId(String pcode) throws Exception {
		pmtMapper.deletePmtInfo(pcode);
	}

}