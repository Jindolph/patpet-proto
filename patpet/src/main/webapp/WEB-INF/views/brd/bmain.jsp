<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
 request.setCharacterEncoding("UTF-8");
%>
<%@include file="../include/header.jsp"%>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.13.0/js/all.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/pp/resources/js/closure/my-pdt3.js"></script>
<script type="text/javascript" src="/pp/resources/js/closure/my-file2.js"></script>
<script type="text/javascript" src="/pp/resources/js/closure/my-board6.js"></script>

<script>
$(document).ready(function(){
	 $(".modal-exit").on('click',function(){
	  $(".modal").modal("hide");
	  return;
	 });
	 
	 $('.modal').on('hidden.bs.modal', function (e) {
	  $(this).find('.comment-modal-form')[0].reset();
	 });
});

function fn_userbrd(){
	 $("#emptyDiv").load("user");
}
function fn_trdbrd(){
	   var type="TRD";
	   var page=1;
	   showArticles(type,page);
}
function fn_subspdt(){
	 var pdtType = 'SUBS_PDT';
	 showAllProducts(pdtType);
}
function fn_randompdt(){
	var pdtType = 'RD_PDT';
	 showAllProducts(pdtType);
}

function showAllProducts(pdtType){
	 var content = "PDT";
	 productService.getAllProducts(
	  pdtType,
	  function(products){
	   var strLi = "";
	   if(products == null || products.length == 0)
	    return;
	   for (var i = 0, listLen = products.length; i < listLen; i++) {
	    strLi += "<li class='left clearfix'>"
	         + "    <div>"
	         + "        <div class='header'>"
	         + "            <img src='/pp/file/thumbnail/"+content+"/"+products[i].pdt_code+".json' width='100px' height='100px'>"
	         + "            <small class='text-muted' style='padding-left:10px;'>상품번호: </small>"
	         + "            <small class='text-muted'>"
	         +                  products[i].pdt_code
	         + "            </small>"
	         + "            <small class='text-muted' style='padding-left:10px;'>종류: </small>"
	         + "            <small class='text-muted'>"
	         +                  products[i].pdt_type
	        + "            </small>"
	        + "            <small class='text-muted' style='padding-left:10px;'>이름: </small>"
	        + "            <small class='text-muted'>"
	        +                  products[i].pdt_name
	        + "            </small>"
	        + "            <small class='text-muted' style='padding-left:10px;'>등록일자: </small>"
	        + "            <small class='text-muted'>"
	        +                  productService.showLastModTime(products[i].regDate)
	        + "            </small>"
	        + "        </div>"
	        + "    </div>"
	        + "</li><hr>";
	   }
	   $("#emptyDiv").html(strLi);
	  })
	}
</script>

<script type="text/javascript">
var cmtPage = 1;
/* 문서 로드 완료 후, 게시한 함수 호출. */

