<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
	request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
<meta charset="UTF-8">
<title>구독 정보 출력창</title>
<script type="text/javascript" src="${contextPath}/resources/js/closure/my-file2.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
$(document).ready(function () {
	/* 이부분 수정해야함 ㅎㅎㅎㅎ 원하는 변수값으로 주면 됨.*/
	var content='mem';
	var id=3;
	/* 이부분 수정해야함 ㅎㅎㅎㅎ */
	
	showAllFiles(content,id);
	
	function showAllFiles(content,id){
		fileService.getAllFiles(
			{content: content, id: id},
			function(files){
				if(files == null || files.length == 0){
					return;
				}
				var strLi = "";
				for (var i = 0, listLen = files.length; i < listLen; i++) {
					strLi += "<li class='left clearfix'>"
						    + "    <div>"
							  + "        <div class='header'>"
							  + "            <img src='/pp/file/thumbnail/"+content+"/"+id+"/"+files[i].new_name+".json'>"
						 	 	+ "            <small class='text-muted' style='padding-left:10px;'>파일코드: </small>"
						 	 	+ "            <small class='text-muted'>"
						 	 	+                  files[i].file_code
						 	 	+ "            </small>"
						 	 	+ "            <small class='text-muted' style='padding-left:10px;'>컨텐츠ID: </small>"
						 	 	+ "            <small class='text-muted'>"
						 	 	+                  files[i].content_id
						  	+ "            </small>"
						  	+ "            <small class='text-muted' style='padding-left:10px;'>원본파일명: </small>"
						  	+ "            <small class='text-muted'>"
						  	+                  files[i].orgn_name
						  	+ "            </small>"
						  	+ "            <small class='text-muted' style='padding-left:10px;'>저장파일명: </small>"
						  	+ "            <small class='text-muted'>"
						  	+                  files[i].new_name
						  	+ "            </small>"
						  	+ "            <small class='text-muted' style='padding-left:10px;'>사이즈: </small>"
						  	+ "            <small class='text-muted'>"
						  	+                  files[i].fileSize + "(bytes)"
						  	+ "            </small>"
						  	+ "            <small class='text-muted' style='padding-left:10px;'>저장경로: </small>"
						  	+ "            <small class='text-muted'>"
						  	+                  files[i].data_path
						  	+ "            </small>"
						  	+ "        </div>"
						  	+ "    </div>"
						  	+ "</li><hr>";
				}
				$(".showFilesUL").html(strLi);
			})
	}
});
</script>
</head>
<body>
	<ul class="showFilesUL" style="list-style: none; padding-left: 0px;"></ul>
</body>
</html>