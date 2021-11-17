package com.goott.pp.product.restcontroller;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.goott.pp.product.vo.PdtVO;

public interface PdtRestController {
	public List<PdtVO> subsPdtLists();

	public List<PdtVO> rdPdtLists();
	
	public ResponseEntity<String> newSubsPdt(PdtVO pdtVO);

	public ResponseEntity<String> newRdPdt(PdtVO pdtVO);
	
	public ResponseEntity<String> modPdt(int pdt_code);
	
	public ResponseEntity<String> dropPdt(int pdt_code);
}
