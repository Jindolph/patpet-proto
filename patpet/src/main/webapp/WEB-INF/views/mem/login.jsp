<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@include file="../include/header.jsp"%>

	<div class="row" style="height: 800px;">
		<div style="margin-left:800px; margin-top:250px;">
				<form class="form-group">
					<span> 로그인/회원가입 </span>

					<div>
						<input class="form-control"id="_id" type="text" name="mem_id" placeholder="아이디(이메일)" style="width:30%"> 
					</div>
					
					<div>
						<input class="form-control" id="_pw" type="password" name="mem_pw" placeholder="비밀번호" style="width:30%"> 
					</div>

					<div>
						<button class="btn btn-default" onClick="fn_login(this.form)">
							로그인
						</button>
					</div>

					<div> 
						 <a href="${contextPath}/mem/find">
							아이디/비밀번호 찾기 
							</a>
					</div>

					<div>
						<a href="${contextPath}/mem/signup">
						 회원가입
						</a>
					</div>
				</form>
		</div>
	</div>

	<script>

		  function fn_login(obj) {
			   var _id = document.getElementById("_id").value;
			   var _pw = document.getElementById("_pw").value;
			   var emailRule = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

			   if (_id == '') {
			    alert("ID를 입력하세요");
			    return;
			   } else if (_id.match(emailRule) == null) {
			    alert("이메일 형식으로 입력해주세요.");
			    return;
			   } else if (_pw == '') {
			    alert("비밀번호를 입력하세요");
			    return;
			   }

			   obj.action = "${contextPath}/mem/login.do";
			   obj.method = "post";
			   obj.submit();
			  }

			  $(function() {
			   $("#signupBtn").click(function() {
			    $("#signupModal").modal("show");
			   });

			   $("#close_modal").click(function() {
			    $("#signupModal").modal("hide");
			   });
			  });
	</script>
<%@include file="../include/footer.jsp"%>