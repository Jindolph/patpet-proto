//package com.goott.pp.common.file.controller;
//
//import java.io.File;
//import java.net.URLEncoder;
//import java.util.ArrayList;
//import java.util.Iterator;
//import java.util.List;
//import java.util.Map;
//import java.util.stream.Collectors;
//
//import javax.servlet.http.HttpServletResponse;
//
//import org.apache.commons.io.FileUtils;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.DeleteMapping;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.RestController;
//import org.springframework.web.multipart.MultipartFile;
//import org.springframework.web.multipart.MultipartHttpServletRequest;
//
//import com.goott.pp.common.base.BaseController;
//import com.goott.pp.common.file.service.FileService;
//import com.goott.pp.common.file.util.FileUtilities;
//import com.goott.pp.common.file.vo.FileVO;
//
//@RestController
//@RequestMapping("/file")
//public class FileControllerImpl extends BaseController implements FileController {
//	private static final String baseDir = "C:\\FileRepository\\";
//	@Autowired
//	FileService fileService;
//	@Autowired
//	FileVO fileVO;
//	FileUtilities fileutils = new FileUtilities();
//
//	//테스트용 메소드이므로 무시.
//	@GetMapping({ "/all", "file-upload", "upload", "test2", "test", "allFiles" })
//	private @ModelAttribute List<FileVO> getAllFiles() {
//		return fileService.showAllFiles();
//	}
//
//	//REST API 이용해서 경로에 저장된 모든 파일 정보 읽어오기.(DB에서)
//	//download 메소드 아님!!!!
//	@GetMapping("/{content}/{id}")
//	private List<FileVO> getAllFilesFromDir(@PathVariable Map<String, String> map) {
//		String data_path = baseDir + map.get("content") + "\\" + map.get("id") + "\\";
//		System.out.println("데이터 패스: " + data_path);
//		return fileService.showAllFilesFromDir(data_path);
//	}
//
//	//REST API를 이용해서 직접 업로드 1차
//	@PostMapping("/{content}/{id}")
//	private void fileUploader(@PathVariable Map<String, String> map, MultipartHttpServletRequest request)
//			throws Exception {
//		// 메소드 내부에서 쓸 변수들 저장, content_id, data_path
//		String content = map.get("content");
//		String dataPath = baseDir + content + "\\" + map.get("id") + "\\";
//		// 확장자 처리에 임시로 쓸 변수들.
//		String originalFileName, originalFileExtension;
//		long fileSize;
//
//		// 업로드에 필요한 파일객체
//		MultipartFile mFile;
//
//		// 경로에 파일 디렉토리가 없으면 디렉토리 형성함.
//		File file = new File(dataPath);
//		if (!file.exists())
//			file.mkdirs();
//
//		// 요청에 등록된 파일 이름들 가져옴.
//		Iterator<String> fileNameIterator = request.getFileNames();
//
//		// 파일 이름 반복자를 이용해서, DB저장 및 파일시스템에 업로드.
//		while (fileNameIterator.hasNext()) {
//			// 요청에 전달된 파일을 mFile객체에 저장.
//			mFile = request.getFile(fileNameIterator.next());
//
//			if (!mFile.isEmpty()) {
//				// 확장자 처리.
//				originalFileName = mFile.getOriginalFilename();
//				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
//				// 파일사이즈
//				fileSize = mFile.getSize();
//
//				// 서비스 호출 : DB에 File 저장.
//				fileVO.setContent_id(content);
//				fileVO.setData_path(dataPath);
//				fileVO.setOrgn_name(originalFileName);
//				fileVO.setFileSize(fileSize);
//				fileVO.setNew_name(originalFileExtension);
//				Map<String, Object> resultMap = fileService.newFile(fileVO);
//
//				// DB에 파일 업로드 정상적으로 된 경우, 모든 파일정보 가진 파일객체 셋팅.
//				if ((int) resultMap.get("result") == 1) {
//					fileVO = (FileVO) resultMap.get("file");
//				}
//
//				// 디렉토리에 파일 저장.
//				file = new File(dataPath + fileVO.getNew_name());
//				mFile.transferTo(file);
//			}
//		}
//	}
//
//	//FileUtilities의 업로드 메소드 사용 2차
//	@PostMapping("/util/{content}/{id}")
//	private void uploadTest(@PathVariable Map<String, String> map, MultipartHttpServletRequest request) throws Exception {
//		//메소드 내부에서 쓸 변수들 저장.
//		String content = (String) map.get("content");
//		String dataPath = baseDir + map.get("content") + "\\" + map.get("id") + "\\";
//		//스트림을 이용해서 Map을 List로 변환함. (value만 가져옴)
//		List<MultipartFile> mFileList = request.getFileMap().values().stream()
//				.collect(Collectors.toCollection(ArrayList::new));
//		//DB 접속해서 파일 목록 저장 후, 파일리스트 객체 받아옴.
//		List<FileVO> fileList = fileService.newFilesToDB(content, dataPath, mFileList);
//		//fileUtils의 업로드 메소드 이용해서 FileSystem에 저장함.
//		fileutils.uploadFilesToDir(dataPath, mFileList, fileList);
//	}
//
//	//REST API로 요청받아, fileUtilities 메소드 이용. 삭제/업로드.
//	//FileUtilities의 메소드 사용 3차
//	@PostMapping("/modtest/{content}/{id}")
//	private void modUploadTest(@PathVariable Map<String, Object> map, @RequestParam("fileNames") String[] fileNames,
//			MultipartHttpServletRequest request) throws Exception {
//		//메소드 내부에서 쓸 변수들 저장
//		String content = (String) map.get("content");
//		String dataPath = baseDir + map.get("content") + "\\" + map.get("id") + "\\";
//		//스트림을 이용해서 Map을 List로 변환함. (value만 가져옴)
//		List<MultipartFile> mFileList = request.getFileMap().values().stream()
//				.collect(Collectors.toCollection(ArrayList::new));
//		List<FileVO> fileList = fileService.updateFilesInDir(content, dataPath, mFileList, fileNames);
//
//		//fileUtils 이용해서 FileSystem에 있는 파일 삭제/ 업로드.
//		fileutils.deleteFilesInDir(dataPath, fileNames);
//		fileutils.uploadFilesToDir(dataPath, mFileList, fileList);
//	}
//
//	//REST API를 이용해서 경로에 저장된 모든 파일 삭제.(DB, DIR)
//	@DeleteMapping("/{content}/{id}/{fileName}")
//	private ResponseEntity<String> fileUpdater(@PathVariable Map<String, String> map) throws Exception {
//		String dataPath = baseDir + map.get("content") + "\\" + map.get("id") + "\\";
//		String fileName = map.get("fileName");
//
//		fileutils.deleteFileInDir(dataPath, fileName);
//
//		return fileService.deleteFile(dataPath, fileName) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
//				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//	}
//
//	//파일 다운로드
//	@GetMapping("/download/{content}/{id}/{fileName}")
//	private void download(@PathVariable Map<String, String> map, HttpServletResponse response) throws Exception {
//		// 메소드 내부에서 쓸 변수들 저장, data_path, fileName
//		String dataPath = baseDir + map.get("content") + "\\" + map.get("id") + "\\";
//		String fileName = map.get("fileName");
//
//		// 파일 스트림 형성 후, byte[] 바이트 형 배열로 만듦.
//		byte fileBytes[] = FileUtils.readFileToByteArray(new File(dataPath + "\\" + fileName));
//
//		// 파일스트림으로 응답함.
//		response.setContentType("application/octet-stream");
//		response.setContentLength(fileBytes.length);
//		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileName, "UTF-8") + "\";");
//		response.getOutputStream().write(fileBytes);
//		response.getOutputStream().flush();
//		response.getOutputStream().close();
//	}
//}