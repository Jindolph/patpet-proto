<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
	request.setCharacterEncoding("UTF-8");
%>

<div class="container-custom">

<%@include file="../include/header.jsp"%>

<div class="row" style="height: 75%">

<%@include file="../include/memsidebar.jsp"%>

<div class="cols col-md-10" style="background-color: lightgray;">
    <div class="panel panel-default content-section-panel">
     <div class="panel-heading">&nbsp;&nbsp;&nbsp;</div>
     <div class="panel-body" id="emptyTable">
     </div>
    </div>
   </div>

   <div class="cols col-xs-1">
    <div class="panel panel-default content-section-panel-side">
     <div class="panel-heading">광고배너</div>
     <div class="panel-body"></div>
    </div>
   </div>
</div> 

<%@include file="../include/footer.jsp"%>

<!-- 모달 div -->
 <div class="modal fade" id="modalModSubs" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
   <div class="modal-content">
    <div class="modal-header">
     <button type="button" class="close" data-dismiss="modal" aria-label="Close">
      <span aria-hidden="true">x</span>
     </button>
     <h4 class="modal-title w-100 font-weight-bold">Modify</h4>
    </div>
    <div class="modal-body">
     <button id='btnProlong' type="button" class="btn btn-danger">연장하기</button>
     <button id='btnGrade' type="button" class="btn btn-danger">등급변경</button>
     <div class="prolongDiv" style="display:none;">
      <i class="far fa-calendar-alt prefix grey-text"></i> 
      <label>MONTH</label>
      <select id="month">
           <c:forEach var="i" begin="0" end="12">
          <option value="${i}">${i}개월</option>
        </c:forEach>
          </select>
     </div>
     <div class="gradeDiv" style="display:none;">
      <i class="fas fa-dog text-white"></i>
      <label data-error="wrong" data-success="right" for="form2">GRADE</label><br>
      <input type="radio" name="subs_grade" value="SILVER"/> SILVER
      <input type="radio" name="subs_grade" value="GOLD" /> GOLD
      <input type="radio" name="subs_grade" value="PLATINUM" /> PLATINUM
     </div>
    </div>
    <div class="modal-footer">
     <button id='btnSubmit' type="button" class="btn btn-danger">결정</button>
     <button id='btnModModalExit' type="button" class="btn btn-default">나가기</button>
    </div>
   </div>
  </div>
 </div>
 
 <div class="modal fade" id="modalNewSubsForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
   <div class="modal-content">
    <!-- 모달 헤더 -->
    <div class="modal-header">
     <button type="button" class="close" data-dismiss="modal" aria-label="Close">
      <span aria-hidden="true">x</span>
     </button>
     <h4 class="modal-title w-100 font-weight-bold">Subscribe</h4>
    </div>
    <!-- 모달 헤더 종료 -->
    <!-- 모달 바디 -->
    <div class="modal-body">
     <div class="md-form mb-4">
      <i class="fas fa-envelope prefix grey-text"></i> 
      <label data-error="wrong" data-success="right" for="form2">ID</label>
      <input type="email" id="id" class="form-control validate" value="${memId}"> 
     </div>
     <div class="md-form mb-5">
      <i class="fas fa-dog text-white"></i>
      <label data-error="wrong" data-success="right" for="form2">GRADE</label><br>
      <input type="radio" name="subs_grade" value="SILVER" checked="checked" /> SILVER
      <input type="radio" name="subs_grade" value="GOLD" /> GOLD
      <input type="radio" name="subs_grade" value="PLATINUM" /> PLATINUM
     </div>
     <div class="md-form mb-5">
      <i class="far fa-calendar-alt prefix grey-text"></i> 
      <label data-error="wrong" data-success="right" for="form2">MONTH</label>
      <select id="nMonth">
        <c:forEach var="i" begin="1" end="12">
        <option value="${i}">${i}개월</option>
        </c:forEach>
      </select>
     </div>
     <div class="md-form mb-5">
      <i class="fas fa-dog text-white"></i>
      <label data-error="wrong" data-success="right" for="form2">배송지</label><br>
      <input type="text"  id="dvrInfo" value="">
      <input type="text"  id="dvrDetail" value="">
     </div>
     <div class="md-form mb-5">
      <i class="fas fa-dog text-white"></i>
      <label data-error="wrong" data-success="right" for="form2">결제수단</label><br>
      <input type="text"  id="pmtCard" value="">
      <input type="text"  id="pmtCnum" value="">
     </div>           
    </div>
    <!-- 모달 바디 종료 -->
    <!-- 모달 푸터 -->
    <div class="modal-footer">
     <button class="btn btn-indigo" id="newSubscription">Send <i class="fas fa-paper-plane prefix grey-text"></i></button>
     <button class="btn btn-indigo" id="btnSModalExit">Exit <i class="fas fa-sign-out prefix"></i></button>
    </div>
    <!-- 모달 푸터 종료 -->
   </div>
  </div>
 </div>
 
 <div class="modal fade" id="modalCancelSubs" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
   <div class="modal-content">
    <div class="modal-body">
     <h3>정말 구독을 취소하시겠습니까?</h3>
    </div>
    <div class="modal-footer">
     <button id='btnCModalDelSubs' type="button" class="btn btn-danger">구독취소</button>
     <button id='btnCModalExit' type="button" class="btn btn-default">나가기</button>
    </div>
   </div>
  </div>
 </div>
    
<!-- a 태그 이벤트 스크립트 모음  -->
<script>
//회원정보 보기 버튼
 $("#myInfo").click(function() {
  $("#btnModSubscription").hide();
  $("#btnNewSubscription").hide();
  $("#btnCancelSubs").hide();
  var id = '${memId}';
  myInfo(id);
 });
//방명록 버튼
 $("#myGuestBook").click(function() {
	  $("#btnModSubscription").hide();
	  $("#btnNewSubscription").hide();
	  $("#btnCancelSubs").hide();
	  var id = '${memId}';
	  myBook(id);
	 });
	 
 $("#myGuestBook2").click(function() {
	   var id = '${memId}';
	   myBook(id);
	  });
//선물함버튼
 $("#myPdt").click(function() {
  $("#btnModSubscription").hide();
  $("#btnNewSubscription").hide();
  $("#btnCancelSubs").hide();
  var id = '${memId}';
  myPdt(id);
 });
//회원탈퇴버튼
 $("#dropMyInfo").click(function() {
  $("#btnModSubscription").hide();
  $("#btnNewSubscription").hide();
  $("#btnCancelSubs").hide();
  var id = '${memId}';
  dropmyInfo(id);
 });
