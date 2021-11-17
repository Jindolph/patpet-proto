<%@ page language="java" 
		 contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>진석이가 만든 파일 추가폼입니다.</title>


<script type="text/javascript">
/* 이 자바스크립트 및 파일생성 폼은 박진석 수강생이 만들었으며, 
필요한 요소만 남기고 모두 삭제해서 다른 사람이 쓰기 편리한 템플릿으로 만들었습니다. 
제이쿼리를 선호하지 않으므로, 제이쿼리 요소를 모두 제거한 순수 자바스크립트입니다.*/

// 카운터
var cnt=1;

//노드 조작을 이용해서 이미지 파일 섬네일 생성
function readURL(input) {

 var parent = input.parentNode;
 img = parent.childNodes[0];

 if(input.files && input.files[0]){
	 //사이즈 검사, 너무 큰 파일 저장되지 않도록. 3MB로 조정.
  if (input.files[0].size > 3000000){
   alert("File is too big!");
   input.value=null;
  } else {
   var reader = new FileReader();
	  
   reader.onload=function(e){
    img.width = "100";
    img.height = "100";
    img.src = e.target.result;
   }
   reader.readAsDataURL(input.files[0]);
  }
 }
}

/* 삭제 버튼 누르면 새로만든 div 행 삭제 해주는 함수 */
function fn_delFileDiv(btn){
 btn.parentNode.remove();
}

/* 파일, 이미지, 버튼, div 를 동적으로 생성하는 함수 */
function fn_addFileDiv(){
 var i = document.createElement("input");
 var img = document.createElement("img");
 var btn = document.createElement("input");
 var br = document.createElement("br");
 var div = document.createElement("div");
 
 //이미지 생성, 만약 기본이미지를 다르게 설정하고 싶다면 #부분에 소스 경로 지정.
 img.setAttribute("src","#");

 //삭제버튼 생성.
 btn.setAttribute("type","button");
 btn.setAttribute("value","삭제");
 btn.setAttribute("onclick","fn_delFileDiv(this)");

 //파일태그 생성.
 i.setAttribute("type","file");
 //컨트롤러로 보낼 파일 이름은 이곳에서 바꾸면 됨.
 //file1, file2, file3 이런식으로 이름이 전송됨.
 i.setAttribute("name","file" + cnt++);
 i.setAttribute("onchange","readURL(this);");
 
 div.appendChild(img);
 div.appendChild(i);
 div.appendChild(btn);
 div.appendChild(br);

 //filesDiv에 새로 만든 div를 붙여넣기함.
 document.getElementById("filesDiv").appendChild(div);
}
</script>
</head>
<body>

<form>
<input type="button" value="사진등록" onClick="fn_addFileDiv()" />

<!-- 요기 다이브에 파일 추가 행을 동적으로 생성함 -->
<div id="filesDiv"></div>
</form>

</body>
</html>