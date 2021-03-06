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
	         + "            <small class='text-muted' style='padding-left:10px;'>????????????: </small>"
	         + "            <small class='text-muted'>"
	         +                  products[i].pdt_code
	         + "            </small>"
	         + "            <small class='text-muted' style='padding-left:10px;'>??????: </small>"
	         + "            <small class='text-muted'>"
	         +                  products[i].pdt_type
	        + "            </small>"
	        + "            <small class='text-muted' style='padding-left:10px;'>??????: </small>"
	        + "            <small class='text-muted'>"
	        +                  products[i].pdt_name
	        + "            </small>"
	        + "            <small class='text-muted' style='padding-left:10px;'>????????????: </small>"
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
/* ?????? ?????? ?????? ???, ????????? ?????? ??????. */

/* ???????????? ???????????? ajax ????????? ?????? */
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
   + "<td width='10%'><b>?????????</b></td>"
   + "<td width='35%'><b>??????</b></td>"
   + "<td width='25%'><b>?????????ID</b></td>"
   + "<td width='15%'><b>?????????</b></td>"
   + "<td width='15%'><b>?????????</b></td>"
   + "<td width='10%'><b>?????????</b></td>"
   + "<td width='5%'><b>?????????</b></td>"
   + "</tr>"
   + "</thead>"
   + "<tbody class='board'>" 
   + "<tr id='rowAlt' height='10' style='display:none;'>"
   + "<td colspan='6'>"
   + "<b><span style='font-size: 9pt;'>????????? ?????? ????????????.</span></b>"
   + "</td>"
   + "</tr>";
   
   /* ????????? ?????? ????????? */
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
   strArticle += "<tr><td><button class='btn btn-default' data-toggle='modal' data-target='.article-write-modal'>?????????</button></td></tr>";
   
   var strPages="";
   /* ????????? ?????? ????????? */
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
	 /* ????????? ?????? */
	 brdService.hitsUpArticle(code,function(){});
	 /* ???????????? */
	 brdService.getArticleView(
	  code,
	  function(data){
		  $(".article-detail").remove();
	   var str="<div class='article-detail'>"
	       +"  <div>"
	       +"    <label>??????</label>"
	       +    data.title
	       +"  </div>"
	       +"  <div>"
	       +"    <label>?????????</label>"
	       +    brdService.showLastModTime(data.regDate) 
	       +"  </div>"
	       +"  <div>"
	       +"    <label>?????????</label>"
	       +    brdService.showLastModTime(data.modDate) 
	       +"  </div>"
	       +"  <div>"
	       +"    <label>??????</label>"
	       +"    <textarea disabled>"+data.txt_content+"</textarea>" 
	       +"  </div>"
	       +"  <div>"
	       +"    <label>???????????????</label>"
	       +    data.atc_no
	       +"    <input type='hidden' id='atcNO' value='"+data.atc_no+"'>"
	       +"  </div>"
	       +"  <div>"
	       +"    <label>?????????</label>"
	       +    data.writer
	       +"  </div>" 
	       +"  <div class='form-group'>"
	       +"    <label>?????????</label>"
	       +    data.hits 
	       +"  </div>"
	       +"  <div>"
	       +"    <button id='btnHearts' class='btn btn-default'>?????????</button>" 
	       +"    <button id='btnReport' class='btn btn-default'>????????????</button>"
	       +"    <button id='btnModifyTrdArticle' class='btn btn-default'>????????????</button>" 
	       +"    <button id='btnDeleteTrdArticle' class='btn btn-default'>????????????</button>" 
	       +"  </div>"
	       +"</div>";
	    $("#emptyDiv").prepend(str);
	    
	    var cmtPage = $("#cmtPage").val();
	    $("#cmtPage").attr("value",cmtPage++);
	    
	    /* ????????? ?????? */
	    $("#btnModifyTrdArticle").on("click", function(e){
	     $("#modalModTrdArticle").modal("show");
	    });
	    $("#btnModTrdArticleModalExit").on("click", function(e){
	     $("#modalModTrdArticle").modal('hide');
	    });
	    /* ????????? ?????? ?????? */
	    /* ????????? */
	    $("#btnHearts").on("click", function(e){
	     var memId='abc@test.com';
	     var obj=
	      { atcNO:code,memId:memId };
	     brdService.heartMaker(obj,function(){});
	    });
	    /* ????????? ?????? */
	    /* ????????? */
	    $("#btnDeleteTrdArticle").on("click", function(e){
	     brdService.deleteArticle(code,function(){
	    	 fn_trdbrd();
	     });
	    });
	    /* ????????? ?????? */
	    //?????? ?????? ??????
	    showAllComments(code);
	  });
	}
	
