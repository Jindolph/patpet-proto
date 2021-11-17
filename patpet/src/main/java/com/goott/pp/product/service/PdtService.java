package com.goott.pp.product.service;

import java.util.List;

import com.goott.pp.product.vo.PdtVO;

public interface PdtService {
	List<PdtVO> showAllProducts();

	List<PdtVO> showAllSubsProducts();

	List<PdtVO> showAllRandomProducts();
	
	PdtVO showProductDetail(int code);

	int addNewSubsProduct(PdtVO pdtVO);

	int addNewRdProduct(PdtVO pdtVO);

	int modifyProductName(PdtVO pdtVO);

	int deleteProduct(int pdt_code);
}