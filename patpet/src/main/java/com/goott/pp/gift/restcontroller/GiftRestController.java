package com.goott.pp.gift.restcontroller;

import java.util.List;

import com.goott.pp.gift.vo.GiftVO;

public interface GiftRestController {
	List<GiftVO> showAllGifts();

	List<GiftVO> showAllGiftById(String id);

	void createNewGiftToUser(GiftVO gift);

	void deleteGiftByUserId(int gift_code);
}