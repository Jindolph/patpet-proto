package com.goott.pp.common.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.goott.pp.common.file.vo.FileVO;

@Mapper
public interface FileMapper {
	public int selectFileSeq();

	public List<FileVO> selectAllFileList();

	public List<FileVO> selectAllFilesFromDataPath(String data_path);

	public int selectSavedFile(String orgn_name, long fileSize);

	public FileVO selectFileInfo(String fileName);

	public int insertNewFile(FileVO fileVO);

	public int deleteFile(FileVO fileVO);
}