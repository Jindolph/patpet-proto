package com.goott.pp.gift.restcontroller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.goott.pp.gift.service.GiftService;
import com.goott.pp.gift.vo.GiftVO;

@RestController
@RequestMapping("/gift")
public class GiftRestControllerImpl /* implements GiftRestController */ {
	@Autowired
	GiftService giftService;
	@Autowired
	GiftVO gift;

	@GetMapping(value = "/all", produces = { "application/json; charset=utf-8" })
	public List<GiftVO> showAllGifts() {
		return giftService.allGiftList();
	}

	@GetMapping(value = "/{id}", produces = { "application/json; charset=utf-8" })
	public List<GiftVO> showAllGiftById(@PathVariable String id) {
		return giftService.showUserGifts(id);
	}
	
	@GetMapping("/RDCode/{code}")
	public String getRDCode(@PathVariable("code") int code) {
		return "" + giftService.getRDCode(code);
	}

	@PostMapping("/new")
	public void createNewGiftToUser(@ModelAttribute GiftVO gift) {
		giftService.createNewGiftToUser(gift);
	}

	@PatchMapping("/{gift_code}/open")
	public void useGift(@PathVariable("gift_code") int gift_code) {
	}

	@PatchMapping("/{gift_code}/{owner_id}")
	public void changeOwner(@PathVariable Map<String, Object> map) {
	}

	@PutMapping("/exchange")
	public ResponseEntity<String> exchangeGift(@RequestBody Map<String, Object> map) {
		System.out.println(map.toString());
		return giftService.exchangeGift(map) == 4 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@DeleteMapping("/{giftCode}")
	public void deleteGiftByUserId(@PathVariable("giftCode") int gift_code) {
		giftService.dropGiftFromUser(gift_code);
	}

	@GetMapping({ "/*" })
	private @ModelAttribute Object jspFinder() {
		return null;
	}
}