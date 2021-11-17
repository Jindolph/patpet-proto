package com.goott.pp.common.file.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Component("TestFileVO")
public class TestFileVO {

	private int file_NO;
	private int atc_no;
	private String del_GB;
	private String org_File_Name;
	private String stored_File_Name;
	private String content_id;
}