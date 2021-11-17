package com.goott.pp.delivery.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goott.pp.common.mappers.DvrMapper;
import com.goott.pp.delivery.vo.DvrVO;

@Service
@Transactional
public class DvrServiceImpl implements DvrService {
	@Autowired
	DvrMapper dvrMapper;
	@Autowired
	DvrVO dvrVO;

	@Override
	public List<DvrVO> showDvrInfo(String id) throws Exception {
		List<DvrVO> dvrVO = dvrMapper.selectDvrById(id);
		return dvrVO;
	}

	@Override
	public void regNewDvrInfo(Map<String, Object> dvrMap) throws Exception {
		String flag = (String) dvrMap.get("dvr_type");
		
		
		if(flag.equals("Y")) {
			System.out.println("service y:"+flag);
		dvrMapper.updateDvrType(dvrMap);
		dvrMapper.insertNewAddrInfo2(dvrMap);
		}else {
			System.out.println("service n:"+flag);
		dvrMapper.insertNewAddrInfo2(dvrMap);
		}
		
	}

	@Override
	public void modDvrInfoById(Map<String, Object> dvrMap) throws Exception {

		String checktype = (String) dvrMap.get("dvr_type");
		System.out.println(checktype);
		
		if(checktype.equals("Y")) {
		dvrMapper.updateDvrType(dvrMap);
		dvrMapper.updateAddressInfo(dvrMap);
		}else {
			dvrMapper.updateAddressInfo(dvrMap);
		}

	}

	@Override
	public void removeDvrInfoFromId(String dcode) throws Exception {
		dvrMapper.deleteAddressInfo(dcode);
	}
}
