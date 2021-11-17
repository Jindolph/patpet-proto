package com.goott.pp.common.file.restcontroller;

import java.io.File;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.goott.pp.common.base.BaseController;
import com.goott.pp.common.file.service.FileService;
import com.goott.pp.common.file.util.FileUtilities;
import com.goott.pp.common.file.vo.FileVO;
import com.goott.pp.gift.service.GiftService;

import net.coobird.thumbnailator.Thumbnails;

@RestController
@RequestMapping("/file")
public class FileRestControllerImpl extends BaseController implements FileRestController {
	private static final String baseDir = "C:\\FileRepository\\";
	@Autowired
	FileService fileService;
	@Autowired
	GiftService giftService;
	@Autowired
	FileVO fileVO;

	FileUtilities fileutils = new FileUtilities();

	@GetMapping({ "all", "delete", "mod-upload", "upload", "integrated" })
	private @ModelAttribute Object jspFind() {
		return null;
	}

	// REST API 이용해서 경로에 저장된 모든 파일 정보 읽어오기.(DB에서)
	// download 메소드 아님!!!!
	@GetMapping("/{content}/{id}")
	private List<FileVO> getAllFilesFromDir(@PathVariable Map<String, String> map) {
		String data_path = baseDir + map.get("content") + "\\" + map.get("id") + "\\";
		return fileService.showAllFilesFromDir(data_path);
	}

	// FileUtilities의 업로드 메소드 사용 2차
	@PostMapping("/upload/{content}/{id}")
	private void upload(@PathVariable Map<String, String> map, MultipartHttpServletRequest request) throws Exception {
		// 메소드 내부에서 쓸 변수들 저장.
		String content = (String) map.get("content");
		String dataPath = baseDir + map.get("content") + "\\" + map.get("id") + "\\";
		// 스트림을 이용해서 Map을 List로 변환함. (value만 가져옴)
		List<MultipartFile> mFileList = request.getFileMap().values().stream()
				.collect(Collectors.toCollection(ArrayList::new));
		// DB 접속해서 파일 목록 저장 후, 파일리스트 객체 받아옴.
		List<FileVO> fileList = fileService.newFilesToDB(content, dataPath, mFileList);
		// fileUtils의 업로드 메소드 이용해서 FileSystem에 저장함.
		fileutils.uploadFilesToDir(dataPath, mFileList, fileList);
	}

	// REST API로 요청받아, fileUtilities 메소드 이용. 삭제/업로드.
	// 수정이지만 실제 사용은 upload / delete
	// FileUtilities의 메소드 사용 3차
	@PostMapping("/modupload/{content}/{id}")
	private void modUpload(@PathVariable Map<String, Object> map, @RequestParam("fileNames") String[] fileNames,
			MultipartHttpServletRequest request) throws Exception {
		// 메소드 내부에서 쓸 변수들 저장
		String content = (String) map.get("content");
		String dataPath = baseDir + map.get("content") + "\\" + map.get("id") + "\\";
		// 스트림을 이용해서 Map을 List로 변환함. (value만 가져옴)
		List<MultipartFile> mFileList = request.getFileMap().values().stream()
				.collect(Collectors.toCollection(ArrayList::new));
		List<FileVO> fileList = fileService.updateFilesInDir(content, dataPath, mFileList, fileNames);

		// fileUtils 이용해서 FileSystem에 있는 파일 삭제/ 업로드.
		fileutils.deleteFilesInDir(dataPath, fileNames);
		fileutils.uploadFilesToDir(dataPath, mFileList, fileList);
	}

