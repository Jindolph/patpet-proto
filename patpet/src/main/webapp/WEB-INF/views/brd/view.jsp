<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
 request.setCharacterEncoding("UTF-8");
%>

<style>
/* The Modal (background) */
.searchModal {
 display: none; /* Hidden by default */
 position: fixed; /* Stay in place */
 z-index: 10; /* Sit on top */
 left: 0;
 top: 0;
 width: 100%; /* Full width */
 height: 100%; /* Full height */
 overflow: auto; /* Enable scroll if needed */
 background-color: rgb(0, 0, 0); /* Fallback color */
 background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}
/* Modal Content/Box */
.search-modal-content {
 background-color: #fefefe;
 margin: 5% auto; /* 15% from the top and centered */
 padding: 20px;
 border: 1px solid #888;
 width: 20%; /* Could be more or less, depending on screen size */
}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript">

//날짜 변환
function showLastModTime(timeValue) {
 //JSON 날짜시간을 그대로 표시하면 1594169682000 이렇게 표시됩니다.
 var dateObj = new Date(timeValue);//전달된 수정날짜시간값 저장

 var str ="";
 
 var yy = dateObj.getFullYear(); //YYYY
 var mm = dateObj.getMonth() + 1; // getMonth() is zero-based
 var dd = dateObj.getDate();

 var hh = dateObj.getHours();
 var mi = dateObj.getMinutes();
 var ss = dateObj.getSeconds();
 
 str= [yy, '/', 
   (mm > 9 ? '' : '0') + mm, '/',
   (dd > 9 ? '' : '0') + dd, ' ',
   (hh > 9 ? '' : '0') + hh, ':', 
   (mi > 9 ? '' : '0') + mi].join(''); //배열값으로 하나의 문자열로 합침
 console.log(str);
 return str ;
 
}