/* 클로져를 이용해서 ajax 게시판 요청 */
function showArticles(type,page){
 var path =
  { type:type,page:page };
 brdService.getAllArticlesWithPaging(
  path,
  function(data) {
   if (data.length==0){
    $("#rowAlt").show();
    return;
   }
   var strArticle=
     "<table style='margin: auto;'>"
   + "<thead>"
   + "<tr align='center' bgcolor='lightpink'>"
   + "<td width='10%'><b>글번호</b></td>"
   + "<td width='35%'><b>제목</b></td>"
   + "<td width='25%'><b>작성자ID</b></td>"
   + "<td width='15%'><b>등록일</b></td>"
   + "<td width='15%'><b>수정일</b></td>"
   + "<td width='10%'><b>조회수</b></td>"
   + "<td width='5%'><b>좋아요</b></td>"
   + "</tr>"
   + "</thead>"
   + "<tbody class='board'>" 
   + "<tr id='rowAlt' height='10' style='display:none;'>"
   + "<td colspan='6'>"
   + "<b><span style='font-size: 9pt;'>등록된 글이 없습니다.</span></b>"
   + "</td>"
   + "</tr>";
   
   /* 게시글 목록 띄우기 */
   for (var i=0; i<data.list.length; i++) {
    strArticle += 
      "<tr align='center'>"
    + "  <td>"+data.list[i].atc_no+"</td>"
    + "  <td>"
    + "    <a href='#' class='viewDetail'>"+data.list[i].title+"</a>"
    + "    <input type='hidden' value='"+data.list[i].atc_no+"'>"
    + "  </td>"
    + "  <td>${obj.writer}"+data.list[i].writer+"</td>"
    + "  <td>"+brdService.showLastModTime(data.list[i].regDate)+"</td>"
    + "  <td>"+brdService.showLastModTime(data.list[i].modDate)+"</td>"
    + "  <td>"+data.list[i].hits+"</td>"
    + "  <td>"+data.list[i].hearts+"</td>"
    + "</tr>";
   }
   strArticle += "<tr><td><button class='btn btn-default' data-toggle='modal' data-target='.article-write-modal'>글쓰기</button></td></tr>";
   
   var strPages="";
   /* 페이지 버튼 띄우기 */
   for (var i=data.page.startPageNo;i<=data.page.endPageNo;i++) {
    strPages += 
    	 "<button class='btnPage' value='"+i+"'>"+i+"</button>"
    + "</tbody>"
    + "</table>";
   }
   $("#emptyDiv").html(strArticle).append(strPages);
   
   $(".btnPage").on('click', function(){
    page = $(this).val();
    showArticles(type,page);
   });
   
   $(".viewDetail").on('click',function(e){
	    e.preventDefault();
	    var atcNO = $(this).closest("td").find('input').val();
	    showPdtArticleDetail(atcNO);
	   });
  });
}

function showPdtArticleDetail(code){
	 /* 조회수 처리 */
	 brdService.hitsUpArticle(code,function(){});
	 /* 상세보기 */
	 brdService.getArticleView(
	  code,
	  function(data){
		  $(".article-detail").remove();
	   var str="<div class='article-detail'>"
	       +"  <div>"
	       +"    <label>제목</label>"
	       +    data.title
	       +"  </div>"
	       +"  <div>"
	       +"    <label>등록일</label>"
	       +    brdService.showLastModTime(data.regDate) 
	       +"  </div>"
	       +"  <div>"
	       +"    <label>수정일</label>"
	       +    brdService.showLastModTime(data.modDate) 
	       +"  </div>"
	       +"  <div>"
	       +"    <label>내용</label>"
	       +"    <textarea disabled>"+data.txt_content+"</textarea>" 
	       +"  </div>"
	       +"  <div>"
	       +"    <label>게시글번호</label>"
	       +    data.atc_no
	       +"    <input type='hidden' id='atcNO' value='"+data.atc_no+"'>"
	       +"  </div>"
	       +"  <div>"
	       +"    <label>작성자</label>"
	       +    data.writer
	       +"  </div>" 
	       +"  <div class='form-group'>"
	       +"    <label>조회수</label>"
	       +    data.hits 
	       +"  </div>"
	       +"  <div>"
	       +"    <button id='btnHearts' class='btn btn-default'>좋아요</button>" 
	       +"    <button id='btnReport' class='btn btn-default'>신고하기</button>"
	       +"    <button id='btnModifyTrdArticle' class='btn btn-default'>수정하기</button>" 
	       +"    <button id='btnDeleteTrdArticle' class='btn btn-default'>삭제하기</button>" 
	       +"  </div>"
	       +"</div>";
	    $("#emptyDiv").prepend(str);
	    
	    var cmtPage = $("#cmtPage").val();
	    $("#cmtPage").attr("value",cmtPage++);
	    
	    /* 수정창 모달 */
	    $("#btnModifyTrdArticle").on("click", function(e){
	     $("#modalModTrdArticle").modal("show");
	    });
	    $("#btnModTrdArticleModalExit").on("click", function(e){
	     $("#modalModTrdArticle").modal('hide');
	    });
	    /* 수정창 모달 종료 */
	    /* 쪼아요 */
	    $("#btnHearts").on("click", function(e){
	     var memId='abc@test.com';
	     var obj=
	      { atcNO:code,memId:memId };
	     brdService.heartMaker(obj,function(){});
	    });
	    /* 쪼아요 종료 */
	    /* 글삭제 */
	    $("#btnDeleteTrdArticle").on("click", function(e){
	     brdService.deleteArticle(code,function(){
	    	 fn_trdbrd();
	     });
	    });
	    /* 글삭제 종료 */
	    //댓글 목록 호출
	    showAllComments(code);
	  });
	}
	