//구독정보보기버튼
 $("#mySubsInfo").click(function() {
  var id = '${memId}';
  showSubsHistory(id);
 });
//배송정보보기버튼
 $("#myDvr").click(function() {
  $("#btnModSubscription").hide();
  $("#btnNewSubscription").hide();
  $("#btnCancelSubs").hide();
  var id = '${memId}';
  myDvr(id);
 });
//결제정보보기버튼
 $("#myPmt").click(function() {
  $("#btnModSubscription").hide();
  $("#btnNewSubscription").hide();
  $("#btnCancelSubs").hide();
  var id = '${memId}';
  myPmt(id);
 });
//내 문의내역
 $("#myQnA").click(function() {
  var id = '${memId}';
  myQnAList(id);
 });
</script>

<!-- 회원정보 보기 및 수정 스크립트 -->
<script>
 function myInfo(id) {
  memService.getmemInfo(id, function(mylist) {
   var strLi = "";
   strLi += "<table class='table table-bordered'>" 
         + "<tr>" 
         + "<td>아이디</td>"
         + "<td>"
         + mylist[0].mem_id
         + "</td>" 
         + "</tr>" 
   
				     + "<tr>"
				     + "<td>비밀번호</td>" 
				     + "<td>"
				     +"<input type='hidden' value='"+mylist[0].mem_pw+"' id='pw'>"
				     + "<input type='password' id='mem_pw' disabled>"
				     + "</td>"
				     +"<td>"
				     +"<input type='button' value='수정' onClick='fn_changePW()' id='btn1'/>"
				     +"<input type='button' value='비밀번호 확인' onClick='fn_changePW2()'style='display:none;' id='btn2'>"
				     +"<input type='button' value='변경' onClick='fn_changePW3()' style='display:none;' id='btn3'>"
				     +"</td>"
				     + "</tr>" 
     
				     + "<tr>" 
				     + "<td>이름</td>" 
				     + "<td>"
				     + mylist[0].mem_name 
				     + "</td>" 
				     + "</tr>" 
     
				     + "<tr>"
				     + "<td>가입일</td>" 
				     + "<td>" 
				     + memService.showLastModTime(mylist[0].joinDate) 
				     + "</td>"
				     + "</tr>" 
     
				     + "<tr>" 
				     + "<td>포인트</td>" 
				     + "<td>"
				     + mylist[0].points
				     + "</td>" 
				     + "<td>"
				     + "<input type='button' value='사용하기'>"
				     + "</td>"
				     + "</tr>" 
     
				     + "<tr>"
				     + "<td>생년월일</td>" 
				     + "<td>" 
				     + memService.showLastModTime(mylist[0].birthdate) 
				     + "</td>"
				     + "</tr>" 
     
				     + "<tr>"
				     + "<td>구독여부</td>" 
				     + "<td>" 
				     + mylist[0].is_subs
				     + "</td>"
				     + "</tr>" 
     
				     + "<tr>"
				     + "<td>이메일수신여부</td>" 
				     + "<td>" 
				     + "<input type='text' value='"+mylist[0].email_YN+"' disabled style='background-color: transparent; border: 0 solid black;' id='email_yn'>"
				     +"<input type='hidden' value='"+mylist[0].email_YN+"' name='email_yn' id='_email_yn'>"
				     + "</td>"
				     +"<td>"
				     +"<input type='button' value='수정' onClick='fn_emailYN()'>"
				     +"</td>"
				     + "</tr>" 
     
         + "</table>"

   $("#emptyTable").html(strLi);
  }, function() {
  })
}
 
 function fn_changePW() {
	  alert("기존비밀번호를 입력해주세요.");
	  $('#mem_pw').prop("disabled",false);
	  $('#btn1').css('display', "none");
	  $('#btn2').css('display', "table-cell");
	 }

	 function fn_changePW2() {
	     var password = $("#pw").val();
	     var confirm_password = $("#mem_pw").val();

	        if (password != confirm_password) {
	          alert('비밀번호를 확인해주세요');
	        }
	        else{
	          alert('변경할 비밀번호를 입력해주세요');
	          $('#btn2').css('display', "none");
	          $('#btn3').css('display', "table-cell");
	          $('#mem_pw').val('');
	        }
	     }
	 
	 function fn_changePW3(){

	  var _id='${memId}';
	  var _pw=$("#mem_pw").val();
	  var pw=$("#pw").val();
	  var regex = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;

	     if(_pw.match(regex)==null){
	         alert("비밀번호조건을 지켜주세요");
	     }else{
	         $.ajax({
	          type:"post",
	          url:"/pp/mem/modifypw",
	          dataType:"text",
	          data:{id:_id, pw:_pw},
	             
	          success:function(data,textStatus){
	              alert("변경완료됐습니다.");
	              $('#mem_pw').val('');
	              $('#mem_pw').prop("disabled",true);
	              $('#btn3').css('display', "none");
	              $('#btn1').css('display', "table-cell");
	              document.getElementById("pw").value = _pw;
	              myInfo();
	             },
	             error:function(data,textStatus){
	              alert("에러가 발생했습니다");
	             }
	         });
	         
	     }

	 }
	 
	 function fn_emailYN(){

	     var _id='${memId}';
	     var eck = document.getElementById("_email_yn").value;
	     
	     if (eck == 'Y') {
	       document.getElementById("email_yn").value = "N";
	       document.getElementById("_email_yn").value = "N";
	       eck="N";
	     } else {
	       document.getElementById("email_yn").value = "Y";
	       document.getElementById("_email_yn").value = "Y";
	       eck="Y";
	     }
	     
	     $.ajax({
	           type:"post",
	           url:"/pp/mem/modifyemail",
	           dataType:"text",
	           data:{id:_id, eck:eck},
	              
	           success:function(data,textStatus){
	               alert("변경완료됐습니다.");
	              },
	              error:function(data,textStatus){
	               alert("에러가 발생했습니다");
	              }
	          });
	  
	  
	 }
	</script>
	
