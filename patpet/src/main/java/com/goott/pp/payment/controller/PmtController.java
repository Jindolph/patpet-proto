package com.goott.pp.payment.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.goott.pp.payment.vo.PmtVO;

public interface PmtController {

	List<PmtVO> pmtInfo(String id) throws Exception;

	void addNewPmt(Map<String, Object> pmtMap, HttpServletRequest request) throws Exception;

	void modPmtInfo(Map<String, Object> pmtMap) throws Exception;

	void dropPmtInfo(String pcode) throws Exception;

}