	//디렉토리 내 모든 파일 삭제
	@DeleteMapping("/{content}/{id}")
	private ResponseEntity<String> delFileInDir(@PathVariable Map<String, String> map) throws Exception {
		//URL에 담긴 패스변수들 자바변수로 변환
		String dataPath = baseDir + map.get("content") + "\\" + map.get("id") + "\\";
		List<FileVO> files = getAllFilesFromDir(map);
		String[] delFileNames = new String[files.size()];
		int index = 0;
		
		for (FileVO delFile : files) {
			delFileNames[index] = delFile.getNew_name();
		}
		
		//파일유틸 이용해서 삭제 
		fileutils.deleteFilesInDir(dataPath, delFileNames);

		//삭제결과에 따라 상태 Status 반환
		return fileService.deleteFile(dataPath, delFileNames) >= 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//REST API를 이용해서 경로에 저장된 모든 파일 삭제.(DB, DIR)
	@DeleteMapping("/{content}/{id}/{fileName}")
	private ResponseEntity<String> fileUpdater(@PathVariable Map<String, String> map) throws Exception {
		// URL에 담긴 패스변수들 자바변수로 변환
		String dataPath = baseDir + map.get("content") + "\\" + map.get("id") + "\\";
		String fileName = map.get("fileName");

		// 파일유틸 이용해서 삭제
		fileutils.deleteFileInDir(dataPath, fileName);

		// 삭제결과에 따라 상태 Status 반환
		return fileService.deleteFile(dataPath, fileName) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	//파일 다운로드
	@GetMapping("/download/{content}/{id}/{fileName}")
	private void download(@PathVariable Map<String, String> map, HttpServletResponse response) throws Exception {
		// 메소드 내부에서 쓸 변수들 저장, data_path, fileName
		String dataPath = baseDir + map.get("content") + "\\" + map.get("id") + "\\";
		String fileName = map.get("fileName");

		File file = new File(dataPath + "\\" + fileName);
		if(!file.exists())
			return;
		
		// 파일 스트림 형성 후, byte[] 바이트 형 배열로 만듦.
		byte fileBytes[] = FileUtils.readFileToByteArray(new File(dataPath + "\\" + fileName));

		// 파일스트림으로 응답함.
		response.setContentType("application/octet-stream");
		response.setContentLength(fileBytes.length);
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileName, "UTF-8") + "\";");
		response.getOutputStream().write(fileBytes);
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}

	//파일 다운로드2
	@GetMapping("/download/{content}/{id}")
	private void singleDownload(@PathVariable Map<String, String> map, HttpServletResponse response) throws Exception {
		// 메소드 내부에서 쓸 변수들 저장, data_path, fileName
		String dataPath = baseDir + map.get("content") + "\\" + map.get("id") + "\\";
		String fileName = getAllFilesFromDir(map).get(0).getNew_name();

		File file = new File(dataPath + "\\" + fileName);
		if(!file.exists())
			return;
		
		// 파일 스트림 형성 후, byte[] 바이트 형 배열로 만듦.
		byte fileBytes[] = FileUtils.readFileToByteArray(file);
		
		// 파일스트림으로 응답함.
		response.setContentType("application/octet-stream");
		response.setContentLength(fileBytes.length);
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileName, "UTF-8") + "\";");
		response.getOutputStream().write(fileBytes);
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}

	//썸네일 다운로드
	@GetMapping("/thumbnail/{content}/{id}/{fileName}")
	private void thumbnails(@PathVariable Map<String, String> map, HttpServletResponse response) throws Exception {
		// 메소드 내부에서 쓸 변수들 저장, data_path, fileName
		String dataPath = baseDir + map.get("content") + "\\" + map.get("id") + "\\";
		String fileName = map.get("fileName");
		OutputStream os = response.getOutputStream();

		File image = new File(dataPath + "\\" + fileName);
		if(!image.exists())
			return;

		Thumbnails.of(image).size(121, 154).outputFormat("png").toOutputStream(os);

		byte[] buffer = new byte[1024 * 8];
		os.write(buffer);
		os.flush();
		os.close();
	}

	//썸네일 다운로드2
	@GetMapping("/thumbnail/{content}/{id}")
	private void thumbnails2(@PathVariable Map<String, String> map, HttpServletResponse response) throws Exception {
		// 메소드 내부에서 쓸 변수들 저장, data_path, fileName
		String dataPath = baseDir + map.get("content") + "\\" + map.get("id") + "\\";
		String fileName = getAllFilesFromDir(map).get(0).getNew_name();

		OutputStream os = response.getOutputStream();

		File image = new File(dataPath + "\\" + fileName);
		if(!image.exists())
			return;
		
		Thumbnails.of(image).size(121, 154).outputFormat("png").toOutputStream(os);

		byte[] buffer = new byte[1024 * 8];
		os.write(buffer);
		os.flush();
		os.close();
	}
	
	//썸네일 다운로드2
	@GetMapping("/thumbnail/GIFT/{code}")
	private void giftThumbnails(@PathVariable("code") int code, HttpServletResponse response) throws Exception {
		int pdtCode = giftService.getRDCode(code);
		String dataPath = baseDir + "PDT" + "\\" + pdtCode + "\\";
		String fileName = findFileFromDir(dataPath).get(0).getNew_name();

		OutputStream os = response.getOutputStream();

		File image = new File(dataPath + "\\" + fileName);
		if(!image.exists())
			return;
		
		Thumbnails.of(image).size(121, 154).outputFormat("png").toOutputStream(os);

		byte[] buffer = new byte[1024 * 8];
		os.write(buffer);
		os.flush();
		os.close();
	}
	
	private List<FileVO> findFileFromDir(String dataPath) {
		return fileService.showAllFilesFromDir(dataPath);
	}
}