<!-- 방명록 보기 스크립트 -->
<script>
	function myBook(id){
		var id='${memId}';
		brdService.getArticleView2(id, function(atcNo){
			var atcnum = atcNo.atc_no;
			brdService.getCommentView(atcnum, function(cmtlist){
				var cmt = "";
				var str = "";
			     
			     str += "<form>" 
			     + "<table class='table table-bordered'>"
			     + "<tr>"
			     + "<td>"
			     + "<input type='hidden' name='atc_no' id='atcnum' value='"+atcNo.atc_no+"'>"
			     + atcNo.writer+"의 방명록"
			     + "</td>"
			     + "</tr>"
			     
			     + "<tr>"
			     + "<td align='center'>"
			     + "<textarea rows='18' cols='70px' name='txt_content' id='bookContent' disabled>"
			     + atcNo.txt_content
			     + "</textarea>"
			     + "<button  type='button' class='btn btn-default' id='modBtn' onClick='fn_modBook()'>수정</button>"
			     + "<button type='button' class='btn btn-default' id='modBtn2' style='display:none;' onClick='fn_modBook2(this.form)'>완료</button>"
			     + "</td>"
			     + "</tr>"
			     
			     + "<tr>"
			     + "<td>"
			     + "<div id='cmtarea'>"
			     + "</div>"
			     + "</td>"
			     + "</tr>"
			     
			     + "<tr>"
			     + "<td>"
			     + "<input type='text' id='txt_content' name='txt_content'>"
			     + "</form>"
			     + "<button type='button' class='btn btn-default' onClick='fn_guestCmt(this.form)'>등록</button>"
			     + "</td>"
			     + "</tr>"  
			     + "</table>";
			     $("#emptyTable").html(str); 
			     
			        for(var i=0; i<cmtlist.length; i++){
			            cmt += cmtlist[i].txt_content
			            + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
			            + "<b>작성자</b>"
			            + cmtlist[i].writer
			            + "&nbsp;&nbsp;&nbsp;"
			            + "<b>작성일</b>"
			            + cmtlist[i].regDate
			            + "<br>";
			            $("#cmtarea").html(cmt); 
			           }
			  });
			});
			

	}
	function fn_modBook(){
		$('#bookContent').prop('disabled', false);
		$('#modBtn').css('display', 'none');
		$('#modBtn2').css('display', 'inline');
	}
	
	function fn_modBook2(atcnum){
		  $('#bookContent').prop('disabled', true);
		  $('#modBtn').css('display', 'inline');
		  $('#modBtn2').css('display', 'none');
		  var txt_content = $('#bookContent').val();
		  var atc_no = $('#atcnum').val();
		  
		  var content={atc_no:atc_no,txt_content:txt_content};
		  
		  brdService.modArticle2(content,function(article){
		  });
		 }
	
	
	function fn_guestCmt(form){
		var writer='${memId}';
  var txt_content = $('#txt_content').val();
  var atc_no = $('#atcnum').val();
  var comment={writer:writer,txt_content:txt_content,atc_no:atc_no};
  
  
   $.ajax({
	   type: 'POST',
	   url: '/pp/board/guestCmt',
	   data: JSON.stringify(comment), 
	   contentType: "application/json; charset=utf-8",
	   success: function(data){
	   }
	  }); 
   myBook();
	}
	</script>
	
<!-- 회원탈퇴 스크립트 -->
<script> 

		 function dropmyInfo(id) {
 
		  memService.getmemInfo(id, function(mylist) {
	
			  
		   var strLi = "";
		   strLi += "<table class='table table-bordered'>" 
		   + "<tr>" 
		   + "<td>회원탈퇴</td>" 
		   + "</tr>" 
		   
		   + "<tr>"
		   + "<td>탈퇴하시려면 비밀번호를 입력해주세요</td>" 
		   + "</tr>" 

		   + "<tr>"
		   + "<td>"
		   + "<input type='hidden' value='"+mylist[0].mem_id+"' id='mem_id'>"
		   + "<input type='password' id='chk_pw'>"
		   + "<input type='hidden' value='"+mylist[0].mem_pw+"' id='mem_pw'>"
		   + "<input type='button' value='탈퇴하기' onClick='fn_checkPw()''>"
		   + "</td>"
		   + "</tr>" 
		   + "</table>"

		   $("#emptyTable").html(strLi);
		  }, function() {
		  })

		 }	 
		 
		 function fn_checkPw(){

			  var pw = $("#mem_pw").val();
			  var confirm_password = $("#chk_pw").val();
			  var id = $("#mem_id").val();
			 
			     if (pw != confirm_password) {
			      alert('비밀번호가 일치하지 않습니다.');
			     }
			     else{
			      if (confirm("정말 탈퇴하시겠습니까??") == true){    
			              $.ajax({
			                  type:"post",
			                  url:"/pp/mem/resign",
			                  dataType:"text",
			                  data:{id:id},
			                     
			                  success:function(data,textStatus){
			                       alert("탈퇴되셨습니다.");
			                       location.href="/pp/";
			                     },
			                     error:function(data,textStatus){
			                         alert("에러가 발생했습니다");
			                     }
			                 });


			      }else{   

			          return;

			      }
			     } 
			}
</script>
<!-- 선물함 스크립트 -->
<script>
function myPdt(){
var str=""
str+="<button id='btnSubsProducts' class='btn btn-primary'>구독상품</button>"
   +"<button id='btnRandomProducts' class='btn btn-primary'>랜덤박스</button>"
   +"<ul class='showGiftsUL' style='list-style: none; padding-left: 0px;'></ul>"
   
$("#emptyTable").html(str);
   
$("#btnSubsProducts").on('click',function () {
	  var pdtType = 'SUBS_PDT';
	  showAllProducts(pdtType);
	 });
	 $("#btnRandomProducts").on('click',function () {
	  var pdtType = 'RD_PDT';
	  showAllProducts(pdtType);
	 });
}


	
	function showAllProducts(pdtType){
		 var content = "PDT";
		 productService.getAllProducts(
		  pdtType,
		  function(products){
		   var strLi = "";
		   if(products == null || products.length == 0)
		    return;
		   for (var i = 0, listLen = products.length; i < listLen; i++) {
		    strLi += "<li class='left clearfix'>"
		         + "    <div>"
		         + "        <div class='header'>"
		         + "            <img src='/pp/file/thumbnail/"+content+"/"+products[i].pdt_code+".json' width='100px' height='100px'>"
		         + "            <small class='text-muted' style='padding-left:10px;'>상품번호: </small>"
		         + "            <small class='text-muted'>"
		         +                  products[i].pdt_code
		         + "            </small>"
		         + "            <small class='text-muted' style='padding-left:10px;'>종류: </small>"
		         + "            <small class='text-muted'>"
		         +                  products[i].pdt_type
		        + "            </small>"
		        + "            <small class='text-muted' style='padding-left:10px;'>이름: </small>"
		        + "            <small class='text-muted'>"
		        +                  products[i].pdt_name
		        + "            </small>"
		        + "            <small class='text-muted' style='padding-left:10px;'>등록일자: </small>"
		        + "            <small class='text-muted'>"
		        +                  productService.showLastModTime(products[i].regDate)
		        + "            </small>"
		        + "        </div>"
		        + "    </div>"
		        + "</li><hr>";
		   }
		   $(".showGiftsUL").html(strLi);
		  })
		}
	</script>

