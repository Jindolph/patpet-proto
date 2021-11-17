package com.goott.pp.subs.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component("subsVO")
public class SubsVO {
	private int subs_code;
	private String subs_grade;
	private Date beginDate;
	private Date endDate;
	private String client_id;
	private String is_canceled;
}
