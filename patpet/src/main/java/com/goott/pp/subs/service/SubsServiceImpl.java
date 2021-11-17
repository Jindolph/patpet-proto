package com.goott.pp.subs.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goott.pp.common.mappers.MemMapper;
import com.goott.pp.common.mappers.SubsMapper;
import com.goott.pp.subs.vo.SubsVO;

@Service
@Transactional
public class SubsServiceImpl implements SubsService {
	@Autowired
	SubsMapper sMapper;
	@Autowired
	SubsVO subs;
	@Autowired
	MemMapper memMapper;

	@Override
	public List<SubsVO> showAllSubs(){
		return sMapper.selectAllSubs();
	}

	public List<SubsVO> showAllSubsById(String id){
		System.out.println("서비스 받았습니다!!!!!!!!!!!!!!!!!!!!!!!!!");
		return sMapper.selectAllSubsById(id);
	}

	@Override
	public SubsVO selectSubsInfoById(String id){
		return sMapper.selectSubsInfoById(id);
	}

	@Override
	public Map<String, Object> idCheck(String id){
		Map<String, Object> result = new HashMap<String, Object>();

		String grade = sMapper.selectCheckIdAvailable(id);

		if (grade == null)
			grade = "";

		if (!grade.equals("")) {
			result.put("id", id);
			result.put("isSubs", true);
			result.put("grade", grade);
		} else {
			result.put("id", "");
			result.put("isSubs", false);
			result.put("grade", "");
		}
		return result;
	}

	@Override
	public int addNewSubs(Map<String, Object> map){
		memMapper.updateisSubs(map);
		return sMapper.insertNewSubs(map);
	}

	@Override
	public int modSubsInfo(Map<String, Object> map) {
		String grade = (String) map.get("grade");
		return grade.equals("none") ? sMapper.updateSubsProlonged(map) : sMapper.updateSubsGrade(map); 
	}

	@Override
	public int cancelSubs(Map<String, Object> map) {
		memMapper.updateisSubsn(map);
		Integer subs_code = Integer.parseInt((String)map.get("subs_code"));
		map.put("subs_code", subs_code);
		return sMapper.updateSubsCancel(map);
	}
}
