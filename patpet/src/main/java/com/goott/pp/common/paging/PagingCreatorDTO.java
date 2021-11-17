package com.goott.pp.common.paging;

import org.springframework.web.util.UriComponentsBuilder;


public class PagingCreatorDTO {
	
	private PagingDTO pagingDTO;

	private int pageNoCnt = 10;	// 화면 하단에 출력할 페이지 번호 개수
 
	private int groupNoOfPage;
	private int endPageNoOfGroup;
	private int startPageNoOfGroup;
	
	private int totalRecordCnt;   				  //전체 레코드 개수 (get)
	private boolean isPrev = false ; 			  //prev 버튼 표시 유무(true: 표시됨, false:표시않됨)
	private boolean isNext = false ; 			  //next 버튼버튼 표시 유무(true: 표시됨, false:표시않됨)
    
	private int endRecordNoOfPage;	// 선택 페이지에 표시되는 끝 레코드 번호
	private int startRecordNoOfPage;// 선택 페이지에 표시되는 첫 레코드 번호
    
	//생성자를 통해 필요할 변수값을 초기화합니다.
	public PagingCreatorDTO(PagingDTO pagingDTO, int totalRecordCnt) {
		System.out.println("========PaingCreator 생성자 생성 시작=============");
		this.pagingDTO = pagingDTO;

		System.out.println("전달된 currentPageNo: "+pagingDTO.getCurrentPageNo());
		System.out.println("전달된 끝 레코드번호: "+pagingDTO.getEndRecordNoOfPage());
		System.out.println("전달된 시작 레코드번호: "+pagingDTO.getStartRecordNoOfPage());
		
		this.endRecordNoOfPage = pagingDTO.getCurrentPageNo() * pagingDTO.getRecordsPerPage();
		this.startRecordNoOfPage =  (pagingDTO.getCurrentPageNo() 
										* pagingDTO.getRecordsPerPage())
											- (pagingDTO.getRecordsPerPage()-1);
		System.out.println("새로 계산된 끝 레코드번호: "+this.endRecordNoOfPage);
		System.out.println("새로 계산된 시작 레코드번호: "+this.startRecordNoOfPage);		
		
		pagingDTO.setEndRecordNoOfPage(this.endRecordNoOfPage);
		pagingDTO.setStartRecordNoOfPage(this.startRecordNoOfPage);
		System.out.println("수정된 끝 레코드번호: "+pagingDTO.getEndRecordNoOfPage());
		System.out.println("수정된 시작 레코드번호: "+pagingDTO.getStartRecordNoOfPage());
		
		
		this.totalRecordCnt = totalRecordCnt ;
		System.out.println("전달된 currentPageNo: "+pagingDTO.getCurrentPageNo());
		System.out.println("전달된 끝 레코드번호: "+pagingDTO.getEndRecordNoOfPage());
		System.out.println("전달된 시작 레코드번호: "+pagingDTO.getStartRecordNoOfPage());
				
		this.groupNoOfPage = (int) Math.ceil((double) pagingDTO.getCurrentPageNo() / this.pageNoCnt);
		System.out.println("pagingGroupNo : " + this.groupNoOfPage);
		
		this.endPageNoOfGroup = this.groupNoOfPage * this.pageNoCnt;
		System.out.println("endPageNoOfPagingGroup : " + endPageNoOfGroup);
		
		this.startPageNoOfGroup = this.endPageNoOfGroup 
									- ( this.pageNoCnt -1 );
		System.out.println("startPageNoOfPagingGroup : " + startPageNoOfGroup);
		
		int totalPagesCnt = (int) (Math.ceil(((double)(totalRecordCnt))/pagingDTO.getRecordsPerPage()));
		System.out.println("totalPagesCnt : " + totalPagesCnt);
		
		if (totalPagesCnt < endPageNoOfGroup) {
			this.endPageNoOfGroup = totalPagesCnt ;
		}
		System.out.println("endPageNoOfPagingGroup : " + endPageNoOfGroup);
		
		
		System.out.println("총레코드개수 :" + this.totalRecordCnt );
        System.out.println("마지막페이지의 마지막레코드번호 :" + pagingDTO.getEndRecordNoOfPage());
		if (totalRecordCnt < pagingDTO.getEndRecordNoOfPage()) {
			pagingDTO.setEndRecordNoOfPage(totalRecordCnt);
		}

		System.out.println("총레코드개수2 :" + this.totalRecordCnt );
        System.out.println("마지막페이지의 마지막레코드번호2 :" + pagingDTO.getEndRecordNoOfPage());
        
		this.isPrev = this.groupNoOfPage > 1 ;
		this.isNext = this.groupNoOfPage * this.pageNoCnt 
												< totalPagesCnt ;
		
		System.out.println("isPrev : " + this.isPrev);
        System.out.println("isNext : " + this.isNext);
        
        System.out.println("=======최종 정리=======================================================");
		
        System.out.println("최종 페이징 변수=============================================");
        System.out.println("현재 페이지 번호 :      " + pagingDTO.getCurrentPageNo());
        System.out.println("페이지당 표시레코드개수 : " + pagingDTO.getRecordsPerPage());
        System.out.println("하단 표시 숫자 개수 : " + this.pageNoCnt);
		System.out.println("페이지의그룹번호 : " + this.groupNoOfPage);
        System.out.println("endPageNoOfGroup : " + endPageNoOfGroup);
        System.out.println("startPageNoOfGroup : " + startPageNoOfGroup);
        System.out.println("총페이지개수(totalPageCnt) : " + totalPagesCnt);
        System.out.println("isPrev : " + this.isPrev);
        System.out.println("isNext : " + this.isNext);
        System.out.println("총레코드개수 :" + this.totalRecordCnt );
        System.out.println("마지막페이지의 마지막레코드번호 :" + pagingDTO.getEndRecordNoOfPage());
        System.out.println("=======================================================");
	}

