package com.goott.pp.common.paging;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.ToString;

@ToString
public class PagingDTO2 {
	private int currentPageNo;
	private int rowCntPerPage;
	private String searchKeyword;
	private String searchScope;

	public PagingDTO2() {
		this.currentPageNo = 1;
		this.rowCntPerPage = 10;
	}

	public PagingDTO2(int currentPageNo, int rowCntPerPage) {
		this.rowCntPerPage = rowCntPerPage;
		if (currentPageNo <= 0) {
			this.currentPageNo = 1;
			return;
		}
		this.currentPageNo = currentPageNo;

	}

	public PagingDTO2(int currentPageNo, int rowCntPerPage, String searchKeyword, String searchScope) {
		super();
		this.currentPageNo = currentPageNo;
		this.rowCntPerPage = rowCntPerPage;
		this.searchKeyword = searchKeyword;
		this.searchScope = searchScope;
	}

	public int getCurrentPageNo() {
		return currentPageNo;
	}

	public void setCurrentPageNo(int currentPageNo) {
		if (currentPageNo <= 0) {
			this.currentPageNo = 1;
			return;
		}
		this.currentPageNo = currentPageNo;
	}

	public int getRowCntPerPage() {
		return rowCntPerPage;
	}

	public void setRowCntPerPage(int rowCntPerPage) {
		this.rowCntPerPage = rowCntPerPage;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	public String getSearchScope() {
		return searchScope;
	}

	public void setSearchScope(String searchScope) {
		this.searchScope = searchScope;
	}

	public String addPagingParamsToURI() {
		UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromPath("").queryParam("currentPageNo", this.currentPageNo)
				.queryParam("rowCntPerPage", this.rowCntPerPage).queryParam("searchScope", this.searchScope)
				.queryParam("searchKeyword", this.searchKeyword);
		return uriBuilder.toUriString();
	}
}