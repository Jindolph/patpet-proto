package com.goott.pp.product.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
//import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
//import org.springframework.web.multipart.MultipartFile;

import com.goott.pp.common.base.BaseController;
import com.goott.pp.product.service.PdtService;
import com.goott.pp.product.vo.PdtVO;

@RestController
@RequestMapping("/pdt")
public class PdtRestControllerImpl extends BaseController /* implements PdtRestController */ {
	
	@Autowired
	PdtService pdtService;
	@Autowired
	PdtVO pdt;

	@GetMapping({"/all", "/new", "/modify", "/delete", "/detail"})
	public @ModelAttribute Object jspFinder() {
		return null;
	}
	
	@GetMapping("/{code}")
	public PdtVO getProductInfo(@PathVariable("code") int code) {
		return pdtService.showProductDetail(code);
	}

	@GetMapping("/list/{type}")
	public List<PdtVO> productList(@PathVariable("type") String pdtType) {
		if(pdtType.equals("SUBS_PDT")) {
			return pdtService.showAllSubsProducts();
		}else if(pdtType.equals("RD_PDT")) {
			return pdtService.showAllRandomProducts();
		}
		return null;
	}

	@PostMapping("/new/{type}")
	public ResponseEntity<String> newProduct(@PathVariable("type") String pdtType, @RequestBody PdtVO pdtVO) {
		int result = 0;
		if(pdtType.equals("SUBS_PDT")) {
			result = pdtService.addNewSubsProduct(pdtVO);
		}else if(pdtType.equals("RD_PDT")) {
			result = pdtService.addNewRdProduct(pdtVO);
		}
		return result > 1 ? new ResponseEntity<String>(""+result, HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@PutMapping("/{pdt_code}")
	public ResponseEntity<String> modProduct(@PathVariable("pdt_code") int pdt_code, @RequestBody PdtVO pdtVO) {
		return pdtService.modifyProductName(pdtVO) == 1 ? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@DeleteMapping("/{pdt_code}")
	public ResponseEntity<String> delProduct(@PathVariable("pdt_code") int pdt_code) {
		return pdtService.deleteProduct(pdt_code) == 1 ? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}