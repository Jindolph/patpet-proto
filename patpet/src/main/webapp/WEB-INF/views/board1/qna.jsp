<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<title>QnA 게시판</title>
 <div class="container-custom">
 <%@include file="../include/header.jsp"%>
<!-- 몸체 div입니당 -->
<div class="row" style="height: 75%">

<%@include file="../include/qnasidebar.jsp"%>

   <div class="cols col-md-10" style="background-color: lightgray;">
    <div class="panel panel-default content-section-panel">
     <div class="panel-heading">&nbsp;&nbsp;&nbsp;</div>
     <div class="panel-body">
      <!-- 상세보기창 -->
      <div class="divBoard"></div>
     
      <!-- 테이블 표시 -->
      <table class="table board-boards">
       <thead>
        <tr style="text-align: center;">
         <td width="7%"><b>NO.</b></td>
         <td width="35%"><b>제&nbsp; &nbsp; &nbsp; &nbsp; 목</b></td>
         <td width="25%"><b>작성자 ID</b></td>
         <td width="12%"><b>등록일</b></td>
         <td width="12%"><b>비밀글</b></td>
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
      <div class='div write-board'>
       <button class="btn btn-default" data-toggle="modal" data-target="#newBoardModal">글쓰기</button>
      </div>
     </div>
     <div class="panel-footer"></div>
    </div>
   </div>

   <div class="cols col-xs-1" style="background-color: lightyellow;">
    <div class="panel panel-default content-section-panel-side">
     <div class="panel-heading">광고배너</div>
     <div class="panel-body"></div>
     <div class="panel-footer"></div>
    </div>
   </div>
  </div>

<%@include file="../include/footer.jsp"%>



<script type="text/javascript">
$("#noticeBrd").on('click',function(){
	  type="NTC";
	  page=1;
	  $(".btn-default").hide();
	  showArticleList(type, page);
});
	 
function showArticleList(type, page) {
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
	  + "  <td>" 
	  + "    <a href='#' class='a article-view'>"
	  +    data.list[i].title 
	  + "    </a>"
	  + "    <input type='hidden' value='"+data.list[i].atc_no+"'>" 
	  + "  </td>"
	  + "  <td>"+data.list[i].writer+"</td>" 
	  + "  <td>"+brdService.showLastModTime(data.list[i].regDate)+"</td>" 
	  + "  <td>"+brdService.showLastModTime(data.list[i].modDate)+"</td>" 
	  + "  <td>"+data.list[i].hits+"</td>" 
	  + "  <td>" + data.list[i].hearts + "</td>"
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
	  showArticleList(type, page);
	 });
	 
	 // 상세보기 버튼 처리
	 $(".article-view").on('click', function(e) {
	  e.preventDefault();
	  var atcNO = $(this).next().val();
	  getArticle(atcNO);
	 });
	});
	}	 
	 
	 
	 
	 



