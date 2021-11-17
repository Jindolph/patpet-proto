<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
	request.setCharacterEncoding("UTF-8");
%>

<html>
<head>
<meta charset="UTF-8">
<title>상품등록</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.13.0/js/all.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/pp/resources/js/closure/my-pdt3.js"></script>
<script type="text/javascript" src="/pp/resources/js/closure/my-file2.js"></script>

</head>
<body>
	<button type="button" class="btn btn-primary btn-lg" id="btnOpenPdtModal">상품등록</button>
	<!-- 모달 영역 -->
	<div id="modalNewPdtBox" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
			<!-- 모달헤더에용 -->
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">x</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">상품등록창</h4>
				</div>
			<!-- 모달바디에용 -->
				<div class="modal-body">
					<label>PRODUCT TYPE</label>
					<select id="pdtType" name="pdt_type" class="form-control validate">
						<option value="SUBS_PDT" selected="selected" class="form-control validate">구독상품</option>
						<option value="RD_PDT" class="form-control validate">랜덤박스</option>
					</select><br> 
					<label>PRODUCT NAME</label>
					<input type="text" name="pdt_name" id="modalPdtName" class="form-control validate"><br> 
					<label>PRODUCT IMAGE</label>
					<input type="file" name="pdt_img" id="modalPdtImg" class="form-control validate">
					<img alt="사진을 등록해주세요." src="#" id="preview">
				</div>
			<!-- 모달푸터에용 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="btnNewProduct">상품등록</button>
					<button type="button" class="btn btn-default" id="btnClosePdtModal">취소</button>
				</div>
			</div>
		</div>
	</div>

<script>
/* 모달 컨트롤 */
$('#btnOpenPdtModal').on('click', function() {
	$('#modalNewPdtBox').modal('show');
});
$('#btnClosePdtModal').on('click', function() {
	$('#modalNewPdtBox').modal('hide');
});
/* 모달 컨트롤 종료*/

/* 모달 프리뷰 */
function readURL(input) {
	if (input.files && input.files[0]) {
  	var reader = new FileReader();
    reader.onload = function(e) {
    	$('#preview').attr('src', e.target.result);
      $('#preview').width('100px');
      $('#preview').height('100px');
		}
    	reader.readAsDataURL(input.files[0]);
	}
}
$("#modalPdtImg").change(function() {
	readURL(this);
});
/* 모달 프리뷰 종료*/

/* 상품등록 및 파일처리 */
$('#btnNewProduct').on('click', function() {
	/* 상품등록 */
	var content = 'PDT';
	var id;
	var modalInputPdtType = $("#pdtType option:selected");
	var modalInputPdtName = $(".modal").find("input[name='pdt_name']");
	var product =
		{ pdt_type:modalInputPdtType.val(),
	  	pdt_name:modalInputPdtName.val() };
	productService.addNewProduct(
		product,
		function(newPdtCode){
			/* 파일처리 */
			var newForm = $('<form></form>');
			var file = $('#modalPdtImg');
			newForm.append(file);
			var formData = new FormData(newForm[0]);
			fileService.uploadNewFileUsingUtils(
				formData, 
				{content:content,id:newPdtCode}, 
				function() {
					location.href = '/pp/pdt/all';
				})
			/* 파일처리 종료 */
		})
	/* 상품등록 종료 */
});
</script>

</body>
</html>