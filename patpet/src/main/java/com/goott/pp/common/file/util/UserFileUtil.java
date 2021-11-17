package com.goott.pp.common.file.util;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.goott.pp.board.vo.AtcVO;

@Component("UserFileUtil")
public class UserFileUtil {

	private static final String data_Path = "C:\\FileRepository\\";

	public List<Map<String, Object>> FileUpload(AtcVO atcVO, MultipartHttpServletRequest mpRequest) throws Exception {

		Iterator<String> iterator = mpRequest.getFileNames();

		MultipartFile multipartFile = null;
		String originalFileName = null;
		String originalFileExtension = null;
		String storedFileName = null;
		String content_id = "USERBRD";

		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> listMap = null;

		int atc_no = atcVO.getAtc_no();

		File file = new File(data_Path + "\\" + content_id + "\\" + atc_no + "\\");
		if (file.exists() == false) {
			file.mkdirs();
		}

		while (iterator.hasNext()) {
			multipartFile = mpRequest.getFile(iterator.next());
			if (multipartFile.isEmpty() == false) {
				originalFileName = multipartFile.getOriginalFilename();
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				storedFileName = getRandomString() + originalFileExtension;

				file = new File(data_Path + "\\" + content_id + "\\" + atc_no + "\\" + storedFileName + "\\");
				multipartFile.transferTo(file);
				listMap = new HashMap<String, Object>();
				listMap.put("atc_no", atc_no);
				listMap.put("originalFileName", originalFileName);
				listMap.put("storedFileName", storedFileName);
				listMap.put("fileSize", multipartFile.getSize());
				listMap.put("content_id", content_id);
				list.add(listMap);
			}
		}
		return list;
	}

	public List<Map<String, Object>> parseUpdateFileInfo(AtcVO atcVO, String[] files, String[] fileNames,
			MultipartHttpServletRequest mpRequest) throws Exception {

//저장된 요소 읽어오기
		Iterator<String> iterator = mpRequest.getFileNames();

		MultipartFile multipartFile = null;
		String originalFileName = null;
		String originalFileExtension = null;
		String storedFileName = null;
		String content_id = "USERBRD";

		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

		Map<String, Object> listMap = null;

		int atc_no = atcVO.getAtc_no();

		while (iterator.hasNext()) {
			multipartFile = mpRequest.getFile(iterator.next());
			if (multipartFile.isEmpty() == false) {

				originalFileName = multipartFile.getOriginalFilename();
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));

				storedFileName = getRandomString() + originalFileExtension;
				multipartFile.transferTo(new File(data_Path + "\\" + content_id + "\\" + atc_no + "\\" + storedFileName + "\\"));

				listMap = new HashMap<String, Object>();
				listMap.put("IS_NEW", "Y");
				listMap.put("atc_no", atc_no);
				listMap.put("originalFileName", originalFileName);
				listMap.put("storedFileName", storedFileName);
				listMap.put("fileSize", multipartFile.getSize());
				listMap.put("content_id", content_id);
				list.add(listMap);
			}
		}
		if (files != null && fileNames != null) {
			for (int i = 0; i < fileNames.length; i++) {
				listMap = new HashMap<String, Object>();
				listMap.put("IS_NEW", "N");
				listMap.put("FILE_NO", files[i]);
				listMap.put("storedFile", storedFileName);
				list.add(listMap);
			}
		}
		return list;
	}

	// 난수 주는 로직
	public static String getRandomString() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}

}