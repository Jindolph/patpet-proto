<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@include file="../include/header.jsp"%>
 <div class="row" style="height: 800px;">
<div style="margin-left:750px; margin-top:150px;">
<h2 class="title">회원가입</h2>
<form class="form-group">
	<div>
		<input class="form-control" style="width:20%; display:inline;" type="email" placeholder="아이디(이메일형식)" id="id"> <input class="form-control"
			type="hidden" name="mem_id" id="mem_id">
		<button class="btn btn-default" type="button" style="width:20% display:inline;" class="btn btn-outline-danger"
			id="btnOverlapped" onClick="fn_checkIdFormat()">중복확인</button>
		<input class="form-control" type="hidden" id="isIdChecked" value="false" />
	 <br><br>
	</div>
	
	<div>
		<input class="form-control" style="width:20%; display:inline;" type="password" placeholder="비밀번호" name="mem_pw" id="pw"
			onchange="fn_pwCheck(this)"> <span
			style="display: inline" id="pw_alert">특수문자 / 문자 / 숫자 포함
			형태의 8~15자리 이내의 암호 정규식</span> <span style="display: none; color: #d92742;"
			id="pw_check">비밀번호 조건을 지켜주세요</span>
	</div>
	
	<div>
		<input class="form-control" style="width:20%; display:inline;" type="password" placeholder="비밀번호확인" name="_mem_pw" id="pwchk"
			onkeyup="ppd();"> <span
			style="display: none; color: #d92742;" id="textWarning">비밀번호가
			일치하지 않습니다</span>
	</div>
	
	<div>
	<br><br>
		<input class="form-control" style="width:20%; display:inline;" type="text" placeholder="이름" name="mem_name" id="name">
	</div>
	
	<div>
	<br><br>
		<input class="form-control" style="width:20%; display:inline;"  type="text" placeholder="생년월일" name="_birthday" disabled>
		<input class="form-control" style="width:20%;" type="date" name="birthdate" id="birthdate"> <i
			class="zmdi zmdi-calendar-note input-icon js-btn-calendar"></i>
	</div>
	
	<div>
	<br><br>
		<input class="form-control" style="width:15%; display:inline;" type="text" placeholder="이메일수신여부" disabled> <input type="hidden" name="email_yn" value="Y" id="email_yn" > 
		<input class="form-control" style="width:2%; font-size:5px; display:inline;" type="checkbox" name="email_chk" id="email_chk"
			onchange="fn_valCheck()" checked>
	</div>
	
	<div>
	<br>
		<input class="btn btn-default" type="button" onClick="signupFormValidator(this.form)"
			value="가입하기" />
	</div>
</form>
</div>
</div>
<script>
	function fn_checkIdFormat() {
		var _id = $("#id").val();
		var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		if (_id == '') {
			alert("ID를 입력하세요");
			return;
		} else if (_id.match(regExp) == null) {
			alert("이메일 주소 형식으로 입력해주세요.");
			return;
		} else {
			$.ajax({
				type : "post",
				async : false,
				url : "${contextPath}/mem/overlapped.do",
				dataType : "text",
				data : {
					id : _id
				},

				success : function(data) {
					if (data == 'false') {
						alert("사용할 수 있는 ID입니다.");
						$('#btnOverlapped').prop("disabled", true);
						$('#id').prop("disabled", true);
						$('#mem_id').val(_id);
						$('#isIdChecked').val('true');
					} else {
						alert("사용할 수 없는 ID입니다.");
					}
				},
				error : function(data) {
					alert("에러가 발생했습니다.");
					ㅣ
				},
				complete : function(data) {
				}
			});
		}
	}

	function fn_valCheck() {
		var eck = document.getElementById("email_yn").value;

		if (eck == 'Y') {
			document.getElementById("email_yn").value = "N";
			eck.innerHTML = "N";
		} else {
			document.getElementById("email_yn").value = 'Y';
			eck.innerHTML = "Y";
		}
	}

	function fn_pwCheck(pwd) {

		var regex = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
		/* var password = $("#password").val(); */
		if (pwd.value.match(regex) == null) {
			$("#pw_check").css('display', "inline");
			$("#pw_alert").css('display', "none");
		} else {
			$("#pw_check").css('display', "none");
			$("#pw_alert").css('display', "inline");
		}
	}

	function ppd() {
		var password = $("#pw").val();
		var confirm_password = $("#pwchk").val();

		if (password != confirm_password) {
			$("#textWarning").css('display', "inline");
		} else {
			$("#textWarning").css('display', "none");
		}
	}

	function signupFormValidator(obj) {
		var idChecker = document.getElementById("isIdChecked").value;
		var _pw = document.getElementById("pw").value;
		var _pw = document.getElementById("pwchk").value;
		var _name = document.getElementById("name").value;
		var _birthDate = document.getElementById("birthdate").value;

		if (idChecker != 'true') {
			alert('아이디 중복확인은 필수입니다.');
			return;
		} else if (_pw == '') {
			alert('비밀번호는 필수입니다.');
			return;
		} else if (_name == '') {
			alert('이름은 필수입니다.');
			return;
		} else if (_birthDate == '') {
			alert('생년월일은 필수입니다.');
			return;
		}

		obj.method = "post";
		obj.action = "${contextPath}/mem/register";
		obj.submit();
	}
</script>
<%@include file="../include/footer.jsp"%>