//댓글 리스트 불러오기
function CommentList(){
 var atc_no = ${atcVO.atc_no};
 
 
 $.ajax({
  url : "/pp/brd/commentView",
  type : "post",
  data: {atc_no:atc_no},
  dataType: "JSON",
  success:function (data,textStatus){
   /* alert(JSON.stringify(data)); */ 
   var str1="";
   var id = '${memId}';

  
  
	   for(var i in data){

		   if(id==data[i].writer){

			     str1 += "<tr class='tbRow1'>"
			         + "  <td>"
			         +      data[i].cmt_no + "번" 
			         + "  </td>"
			         + "  <td>"
			         +      data[i].writer + showLastModTime(data[i].regDate)
			         + "  </td>"
			         + "</tr>"
			         + "<tr>"
			         + "  <td colspan='2'>"
			         +      data[i].txt_content 
			         + "  </td>"
			         + "</tr>"
			         + "<tr class='tbRow2'>"
			         + "  <td colspan='2' align='right'>"
			         + "  <input type='button' onclick='openModal1()' value='수정' /> "
			         + "  <input type='button' id='btnDelete' value='삭제' /> "
			         + "  <input type='hidden'  value='"+data[i].cmt_no+"' id='up' /> "
			         + "  </td>"
			         + "</tr>";
		   }else{

	      str1 += "<tr class='tbRow1'>"
	          + "  <td>"
	          +      data[i].cmt_no + "번" 
	          + "  </td>"
	          + "  <td>"
	          +      data[i].writer + showLastModTime(data[i].regDate)
	          + "  </td>"
	          + "</tr>"
	          + "<tr>"
	          + "  <td colspan='2'>"
	          +      data[i].txt_content 
	          + "  </td>"
	          + "</tr>";
   }
	   }
   $("#jsonResult1").html(str1);

   //댓글 삭제 버튼
   $("#btnDelete").on('click',function(){
    var td = $(this).closest("td");
    var cmtNO = td.find("input[type='hidden']").val();
    CommentDelete(cmtNO);
   }); 
   
   //댓글 삭제
   function CommentDelete(cmtNO){
    var data = {cmt_no: cmtNO};
    /* alert(JSON.stringify(data)); */ 
    $.ajax({
     url : "/pp/brd/commentDelete",
     type : "post",
     data:data,
     success:function (data,textStatus){
      alert('댓글이 삭제되었습니다.');
      CommentList();
     },
     error:function(err){
      alert("다시 시도해주세요.");
     }
    });
    
   };
  },
  error:function(data,textStatus){
      alert("에러가 발생했습니다.");
  }
 });
}
 $(document).ready(function(){
  //댓글 리스트 부르기
  var atc_no = ${atcVO.atc_no};
  CommentList();
 
 //좋아요 클릭
 $('.heartBtn').on("click", function(){
  /* var _data = {atc_no:'${atcVO.atc_no}', mem_id:'${memId}'}; */
  var _data = document.getElementById("atc1").value;
  var _id = '${memId}';
   $.ajax({
   url:"${contextPath}/brd/AddheartLogs",
   type:"POST",
   data:{atc:_data, id:_id},
   success : function(data){
    alert('success: '+data);
         },
         error : function(data, textstatus){
          alert('fail: '+data);
         }
  })
  
 }); 
 
 //신고 클릭
 $('.reportBtn').on("click", function() {
  var atc_no = document.getElementById("atc1").value;
  alert(atc_no);
  var mem_id = '${memId}';
  alert(mem_id);
  $.ajax({
   url:"${contextPath}/brd/Report",
   type:"POST",
   data:{atc_no:atc_no, mem_id:mem_id},
   success : function(data) {
    alert('success: '  + data);
   },
   error : function(data, textstatus) {
    alert('flail: ' + data);
   }
  })
 });
 
 //등록버튼 클릭
 $("#btnWrite").on('click',function(){
  CommentWriter();
 });
 
})
 
 //댓글 작성
 function CommentWriter(){
  var txt_content = $("#txt_content").val();
  /* var mem_id = $("#mem_id").val(); */
  var writer = '${memId}';
  var atc_no = $("#atc_no").val();
  var data = {txt_content: txt_content, writer: writer, atc_no : atc_no};
  /* alert(JSON.stringify(data)); */
  $.ajax({
   url : "/pp/brd/commentWriter",
   type : "post",
   data:data,
   success:function (data,textStatus){
    alert('댓글 등록이 완료되었습니다.');
     /* $("#txtContent").value=''; */
     document.getElementById("txt_content").value='';
    CommentList();
   },
   error:function(err){
       alert("로그인을 해주세요.");
   /* location.href="/pp/mem/login"; */
   }
  });
  
 }
 
 //수정시 실행
 function update() {
  var cmtNO = $("#up").val();
  
  alert(JSON.stringify(cmtNO));
  
  var upcmt = $("#U_txt_content").val();
  alert(JSON.stringify(upcmt)); 
  
  var data = {txt_content:upcmt, cmt_no:cmtNO};
  alert(JSON.stringify(data));
  $.ajax({
   type:"POST",
   url:"/pp/brd/commentUpdate",
   data:data,
   
   success:function(data){
    alert('success: 수정 완료.');
    location.href = "${contextPath}/brd/view?atc_no="+${atcVO.atc_no};
   },
   error : function(data, textstatus){
          alert('fail: 다시 시도해주세요.');
          location.href = "${contextPath}/brd/view?atc_no="+${atcVO.atc_no};
         }
  });
 }
 
 //삭제시 실행
 function remove(obj) {
  obj.setAttribute("method", "post");
  obj.setAttribute("action", "${contextPath}/brd/delete");
  obj.submit();
 }
 
 //파일 다운로드 시 실행 
 function fn_fileDown(fileNo) {
  var formObj = $("form[name='frmBoard']");
  $("#FILE_NO").attr("value", fileNo);
  formObj.attr("action", "${contextPath}/brd/fileDownload");
  formObj.submit();
 }
 
 //게시글 삭제 시 모달 열기
 function openModal() {
  $("#modal").show();
 }
 
 //모달 닫기
 function closeModal() {
  $('.searchModal').hide();
 }
 
 //댓글 수정 시 모달 열기
 function openModal1() {
  $("#modal1").show();
 }
 
 
