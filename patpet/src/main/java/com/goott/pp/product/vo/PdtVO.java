package com.goott.pp.product.vo;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component("pdtVO")
public class PdtVO {
	private int pdt_code;
	private String pdt_type;
	private String pdt_name;
	private Timestamp regDate;
}