<!-- 구독정보 보기 스크립트 -->
<script>
function showSubsHistory(id) {
	 subsService.getSubsById(
	  id,
	  function(data){
	   if (data == '') {
		   alert('구독내역이 없습니다');
	    $("#btnNewSubscription").show();
	    $("#btnModSubscription").hide();
	    $("#btnCancelSubs").hide();
	    
	    delService.getDvrById(id, function(mydvrlist){
	     var address = JSON.stringify(mydvrlist[0].address);
	     var detail = JSON.stringify(mydvrlist[0].addr_detail);
	     $("#dvrInfo").val(address);
	     $("#dvrDetail").val(detail);
	     pmtService.getPmtById(id, function(mypmtlist){
	      var card = JSON.stringify(mypmtlist[0].pmt_card);
	      var cnum = JSON.stringify(mypmtlist[0].pmt_cnum);
	      $("#pmtCard").val(card);
	      $("#pmtCnum").val(cnum);
	     });
	    });
	    
	    var subsInfo = "";
	    subsInfo +="<button id='btnNewSubscription' class='btn btn-primary' data-toggle='modal' data-target='#modalNewSubsForm'>지금 구독하기</button>";
	    $("#emptyTable").html(subsInfo);
	    return;
	   }
	   $("#btnNewSubscription").hide();
	   $("#btnModSubscription").show();
	   $("#btnCancelSubs").show();
	   delService.getDvrById(id, function(mydvrlist){
		    var address = JSON.stringify(mydvrlist[0].address);
		    var detail = JSON.stringify(mydvrlist[0].addr_detail);
		    pmtService.getPmtById(id, function(mypmtlist){
		     var card = JSON.stringify(mypmtlist[0].pmt_card);
		     var cnum = JSON.stringify(mypmtlist[0].pmt_cnum);
		     
		     var subsInfo = "";
		     subsInfo += "<div class='form-group'>"
		          +  "  <label>아이디</label>"
		          +  "  <input class='form-control' value='"+id+"' readonly='readonly'>"
		          +  "</div>"
		          +  "<div class='form-group'>"
		          +  "  <label>구독코드</label>"
		          +  "  <input class='form-control' id='scode' value='"+data.subs_code+"' readonly='readonly'>"
		          +  "</div>"
		          +  "<div class='form-group'>"
		          +  "  <label>등급</label>"
		          +  "  <input class='form-control' value='"+data.subs_grade+"' readonly='readonly'>"
		          +  "</div>"
		          +  "<div class='form-group'>"
		          +  "  <label>배송지</label>"
		          +  "  <input class='form-control' value='"+address+"' readonly='readonly'>"
		          +  "  <input class='form-control' value='"+detail+"' readonly='readonly'>"
		          +  "</div>"
		          +  "<div class='form-group'>"
		          +  "  <label>결제수단</label>"
		          +  "  <input class='form-control' value='"+card+"' readonly='readonly'>"
		          +  "  <input class='form-control' value='"+cnum+"' readonly='readonly'>"
		          +  "</div>"
		          +  "<div class='form-group'>"
		          +  "  <label>시작일</label>"
		          +  "  <input class='form-control' value='"+subsService.showLastModTime(data.beginDate)+"' readonly='readonly'>" 
		          +  "</div>"
		          +  "<div class='form-group'>"
		          +  "  <label>종료일</label>"
		          +  "  <input class='form-control' value='"+subsService.showLastModTime(data.endDate)+ "' readonly='readonly'>" 
		          +  "</div>"
		          +  "<div class='form-group'>"
		          +  "<button id='btnModSubscription' class='btn btn-primary' data-toggle='modal' data-target='#modalModSubs'>변경하기</button>"
		          +  "<button id='btnCancelSubs' class='btn btn-primary' data-toggle='modal' data-target='#modalCancelSubs'>구독취소</button>"
		          +  "</div>"
		          +  "<div>"
		          +  "<div class='form-group'>"
		          +  "</div>";         
		          
		     $("#emptyTable").html(subsInfo);
		    });
		     
		   });

	  })
	}
</script>

