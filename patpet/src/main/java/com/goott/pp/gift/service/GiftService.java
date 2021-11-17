package com.goott.pp.gift.service;

import java.util.List;
import java.util.Map;

import com.goott.pp.gift.vo.GiftVO;

public interface GiftService {
	List<GiftVO> allGiftList();

	List<GiftVO> showUserGifts(String id);
	
	int getRDCode(int code);

	int createNewGiftToUser(GiftVO giftVO);

	int useGift(int gift_code);
	
	int exchangeGift(Map<String, Object> map);
	
	int dropGiftFromUser(int gift_code);
}