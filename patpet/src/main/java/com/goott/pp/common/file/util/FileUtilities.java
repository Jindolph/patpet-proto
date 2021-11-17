package com.goott.pp.common.file.util;

import java.io.File;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.goott.pp.common.file.vo.FileVO;

public class FileUtilities {
	public int uploadFilesToDir(String dataPath, List<MultipartFile> mFiles, List<FileVO> fileList) throws Exception {
		// 카운터
		int count = 0;

		// 경로에 파일 디렉토리가 없으면 디렉토리 형성함.
		File file = new File(dataPath);
		if (!file.exists())
			file.mkdirs();

		// multiFile의 리스트객체를 반복자로 Dir에 파일 업로드.
		for (MultipartFile mFile : mFiles) {
			if (!mFile.isEmpty()) {
				// 디렉토리에 파일 저장.
				file = new File(dataPath + fileList.get(count).getNew_name());
				System.out.println("FileUtils 카운터 : " + count);
				System.out.println("FileUtils 파일이름 : " + fileList.get(count).getNew_name());
				mFile.transferTo(file);
				count++;
			}
		}
		return count;
	}

	//단일 파일 삭제.
	public int deleteFileInDir(String dataPath, String delFileName) {
		try {
			File oldFile = new File(dataPath + delFileName);
			oldFile.delete();
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}

	//다중 파일 삭제.
	public int deleteFilesInDir(String dataPath, String[] delFileNamesArr) throws Exception {
		//카운터
		int count = 0;

		// 지울 파일 이름들을 이용해서 반복자
		// Dir에서 Arr에 저장된 이름의 파일들 삭제.
		for (String fileName : delFileNamesArr) {
			File oldFile = new File(dataPath + fileName);
			oldFile.delete();
			count++;
		}
		// 지워진 파일 갯수 리턴.
		return count;
	}
}