<!-- 배송정보 보기 스크립트 -->
<script>
	function myDvr(id) {
		
		delService.getDvrById(id, function(mydvrlist) {
			
			if(mydvrlist==''){
				alert('배송지가없습니다 추가해주세요.'); 
				
				  var strLi=""
					  strLi+="<form id='dvrform'>" 
					      +"<table class='table table-bordered'>" 
					      + "<tr>" 
					      + "<td>수령자이름</td>" 
					      + "<td>"
					      + "<input type='text' name='rcvr_name' id='rcvr_name' >"
					      + "<td>" 
					      + "</tr>" 
					      
					      + "<tr>"
					      + "<td>주문자아이디</td>" 
					      + "<td>"
					      + "<input type='hidden' value='${memId}' name='mem_id'>"
					      + '${memId}'
					      + "<td>"
					      + "</tr>" 
					      
					         + "<tr>" 
					         + "<td>주소</td>" 
					         + "<td>"
					         + "<input type='text' name='address' id='_address'>"
					         + "<input type='hidden' name='address' id='address'>"
					         + "<input type='button' onclick='daumPostcode()' value='우편번호 찾기' id='addrBtn'>"
					         + "</td>" 
					         + "</tr>" 
					         
					         + "<tr>"
					         + "<td>우편번호</td>" 
					         + "<td>" 
					         + "<input type='text' name='zipcode' id='_postcode'>"
					         + "<input type='hidden' name='zipcode' id='zipcode'>"
					         +"<td>"
					         + "</tr>" 
					         
					         + "<tr>"
					         + "<td>상세주소</td>" 
					         + "<td>" 
					         + "<input type='text' name='addr_detail' id='_addr_detail'>"
					         + "<td>"
					         + "</tr>"
					      
					      + "<tr>" 
					      + "<td>요청사항</td>" 
					      + "<td>"
					      + "<input type='text' name='requirement' id='requirement'>"
					      + "<td>" 
					      + "</tr>" 
					      
					      + "<tr>"
					      + "<td>핸드폰번호</td>" 
					      + "<td>" 
					      + "<input type='text' name='phone_num' id='phone_num'>"
					      +"<td>"
					      + "</tr>" 
					      + "</table>"
					      +"<input type='hidden' value='N' name='dvr_type' id='dvr_type'>"
					      + "<input type='checkbox' onChange='fn_checkVal()'>"
					      +"기본배송지로 등록"
					      +"<br>"
					      + "</form>"
					      + "<input type='button' value='등록하기' onClick='fn_addDvrInfo(this.form)'>"
					      

					      $("#emptyTable").html(strLi);
			}else{
		          var strLi = "";
		          var strBtn = "";
		          for(var i=0; i<mydvrlist.length; i++){
		        	  if(mydvrlist[i].dvr_type=="Y"){
		        		  strLi +="<form>" 
		        			  +"<label>기본배송지</label>" 
		        	  }
		          strLi += "<table class='table table-bordered'>" 
		            +"<tr>" 
		            + "<td>수령자이름</td>" 
		            + "<td>"
		            + mydvrlist[i].rcvr_name 
		            + "</td>" 
		            + "</tr>" 
		            
		            + "<tr>"
		            + "<td>주문자아이디</td>" 
		            + "<td>" 
		            + mydvrlist[i].mem_id 
		            + "<td>"
		            + "</tr>" 
		            
		            + "<tr>" 
		            + "<td>주소</td>"
		            + "<td>"
		            + mydvrlist[i].address 
		            + "<td>" 
		            + "</tr>" 
		            
		            + "<tr>"
		            + "<td>우편번호</td>" 
		            + "<td>" 
		            + mydvrlist[i].zipcode 
		            + "<td>"
		            + "</tr>" 
		            
		              + "<tr>"
		              + "<td>상세주소</td>" 
		              + "<td>" 
		              + mydvrlist[i].addr_detail 
		              + "<td>"
		              + "</tr>" 
		            
		            + "<tr>" 
		            + "<td>요청사항</td>" 
		            + "<td>"
		            + mydvrlist[i].requirement 
		            + "<td>" 
		            + "</tr>" 
		            
		            + "<tr>"
		            + "<td>핸드폰번호</td>" 
		            + "<td>" 
		            + mydvrlist[i].phone_num 
		            + "<td>"
		            + "</tr>" 
		            + "<tr>"
		            + "<td>"
		            + "<input type='button' value='수정하기' onClick='fn_modDvr("+i+")'>"
		            + "<input type='button' value='삭제하기' onClick='fn_delDvr("+i+")'>"
		            + "</td>"
		            + "</tr>"
		            + "</table>"
		            + "</form>"
		          }
		        strBtn += "<input type='button' value='추가하기' onClick='fn_addDvr()'>"

		        $("#emptyTable").html(strLi);
		        $("#emptyTable").append(strBtn);
			}

		}, function() {
		})

	}
	
	function daumPostcode(){
		 new daum.Postcode({
		  oncomplete:function(data){
		   var addr='';
		   var extraAddr='';

		   if(data.userSelectedType==='R'){
		    addr = data.roadAddress;
		   }else{
		    addr = data.jibunAddress;
		   }

		   if(data.userSelectedType ==='R'){
		    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		     extraAddr += data.bname;
		 }
		         
		 if(data.buildingName !== '' && data.apartment === 'Y'){
		  extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		 }
		   }

		   document.getElementById("_postcode").value = data.zonecode;
		   document.getElementById("_address").value = addr;
		   document.getElementById("_addr_detail").focus();
		  }
		 }).open();
		}
	
	function fn_addDvr(){
		var strLi=""
		strLi+="<form id='dvrform'>" 
			   +"<table class='table table-bordered'>" 
		    + "<tr>" 
		    + "<td>수령자이름</td>" 
		    + "<td>"
		    + "<input type='text' name='rcvr_name' id='rcvr_name' >"
	     + "<td>" 
	     + "</tr>" 
	     
	     + "<tr>"
	     + "<td>주문자아이디</td>" 
	     + "<td>"
	     + "<input type='hidden' value='${memId}' name='mem_id'>"
	     + '${memId}'
	     + "<td>"
	     + "</tr>" 
	     
         + "<tr>" 
         + "<td>주소</td>" 
         + "<td>"
         + "<input type='text' name='address' id='_address'>"
         + "<input type='hidden' name='address' id='address'>"
         + "<input type='button' onclick='daumPostcode()' value='우편번호 찾기' id='addrBtn'>"
         + "</td>" 
         + "</tr>" 
         
         + "<tr>"
         + "<td>우편번호</td>" 
         + "<td>" 
         + "<input type='text' name='zipcode' id='_postcode'>"
         + "<input type='hidden' name='zipcode' id='zipcode'>"
         +"<td>"
         + "</tr>" 
         
         + "<tr>"
         + "<td>상세주소</td>" 
         + "<td>" 
         + "<input type='text' name='addr_detail' id='_addr_detail'>"
         + "<td>"
         + "</tr>"
	     
	     + "<tr>" 
	     + "<td>요청사항</td>" 
	     + "<td>"
	     + "<input type='text' name='requirement' id='requirement'>"
	     + "<td>" 
	     + "</tr>" 
	     
	     + "<tr>"
	     + "<td>핸드폰번호</td>" 
	     + "<td>" 
	     + "<input type='text' name='phone_num' id='phone_num'>"
	     +"<td>"
	     + "</tr>" 
	     + "</table>"
	     +"<input type='hidden' value='N' name='dvr_type' id='dvr_type'>"
	     + "<input type='checkbox' onChange='fn_checkVal()'>"
      +"기본배송지로 등록"
      +"<br>"
      + "</form>"
	     + "<input type='button' value='등록하기' onClick='fn_addDvrInfo(this.form)'>"
	     

	     $("#emptyTable").html(strLi);
	     	    
	}
	
	function fn_modDvr(i){
		var id = '${memId}';
		 delService.getDvrById(id, function(mydvrlist){
		var strLi=""
			  strLi+="<form id='moddvr'>"
				     +"<table class='table table-bordered'>" 
				     + "<input type='hidden' name='dvr_code' value='"+mydvrlist[i].dvr_code+"'>"
			      + "<tr>" 
			      + "<td>수령자이름</td>" 
			      + "<td>"
			      + "<input type='text' name='rcvr_name' value='"+mydvrlist[i].rcvr_name+"'>"
			      + "<td>" 
			      + "</tr>" 
			      
			      + "<tr>"
			      + "<td>주문자아이디</td>" 
			      + "<td>"
			      + "<input type='text' name='mem_id' value='"+mydvrlist[i].mem_id+"'>"
			      + "<td>"
			      + "</tr>" 
		           + "<tr>" 
		           + "<td>주소</td>" 
		           + "<td>"
		           + "<input type='text' name='address' value='"+mydvrlist[i].address+"' id='_address'>"
		           + "<input type='hidden' name='address' id='address'>"
		           + "<input type='button' onclick='daumPostcode()' value='우편번호 찾기' id='addrBtn'>"
		           + "</td>" 
		           + "</tr>" 
		           
		           + "<tr>"
		           + "<td>우편번호</td>" 
		           + "<td>" 
		           + "<input type='text' name='zipcode' value='"+mydvrlist[i].zipcode+"' id='_postcode'>"
		           + "<input type='hidden' name='zipcode' id='zipcode'>"
		           +"<td>"
		           + "</tr>" 
		           
		           + "<tr>"
		           + "<td>상세주소</td>" 
		           + "<td>" 
		           + "<input type='text' value='"+mydvrlist[i].addr_detail+"' name='addr_detail' id='_addr_detail'>"
		           + "<td>"
		           + "</tr>"		      
			      + "<tr>" 
			      + "<td>요청사항</td>" 
			      + "<td>"
			      + "<input type='text' name='requirement' value='"+mydvrlist[i].requirement+"'>"
			      + "<td>" 
			      + "</tr>" 
			      
			      + "<tr>"
			      + "<td>핸드폰번호</td>" 
			      + "<td>" 
			      + "<input type='text' name='phone_num' value='"+mydvrlist[i].phone_num+"'>"
			      +"<td>"
			      + "</tr>" 
			      + "</table>"
			      +"<input type='hidden' value='N' name='dvr_type' id='dvr_type'>"
			      + "<input type='checkbox' onChange='fn_checkVal()'>"
			      +"기본배송지로 등록"
			      +"<br>"
			      + "</form>"
			      + "<input type='button' value='수정하기' onClick='fn_modDvrInfo()'>"
			      

			      $("#emptyTable").html(strLi);
	})
	}
	
	function fn_modDvrInfo(){
		  var form = $("#moddvr")[0];
		   var formData = new FormData(form)
		   
		   $.ajax({
		      type : 'post',
		      url : '/pp/dvr/modify.do',
		      data : formData,
		      processData:false,
		      contentType:false,
		      cache:false,
		      timeout:600000,
		      
		      success : function(data) {
		        alert('성공');
		    	  location.href="/pp/mem/myMain";
		      },
		      error : function(data) {
		       alert('실패');
		      }
		     });
	}
	
    function fn_checkVal(){
        var dck = document.getElementById("dvr_type").value;

        if (dck == "Y") {
        	alert(dck);
         document.getElementById("dvr_type").value = "N";
         alert(dck);
        } else {
        	alert(dck);
         document.getElementById("dvr_type").value = "Y";
         alert(dck);
        }
    }	
	
	
	 function fn_addDvrInfo(){
		 var form = $("#dvrform")[0];
		 var formData = new FormData(form)
		 
		 $.ajax({
			   type : 'post',
			   url : '/pp/dvr/register.do',
			   data : formData,
      processData:false,
      contentType:false,
      cache:false,
      timeout:600000,
      
			   success : function(data) {
        alert('성공');
        location.href="/pp/mem/myMain";
			   },
			   error : function(data) {
				   alert('실패');
			   }
			  });
	      }
	 
	 function fn_delDvr(i){
		  var id = '${memId}';
		 
		  delService.getDvrById(id, function(mydvrlist){
			  var dcode = mydvrlist[i].dvr_code;
			  
			   $.ajax({
		             type:"post",
		             url:"/pp/dvr/drop.do",
		             dataType:"text",
		             data:{dcode:dcode},
		                
		             success:function(data,textStatus){
		                  alert("삭제되셨습니다.");
		                  location.href="/pp/mem/myMain";
		                },
		                error:function(data,textStatus){
		                    alert("에러가 발생했습니다");
		                }
		            });
			 
		 })
		  
		 

		 
	 }
