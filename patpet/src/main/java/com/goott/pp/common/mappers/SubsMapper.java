package com.goott.pp.common.mappers;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goott.pp.subs.vo.SubsVO;

@Mapper
public interface SubsMapper {
	public List<SubsVO> selectAllSubs();

	public List<SubsVO> selectAllSubsById(String id);

	public SubsVO selectSubsInfoById(String id);

	public String selectCheckIdAvailable(String id);

	public int insertNewSubs(Map<String, Object> map);

	public int updateSubsProlonged(Map<String, Object> map);

	public int updateSubsGrade(Map<String, Object> map);

	public int updateSubsCancel(Map<String, Object> map);
}