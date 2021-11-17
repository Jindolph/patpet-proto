package com.goott.pp.member.service;

import java.util.List;
import java.util.Map;

import com.goott.pp.member.vo.MemVO;

public interface MemService {

	public MemVO login(Map<String, String> loginMap) throws Exception;

	public void regNewMemInfo(Map<String, Object> regMap) throws Exception;

	public String overlapped(String id) throws Exception;

	public void chgpw(Map<String, String> changepwMap) throws Exception;
	
	void chgemail(Map<String, String> chageemailMap) throws Exception;
	
	public void dropMember(String id)throws Exception;

	public String searchId(Map<String, Object> findMap) throws Exception;

	String searchPw(Map<String, Object> findMap) throws Exception;

	public List<MemVO> getInfo(String id) throws Exception;

}
