package com.goott.pp.member.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goott.pp.common.mappers.BoardMapper;
import com.goott.pp.common.mappers.DvrMapper;
import com.goott.pp.common.mappers.MemMapper;
import com.goott.pp.member.vo.MemVO;



@Service
@Transactional
public class MemServiceImpl implements MemService {
	@Autowired
	MemMapper memMapper;
	@Autowired
	BoardMapper brdMapper;
	@Autowired
	DvrMapper dvrMapper;
	@Autowired
	MemVO mem;

	@Override
	public MemVO login(Map<String, String> loginMap) throws Exception {

			return memMapper.selectMemberByInfo(loginMap);
		
	}

	@Override
	public void regNewMemInfo(Map<String, Object> regMap) throws Exception {
		memMapper.insertNewMember(regMap);
		brdMapper.insertNewArticle2(regMap);
	}
	
	@Override
	public String overlapped(String id) throws Exception {
		if (memMapper.selectCheckOverlappedId(id) == 1) {
			return "true";
		} else {
			return "false";
		}
	}

	@Override
	public void chgpw(Map<String,String> changepwMap) throws Exception{
		memMapper.updateMemberPw(changepwMap);
	}
	
	@Override
	public void chgemail(Map<String,String> chageemailMap) throws Exception{
		memMapper.updateMemberEmail(chageemailMap);
	}
	
	@Override
	public void dropMember(String id) throws Exception {
		memMapper.updateMemberDropYN(id);
	}
	
	@Override
	public String searchId(Map<String,Object> findMap) throws Exception{
		String id = memMapper.selectFindId(findMap);
		return id;
	}
	
	@Override
	public String searchPw(Map<String,Object> findMap) throws Exception{
		String pw = memMapper.selectFindPw(findMap);
		return pw;
	}
	
	@Override
	public List<MemVO> getInfo(String id)throws Exception{
		return memMapper.selectMyInfo(id);
	}
	
}

