<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8" isELIgnored="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
 //카운터
 var cnt = 1;

 //노드 조작을 이용해서 이미지 파일 섬네일 생성
 function readURL(input) {

  var parent = input.parentNode;
  img = parent.childNodes[0];

  if (input.files && input.files[0]) {
   //사이즈 검사, 너무 큰 파일 저장되지 않도록. 3MB로 조정.
   if (input.files[0].size > 3000000) {
    alert("File is too big!");
    input.value = null;
   } else {
    var reader = new FileReader();

    reader.onload = function(e) {
     img.width = "80";
     img.height = "80";
     img.src = e.target.result;
    }
    reader.readAsDataURL(input.files[0]);
   }
  }
 }

 /* 삭제 버튼 누르면 새로만든 div 행 삭제 해주는 함수 */
 function fn_delFileDiv(btn) {
  btn.parentNode.remove();
 }

 /* 파일, 이미지, 버튼, div 를 동적으로 생성하는 함수 */
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
 
 $(document).ready(function() {
  $(".EnrollmentBtn").on("click", function() {
   var form = $('#postForm')[0];
   var formData = new FormData(form);
   
   $.ajax({
    type:"POST",
    enctype:"multipart/form-data",
    url:"${contextPath}/brd/post",
    data:formData,
    processData:false,
    contentType:false,
    cache:false,
    timeout:600000,
    
    success:function(data){
     alert('success: 작성 완료.');
     location.href = "${contextPath}/brd/user"
    },
    error : function(data, textstatus){
           alert('fail: 다시 시도해주세요.');
           location.href = "${contextPath}/brd/postView"
          }
   })
  }); 
 })
 
</script>


 <div align="center">
  <br /> <br />
  <table>
   <tr>
    <td bgcolor="84F399" height="25" align="center">글쓰기</td>
   </tr>
  </table>
  <br />
  <form name="postFrm" id="postForm" method="post" action="${contextPath}/brd/post"
   enctype="multipart/form-data">
   <table>
    <tr>
     <td align=center>
      <table>

       <tr>
        <td width="10%">ID</td>
        <td width="90%">         
        <input type="hidden" name="writer" id="i_writer" value="${memId}">
        <input name="_writer" id="_i_writer" value="${memId}" disabled>
        </td>
       </tr>

       <tr>
        <td>제 목</td>
        <td><input name="title" id="i_title" size="50" maxlength="30"></td>
       </tr>

       <tr>
        <td>내 용</td>
        <td><textarea name="txt_content" id="i_txt_content" rows="10" cols="50"></textarea></td>
       </tr>

       <tr>
        <td></td>
        <td>
         <div id="filesDiv"></div>
        </td>
       </tr>

       <tr>
        <td colspan="2"><hr /></td>
       </tr>

       <tr>
        <td colspan="2">
         <!-- <input type="submit" value="등록"> -->
         <input type="button" value="등록" class="EnrollmentBtn">
         <input type="reset" value="다시쓰기"> 
         <input type="button" onclick="fn_addFileDiv()" value="파일추가" /> 
         <input type="button" value="리스트" onClick="location.href='${contextPath}/brd/user'">
        </td>
       </tr>
      </table>
     </td>
    </tr>
   </table>
  </form>
 </div>
