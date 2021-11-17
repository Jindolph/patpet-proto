package com.goott.pp.payment.vo;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

@Component("pmtVO")
public class PmtVO {
	private int pay_code;
	private String mem_id;
	private int subs_code;
	private String pmt_card;
	private String pmt_cnum;
	private Timestamp pmt_date;
	private String pmt_type;
	
	public String getPmt_type() {
		return pmt_type;
	}
	public void setPmt_type(String pmt_type) {
		this.pmt_type = pmt_type;
	}
	public int getPay_code() {
		return pay_code;
	}
	public void setPay_code(int pay_code) {
		this.pay_code = pay_code;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public int getSubs_code() {
		return subs_code;
	}
	public void setSubs_code(int subs_code) {
		this.subs_code = subs_code;
	}
	public String getPmt_card() {
		return pmt_card;
	}
	public void setPmt_card(String pmt_card) {
		this.pmt_card = pmt_card;
	}
	public String getpmt_cnum() {
		return pmt_cnum;
	}
	public void setpmt_cnum(String pmt_cnum) {
		this.pmt_cnum = pmt_cnum;
	}
	public Timestamp getPmt_date() {
		return pmt_date;
	}
	public void setPmt_date(Timestamp pmt_date) {
		this.pmt_date = pmt_date;
	}
	
	
}