</script>

<!-- 결제정보 스크립트 -->
<script> 

 function myPmt(id){
  
  pmtService.getPmtById(id, function(mypmtlist) {
   
   if(mypmtlist==''){
    alert('결제정보가 없습니다 추가해주세요.'); 
    
      var strLi=""
       strLi+="<form id='pmtform'>" 
           +"<table class='table table-bordered'>" 
           + "<tr>" 
           + "<td>카드번호</td>"
           + "<td>"
           + "<select name='pmt_card' id='pmt_card'>"
           + "<option>카드종류</option>"
           + "<option value='국민카드' name='pmt_card' id='pmt_card'>국민카드</option>" 
           + "<option value='신한카드' name='pmt_card' id='pmt_card'>신한카드</option>"
           + "<option value='하나카드' name='pmt_card' id='pmt_card'>하나카드</option>" 
           + "</select>"
           + "</td>" 
           + "</tr>" 
           
           + "<tr>" 
           + "<td>카드번호</td>" 
           + "<td>"
           + "<input type='text' name='pmt_cnum' id='pmt_cnum'>"
           + "</td>" 
           + "</tr>" 
           
           + "<tr>"
           + "<td>결제자아이디</td>" 
           + "<td>"
           + "<input type='hidden' value='${memId}' name='mem_id'>"
           + '${memId}'
           + "<td>"
           + "</tr>" 
           + "</table>"
           
           + "<input type='hidden' value='N' name='pmt_type' id='pmt_type'>"
           + "<input type='checkbox' onChange='fn_checkVal2()'>"
           + "기본결제등록"
           + "<br>"
           + "</form>"
           + "<input type='button' value='등록하기' onClick='fn_addPmtInfo(this.form)'>"
           

           $("#emptyTable").html(strLi);
   }else{
            var strLi = "";
            var strBtn = "";
            for(var i=0; i<mypmtlist.length; i++){
             if(mypmtlist[i].pmt_type=="Y"){
              strLi +="<form>" 
               +"<label>기본결제수단</label>" 
             }
            strLi += "<table class='table table-bordered'>" 
              +"<tr>" 
              + "<td>카드종류</td>" 
              + "<td>"
              + mypmtlist[i].pmt_card 
              + "</td>" 
              + "</tr>" 
              
              + "<tr>" 
              + "<td>카드번호</td>"
              + "<td>"
              + mypmtlist[i].pmt_cnum 
              + "<td>" 
              + "</tr>" 
              
              + "<tr>"
              + "<td>결제자아이디</td>" 
              + "<td>" 
              + mypmtlist[i].mem_id 
              + "<td>"
              + "</tr>" 
              
              + "<tr>"
              + "<td>"
              + "<input type='button' value='수정하기' onClick='fn_modPmt("+i+")'>"
              + "<input type='button' value='삭제하기' onClick='fn_delPmt("+i+")'>"
              + "</td>"
              + "</tr>"
              
              + "</table>"
              + "</form>"
            }
          strBtn += "<input type='button' value='추가하기' onClick='fn_addPmt()'>"

          $("#emptyTable").html(strLi);
          $("#emptyTable").append(strBtn);
   }

  }, function() {
  })

 }

 
 function fn_addPmt(){
	 var strLi=""
	       strLi+="<form id='pmtform'>" 
	           +"<table class='table table-bordered'>" 
	           + "<tr>" 
	           + "<td>카드종류</td>"
	           + "<td>"
	           + "<select name='pmt_card' id='pmt_card'>"
	           + "<option>카드종류</option>"
	           + "<option value='국민카드' name='pmt_card' id='pmt_card'>국민카드</option>" 
	           + "<option value='신한카드' name='pmt_card' id='pmt_card'>신한카드</option>"
	           + "<option value='하나카드' name='pmt_card' id='pmt_card'>하나카드</option>" 
	           + "</select>"
	           + "</td>" 
	           + "</tr>" 
	           
	           + "<tr>" 
	           + "<td>카드번호</td>" 
	           + "<td>"
	           + "<input type='text' name='pmt_cnum' id='pmt_cnum'>"
	           + "</td>" 
	           + "</tr>" 
	           
	           + "<tr>"
	           + "<td>결제자아이디</td>" 
	           + "<td>"
	           + "<input type='hidden' value='${memId}' name='mem_id'>"
	           + '${memId}'
	           + "<td>"
	           + "</tr>" 
	           + "</table>"
	           
	           + "<input type='hidden' value='N' name='pmt_type' id='pmt_type'>"
	           + "<input type='checkbox' onChange='fn_checkVal2()'>"
	           + "기본결제등록"
	           + "<br>"
	           + "</form>"
	           + "<input type='button' value='등록하기' onClick='fn_addPmtInfo(this.form)'>"
	           

	           $("#emptyTable").html(strLi);           
 }
 
 function fn_modPmt(i){
  var id = '${memId}';
   pmtService.getPmtById(id, function(mypmtlist){
  var strLi=""
     strLi+="<form id='modpmt'>"
         +"<table class='table table-bordered'>" 
         + "<input type='hidden' name='pay_code' value='"+mypmtlist[i].pay_code+"'>"
         + "<tr>" 
         + "<td>카드종류</td>" 
         + "<td>"
         + "<select name='pmt_card' id='pmt_card'>"
         + "<option value='"+mypmtlist[i].pmt_card+"' name='pmt_card' id='pmt_card'>"
         + mypmtlist[i].pmt_card
         + "</option>"
         + "<option value='국민카드' name='pmt_card' id='pmt_card'>국민카드</option>" 
         + "<option value='신한카드' name='pmt_card' id='pmt_card'>신한카드</option>"
         + "<option value='하나카드' name='pmt_card' id='pmt_card'>하나카드</option>"          
         + "</select>"
         + "<td>" 
         + "</tr>" 
         
         + "<tr>"
         + "<td>카드번호</td>" 
         + "<td>"
         + "<input type='text' name='pmt_cnum' value='"+mypmtlist[i].pmt_cnum+"'>"
         + "<td>"
         + "</tr>"
         
         + "<tr>"
         + "<td>결제자아이디</td>" 
         + "<td>"
         + "<input type='text' name='mem_id' value='"+mypmtlist[i].mem_id+"'>"
         + "<td>"
         + "</tr>"
         + "</table>"
         
         +"<input type='hidden' value='N' name='pmt_type' id='pmt_type'>"
         + "<input type='checkbox' onChange='fn_checkVal2()'>"
         +"기본결제로 등록"
         +"<br>"
         + "</form>"
         + "<input type='button' value='수정하기' onClick='fn_modPmtInfo()'>"
         

         $("#emptyTable").html(strLi);
 })
 }
 
 function fn_modPmtInfo(){
    var form = $("#modpmt")[0];
     var formData = new FormData(form)
     
     $.ajax({
        type : 'post',
        url : '/pp/pmt/modify.do',
        data : formData,
        processData:false,
        contentType:false,
        cache:false,
        timeout:600000,
        
        success : function(data) {
          alert('성공');
         location.href="/pp/mem/myMain";
        },
        error : function(data) {
         alert('실패');
        }
       });
 }
 
 function fn_checkVal2(){
     var dck = document.getElementById("pmt_type").value;

     if (dck == "Y") {
    	 alert(dck);
      document.getElementById("pmt_type").value = "N";
      alert(dck);
     } else {
    	 alert(dck);
      document.getElementById("pmt_type").value = "Y";
      alert(dck);
     }
 }  
 
 
  function fn_addPmtInfo(){
   var form = $("#pmtform")[0];
   var formData = new FormData(form)
   
   $.ajax({
      type : 'post',
      url : '/pp/pmt/register.do',
      data : formData,
      processData:false,
      contentType:false,
      cache:false,
      timeout:600000,
      
      success : function(data) {
        alert('성공');
        location.href="/pp/mem/myMain";
      },
      error : function(data) {
       alert('실패');
      }
     });
       }
  
  function fn_delPmt(i){
    var id = '${memId}';
   
    pmtService.getPmtById(id, function(mypmtlist){
     var pcode = mypmtlist[i].pay_code;
     
      $.ajax({
               type:"post",
               url:"/pp/pmt/drop.do",
               dataType:"text",
               data:{pcode:pcode},
                  
               success:function(data,textStatus){
                    alert("삭제되셨습니다.");
                    location.href="/pp/mem/myMain";
                  },
                  error:function(data,textStatus){
                      alert("에러가 발생했습니다");
                  }
              });
    
   })
    
   

   
  }
