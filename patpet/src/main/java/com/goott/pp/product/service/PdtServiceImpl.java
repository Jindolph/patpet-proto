package com.goott.pp.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goott.pp.common.mappers.PdtMapper;
import com.goott.pp.product.vo.PdtVO;

@Service
@Transactional
public class PdtServiceImpl implements PdtService {
	@Autowired
	PdtMapper pdtMapper;
	@Autowired
	PdtVO pdt;
	
	private int getNewProductSeq(String type) {
		return type.equals("SUBS_PDT") ? pdtMapper.selectSubsProductSeq() : pdtMapper.selectRdProductSeq();
	}

	@Override
	public List<PdtVO> showAllProducts() {
		return pdtMapper.selectAllProducts();
	}

	@Override
	public List<PdtVO> showAllSubsProducts() {
		return pdtMapper.selectAllSubsProducts();
	}

	@Override
	public List<PdtVO> showAllRandomProducts() {
		return pdtMapper.selectAllRdProducts();
	}
	
	@Override
	public PdtVO showProductDetail(int code) {
		return pdtMapper.selectProductByCode(code);
	}

	@Override
	public int addNewSubsProduct(PdtVO pdtVO) {
		int code = getNewProductSeq(pdtVO.getPdt_type());
		pdtVO.setPdt_code(code);
		pdtMapper.insertNewSubsProduct(pdtVO);
		return code;
	}

	@Override
	public int addNewRdProduct(PdtVO pdtVO) {
		int code = getNewProductSeq(pdtVO.getPdt_type());
		pdtVO.setPdt_code(code);
		pdtMapper.insertNewRdProduct(pdtVO);
		return code;
	}

	@Override
	public int modifyProductName(PdtVO pdtVO) {
		return pdtMapper.updatePdt(pdtVO);
	}

	@Override
	public int deleteProduct(int pdt_code) {
		return pdtMapper.deletePdt(pdt_code);
	}
}