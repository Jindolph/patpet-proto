//package com.goott.pp.gift.controller;
//
//import java.util.List;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestMapping;
//
//import com.goott.pp.common.base.BaseController;
//import com.goott.pp.gift.service.GiftService;
//import com.goott.pp.gift.vo.GiftVO;
//
//@Controller
//@RequestMapping("/gift")
//public class GiftControllerImpl extends BaseController implements GiftController {
//	@Autowired
//	GiftService giftService;
//	@Autowired
//	GiftVO gift;
//
//	@Override
//	public List<GiftVO> showAllGifts() throws Exception {
//		return giftService.allGiftList();
//	}
//
//	@Override
//	public List<GiftVO> showAllGiftById(String id) throws Exception {
//		return giftService.showUserGifts(id);
//	}
//
//	@Override
//	public void createNewGiftToUser(GiftVO gift) throws Exception {
//		giftService.createNewGiftToUser(gift);
//	}
//
//	@Override
//	public void deleteGiftByUserId(String id) throws Exception {
//		giftService.dropGiftFromUser(id);
//	}
//}