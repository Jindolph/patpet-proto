package com.goott.pp.common.paging;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PagingCreatorDTO2 {
	private PagingDTO2 PagingDTO2;
	private int totalRecordCnt;
	private int pageNoCnt;

	private int pageGroupNo;

	private int endPageNo;
	private int startPageNo;

	private boolean isPrev = false;
	private boolean isNext = false;

	public PagingCreatorDTO2(PagingDTO2 PagingDTO2, int totalRecordCnt, int pageNoCnt) {
		this.PagingDTO2 = PagingDTO2;
		this.totalRecordCnt = totalRecordCnt;
		this.pageNoCnt = pageNoCnt;

		this.pageGroupNo = (int) (Math.ceil(PagingDTO2.getCurrentPageNo() / (double) this.pageNoCnt));
		
		this.endPageNo = this.pageGroupNo * this.pageNoCnt;
		this.startPageNo = this.endPageNo - (this.pageNoCnt - 1);

		int realLastPageNo = (int) (Math.ceil(((double) (totalRecordCnt)) / PagingDTO2.getRowCntPerPage()));

		if (realLastPageNo < endPageNo) {
			this.endPageNo = realLastPageNo;
		}

		this.isPrev = this.startPageNo > 1;
		this.isNext = this.endPageNo < realLastPageNo;
	}
}
