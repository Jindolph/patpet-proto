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
<title>Insert title here</title>
<script type="text/javascript" src="${contextPath}/resources/js/closure/my-file2.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	$(document).ready(
		function() {
			/* 이부분 수정해야함 ㅎㅎㅎㅎ 원하는 변수값으로 주면 됨.*/
			var content='mem';
			var id=3;
			/* 이부분 수정해야함 ㅎㅎㅎㅎ */

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
									+ "							<button id='fileDel' type='button'>삭제</button>"
									+ "            </small>"
									+ "        </div>" 
									+ "    </div>"
									+ "    <input type='hidden' value='"+files[i].new_name+"'/>"
									+ "    <hr>"
									+ "</li>";
					}
					$(".showFilesUL").html(strLi);
				})//getAllFiles 종료.
			}
			
			/* 삭제처리 함수 */
			$(document).on("click","#fileDel", function(){
				var li = $(this).closest("li");
				var fileName = li.find("input").val();
				var content = "mem";
				var id = 3;

				alert(fileName);
				
				fileService.deleteUploadedFiles(
					{content:content,id:id,fileName:fileName}, 
					function(data) {
						alert(data);
						/* location.href = "/pp/file/delete" */
					})
			})
			/* 삭제처리 함수 종료 */
		});
</script>
</head>
<body>
<ul class="showFilesUL" style="list-style: none; padding-left: 0px;"></ul>
</body>
</html>