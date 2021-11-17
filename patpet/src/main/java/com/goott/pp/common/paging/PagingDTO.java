package com.goott.pp.common.paging;

import lombok.ToString;

@ToString
public class PagingDTO  {

	private int currentPageNo; 		// 현재 페이지 번호
	private int recordsPerPage = 10; 	// 페이지당 출력할 데이터 개수
	
	private int endRecordNoOfPage;	// 선택 페이지에 표시되는 끝 레코드 번호
	private int startRecordNoOfPage;// 선택 페이지에 표시되는 첫 레코드 번호
	//시작페이지/끝 페이지 계산식
	//this.endRecordNoOfPage = this.currentPageNo * this.recordsPerPage;
	//this.startRecordNoOfPage = (this.currentPageNo * this.recordsPerPage) - (this.recordsPerPage-1);

	private String searchType = "";
	private String keyword = "";
	
	//기본생성자:속성들이 초기화됨. 
	public PagingDTO() {
			this.currentPageNo = 1 ;
			this.recordsPerPage = 10 ;
			this.endRecordNoOfPage = 1 * this.recordsPerPage;
			this.startRecordNoOfPage = (1 * this.recordsPerPage) - (this.recordsPerPage-1);
	}
	
	public PagingDTO(int currentPageNo) {
		this.currentPageNo = currentPageNo ;
		this.recordsPerPage = 10 ;
		this.endRecordNoOfPage = 
				this.currentPageNo * this.recordsPerPage;
		this.startRecordNoOfPage = 
				(this.currentPageNo * this.recordsPerPage) 
					- (this.recordsPerPage-1) ;
	}
	
	
	public void setCurrentPageNo(int currentPageNo) {
		if (currentPageNo <= 0) {
		      this.currentPageNo = 1;
		      return;
	}
		
		this.currentPageNo = currentPageNo;
	}
	
	
	public int getCurrentPageNo() {
		return currentPageNo;
	}

	public int getRecordsPerPage() {
		return recordsPerPage;
	}

	public void setRecordsPerPage(int recordsPerPage) {
		this.recordsPerPage = recordsPerPage;
	}


	
	public int getEndRecordNoOfPage() {
		return this.endRecordNoOfPage;
	}

	public void setEndRecordNoOfPage(int endRecordNoOfPage) {
		this.endRecordNoOfPage = endRecordNoOfPage;
	}
	
	public int getStartRecordNoOfPage() {
		return this.startRecordNoOfPage;
	}


	public void setStartRecordNoOfPage(int startRecordNoOfPage) {
		this.startRecordNoOfPage = startRecordNoOfPage;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

}
