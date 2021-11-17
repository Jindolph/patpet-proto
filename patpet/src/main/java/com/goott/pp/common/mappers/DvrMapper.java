package com.goott.pp.common.mappers;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goott.pp.delivery.vo.DvrVO;

@Mapper
public interface DvrMapper {
	
	
	public List<DvrVO> selectAllDvrInfo() throws Exception;

	public List<DvrVO> selectDvrById(String id) throws Exception;

	public void insertNewAddrInfo1(Map<String, Object> map) throws Exception;

	public void insertNewAddrInfo2(Map<String, Object> map) throws Exception;

	public void updateAddressInfo(Map<String, Object> map) throws Exception;

	public void deleteAddressInfo(String dcode) throws Exception;

	void updateDvrType(Map<String, Object> dvrMap);
}