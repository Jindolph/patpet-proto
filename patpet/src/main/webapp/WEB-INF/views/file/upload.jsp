<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>진석이가 만든 파일 추가폼입니다.</title>
<script type="text/javascript" src="${contextPath}/resources/js/closure/my-file2.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
/* 멀티파일 등록 및 썸네일 표시 관련 함수들 */
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

	//이미지 생성, 만약 기본이미지를 다르게 설정하고 싶다면 #부분에 소스 경로 지정.
	img.setAttribute("src", "#");

	//삭제버튼 생성.
	btn.setAttribute("type", "button");
	btn.setAttribute("value", "삭제");
	btn.setAttribute("onclick", "fn_delFileDiv(this)");

	//파일태그 생성.
	i.setAttribute("type", "file");
	//컨트롤러로 보낼 파일 이름은 이곳에서 바꾸면 됨.
	//file1, file2, file3 이런식으로 이름이 전송됨.
	i.setAttribute("name", "file" + cnt++);
	i.setAttribute("onchange", "readURL(this);");

	div.appendChild(img);
	div.appendChild(i);
	div.appendChild(btn);
	div.appendChild(br);

	//filesDiv에 새로 만든 div를 붙여넣기함.
	document.getElementById("filesDiv").appendChild(div);
}
/* 멀티파일 등록 및 썸네일 표시 관련 함수들 종료 */
  
 
/* FILEUTILS 이용해서 업로드 2차 업로드 */
$(document).ready(function() {
	$("#btnUtilUploadFiles").on("click", function(e) {
		var form = $('#filesForm')[0];
		var formData = new FormData(form);

		//이부분 재설정하면됨.
		var content = "ATC";
		var id = 80;

		fileService.uploadNewFileUsingUtils(
			formData, 
			{content:content,id:id}, 
			function() {
				alert('upload success!');
				location.href = "/pp/file/all"
			})//uploadNewFileUsingUtils 콜백함수 종료.
	});
});
/* FILEUTILS 이용해서 업로드 2차 업로드 종료 */
</script>
</head>
<body>
	<form id="filesForm">
		<input type="button" value="사진등록" onClick="fn_addFileDiv()" />
		
		<div id="filesDiv"><!-- 요기 다이브에 파일 추가 행을 동적으로 생성함 --></div>
		<input type="button" value="업로드" id="btnUtilUploadFiles"/>
	</form>
</body>
</html>