/* 댓글 처리 함수 */
function showAllComments(atcNO){
 var json={atc_no:atcNO,page:cmtPage};
 brdService.getAllCommentsWithPaging(
  json,
  function(comments){
	  $(".comment-static-info").remove();
	  $(".comment-list").remove();
   var str_static= 
	            "<div class='comment-static-info'>"
	          + "  <h3><b>코멘트</b></h3>"
           + "  <textarea id='textareaTrdCommentContentWrite'></textarea>"
           + "  <button id='btnWriteTrdCommentSend' class='btn btn-default'>등록</button>"
           + "</div>";
    $(".article-detail").append(str_static);
    /* 댓글쓰기 등록 버튼 처리 함수 */
    $('#btnWriteTrdCommentSend').on('click', function() {
     var txt_content=$("#textareaTrdCommentContentWrite").val();
     var writer='${memId}';
     var comment={parent_atc:atcNO,txt_content:txt_content,writer:writer};
     brdService.writeNewComment(
      comment,
      function(){
       showAllComments(atcNO);
      });
    });
    /* 댓글쓰기 등록 버튼 처리 함수 종료*/
   if (comments==0){
    return;  //객체 못가져오면 리턴
   }
   var str_changable="<table class='comment-list'>";
   /* 댓글 목록 띄우기 */
   for (var i=0; i<comments.length; i++) {
    str_changable+=
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
    + "</tr>"
    + "<tr class='tbRow2'>"
    + "  <td class='tdTrdCommentButtons'>"
    + "    <button type='button' class='btn btn-default' data-toggle='modal' data-target='.bs-example-modal-sm'>수정</button>"
    + "    <button class='btn btn-default'>삭제</button>"
    + "    <input type='hidden' value='"+comments[i].cmt_no+"'>"
    + "  </td>"
    + "</tr>";
   }
   str_changable += "</table>";
   $(".article-detail").append(str_changable);
   /* 댓글 목록 띄우기 종료 */
   /* 수정버튼 처리 함수 */
   $(".tdTrdCommentButtons").children("button").on("click", function(e){
	   c_no=$(this).next().next().val();
    $(".comment-register").on('click',function(){
        var content = $(this).closest("div").prev().find("textarea").val();
        var cmt_no = c_no;
        var comment={cmt_no:cmt_no,txt_content:content};
        brdService.modComment(
          comment,
          function(){
            $(".modal").modal("hide");
            showAllComments(atcNO);
          });
      });
   });
   /* 수정버튼 처리 함수 종료 */
   /* 삭제버튼 처리 함수 */
   $(".tdTrdCommentButtons").children("button").next().on("click", function(e){
	   var cno = $(this).next().val();
	   brdService.deleteComment(
			   cno,
			   function(){
			     showAllComments(atcNO);
			   });
   });
   /* 삭제버튼 처리 함수 종료 */
 });
}
/* 댓글 처리 함수 */
</script>

<%@include file="../include/brdsidebar.jsp"%>

<table id="cmtRegisterForm"></table>
<table id="tableComments"></table>

<div id="emptyDiv"></div>

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 교환게시판 글쓰기 모달  시작 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
<div class="modal fade article-write-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
 <div class="modal-dialog" role="document">
  <div class="modal-content">
   <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
     <span aria-hidden="true">x</span>
    </button>
    <h4 class="modal-title w-100 font-weight-bold">Write</h4>
   </div>
   <div class="modal-body">
    <div class="divTrdArticleWriter">
     <label>작성자</label>
     <input type="text" value="${memId}" class="form-control validate" disabled>
    </div>
    <div class="divTrdArticleTitle">
     <label>제목</label>
     <input type="text" class="form-control validate" id="textWriteTrdArticleTitle">
    </div>
    <div class="divTrdArticleTextContent">
     <label>내용</label>
     <textarea id="textareaWriteTrdArticle" class="form-control validate"></textarea>
    </div>
    <div class="divTrdArticleType">
     <label>글종류</label>
     <input value="교환게시판" class="form-control validate" disabled>
    </div>
    <div class="divTrdArticleType">
     <label>내가 가진 상품목록 보기</label>
     <button id='btnSearchProduct' class="btn btn-default">검색</button>
     <div id="divRdProducts"><!-- 요기 다이브에 랜덤박스 목록 표시 예정 --></div>
    </div>
    <div class="fileDiv"></div>
   </div>
   <div class="modal-footer">
    <button id='btnWriteTrdArticleSend' type="button" class="btn btn-danger">등록</button>
    <button id='btnWriteTrdArticleModalExit' type="button" class="btn btn-default">나가기</button>
   </div>
  </div>
 </div>
