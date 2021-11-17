package com.goott.pp.delivery.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;

import com.goott.pp.delivery.vo.DvrVO;

public interface DvrController {
	public List<DvrVO> dvrInfo2(String id) throws Exception;

	public ResponseEntity<String> regNewDvrInfo(Map<String, Object> dvrMap, HttpServletRequest request) throws Exception;
	
	void modDvrInfo(Map<String, Object> dvrMap) throws Exception;

	void dropDvrInfo(String dcode) throws Exception;
}