    //Making URI(방법1)
    public String addPagingParamsToURI(int pageNo) {
    	UriComponentsBuilder uriBuilder = 
    				UriComponentsBuilder.fromPath("")
				    .queryParam("currentPageNo", pageNo)
				    .queryParam("recordsPerPage", pagingDTO.getRecordsPerPage())
				    .queryParam("SearchType", pagingDTO.getSearchType())
				    .queryParam("Keyword", pagingDTO.getKeyword())
				    ;
    	System.out.println("uriBuilder.toString(): " + uriBuilder.toString());
		return uriBuilder.toUriString();
	}

//getters & setters
    
	public PagingDTO getPagingDTO() {
		return pagingDTO;
	}

	public void setPagingDTO(PagingDTO pagingDTO) {
		this.pagingDTO = pagingDTO;
	}

	public int getPageNoCnt() {
		return pageNoCnt;
	}

	public void setPageNoCnt(int pageNoCnt) {
		this.pageNoCnt = pageNoCnt;
	}

	public int getGroupNoOfPage() {
		return groupNoOfPage;
	}

	public void setGroupNoOfPage(int groupNoOfPage) {
		this.groupNoOfPage = groupNoOfPage;
	}

	public int getEndPageNoOfGroup() {
		return endPageNoOfGroup;
	}

	public void setEndPageNoOfGroup(int endPageNoOfGroup) {
		this.endPageNoOfGroup = endPageNoOfGroup;
	}

	public int getStartPageNoOfGroup() {
		return startPageNoOfGroup;
	}

	public void setStartPageNoOfGroup(int startPageNoOfGroup) {
		this.startPageNoOfGroup = startPageNoOfGroup;
	}

	public int getTotalRecordCnt() {
		return totalRecordCnt;
	}

	public void setTotalRecordCnt(int totalRecordCnt) {
		//setTotalRecordCnt()를 꼭 호출해야 paging이 되기 때문에
        //setTotalRecordCnt()를 호출했을 때 paging()함수를 자동으로 호출되게 한다.
		this.totalRecordCnt = totalRecordCnt;
		//this.paging();
	}

	public boolean getIsPrev() {
		return isPrev;
	}

	public void setIsPrev(boolean isPrev) {
		this.isPrev = isPrev;
	}

	public boolean getIsNext() {
		return isNext;
	}

	public void setIsNext(boolean isNext) {
		this.isNext = isNext;
	}
/*
	public int getEndRecordNoOfPage() {
		return endRecordNoOfPage;
	}

	public void setEndRecordNoOfPage(int endRecordNoOfPage) {
		this.endRecordNoOfPage = endRecordNoOfPage;
	}

	public int getStartRecordNoOfPage() {
		return startRecordNoOfPage;
	}

	public void setStartRecordNoOfPage(int startRecordNoOfPage) {
		this.startRecordNoOfPage = startRecordNoOfPage;
	}
*/
}