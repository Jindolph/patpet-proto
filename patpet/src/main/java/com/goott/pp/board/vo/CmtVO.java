package com.goott.pp.board.vo;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component("cmtVO")
public class CmtVO {
	private int cmt_no;
	private int parent_atc;
	private String txt_content;
	private Timestamp regDate;
	private Timestamp modDate;
	private String writer;
	private int product;
}