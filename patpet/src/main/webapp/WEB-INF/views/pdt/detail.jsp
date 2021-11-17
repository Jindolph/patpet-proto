<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<html>
<head>
<meta charset="UTF-8">
<title>상품 상세보기 창</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.13.0/js/all.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/pp/resources/js/closure/my-pdt7.js"></script>
<script type="text/javascript" src="/pp/resources/js/closure/my-file2.js"></script>

<!-- 파일 추가,삭제 및 파일 추가 시 미리보기 관련 함수 -->
<script type="text/javascript">
var cnt = 1;
function readURL(input) {
	var parent = input.parentNode;
	img = parent.childNodes[0];
	if (input.files && input.files[0]) {
		if (input.files[0].size > 3000000) {
			alert("File is too big!");
			input.value = null;
		} else {
			var reader = new FileReader();
			reader.onload = function(e) {
				img.width = "100";
				img.height = "100";
				img.src = e.target.result;
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
}
function fn_delFileDiv(btn) {
	btn.parentNode.remove();
}
function fn_addFileDiv() {
	var i = document.createElement("input");
	var img = document.createElement("img");
	var btn = document.createElement("input");
	var br = document.createElement("br");
	var div = document.createElement("div");

	img.setAttribute("src", "#");

	btn.setAttribute("type", "button");
	btn.setAttribute("value", "삭제");
	btn.setAttribute("onclick", "fn_delFileDiv(this)");

	i.setAttribute("type", "file");
	i.setAttribute("name", "file" + cnt++);
	i.setAttribute("onchange", "readURL(this);");

	div.appendChild(img);
	div.appendChild(i);
	div.appendChild(btn);
	div.appendChild(br);

	document.getElementById("filesDiv").appendChild(div);
}
</script>
<!-- 파일 추가 및 파일 추가 시 미리보기 관련 함수 종료-->


<!-- 파일 목록 보여주기 -->
<script type="text/javascript">
function showAllFiles(content, id) {
	fileService.getAllFiles(
		{content : content,id : id},
		function(files) {
			var strLi = "";
			
			if (files == null || files.length == 0) {
				return; 
			}
			
			for (var i = 0, listLen = files.length; i < listLen; i++) {
				fileName = files[i].new_name;
				strLi += "<li class='left clearfix'>"
							+ "    <div>"
							+ "        <div class='header' id='fileDiv"+i+"'>"
							+ " <input type='hidden' value='"+files[i].new_name+"'>"
							+ "            <small class='text-muted' style='padding-left:10px;'>파일코드: </small>"
							+ "            <small class='text-muted'>"
							+               files[i].file_code
							+ "            </small>"
							+ "            <small class='text-muted' style='padding-left:10px;'>컨텐츠ID: </small>"
							+ "            <small class='text-muted'>"
							+ 							files[i].content_id
							+ "            </small>"
							+ "            <small class='text-muted' style='padding-left:10px;'>원본파일명: </small>"
							+ "            <small class='text-muted'>"
							+ 							files[i].orgn_name
							+ "            </small>"
							+ "            <small class='text-muted' style='padding-left:10px;'>저장파일명: </small>"
							+ "            <small class='text-muted'>"
							+ 							files[i].new_name
							+ "            </small>"
							+ "            <small class='text-muted' style='padding-left:10px;'>사이즈: </small>"
							+ "            <small class='text-muted'>"
							+ 							files[i].fileSize + "(bytes)"
							+ "            </small>"
							+ "            <small class='text-muted' style='padding-left:10px;'>저장경로: </small>"
							+ "            <small class='text-muted'>"
							+ 							files[i].data_path
							+ "            </small>"
							+ "            <img src='/pp/file/download/"+content+"/"+id+"/"+files[i].new_name+".json' width='50px' height='50px'>"
							+ "            <br>"
							+ "            <small class='text-muted'>"
							+ "							<button id='fileDel' onclick='fn_del(\""+files[i].new_name+"\");' type='button'>삭제</button>"
							+ "            </small>"
							+ "        </div>" 
							+ "    </div>"
							+ "    <hr>"
							+ "</li>";
			}
			$(".showFilesUL").html(strLi);
		});
	}
//상품 목록 보여주기 종료 
function showProductInfo(code){
	productService.getProductDetailInfo(
		code,
		function(data){
			if(data==''){
				$("#divShowProductDetail").html('');
				return;
			}
			var str =
			 +"<div class='right'>"
			 +"  <div class='form-group'>"
			 +"    <img src='/pp/file/download/PDT/"+data.pdt_code+"' width='100px' height='100px'>"
			 +"  </div>"
			 +"</div>"
			 +"<div class='right'>"
			 +"  <div class='form-group'>"
			 +"    <label>상품코드</label>"
			 +"    <input class='form-control' value='"+data.pdt_code+"' readonly='readonly'>"
			 +"    <input type='hidden' id='pdtCode' value='"+data.pdt_code+"'>"
			 +"  </div>"
			 +"  <div class='form-group'>"
			 +"    <label>종류</label>"
			 +"    <input class='form-control' value='"+data.pdt_type+"' readonly='readonly'>"
			 +"  </div>"
			 +"  <div class='form-group'>"
			 +"    <label>상품이름</label>"
			 +"    <input class='form-control' value='"+data.pdt_name+"' readonly='readonly'>"
			 +"  </div>" 
			 +"  <div class='form-group'>"
			 +"    <label>등록일</label>"
			 +"    <input class='form-control' value='"+productService.showLastModTime(data.regDate)+"' readonly='readonly'>" 
			 +"  </div>"
			 +"</div>";
			$("#divShowProductDetail").html(str);
		});
	
	var content = 'PDT';
	
	showAllFiles(content, code);
}
</script>
</head>
<body>

<script type="text/javascript">

$(document).ready(function(){
	var code = 46;
	showProductInfo(code);
});

</script>

<input type="hidden" name="productCode">

<div class="divThumbnail"><img></div>
<div id="divShowProductDetail" style="list-style: none; padding-left: 0px;">상품 상세 다이브</div>
<div class="divFiles"></div>

<button id="btnModProductInfo" class='btn btn-primary'>수정</button>
<button id="btnDeleteProduct" class='btn btn-primary'>삭제</button>

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 상품수정 모달  시작 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
<div class="modal fade" id="modalModProduct" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
				<h4 class="modal-title w-100 font-weight-bold">Modify</h4>
			</div>
			<div class="modal-body">
				<div class="typeDiv">
					<label>구독상품</label>
					<input type="radio" name="pdt_type" value="SUBS_PDT" checked/>
					<label>랜덤박스</label>
					<input type="radio" name="pdt_type" value="RD_PDT" />
				</div>
				<div class="nameDiv">
					<label>상품이름</label>
					<input type="text"  class="form-control validate" name="pdt_name">
				</div>
				<div class="fileDiv"></div>
			</div>
			<div class="modal-footer">
				<button id='btnModifyNow' type="button" class="btn btn-danger">수정</button>
				<button id='btnModModalExit' type="button" class="btn btn-default">나가기</button>
			</div>
		</div>
	</div>
</div>

<script>
/* 수정창 모달 */
$("#btnModProductInfo").on("click", function(e){
	$("#modalModProduct").modal("show");
});
$("#btnModModalExit").on("click", function(e){
	$("#btnModModalExit").modal('hide');
});
/* 수정창 모달 종료 */
/* 모달 값 받아서 수정 처리 */
$("#btnModifyNow").on("click", function(e){
	var modalInputType = $("input:radio[name='pdt_type']:checked").val();
	var modalInputName = $("input:text[name='pdt_name']").val();
	var pdtCode = $("#pdtCode").val();
	var product = 
		{ pdt_code:pdtCode,
			pdt_type:modalInputType,
			pdt_name:modalInputName };
	alert(JSON.stringify(product));
	productService.modProductInfo(
		product,
		function(msg){
			if (msg == 'success') {
				$("#modalModProduct").modal("hide");
				showProductInfo(pdtCode);
			}
	});
});
/* 모달 값 받아서 수정 처리 종료 */
</script>
<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 상품수정 모달  종료 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 상품 삭제 모달  시작 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
<div class="modal fade" id="modalDeleteProduct" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-body">
				<h3>상품을 삭제하시겠습니까?</h3>
			</div>
			<div class="modal-footer">
				<button id='btnDelProduct' type="button" class="btn btn-danger">상품삭제</button>
				<button id='btnPdtModalExit' type="button" class="btn btn-default">나가기</button>
			</div>
		</div>
	</div>
</div>

<script>
/* 상품 삭제 모달 */
$("#btnDeleteProduct").on("click", function(e) {
	$("#modalDeleteProduct").modal("show");
});
$("#btnPdtModalExit").on("click", function(e) {
	$("#modalDeleteProduct").modal('hide');
});
/* 상품 삭제 모달 */
/* 상품 삭제 컨트롤러 요청  */
$("#btnDelProduct").on("click", function(e) {
	var pdtCode = $("#pdtCode").val();
	var content="PDT";
	var data = 
		{ content:content, id:pdtCode };
	
	productService.deleteProduct(pdtCode, function(msg){
		if (msg == 'success') {
			fileService.deleteFilesFromDir(data,function(msg){
				if (msg == 'success') {
					location.href="/pp/pdt/all"
				}
			});
		}
	});
});
/* 상품 삭제 컨트롤러 요청 종료 */
</script>
<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 상품 삭제 모달  종료 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

<!-- 파일 목록 보여주기 폼 -->
<form id="filesForm" enctype="multipart/form-data">
	<ul class="showFilesUL" style="list-style: none; padding-left: 0px;"></ul>
	<div id="filesDiv"></div>
	
	<input type="button" value="IMAGE" onClick="fn_addFileDiv()" />
	<input type="button" value="modUpload" id="btnModUploadFiles"/>
	<input type="hidden" id="iDelFiles" name="fileNames" value="1"/>
</form>
<!-- 파일 목록 보여주기 폼 종료 -->

<!-- 모드 업로드 함수 -->
<script type="text/javascript">
$(document).ready(function(){
	$("#btnModUploadFiles").on("click", function(e){
		var form = $('#filesForm')[0];
		var formData = new FormData(form);
		
		content="PDT";
		id=$("#pdtCode").val();
		
		fileService.modAndUpload(
			formData, 
			{content:content,id:id}, 
			function() {
				alert('upload success!');
				location.href = "/pp/pdt/detail"
			})//uploadNewFileUsingUtils 콜백함수 종료.
	});
});
</script>
<!-- 모드 업로드 함수 종료 -->

<!-- 파일 삭제 시, 삭제목록 저장 관련 함수 -->
<script type="text/javascript">
$(document).ready(function(){
	var fileNameArry = new Array();
	
	$(document).on("click","#fileDel", function(){
		var li = $(this).closest("li");
		name = li.find("input").val();
		fileNameArry.push(name);
		$("#iDelFiles").attr("value", fileNameArry);
		$(this).closest("li").remove();
	})
});
</script>
<!-- 파일 삭제 시, 삭제목록 저장 관련 함수 -->

</body>
</html>