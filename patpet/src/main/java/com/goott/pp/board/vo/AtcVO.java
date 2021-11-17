package com.goott.pp.board.vo;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component("atcVO")
public class AtcVO {
	private int atc_no;
	private String title;
	private String txt_content;
	private Timestamp regDate;
	private Timestamp modDate;
	private String is_secret;
	private String atc_type;
	private String writer;
	private int hearts;
	private int hits;
	private int product;
}