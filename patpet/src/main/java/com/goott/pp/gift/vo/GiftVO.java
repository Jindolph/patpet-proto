package com.goott.pp.gift.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component("giftVO")
public class GiftVO {
	private int gift_code;
	private String owner_id;
	private String gift_type;
	private int gift_value;
	private String is_opened;
	private Date regDate;
	private String pdt_name;
}