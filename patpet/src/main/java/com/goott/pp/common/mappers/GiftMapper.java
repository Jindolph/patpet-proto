package com.goott.pp.common.mappers;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goott.pp.gift.vo.GiftVO;

@Mapper
public interface GiftMapper {
	List<GiftVO> selectAllGifts();

	List<GiftVO> selectGiftListById(String id);

	int selectRDCode(int code);

	int insertNewGiftToUser(GiftVO giftVO);

	int updateGiftUsed(int gift_code);
	
	int updateOwner(Map<String, Object> map);

	int deleteGiftFromUser(int gift_code);
}