package com.goott.pp.common.file.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.goott.pp.common.file.vo.FileVO;
import com.goott.pp.common.mappers.FileMapper;

@Service
@Transactional
public class FileServiceImpl implements FileService {
	@Autowired
	FileMapper fileMapper;
	@Autowired
	FileVO file;

	@Override
	public List<FileVO> showAllFiles() {
		return fileMapper.selectAllFileList();
	}

	@Override
	public List<FileVO> showAllFilesFromDir(String data_path) {
		return fileMapper.selectAllFilesFromDataPath(data_path);
	}

	@Override
	public int checkFile(String orgn_name, long fileSize) {
		return fileMapper.selectSavedFile(orgn_name, fileSize);
	}

	@Override
	public FileVO fileInfo(String fileName) {
		return fileMapper.selectFileInfo(fileName);
	}

	@Override
	public Map<String, Object> newFile(FileVO fileVO) {
		System.out.println("Service: " + fileVO.toString());

		String fileExtention = file.getNew_name();
		Map<String, Object> map = new HashMap<String, Object>();

		// 시퀀스 받아서 파일코드, 파일이름 세팅.
		int fileSeq = fileMapper.selectFileSeq();
		fileVO.setFile_code(fileSeq);
		fileVO.setNew_name("FILE" + fileSeq + fileExtention);

		// 행 추가 결과 받기.
		int result = fileMapper.insertNewFile(fileVO);

		// 맵에 이름, 결과 추가 후 리턴.
		map.put("result", result);
		map.put("file", fileVO);
		return map;
	}

	@Override
	public List<FileVO> newFilesToDB(String content, String dataPath, List<MultipartFile> mFileList) {
		List<FileVO> fileList = new ArrayList<FileVO>();
		String orgn_name, fileExtension;

		for (MultipartFile mFile : mFileList) {
			if (!mFile.isEmpty()) {
				FileVO _file = new FileVO();
				_file.setContent_id(content);
				_file.setData_path(dataPath);
				_file.setFileSize(mFile.getSize());

				int fileSeq = fileMapper.selectFileSeq();
				_file.setFile_code(fileSeq);
				orgn_name = mFile.getOriginalFilename();
				_file.setOrgn_name(orgn_name);
				fileExtension = orgn_name.substring(orgn_name.lastIndexOf("."));
				_file.setNew_name("FILE" + fileSeq + fileExtension);

				fileMapper.insertNewFile(_file);
				fileList.add(_file);
			}
		}
		System.out.println("DB에 저장된 파일들 : " + fileList.size());
		return fileList;
	}

	@Override
	public int deleteFile(String dataPath, String delFileName) {
		int delResult = 0;

		/* 파일 삭제 */
		file.setData_path(dataPath);

		file.setNew_name(delFileName);
		delResult += fileMapper.deleteFile(file);
		return delResult;
	}

	@Override
	public int deleteFile(String dataPath, String[] delFileNames) {
		int delResult = 0;

		/* 파일 삭제 */
		file.setData_path(dataPath);

		for (String fileName : delFileNames) {
			file.setNew_name(fileName);
			delResult += fileMapper.deleteFile(file);
		}
		return delResult;
	}

	@Override
	public List<FileVO> updateFilesInDir(String content, String data_path, List<MultipartFile> mFileList,
			String[] fileNames) {
		/* 파일 삭제 */
		file.setData_path(data_path);

		for (String fileName : fileNames) {
			file.setNew_name(fileName);
			fileMapper.deleteFile(file);
		}

		/* 파일 업로드. */

		// DB저장된 파일 객체들 담을 List.
		List<FileVO> fileList = new ArrayList<FileVO>();
		// 확장자에 쓰일 변수들.
		String orgn_name, fileExtension;

		// for문 이용해서 파일 객체 DB 저장 후 리스트에 담음.
		for (MultipartFile mFile : mFileList) {
			if (!mFile.isEmpty()) {
				FileVO _file = new FileVO();
				_file.setContent_id(content);
				_file.setData_path(data_path);
				_file.setFileSize(mFile.getSize());

				int fileSeq = fileMapper.selectFileSeq();
				_file.setFile_code(fileSeq);
				orgn_name = mFile.getOriginalFilename();
				_file.setOrgn_name(orgn_name);
				fileExtension = orgn_name.substring(orgn_name.lastIndexOf("."));
				_file.setNew_name("FILE" + fileSeq + fileExtension);

				fileMapper.insertNewFile(_file);
				fileList.add(_file);
			}
		}
		// 리스트 리턴
		return fileList;
	}
}