package com.goott.pp.delivery.service;

import java.util.List;
import java.util.Map;

import com.goott.pp.delivery.vo.DvrVO;

public interface DvrService {
	public List<DvrVO> showDvrInfo(String id) throws Exception;

	public void regNewDvrInfo(Map<String, Object> dvrMap) throws Exception;

	public void modDvrInfoById(Map<String, Object> dvrMap) throws Exception;

	public void removeDvrInfoFromId(String dcode) throws Exception;
}