</script>


<!-- QnA List 함수 -->
<script>
function myQnAList(id){
	brdService.getAllMyQnAList(id, function(list){
		if(list.length==0){
			alert('등록된 글이 없습니다.');
			return;
		}
		var str=
			"<table id='tableMyQnAList'>"
			+ "<tr>"
			+ "  <td>제목</td>"
			+ "  <td>등록일</td>"
			+ "</tr>";
		for(i=0;i<list.length;i++){
			str+=
			  "<tr>"
			 +"  <td>"
			 +"    <a href='#' class='QNA-detail'>"
			 +       list[i].title
			 +"    </a>"
			 +"    <input type='hidden' value='"+list[i].atc_no+"' />"
			 +"  </td>"
			 +"  <td>"+brdService.showLastModTime(list[i].regDate)+"</td>"
			 +"</tr>";
		}
		str+=
			+"</table>";
		$("#emptyTable").html(str);	
		$(".QNA-detail").on('click', function(e){
			e.preventDefault();
			getQnAArticle($(this).next().val());
		});
	});
}

/* 게시글 상세보기 */
function getQnAArticle(atc_no) {
brdService.getArticleView(atc_no,function(data) {
	var str = 
		"<table id='tableQnAViewDetail'>" 
	+ "  <tr>"
	+ "    <td class='td static-article-view'><label>제목</label></td>"
	+ "    <td class='td fluid-article-view'>"
	+ data.title
	+ "    </td>"
	+ "  </tr>"
	+ "  <tr>"
	+ "    <td class='td static-article-view'><label>등록일</label></td>"
	+ "    <td class='td fluid-article-view'>"
	+ brdService.showLastModTime(data.regDate)
	+ "    </td>"
	+ "  </tr>"
	+ "  <tr>"
	+ "    <td class='td static-article-view'><label>내용</label></td>"
	+ "    <td class='td fluid-article-view'>"
	+ "		  <textarea rows='18' cols='70px' disabled>"+data.txt_content+"</textarea>"
	+ "    </td>"
	+ "  </tr>"
	+ "</table>"
	+	"<div id='divQnAComments'>"
	+	"<br>"
	+ "<table id='tableQnAComments'></table>"
	+ "<br><br><br>"
	+ "</div>";
	if($("#tableQnAViewDetail")){
		$("#tableQnAViewDetail").remove();
		$("#divQnAComments").remove();
	}
	if(str!=''){
		$("#tableMyQnAList").prepend(str);
	}
	
	showAllQnAComments(atc_no);
});
}

