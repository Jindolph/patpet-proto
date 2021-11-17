<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<title>게시판</title>

<!-- 컨테이너 레이아웃 시작 -->
 <div class="container-custom">
 <%@include file="../include/header.jsp"%>

<!-- 몸체 div입니당 -->
  <div class="row" style="height: 75%">
<%@include file="../include/brdsidebar.jsp"%>


   <div class="cols col-md-10" style="background-color: lightgray;">
    <div class="panel panel-default content-section-panel">
     <div class="panel-heading">&nbsp;&nbsp;&nbsp;</div>
     <div class="panel-body">
      <!-- 상세보기창 -->
      <div class="divArticle"></div>
     
      <!-- 테이블 표시 -->
      <table class="table board-articles">
       <thead>
        <tr style="text-align: center;">
         <td width="7%"><b>NO.</b></td>
         <td width="35%"><b>제&nbsp; &nbsp; &nbsp; &nbsp; 목</b></td>
         <td width="25%"><b>작성자 ID</b></td>
         <td width="12%"><b>등록일</b></td>
         <td width="12%"><b>수정일</b></td>
         <td width="12%"><b>조회수</b></td>
         <td width="12%"><b><i class="fas fa-heart"></i></b></td>
        </tr>
       </thead>
       <tbody class="board">
        <tr id="rowAlt">
         <td colspan="6" style="text-align: center;">
          <h1>등록된 글이 없습니다.</h1>
         </td>
        </tr>
       </tbody>
      </table>

      <!-- 페이지 버튼 표시 -->
      <div class="pages" style="margin: auto; text-align: center;"></div>
      <div class='div write-article'>
       <button class="btn btn-default" data-toggle="modal" data-target="#newArticleModal">글쓰기</button>
      </div>
     </div>
     <div class="panel-footer"></div>
    </div>
   </div>

   <div class="cols col-xs-1">
    <div class="panel panel-default content-section-panel-side">
     <div class="panel-heading">광고배너</div>
     <div class="panel-body"></div>
     <div class="panel-footer"></div>
    </div>
   </div>
  </div>

  <!-- 푸터 div입니당 -->
<%@include file="../include/footer.jsp"%>

