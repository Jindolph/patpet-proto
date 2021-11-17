package com.goott.pp.common.file.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.goott.pp.common.file.vo.FileVO;

public interface FileService {
	public List<FileVO> showAllFiles();

	public List<FileVO> showAllFilesFromDir(String data_path);
	
	public List<FileVO> updateFilesInDir(String content, String dataPath, List<MultipartFile> mFileList, String[] fileNames);

	public int checkFile(String orgn_name, long fileSize);
	
	public FileVO fileInfo(String fileName);

	public Map<String, Object> newFile(FileVO file);

	public List<FileVO> newFilesToDB(String content, String dataPath, List<MultipartFile> mFileList);

	public int deleteFile(String dataPath, String delFileName);

	public int deleteFile(String dataPath, String[] delFileNames);
}
