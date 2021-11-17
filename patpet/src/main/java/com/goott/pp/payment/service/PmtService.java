package com.goott.pp.payment.service;

import java.util.List;
import java.util.Map;

import com.goott.pp.payment.vo.PmtVO;

public interface PmtService {

	List<PmtVO> showPmtInfo(String id) throws Exception;

	void addNewInfo(Map<String, Object> pmtMap) throws Exception;

	void modPmtInfoById(Map<String, Object> pmtMap) throws Exception;

	void removePmtInfoFromId(String pcode) throws Exception;

}