<script type="text/javascript">
$(document).ready(function(){
	var type = "USER";
	var page = 1;
	showArticleList(type, page);
	
	$('.modal').on('hidden.bs.modal', function (e) {
	  console.log('modal close');
		$(this).find('form')[0].reset();
	});
	
//글쓰기 모달 처리 함수.
	$("#newArticleModal").on('show.bs.modal', function (event) {
		// 글쓰기 버튼 클릭 시 처리
		$(".new-article").find("div[class='modal-footer']").children().first().on("click",
			function(e) {
				var title = $(this).parent().prev().find("input[name='title']").val();
				var txt_content = $(this).parent().prev().find("textarea").val();
				var writer = '${memId}';
				var atc_type = $(this).parent().prev().find("select").val();
				var product = $("#tableRdProducts").find("input").val();
				var article = {title:title,txt_content:txt_content,writer:writer,atc_type:atc_type,product:product};
				
				brdService.writeNewArticle(article, function(){
					$(".modal").modal("hide");
					alert('글 작성 완료.');
				});
				/* $(".article-view").remove();
				$(".board-comments").remove();
				showArticleList(atc_type, 1); */
		});
		//상품 종류 검색 이후 처리함수
		$(".search-my-products").children().eq(1).on("click",function(e){
			e.preventDefault();			
			
			var id='${memId}'
			giftService.showAllHavingGifts(id, function(data){
				if (data.length == 0) {
					return;
				}
				alert(JSON.stringify(data));
				var str = 
					 "<br><br>"
					+"<tr>"
					+"  <td>종류</td>"
					+"  <td>이름</td>"
					+"  <td>획득일</td>"
					+"  <td>개봉여부</td>"
					+"  <td>사진</td>"
					+"  <td>선택</td>"
					+"</tr>";
				for (var i = 0; i < data.length; i++) {
					str += 
						"<tr>"
					+ "  <td>"
					+       data[i].gift_type
					+ "     <input type='hidden' value='"+data[i].gift_code+"'>"
					+ "  </td>"
					+ "  <td>"+data[i].pdt_name+"</td>"
					+ "  <td>"+giftService.showLastModTime(data[i].regDate)+"</td>" 
					+ "  <td>"+data[i].is_opened+"</td>"
					+ "  <td>"
					+ "    <img src='/pp/file/thumbnail/PDT/"+data[i].gift_value+"' width='100px' height='100px' alt='no Img'>"
					+ "  </td>"
					+ "  <td>"
					+"     <button class='btn btn-default select-article-product'>선택</button>"
					+ "  </td>"
					+ "</tr>";
				}
				$("#tableRdProducts").html(str);
			
				//리스트에서 상품 선택 시, 처리함수.
				$(".select-article-product").on('click',function(){
					var tr = $(this).parent().parent();
					tr.find("button").remove();
					$("#tableRdProducts").html(tr);
				});
			});
		});
		
		//셀렉트 박스 이벤트 처리.
		$(this).find("select").on("change",function(){
			var selector = $(this).val();
			if(selector=='TRD'){
				$(".search-my-products").show();
			}else{
				$(".search-my-products").hide();
			}
		});
	});
	
	/* 수정 모달 뜰 때 처리 */
	$('#modArticleModal').on('show.bs.modal', function (event) {
		var button = $(event.relatedTarget);
		var atc_no = button.next().next().val();
		
		//수정 완료 버튼 처리
		$(".mod-article").find("div[class='modal-footer']").children().first().on("click",function(e){
			var title = $(this).parent().prev().find("input[name='title']").val();
			var txt_content = $(this).parent().prev().find("textarea").val();
			var article = { atc_no:atc_no,title:title,txt_content:txt_content};
			
			brdService.modArticle(article, function(msg){});
			location.href="/pp/board/layout";
		});
	});
	
	/* 댓글 수정 모달 뜰 때 처리 */
	$('#modCommentModal').on('show.bs.modal', function (event) {
		var cmt_no = $(event.relatedTarget).next().next().val();
		var atc_no = $(event.relatedTarget).next().next().next().val();
		//수정 완료 버튼 처리
		$("#modCommentModal").find("div[class='modal-footer']").children().first().on("click",function(e){
			var txt_content = $(this).parent().prev().find("textarea").val();
			var comment = {cmt_no:cmt_no,txt_content:txt_content};
			brdService.modComment(comment,function(){
				$(".modal").modal("hide");
				showAllComments(atc_no);
			});
		});
	});
	
	
	/* 게시판 종류별 처리 */
	$("#userBrd").on('click',function(){
		type="USER";
		page=1;
		$(".article-view").remove();
		$(".board-comments").remove();
		showArticleList(type, page);
	});
	$("#tradeBrd").on('click',function(){
		type="TRD";
		page=1;
		$(".article-view").remove();
		$(".board-comments").remove();
		showArticleList(type, page);
	});
	$("#noticeBrd").on('click',function(){
		type="NTC";
		page=1;
		$(".article-view").remove();
		$(".board-comments").remove();
		showArticleList(type, page);
	});
});

