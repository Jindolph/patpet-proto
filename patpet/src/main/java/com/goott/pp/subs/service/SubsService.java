package com.goott.pp.subs.service;

import java.util.List;
import java.util.Map;

import com.goott.pp.subs.vo.SubsVO;

public interface SubsService {
	public List<SubsVO> showAllSubs();

	public List<SubsVO> showAllSubsById(String id);

	public SubsVO selectSubsInfoById(String id);

	public Map<String, Object> idCheck(String id);

	public int addNewSubs(Map<String, Object> map);

	public int modSubsInfo(Map<String, Object> map);

	public int cancelSubs(Map<String, Object> map);
}