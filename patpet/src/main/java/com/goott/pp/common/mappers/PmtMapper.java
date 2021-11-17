package com.goott.pp.common.mappers;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goott.pp.payment.vo.PmtVO;

@Mapper
public interface PmtMapper {

	public List<PmtVO> selectPmtById(String id) throws Exception;

	public void insertPmtById(Map<String, Object> pmtMap) throws Exception;

	public void updatePmtType(Map<String, Object> pmtMap) throws Exception;

	public void updatePmtInfo(Map<String, Object> pmtMap) throws Exception;

	public void deletePmtInfo(String pcode) throws Exception;

}