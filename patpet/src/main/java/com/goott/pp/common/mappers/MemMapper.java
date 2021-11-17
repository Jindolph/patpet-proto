package com.goott.pp.common.mappers;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goott.pp.member.vo.MemVO;

@Mapper
public interface MemMapper {

	public MemVO selectMemberByInfo(Map<String, String> loginMap) throws Exception;

	public void insertNewMember(Map<String, Object> regMap) throws Exception;
	
	public int selectCheckOverlappedId(String id) throws Exception;

	public void updateMemberPw(Map<String, String> changepwMap);
	
	public void updateMemberEmail(Map<String, String> changepwMap);
	
	public void updateMemberDropYN(String id) throws Exception;
	
	public String selectFindId(Map<String,Object> findMap) throws Exception;

	public String selectFindPw(Map<String, Object> findMap);
	
	public List<MemVO> selectMyInfo(String id) throws Exception;

	public void updateisSubs(Map<String, Object> map);

	public void updateisSubsn(Map<String, Object> map);



	

}