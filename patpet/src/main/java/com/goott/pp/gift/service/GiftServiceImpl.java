package com.goott.pp.gift.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goott.pp.common.mappers.BoardMapper;
import com.goott.pp.common.mappers.GiftMapper;
import com.goott.pp.gift.vo.GiftVO;

@Service
@Transactional
public class GiftServiceImpl implements GiftService {
	@Autowired
	GiftMapper giftMapper;
	@Autowired
	BoardMapper boardMapper;
	@Autowired
	GiftVO gift;

	@Override
	public List<GiftVO> allGiftList() {
		return giftMapper.selectAllGifts();
	}

	@Override
	public List<GiftVO> showUserGifts(String id) {
		return giftMapper.selectGiftListById(id);
	}
	
	@Override
	public int getRDCode(int code) {
		return giftMapper.selectRDCode(code);
	}
	
	@Override
	public int createNewGiftToUser(GiftVO giftVO) {
		return giftMapper.insertNewGiftToUser(giftVO);
	}

	@Override
	public int useGift(int gift_code) {
		return giftMapper.updateGiftUsed(gift_code);
	}
	
	@Override
	public int exchangeGift(Map<String, Object> map) {
		System.out.println(map.toString());
		int result;
		Map<String, Object> tempMap = new HashMap<String, Object>();
		tempMap.put("owner_id", map.get("atcWriter"));
		tempMap.put("gift_code", map.get("cmtGiftCode"));
		tempMap.put("no", map.get("atc_no"));
		result = giftMapper.updateOwner(tempMap);
		result += boardMapper.updateGiftCodeFromArticle(tempMap);
		System.out.println(tempMap.toString());
		tempMap.put("owner_id", map.get("cmtWriter"));
		tempMap.put("gift_code", map.get("atcGiftCode"));
		tempMap.put("no", map.get("cmt_no"));
		result += giftMapper.updateOwner(tempMap);
		result += boardMapper.updateGiftCodeFromComment(tempMap);
		System.out.println(tempMap.toString());
		return result;
	}

	@Override
	public int dropGiftFromUser(int gift_code) {
		return giftMapper.deleteGiftFromUser(gift_code);
	}
}