$(document).ready(function() {
	var type = "QNABRD"
	var page = 1;
	showBoards(type,page);

	
	//글쓰기 모달 처리
	$("#newBoardModal").on('show.bs.modal', function(event) {
		//글쓰기 버튼 클릭 시 
		$(".new-board").find("div[class='modal-footer']").children().first().on("click",
			function(e) {
				var title = $(this).parent().prev().find("input[name='title']").val();
				var txt_content = $(this).parent().prev().find("textarea").val();
				var writer = 'woo@naver.com';
				var atc_type = 'QNABRD';
				var board = {title:title, txt_content:txt_content, writer:writer, atc_type:atc_type};
				
				qnaService.writeNewBoard(board, function(){
					$(".modal").modal("hide");
					alert('글 작성 완료');
					showBoards(type, page);
				});				
			});	
		});
	//수정 모달
	$('#modBoardModal').on('show.bs.modal', function(event) {
		var button = $(event.relatedTarget);
		var atc_no = button.next().next().val();
		
		//수정 완료 버튼 처리
		$(".mod-board").find("div[class='modal-footer']").children().first().on("click",function(e){
			var title = $(this).parent().prev().find("input[name='title']").val();
			var txt_content = $(this).parent().prev().find("textarea").val();
			var board = {atc_no:atc_no, title:title, txt_content:txt_content};
			
			alert(JSON.stringify(board));
			
			qnaService.modBoard(board, function(msg){});
			location.href="/pp/board1/qna";
		});
	});
	
});
	function showBoards(type,page) {
		var path = {type:type, page:page};
		qnaService.getAllBoardsWithPaging(
			path,
			function(data) {
				if(data.length==0){
				return;
			}
			var strBoard = "";
			var strPages = "";
			
			//게시물 띄우기
			for(var i=0; i<data.list.length; i++){
				strBoard +=
					"<tr align='center'>"
				  + " <td>"+data.list[i].atc_no+"</td>"
				  + " <td>"
				  + "  <a href='#' class='board-view'>"+'비밀글입니다.'+"</a>"
				  + "  <input type='hidden' value='"+data.list[i].atc_no+"'>"
				  + " </td>"
				  
				  + " <td>${obj.writer}"+data.list[i].writer+"</td>"
				  + " <td>"+qnaService.showLastModTime(data.list[i].regDate)+"</td>"
				  + " <td><i class='fas fa-lock'></td>"
				  + "<tr>";
			}
			strBoard += "<br>";
			$(".board").html(strBoard);
			
			strPages += "<button class='btn btn-default' id='btnPrev'>이전</button> &nbsp;&nbsp;";
			
			//페이징 버튼 띄우기
			for (var i = data.page.startPageNo; i <= data.page.endPageNo; i++){
				strPages += "<button class='btn btn-default btnPage' value='"+i+"'><b>"+i+"</b></button> &nbsp;&nbsp;";
			}
			
			strPages += "<button class='btn btn-default' id='btnNext'>다음</button>";
			
			$(".pages").html(strPages);
			
			//이전 페이지 클릭 시
			$("#btnPrev").on('click',function(){
				page = parseInt(page)-1;
				if(page<data.page.startPageNo){
					page = data.page.startPageNo;
				}
				showBoards(type, page);
			});
			//다음 페이지 클릭 시
			$("#btnNext").on('click',function(){
				page = parseInt(page)+1;
				if(page>data.page.endPageNo){
					page = data.page.endPageNo;
				}
				showBoards(type, page);
			});
			//현재 페이지에 빨간색 부여
			$("pages").find("button[value='"+page+"']").css("color","red");
			
			//페이징 돌아가는 버튼
			$(".btnPage").on('click', function() {
				page = $(this).val();
				$(".board-view").remove();
				showBoards(type,page);
			});
			
			//상세보기 버튼 클릭
			$(".board-view").on('click', function(e) {
				e.preventDefault();
				var atcNO = $(this).next().val();
				getBoard(atcNO);
			});
			
			//상세보기 버튼 클릭
			$(".board-null").on('click', function(e) {
				alert("접근할 수 없습니다.");
			});
			
			//사이드 메뉴
			$("#qnaBrd").on('click',function(){
				type="QNABRD";
				page=1;
				$(".btn-default").show();
				$(".board-comments").remove();
				$(".board-view").remove();
				showBoards(type, page);
			});
			
			
		});
	}
	
	function getBoard(atc_no) {
		qnaService.getBoardView(atc_no, function(data){
			var str =
			   "<table class='table board-view'>"
			+ " <tr>"
			+ "  <td class='td static-board-view'><lable>제목</lable></td>"
			+ "  <td class='td fluid-board-view'>"
			+  data.title
			+ "  </td>"
			+ " </tr>"
			+ " <tr>"
			+ "  <td class='td static-board-view'><lable>등록일</label></td>"
			+ "  <td class='td fluid-board-view'>"
			+  qnaService.showLastModTime(data.regDate)
			+ "  </td>"
			+ " </tr>";
			if(data.modDate!=null){
				str +=" <tr>"
					+ "  <td class='td static-board-view'><lable>수정일</label></td>"
					+ "  <td class='td fluid-board-view'>"
					+  qnaService.showLastModTime(data.modDate)
					+ "  </td>"
					+ " </tr>";
			}
			str
			+=" <tr>"
			+ "    <td class='td static-board-view'><label>내용</label></td>"
			+ "    <td class='td fluid-board-view'>"
			+ "		  <textarea rows='18' cols='70px' disabled>"+data.txt_content+"</textarea>"
			+ "    </td>"
			+ "  </tr>"
			+ "  <tr>"
			+ "    <td class='td static-board-view'><label>게시글번호</label></td>"
			+ "    <td class='td fluid-board-view'>"
			+  data.atc_no
			+ "    </td>"
			+ "  </tr>"
			+ "  <tr>"
			+ "    <td class='td static-board-view'><label>작성자ID</label></td>"
			+ "    <td class='td fluid-board-view'>"
			+  data.writer
			+ "    </td>"
			+ "  </tr>"
			+ "  <tr>"
			+ "    <td colspan='2'>"
			+ "      <button class='btn btn-default modify-board' data-toggle='modal' data-target='#modBoardModal'>수정하기</button>&nbsp;&nbsp;&nbsp;&nbsp;"
			+ "      <button class='btn btn-default delete-board'>삭제하기</button>"
			+ "      <input type='hidden' value='"+data.atc_no+"'>"
			+ "    </td>" 
			+ "  </tr>"
			+ "</table>"
			+ "<br>"
			+ "<table class='table board-comments'></table>"
			+ "<br><br><br>";
			
			$(".divBoard").html(str);
			
			showCommentsList(atc_no);
			
			//게시글 삭제
			$(".delete-board").on("click", function(e) {
				qnaService.deleteBoard(atc_no, function(){});
				location.href="/pp/board1/qna"
			})
		})
	}
	
	function showCommentsList(atcNO){
		var cmtPage = $("#cmtPage").val();
		var json = {atc_no:atcNO, page:cmtPage};
		alert(JSON.stringify(json));
		qnaService.getAllCommentsWithPaging(json,function(comments){
			
		if(comments==0){
			return;
		}
		var str = "";
			
			for(var i=0; i<comments.length; i++){
				str +=
					  "<tr class='tbRow1'>"
					+ " <td>"+'작성자: '+comments[i].writer+"</td>"
					+ "</tr>"
					+ "<tr class='tbRow1'>"
					+ "	<td>"+'작성일: '+qnaService.showLastModTime(comments[i].regDate)+"</td>"
					+ "</tr>";
					if(comments[i].modDate != null){
					str += "<tr class='tbRow1'>"
						 + "	<td>"+qnaService.showLastModTime(comments[i].modDate)+"</td>"
						 + "</tr>";
					}
					str +=
					  "<tr class='tbRow1'>"
					+ " <td><textarea disabled>"+comments[i].txt_content+"</textarea></td>"
					+ "</tr>";
			}
			$(".board-comments").append(str);			
		});
	}

</script>

	<input type="hidden" id="cmtPage" value=1>
	<!-- <input type="hidden" id="atcType" value="USER"> -->
	<input type="hidden" id="atcPage" value=1>
	<!-- 글쓰기 모달 -->
	<div class="modal fade new-board" id="newBoardModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
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
					<input value="woo@naver.com" class="form-control validate"disabled> 
					<label>제목</label> 
					<input class="form-control validate" name="title"> 
					<label>내용</label>
					<textarea class="form-control validate"></textarea>
					<label>글종류</label>
					<input value="Q&A게시판" class="form-control validate"disabled> 
					<br> 
					<div class="div search-my-products" style="display:none;">
						<label>내가 가진 상품목록 보기</label>
						<button class="btn btn-default">검색</button>
						<table id="tableRdProducts"></table>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-default new-board">Write</button>
					<button class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade mod-board" id="modBoardModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
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
		</div>
	</div>
	<div class="modal fade bs-example-modal-sm" id="modCommentModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-sm" role="document">
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
		</div>
	</div>



