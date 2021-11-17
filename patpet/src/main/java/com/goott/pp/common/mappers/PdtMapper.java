package com.goott.pp.common.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.goott.pp.product.vo.PdtVO;

@Mapper
public interface PdtMapper {
	int selectSubsProductSeq();

	int selectRdProductSeq();
	
	List<PdtVO> selectAllProducts();

	List<PdtVO> selectAllSubsProducts();

	List<PdtVO> selectAllRdProducts();

	PdtVO selectProductByCode(int code);
	
	int insertNewSubsProduct(PdtVO pdtVO);

	int insertNewRdProduct(PdtVO pdtVO);

	int updatePdt(PdtVO pdtVO);

	int deletePdt(int pdt_code);
}