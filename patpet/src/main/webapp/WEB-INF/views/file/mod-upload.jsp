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
<title>수정업로드</title>
<script type="text/javascript" src="/pp/resources/js/closure/my-file2.js"></script>
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
</script>
<script type="text/javascript">
	var fileNameArry = new Array();

	$(document).ready(
		function() {
			/* 여기서 content / id 변수값 원하는대로 설정하면 됨 */
			var content = 'mem';
			var id = 3;

			showAllFiles(content, id);

			function showAllFiles(content, id) {
			//비동기처리 정의된 클로져 호출
			fileService.getAllFiles(
				{content : content,id : id},
				//콜백함수 정의부 시작
				function(files) {
					var strLi = "";
					
					if (files == null || files.length == 0) {
						return; //리스트가 없으면, 함수 종료
					}
					
					for (var i = 0, listLen = files.length; i < listLen; i++) {
						fileName = files[i].new_name;
						strLi += "<li class='left clearfix'>"
									+ "    <div>"
									+ "        <div class='header' id='fileDiv"+i+"'>"
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
				})//getAllFiles 종료.
			}
			
			$(document).on("click","#fileDel", function(){
				$(this).closest("li").remove();
			})
			
			$("#btnModUploadFiles").on("click", function(e) {
				var form = $('#filesForm')[0];
				var formData = new FormData(form);

				fileService.modAndUpload(
					formData, 
					{content:content,id:id}, 
					function() {
						alert('upload success!');
						location.href = "/pp/file/mod-upload"
					})//uploadNewFileUsingUtils 콜백함수 종료.
			});
		});
	function fn_del(name){
		fileNameArry.push(name);
		$("#iDelFiles").attr("value", fileNameArry);
	}
</script>
</head>
<body>
<form id="filesForm" enctype="multipart/form-data">
	<ul class="showFilesUL" style="list-style: none; padding-left: 0px;"></ul>
	<div id="filesDiv"></div>
	
	<input type="button" value="IMAGE" onClick="fn_addFileDiv()" />
	<input type="button" value="modUpload" id="btnModUploadFiles"/>
	<input type="hidden" id="iDelFiles" name="fileNames"/>
</form>
</body>
</html>