</div>
<script type="text/javascript">
/* 글쓰기 모달 */
$("#writeNewArticle").on("click", function(e){
 $("#modalWriteTrdArticle").modal("show");
});
$("#btnWriteTrdArticleModalExit").on("click", function(e){
 $("#modalWriteTrdArticle").modal('hide');
});
/* 글쓰기 모달 종료 */
/* 모달 값 받아서 쓰기 처리 */
$('#btnWriteTrdArticleSend').on('click', function() {
 var title = $("#textWriteTrdArticleTitle").val();
 var txt_content = $("#textareaWriteTrdArticle").val();
 var writer = '${memId}';
 var atc_type = 'TRD';
 var content = 'ATC';
 var article = 
  {title:title,txt_content:txt_content,
   writer:writer,atc_type:atc_type};
 
 brdService.writeNewArticle(
  article,
  function(){
	  $(".modal").modal("hide");
	  fn_trdbrd();
  });
});
/* 모달 값 받아서 쓰기 처리 */
</script>

<div class="modal fade" id="modalModTrdArticle" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
 <div class="modal-dialog" role="document">
  <div class="modal-content">
   <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
     <span aria-hidden="true">x</span>
    </button>
    <h4 class="modal-title w-100 font-weight-bold">Modify</h4>
   </div>
   <div class="modal-body">
    <div class="divTrdArticleTitle">
     <label>제목</label>
     <input type="text" class="form-control validate" id="textModTrdArticleTitle">
    </div>
    <div class="divTrdArticleTextContent">
     <label>내용</label>
     <textarea id="textareaModTrdArticle" class="form-control validate"></textarea>
    </div>
    <div class="fileDiv"></div>
   </div>
   <div class="modal-footer">
    <button id='btnModifyTrdArticleSend' type="button" class="btn btn-danger">수정</button>
    <button id='btnModTrdArticleModalExit' type="button" class="btn btn-default">나가기</button>
   </div>
  </div>
 </div>
</div>

<script>
/* 모달 값 받아서 수정 처리 */
$("#btnModifyTrdArticleSend").on("click", function(e){
 var modalInputTitle = $("#textModTrdArticleTitle").val();
 var modalInputTxtContent = $("#textareaModTrdArticle").val();
 var atcNO = $("#atcNO").val();
 var article = 
  { atc_no:atcNO,
   title:modalInputTitle,
   txt_content:modalInputTxtContent };
 brdService.modArticle(
  article,
  function(msg){
   if (msg == 'success') {
    $("#modalModTrdArticle").modal("hide");
    fn_trdbrd();
   }
 });
});
/* 모달 값 받아서 수정 처리 종료 */
</script>

<div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
 <div class="modal-dialog modal-sm" role="document">
  <div class="modal-content">
   <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
     <span aria-hidden="true">x</span>
    </button>
    <h4 class="modal-title w-100 font-weight-bold">Write</h4>
   </div>
   <div class="modal-body comment-modal-body">
    <div class="divTrdCommentTextContent">
    <form class="comment-modal-form">
     <label>내용</label>
     <textarea id="textareaModTrdComment" class="form-control validate"></textarea>
     <input type="hidden" id="modCmtNo">
    </form>
    </div>
   </div>
   <div class="modal-footer">
    <button class="btn btn-danger comment-register">등록</button>
    <button class='btn modal-exit' class="btn btn-default">나가기</button>
   </div>
  </div>
 </div>
</div>

<%@include file="../include/footer.jsp"%>