function showAllQnAComments(atcNO){
	var json={atc_no:atcNO,page:1};
	brdService.getAllCommentsWithPaging(json,function(comments){
		if (comments==0){
			return;  //객체 못가져오면 리턴
		}
		var str = "";
		for (var i=0; i<comments.length; i++) {
			str+=
			  "<tr>"
			+ "  <td><textarea disabled>"+comments[i].txt_content+"</textarea></td>"
			+ "</tr>";
		}
		$("#tableQnAComments").append(str);
	});
}
</script>

<!-- 모달 관련 스크립트 -->
<script>
/* 수정창 모달 */
$("#btnModSubscription").on("click", function() {
 $("#modalModSubs").modal("show");
});
$("#btnModModalExit").on("click", function() {
 $("#modalModSubs").modal('hide');
});
/* 수정창 모달 종료 */

/* 모달 내 등급변경/연장하기 버튼 클릭 시 처리 */
$("#btnProlong").on("click", function() {
 $("input:radio[name='subs_grade']:checked").prop("checked", false);
 $(".prolongDiv").show();
 $("#btnGrade").show();
 $(".gradeDiv").hide();
 $("#btnProlong").hide();
});
$("#btnGrade").on("click", function() {
 $("input:radio[name='subs_grade']:radio[value='SILVER']").prop("checked", true);
 $("select").find('option:first').attr('selected', 'selected');
 $(".gradeDiv").show();
 $("#btnProlong").show();
 $(".prolongDiv").hide();
 $("#btnGrade").hide();
});
/* 모달 내 등급변경/연장하기 버튼 클릭 시 처리 종료 */

/* 구독 정보 수정하기 비동기처리 부분 */
$("#btnSubmit").on("click", function() {
 var id = '${memId}';
 var scode = $("#scode").val();
 var modalInputSubsGrade = $("input:radio[name='subs_grade']:checked").val();
 var modalInputMonths = $("#month option:selected").val();
 
 if(modalInputSubsGrade==null || modalInputSubsGrade==''){
  modalInputSubsGrade = 'none';
  alert(modalInputSubsGrade);
 }
 
 var subs = 
  { mem_id : id,
   subs_code : scode,
   grade : modalInputSubsGrade, 
   months : modalInputMonths };
 
 subsService.modSubsInfo(subs, function(msg){
  if (msg == 'successModify') {
   alert('구독이 정상적으로 변경되었습니다.');
   $("#modalModSubs").modal("hide");
   showSubsHistory(id);
  }
 })
});
/* 구독 정보 수정하기 비동기처리 부분 종료 */
 $("#btnNewSubscription").on("click", function() {
  var id = '${memId}';
  delService.getDvrById(id, function(mydvrlist){
   var address = JSON.stringify(mydvrlist[0].address);
   var detail = JSON.stringify(mydvrlist[0].addr_detail);
   alert(address);
   alert(detail);
   $("#dvrInfo").val(address);
   $("#dvrDetail").val(detail);
   pmtService.getPmtById(id, function(mypmtlist){
    var card = JSON.stringify(mypmtlist[0].pmt_card);
    var cnum = JSON.stringify(mypmtlist[0].pmt_cnum);
    alert(card);
    alert(cnum);
    $("#pmtCard").val(card);
    $("#pmtCnum").val(cnum);
   });
   /*  $("#modalNewSubsForm").modal("show");  */
  });
 });


/*   $("#btnNewSubscription").on("click", function() {
   $("#modalNewSubsForm").modal("show");
 }); */
 $("#btnSModalExit").on("click", function() {
  $("#modalNewSubsForm").modal('hide');
 }); 
 
 $("#newSubscription").on("click", function() {
  var modalInputClientId = $(".modal").find("input[id='id']");
   var modalInputSubsGrade = $("input:radio[name='subs_grade']:checked").val();
   var modalInputMonths = $("#nMonth option:selected");
  var subs = 
   { mem_id:modalInputClientId.val(),
    grade:modalInputSubsGrade, 
    months:modalInputMonths.val() };
  alert(JSON.stringify(subs));
  subsService.newSubscription(
   subs, 
   function(resultMsg) {
    if (resultMsg == 'successRegister') {
     alert('구독을 환영합니다.');
     $("#modalNewSubsForm").modal('hide');
     var id = '${memId}';
     showSubsHistory(id);
    }
   });
 });
 
 $("#btnCancelSubs").on("click", function() {
   $("#modalCancelSubs").modal("show");
  });
  $("#btnCModalExit").on("click", function() {
   $("#modalCancelSubs").modal('hide');
  });
  $("#btnCModalDelSubs").on("click", function() {
   var id = '${memId}';
   var scode = $("#scode").val();
   var json = {mem_id:id, subs_code:scode};
   subsService.cancelSubs(json, function(resultMsg) {
    if (resultMsg == 'successCancel') {
     alert('구독이 정상적으로 취소되었습니다.');
     $("#modalCancelSubs").modal("hide");
     var id = '${memId}';
     showSubsHistory(id);
    }
   })
  });
 </script>
