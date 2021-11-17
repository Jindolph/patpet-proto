package com.goott.pp.delivery.vo;

import org.springframework.stereotype.Component;

import lombok.Data;
@Data
@Component("dvrVO")
public class DvrVO {
	private int dvr_code;
	private String rcvr_name;
	private String mem_id;
	private String address;
	private String zipcode;
	private String addr_detail;
	private String requirement;
	private String phone_num;
	private String dvr_type;
}