/* 게시판 보여주기 함수 */
function showArticleList(type, page) {
$("#atcType").value=type;
$("#atcPage").value=page;
var path = {type : type,page : page};
brdService.getAllArticlesWithPaging(path,function(data){
	if (data.list.length == 0) {
		return;
	}
	var strArticleList = "";
	var strPages = "";

	/* 게시글 목록 띄우기 */
	for (var i = 0; i < data.list.length; i++) {
		strArticleList += 
			"<tr align='center'>" 
		+ "  <td>"+data.list[i].atc_no+"</td>"
		+ "  <td>";
		if(data.list[i].title!='교환완료')
			strArticleList +="<a href='#' class='a article-view'>";
		strArticleList += data.list[i].title;
		if(data.list[i].title!='교환완료')
			strArticleList+="</a>"+"<input type='hidden' value='"+data.list[i].atc_no+"'>";
		if(typeof(data.list[i].product)!=='undefined' && data.list[i].product!= 0)
			strArticleList+= "<img src='/pp/file/thumbnail/GIFT/"+data.list[i].product+"' width='30' height='30'>";
		strArticleList +=
		  "  </td>"
		+ "  <td>"+data.list[i].writer+"</td>" 
		+ "  <td>"+brdService.showLastModTime(data.list[i].regDate)+"</td>" 
		+ "  <td>"+brdService.showLastModTime(data.list[i].modDate)+"</td>" 
		+ "  <td>"+data.list[i].hits+"</td>" 
		+ "  <td>" + data.list[i].hearts + "</td>";
		+ "</tr>";
	}
	
	strArticleList += "<br>";
	$(".board").html(strArticleList);

	strPages += "<button class='btn btn-default' id='btnPrev'>이전</button> &nbsp;&nbsp;";

	/* 페이지 버튼 띄우기 */
	for (var i = data.page.startPageNo; i <= data.page.endPageNo; i++) {
		strPages += "<button class='btn btn-default btnPage' value='"+i+"'><b>"+i+"</b></button> &nbsp;&nbsp;";
	}
	strPages += "<button class='btn btn-default' id='btnNext'>다음</button>";

	$(".pages").html(strPages);
	
	$("#btnPrev").on('click',function(){
		page = parseInt(page)-1;
		if(page<data.page.startPageNo){
			page = data.page.startPageNo;
		}
		showArticleList(type, page);
	});
	$("#btnNext").on('click',function(){
		page = parseInt(page)+1;
		if(page>data.page.endPageNo){
			page = data.page.endPageNo;
		}
		showArticleList(type, page);
	});
	
	$(".pages").find("button[value='"+page+"']").css("color","red");
	
	// 페이징 버튼 처리
	$(".btnPage").on('click', function() {
		page = $(this).val();
		$(".article-view").remove();
		$(".board-comments").remove();
		showArticleList(type, page);
	});
	
	// 상세보기 버튼 처리
	$(".article-view").on('click', function(e) {
		e.preventDefault();
		var atcNO = $(this).next().val();
		getArticle(atcNO, type);
	});
});
}
/* 게시판 보여주기 함수 종료 */
/* 게시글 상세보기 */
function getArticle(atc_no,atc_type) {
$("#ano").value = atc_no;
brdService.hitsUpArticle(atc_no, function(){});
brdService.getArticleView(atc_no,function(data) {
	alert(JSON.stringify(data));
	var str = 
		"<table class='table article-view'>" 
	+ "  <tr>"
	+ "    <td class='td static-article-view'><label>제목</label></td>"
	+ "    <td class='td fluid-article-view'>"
	+ data.title
	+ "    </td>"
	+ "  </tr>"
	+ "  <tr>"
	+ "    <td class='td static-article-view'><label>등록일</label></td>"
	+ "    <td class='td fluid-article-view'>"
	+ brdService.showLastModTime(data.regDate)
	+ "    </td>"
	+ "  </tr>"
	+ "  <tr>"
	+ "    <td class='td static-article-view'><label>수정일</label></td>"
	+ "    <td class='td fluid-article-view'>"
	+ brdService.showLastModTime(data.modDate)
	+ "    </td>"
	+ "  </tr>"
	+ "  <tr>"
	+ "    <td class='td static-article-view'><label>내용</label></td>"
	+ "    <td class='td fluid-article-view'>"
	+ "		  <textarea rows='18' cols='70px' disabled>"+data.txt_content+"</textarea>"
	+ "    </td>"
	+ "  </tr>"
	+ "  <tr>"
	+ "    <td class='td static-article-view'><label>게시글번호</label></td>"
	+ "    <td class='td fluid-article-view'>"
	+ data.atc_no
	+ "    </td>"
	+ "  </tr>"
	+ "  <tr>"
	+ "    <td class='td static-article-view'><label>작성자ID</label></td>"
	+ "    <td class='td fluid-article-view'>"
	+ data.writer
	+ "    </td>"
	+ "  </tr>"
	+ "  <tr>"
	+ "    <td class='td static-article-view'><label>조회수</label></td>"
	+ "    <td class='td fluid-article-view'>"
	+ data.hits
	+ "    </td>"
	+ "  </tr>"
	+ "  <tr><td class='td static-article-view'><label>좋아요</label></td>"
	+ "    <td class='td fluid-article-view'>"
	+ "      <button class='btn btn-default' onclick='fn_heart("+data.atc_no+")'>"
	+ "				<i class='fas fa-heart' style='color:red; font-size:15px;'></i> "
	+ data.hearts
	+ "			</button>"
	+ "    </td>"
	+ "  </tr>";
	if(typeof(data.product)!=='undefined' && data.product!= 0){
	str+=
		"  <tr>"
	 +"    <td><label>등록물품 사진</label></td>"
	 +"    <td><img src='/pp/file/thumbnail/GIFT/"+data.product+"' width='50' height='50'>"
	 +"  </tr>";
	}
	str+=
	  "  <tr>"
	+	"    <td colspan='2'>"
	+ "      <button class='btn btn-default report-article'>신고하기</button>&nbsp;&nbsp;&nbsp;&nbsp;"
	+ "      <button class='btn btn-default modify-article' data-toggle='modal' data-target='#modArticleModal'>수정하기</button>&nbsp;&nbsp;&nbsp;&nbsp;"
	+ "      <button class='btn btn-default delete-article'>삭제하기</button>"
	+ "      <input type='hidden' value='"+data.atc_no+"'>"
	+ "    </td>" 
	+ "  </tr>" 
	+ "</table>"
	+ "<input type='hidden' value='"+data.product+"'>"
	+ "<input type='hidden' value='"+data.writer+"'>"
	+ "<input type='hidden' value='"+data.atc_no+"'>"
	+	"<br>"
	+ "<table class='table board-comments'></table>"
	+ "<br><br><br>";
		
	$(".divArticle").html(str);
	
	showAllComments(atc_no,atc_type);
	
	//글 삭제
	$(".delete-article").on("click", function(e){
		brdService.deleteArticle(atc_no, function(){});
		location.href="/pp/board/layout"
	});
	
	$(".report-article").on('click', function(e){
		var obj={atcNO:atc_no,memId:"woo@naver.com"};
		brdService.reportArticle(obj, function(){}, function(err){alert(err)});
	});
});
}
function showAllComments(atcNO,atc_type){
	var cmtPage=$("#cmtPage").val();
	var json={atc_no:atcNO,page:cmtPage};
	brdService.getAllCommentsWithPaging(json,function(comments){
		var str1=
			"<h3><b>코멘트</b></h3>"
		+ "<tr>"
		+ "  <td class='td static-comment-form'>"
		+ "    <textarea id='textareaTrdCommentContentWrite' cols='65'></textarea>";
		if(atc_type=='TRD'){
			str1+= 
			  "<label>내가 가진 상품목록 보기</label><button class='btn btn-default' id='findProducts'>검색</button><br><br>"
			 +"<table id='commentRdProducts' style='text-align:center; width:100%;'></table><br><br>";
		}
		str1+=
		  "    <button class='btn btn-default' id='newComment'>댓글 등록</button>"
		+ "  </td>"
		+ "</tr>";
		$(".board-comments").html(str1);
		
		//상품 검색 버튼 처리
		$("#findProducts").on('click',function(){
			var id = '${memId}';
			giftService.showAllHavingGifts(id, function(data){
				if (data.length == 0) {
					return;
				}
				var str = 
					 "<br><br>"
					+"<tr>"
					+"  <td>종류</td>"
					+"  <td>이름</td>"
					+"  <td>획득일</td>"
					+"  <td>개봉여부</td>"
					+"  <td>사진</td>"
					+"  <td>선택</td>"
					+"</tr>";
				for (var i = 0; i < data.length; i++) {
					str += 
						"<tr>"
					+ "  <td>"
					+       data[i].gift_type
					+ "     <input type='hidden' value='"+data[i].gift_code+"'>"
					+ "  </td>"
					+ "  <td>"+data[i].pdt_name+"</td>"
					+ "  <td>"+giftService.showLastModTime(data[i].regDate)+"</td>" 
					+ "  <td>"+data[i].is_opened+"</td>"
					+ "  <td><img src='/pp/file/thumbnail/PDT/"+data[i].gift_value+"' width='100px' height='100px' alt='no Img'></td>"
					+ "  <td>"
					+"     <button class='btn btn-default select-article-product'>선택</button>"
					+ "  </td>"
					+ "</tr>";
				}
				$("#commentRdProducts").html(str);
				$(".select-article-product").on('click',function(){
					var tr = $(this).parent().parent();
					tr.find("button").remove();
					$("#commentRdProducts").html(tr);
				});
			});
		});

		/* 댓글쓰기 등록 버튼 처리 함수 종료*/
		$("#newComment").on('click',function(){
			var txt_content=$("#textareaTrdCommentContentWrite").val();
			var writer='${memId}';
			var product= $("#commentRdProducts").find("input").val();
			var comment={parent_atc:atcNO,txt_content:txt_content,writer:writer,product:product};
			brdService.writeNewComment(comment,function(){
				showAllComments(atcNO,atc_type);
			});
		});
				
		if (comments==0){
			return;  //객체 못가져오면 리턴
		}
		
		var str = "";
		/* 댓글 목록 띄우기 */
		for (var i=0; i<comments.length; i++) {
			str+=
				"<tr class='tbRow1'>"
			+ "  <td>"+comments[i].writer+"</td>"
			+ "</tr>"
			+ "<tr class='tbRow1'>"
			+ "  <td>"+brdService.showLastModTime(comments[i].regDate)+"</td>"
			+ "</tr>"
			+ "<tr class='tbRow1'>"
			+ "  <td>"+brdService.showLastModTime(comments[i].modDate)+"</td>"
			+ "</tr>"
			+ "<tr class='tbRow1'>"
			+ "  <td><textarea disabled>"+comments[i].txt_content+"</textarea></td>"
			+ "</tr>";
			if(typeof(comments[i].product)!=='undefined' && comments[i].product!= 0){
				str+=
					"  <tr class='tbRow1'>"
				 +"    <td>"
				 +"      <img src='/pp/file/thumbnail/GIFT/"+comments[i].product+"' width='50' height='50'>"
				 +"      <button class='btn btn-default exchange-product'>교환하기</button>"
				 +"      <input type='hidden' value='"+comments[i].product+"'>"
				 +"      <input type='hidden' value='"+comments[i].writer+"'>"
				 +"      <input type='hidden' value='"+comments[i].cmt_no+"'>"
				 +"    </td>"
				 +"  </tr>";
			}
				str+=
			  "<tr class='tbRow2'>"
			+ "  <td class='tdTrdCommentButtons'>"
			+ "    <button type='button' class='btn btn-default modify-comment' data-toggle='modal' data-target='#modCommentModal'>수정</button>"
			+ "    <button class='btn btn-default delete-comment'>삭제</button>"
			+ "    <input type='hidden' value='"+comments[i].cmt_no+"'>"
			+ "    <input type='hidden' value='"+atcNO+"'>"
			+ "  </td>"
			+ "</tr>";
		}
		$(".board-comments").append(str);
		/* 댓글 목록 띄우기 종료 */
		
		/* 삭제버튼 처리 함수 */
		$(".delete-comment").on("click", function(e){
			var td = $(this).closest("td");
			var cmtNO = td.find("input").val();
			brdService.deleteComment(cmtNO,function(){
				showAllComments(atcNO);
			});
		});
		/* 삭제버튼 처리 함수 종료 */
		
		$(".exchange-product").on("click",function(e){
			var atcGiftCode = $(".article-view").next().val();
			var cmtGiftCode = $(this).next().val();
			var atcWriter = $(".article-view").next().next().val();
			var cmtWriter = $(this).next().next().val();
			var atc_no = $(".article-view").next().next().next().val();
			var cmt_no = $(this).next().next().next().val();
			var obj = 
				 {atcWriter:atcWriter,cmtWriter:cmtWriter,
					atcGiftCode:atcGiftCode,cmtGiftCode:cmtGiftCode,
					atc_no:atc_no,cmt_no:cmt_no};
			
			if(atcWriter!='${memId}'){
				alert('게시글 등록자가 아닙니다.');
				return;
			}
			
			giftService.exchangeGift(obj,function(textResult){
				if(textResult=='success'){
				alert('교환 완료');
				}
			});
		});
	});
}
/* 게시글 상세보기 종료 */
function fn_heart(atc_no) {
	var memId = '${memId}';
	var obj = {atcNO : atc_no,memId : memId};
	brdService.heartMaker(obj, function(msg){});
	$(".article-view").remove();
	$(".board-comments").remove();
	getArticle(atc_no);
}
</script>
	<input type="hidden" id="cmtPage" value=1>
	<input type="hidden" id="atcType" value="USER">
	<input type="hidden" id="atcPage" value=1>
	<input type="hidden" id="ano" value=1>
	<input type="hidden" id="cno" value=1>
	<input type="hidden" id="atcGiftCode">
	<!-- 글쓰기 모달 -->
	<div class="modal fade new-article" id="newArticleModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<form>
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">새 글 쓰기 창</h4>
				</div>
				<div class="modal-body">
					<label>작성자</label> 
					<input value="${memId}" class="form-control validate"disabled> 
					<label>제목</label> 
					<input class="form-control validate" name="title"> 
					<label>내용</label>
					<textarea class="form-control validate"></textarea>
					<label>글종류</label> 
					<select class="form-control validate">
						<option value="USER">자유게시판</option>
						<option value="TRD">교환게시판</option>
						<option value="QNA">QnA</option>
					</select> <br> 
					<div class="div search-my-products" style="display:none;">
						<label>내가 가진 상품목록 보기</label>
						<button class="btn btn-default">검색</button>
						<table id="tableRdProducts"></table>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-default new-article">Write</button>
					<button class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
			</form>
		</div>
	</div>
	<div class="modal fade mod-article" id="modArticleModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<form>
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">x</span>
					</button>
					<h4 class="modal-title w-100 font-weight-bold">Modify</h4>
				</div>
				<div class="modal-body">
					<input type="hidden" name="atc_no">
					<div>
						<label>제목</label>
						<input type="text" name="title" class="form-control validate">
					</div>
					<div>
						<label>내용</label>
						<textarea class="form-control validate"></textarea>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default">수정</button>
					<button type="button" class="btn btn-default">나가기</button>
				</div>
			</div>
			</form>
		</div>
	</div>
	<div class="modal fade bs-example-modal-sm" id="modCommentModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-sm" role="document">
			<form>
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">x</span>
					</button>
					<h4 class="modal-title w-100 font-weight-bold">Modify</h4>
				</div>
				<div class="modal-body">
					<div class="divTrdCommentTextContent">
						<label>내용</label>
						<textarea id="textareaModTrdComment" class="form-control validate"></textarea>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default">등록</button>
					<button type="button" class="btn btn-default">나가기</button>
				</div>
			</div>
			</form>
		</div>
	</div>

	
