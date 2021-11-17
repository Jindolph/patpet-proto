package com.goott.pp.common.file.vo;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component("fileVO")
public class FileVO {
	private int file_code;
	private String content_id;
	private String orgn_name;
	private long fileSize;
	private String new_name;
	private String data_path;
}