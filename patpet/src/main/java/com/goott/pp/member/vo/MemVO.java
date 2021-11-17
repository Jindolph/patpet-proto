package com.goott.pp.member.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component("memVO")
public class MemVO {
	private int mem_code;
	private String mem_id;
	private String mem_pw;
	private String mem_name;
	private String nickname;
	private Date birthdate;
	private Date joinDate;
	private int points;
	private String email_YN;
	private String is_subs;
	private String is_left;
	private Date leftDate;
	
}