/* ?????? ?????? ?????? */
function showAllComments(atcNO){
 var json={atc_no:atcNO,page:cmtPage};
 brdService.getAllCommentsWithPaging(
  json,
  function(comments){
	  $(".comment-static-info").remove();
	  $(".comment-list").remove();
   var str_static= 
	            "<div class='comment-static-info'>"
	          + "  <h3><b>?????????</b></h3>"
           + "  <textarea id='textareaTrdCommentContentWrite'></textarea>"
           + "  <button id='btnWriteTrdCommentSend' class='btn btn-default'>??????</button>"
           + "</div>";
    $(".article-detail").append(str_static);
    /* ???????????? ?????? ?????? ?????? ?????? */
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
    /* ???????????? ?????? ?????? ?????? ?????? ??????*/
   if (comments==0){
    return;  //?????? ??????????????? ??????
   }
   var str_changable="<table class='comment-list'>";
   /* ?????? ?????? ????????? */
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
    + "    <button type='button' class='btn btn-default' data-toggle='modal' data-target='.bs-example-modal-sm'>??????</button>"
    + "    <button class='btn btn-default'>??????</button>"
    + "    <input type='hidden' value='"+comments[i].cmt_no+"'>"
    + "  </td>"
    + "</tr>";
   }
   str_changable += "</table>";
   $(".article-detail").append(str_changable);
   /* ?????? ?????? ????????? ?????? */
   /* ???????????? ?????? ?????? */
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
   /* ???????????? ?????? ?????? ?????? */
   /* ???????????? ?????? ?????? */
   $(".tdTrdCommentButtons").children("button").next().on("click", function(e){
	   var cno = $(this).next().val();
	   brdService.deleteComment(
			   cno,
			   function(){
			     showAllComments(atcNO);
			   });
   });
   /* ???????????? ?????? ?????? ?????? */
 });
}
/* ?????? ?????? ?????? */
</script>

<%@include file="../include/brdsidebar.jsp"%>

<table id="cmtRegisterForm"></table>
<table id="tableComments"></table>

<div id="emptyDiv"></div>

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ??????????????? ????????? ??????  ?????? @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
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
     <label>?????????</label>
     <input type="text" value="${memId}" class="form-control validate" disabled>
    </div>
    <div class="divTrdArticleTitle">
     <label>??????</label>
     <input type="text" class="form-control validate" id="textWriteTrdArticleTitle">
    </div>
    <div class="divTrdArticleTextContent">
     <label>??????</label>
     <textarea id="textareaWriteTrdArticle" class="form-control validate"></textarea>
    </div>
    <div class="divTrdArticleType">
     <label>?????????</label>
     <input value="???????????????" class="form-control validate" disabled>
    </div>
    <div class="divTrdArticleType">
     <label>?????? ?????? ???????????? ??????</label>
     <button id='btnSearchProduct' class="btn btn-default">??????</button>
     <div id="divRdProducts"><!-- ?????? ???????????? ???????????? ?????? ?????? ?????? --></div>
    </div>
    <div class="fileDiv"></div>
   </div>
   <div class="modal-footer">
    <button id='btnWriteTrdArticleSend' type="button" class="btn btn-danger">??????</button>
    <button id='btnWriteTrdArticleModalExit' type="button" class="btn btn-default">?????????</button>
   </div>
  </div>
 </div>
</div>
<script type="text/javascript">
/* ????????? ?????? */
$("#writeNewArticle").on("click", function(e){
 $("#modalWriteTrdArticle").modal("show");
});
$("#btnWriteTrdArticleModalExit").on("click", function(e){
 $("#modalWriteTrdArticle").modal('hide');
});
/* ????????? ?????? ?????? */
/* ?????? ??? ????????? ?????? ?????? */
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
/* ?????? ??? ????????? ?????? ?????? */
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
     <label>??????</label>
     <input type="text" class="form-control validate" id="textModTrdArticleTitle">
    </div>
    <div class="divTrdArticleTextContent">
     <label>??????</label>
     <textarea id="textareaModTrdArticle" class="form-control validate"></textarea>
    </div>
    <div class="fileDiv"></div>
   </div>
   <div class="modal-footer">
    <button id='btnModifyTrdArticleSend' type="button" class="btn btn-danger">??????</button>
    <button id='btnModTrdArticleModalExit' type="button" class="btn btn-default">?????????</button>
   </div>
  </div>
 </div>
</div>

<script>
/* ?????? ??? ????????? ?????? ?????? */
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
/* ?????? ??? ????????? ?????? ?????? ?????? */
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
     <label>??????</label>
     <textarea id="textareaModTrdComment" class="form-control validate"></textarea>
     <input type="hidden" id="modCmtNo">
    </form>
    </div>
   </div>
   <div class="modal-footer">
    <button class="btn btn-danger comment-register">??????</button>
    <button class='btn modal-exit' class="btn btn-default">?????????</button>
   </div>
  </div>
 </div>
</div>

<%@include file="../include/footer.jsp"%>