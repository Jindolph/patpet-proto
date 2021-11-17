<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
 request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<link href="style.css" rel="stylesheet" type="text/css">

 <script src="http://code.jquery.com/jquery-latest.min.js"></script>
 <script type="text/javascript"> 
 
 //jquery 파일 삭제 버튼 클릭 시 실행
 $(document).ready(function(){
  $(document).on("click","#fileDel", function(){
   $(this).parent().remove();
  });
  fn_addFile();
  
  
 })
 
 //다중 파일 생성
 function fn_addFile(){
  var fileIndex = 1;
  $(".fileAdd_btn").on("click", function(){
   $("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"<button type='button' style='float:right;' id='fileDelBtn'>"+"삭제"+"</button></div>");
  });
  $(document).on("click","#fileDelBtn", function(){
   $(this).parent().remove(); 
  });
 }
 
  var fileNoArry = new Array();
  var fileNameArry = new Array();
  
  //지워질 파일 번호와 이름 보내기
  function fn_del(value, name){
   
   fileNoArry.push(value);
   fileNameArry.push(name);
   $("#fileNoDel").attr("value", fileNoArry);
   $("#fileNameDel").attr("value", fileNameArry);
 }
 
 //수정 처리
 $(document).ready(function() {
  $(".ModifiedBtn").on("click", function() {
   var form = $('#i_updateFrom')[0];
   var formData = new FormData(form);
   
   $.ajax({
    type:"POST",
    enctype:"multipart/form-data",
    url:"${contextPath}/brd/modify",
    data:formData,
    processData:false,
    contentType:false,
    cache:false,
    timeout:600000,
    
    success:function(data){
     alert('success: 수정 완료.');
     location.href = "${contextPath}/brd/view?atc_no="+${atcVO.atc_no};
    },
    error : function(data, textstatus){
           alert('fail: 다시 시도해주세요.');
           location.href = "${contextPath}/brd/view?atc_no="+${atcVO.atc_no};
          }
   })
  });
 })
 
</script>
 <div align="center">
  <br/>
  <br/>
  <table>
   <tr>
    <td bgcolor="#FF9018" height="21" align="center">수정하기</td>
   </tr>
  </table>
  <form name="updateFrom" id="i_updateFrom" role="form" enctype="multipart/form-data">
   <input type="hidden" name="atc_no" value="${atcVO.atc_no}"/>
   <input type="hidden" id="fileNoDel" name="fileNoDel[]" value="" /> 
   <input type="hidden" id="fileNameDel" name="fileNameDel[]" value="" />
   <table>
    <tr>
     <td>
      <table>
       
       <tr>
        <td width="20%">글번호</td>
        <td width="80%">${atcVO.atc_no}</td> 
       </tr>
       
       <tr>
        <td width="20%">성 명</td>
        <td width="80%">${atcVO.writer}</td>
       </tr>
       
       <tr>
        <td>제 목</td>
        <td>
         <input name="title" size="48" value="${atcVO.title}" maxlength="50">
       </td>
       
       <tr>
        <td>내 용</td>
        <td>
         <textarea name="txt_content" rows="10" cols="50">${atcVO.txt_content}</textarea>
        </td>
       </tr>
       
       <tr>
        <td>파일</td>
        <td id="fileIndex">
         <c:forEach var="file" items="${file}" varStatus="var">
         <div>
          <input type="hidden" id="FILE_NO" name="FILE_NO_${var.index}" value="${file.FILE_NO}">
          <input type="hidden" id="FILE_NAME" name="FILE_NAME" value="FILE_NO_${var.index}">
          <a id="fileName" onclick="return false;">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}KB)
          <button id="fileDel" onclick="fn_del('${file.FILE_NO}','FILE_NO_${var.index}');" type="button">삭제</button><br>
         </div>
         </c:forEach>
        </td> 
       </tr>
       
       <tr>
        <td colspan="2" height="5"></td>
       </tr>
       
       <tr>
        <td colspan="2">
         <button type="button" class="fileAdd_btn">파일추가</button>
         <input type="button" value="수정" class="ModifiedBtn">
         <input type="reset" value="다시수정">
         <input type="button" value="뒤로" onClick="history.go(-1)">
        </td>
       </tr>
       
      </table>
     </td>
    </tr>
   </table>
  </form>
 </div>