</script>


 <form id="i_frmBoard" role="form" name="frmBoard" method="post">
  <input type="hidden" name="atc_no" value="${atcVO.atc_no}" /> 
  <input type="hidden" name="FILE_NO" id="FILE_NO">
  <table>
   <tr id="atcNoRow">
    <td width=150 align="center">글번호</td>
    <td>
     <input type="text" value="${atcVO.atc_no}" id="atc1" disabled />
    </td>
   </tr>

   <tr id="writerRow">
    <td width="150" align="center">작성자 아이디</td>
    <td>
     <input type=text value="${atcVO.writer}" name="writer" disabled />
    </td>
   </tr>

   <tr id="titleRow">
    <td width="150" align="center">제목</td>
    <td>
     <input type=text value="${atcVO.title}" name="title"id="i_title" disabled />
    </td>
   </tr>

   <tr id="txtContentRow">
    <td width="150" align="center">내용</td>
    <td>
     <textarea rows="20" cols="60" name="txt_content" id="i_content" disabled>${atcVO.txt_content}</textarea>
    </td>
   </tr>

   <tr id="fileRow">
    <td width="150" align="center">파일</td>
    <td><c:choose>
      <c:when test="${not empty file}">
       <c:forEach var="obj" items="${file}">
        <img alt="이미지가 없습니다." width="100" height="100" src="${contextPath}/brd/fileDownload?FILE_NO=${obj.FILE_NO}&atc_no=${atcVO.atc_no}" /><br>
        <a href="#" onclick="fn_fileDown('${obj.FILE_NO}'); return false;">${obj.ORG_FILE_NAME}</a>(${obj.FILE_SIZE}KB)<br>
       </c:forEach>
      </c:when>

      <c:when test="${empty file}">
       <a>파일이 없습니다.</a>
      </c:when>
     </c:choose></td>
   </tr>

   <tr id="regDateRow">
    <td width="150" align="center">등록일자</td>
    <td><input type=text
     value="<fmt:formatDate value="${atcVO.regDate}" />" disabled /></td>
   </tr>
   
   <c:choose>
    <c:when test="${not empty atcVO.modDate}">
     <tr id="regDateRow">
      <td width="150" align="center">수정일자</td>
      <td><input type=text
       value="<fmt:formatDate value="${atcVO.modDate}" />" disabled /></td>
     </tr>
    </c:when>
   </c:choose>
   
   <tr>
    <td align="center"></td>
    <td>
     <input type="button" value="list" onclick="location.href='${contextPath}/brd/user'" /> 
 <c:choose>
 <c:when test="${memId==atcVO.writer}">
  <input type="button" value="modify" onclick="location.href='${contextPath}/brd/modifyView?atc_no=${atcVO.atc_no}'" />
  <input type="button" value="delete" onclick="openModal()" />  
 </c:when>
 </c:choose>
     <button type="button" class="heartBtn">좋아요</button>
     <button type="button" class="reportBtn">신고하기</button>
    </td>
   </tr>
  </table>
  
  <table id="jsonResult1" class="table2" ></table>
  
  <br><br>
  
  <table class="table2">
  <tr>
   <%-- <td><input type="hidden" name="mem_id" id="mem_id" value="${memInfo.mem_id}" /></td> --%>
   <td><input type="hidden" name="atc_no" id="atc_no" value="${atcVO.atc_no}" /></td>
  </tr>
 <tr>
  <td colspan=2>
   <textarea name="txt_content" rows="5" cols="65" maxlength="300" id="txt_content"></textarea>
  </td>
  <td><input type="button" id="btnWrite" class="button" value="등록" /></td>
 </tr>
 </table>
 </form>
 
 <!-- 게시글 삭제 모달 -->
 <div id="modal" class="searchModal">
  <div class="search-modal-content">
   <div class="row">
    <div class="col-sm-12">
     <div class="row">
      <div class="col-sm-12">
       <h2>게시글을 삭제하시겠습니까?</h2>
      </div>
     </div>
    </div>
   </div>
   <hr>
   <div style="cursor: pointer; background-color: skyblue; text-align: center; padding-bottom: 10px; padding-top: 10px; " onClick="remove(frmBoard);">
    <span class="pop_bt modalCloseBtn" style="font-size: 13pt;">예</span>
   </div>
   
   <div style="cursor: pointer; background-color: red; text-align: center; padding-bottom: 10px; padding-top: 10px;" onClick="closeModal();">
    <span class="pop_bt modalCloseBtn" style="font-size: 13pt;">닫기</span>
   </div>
  </div>
 </div>
 
 <!-- 댓글 수정 모달 -->
 <div id="modal1" class="searchModal">
  <div class="search-modal-content">
   <div class="row">
    <div class="col-sm-12">
     <div class="row">
      <div class="col-sm-12" align="center">
       <h2>댓글 수정</h2>
      </div>
       <div align="center">
        <textarea name="txt_content" rows="2" cols="24" maxlength="300" id="U_txt_content"></textarea>
       </div>
     </div>
    </div>
   </div>
   <hr>
   <div style="cursor: pointer; background-color: skyblue; text-align: center; padding-bottom: 10px; padding-top: 10px; " onClick="update();">
    <span class="pop_bt modalCloseBtn" style="font-size: 13pt;">예</span>
   </div>
   
   <div style="cursor: pointer; background-color: red; text-align: center; padding-bottom: 10px; padding-top: 10px;" onClick="closeModal();">
    <span class="pop_bt modalCloseBtn" style="font-size: 13pt;">닫기</span>
   </div>
  </div>
 </div>
 <input type="hidden" id="bbb" value="">
