<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@include file="../include/header.jsp"%>
	<div class="row" style="height: 800px;">
		<div style=" margin-top:250px;">
			<div style="text-align:center;">
				<span>아이디/비밀번호 찾기  </span>
				<div>
					<button class="btn btn-default" style="display: inline;" onClick="fn_findId()">아이디찾기</button>
					<button class="btn btn-default" style="display: inline;" onClick="fn_findPw()">비밀번호찾기</button>
				</div>
    <div style="margin-left:850px;">
				<form class="form-group">
					
					<div style="display: none;" id="findId">
						
						<div data-validate="Enter username">
							<input class="form-control" type="text" name="mem_name" placeholder="이름" id="mem_name"/> 
						</div>

						<div data-validate="Enter password">
							<input class="form-control" type="date" name="생년월일" id="birthdate"/> 
						</div>

						<div>
							<input class="form-control" type="button" value="찾기" class="login100-form-btn"
								onClick="fn_findMyId(this.form)">
						</div>
						
					</div>
					
				</form>
    </div>

    <div style="margin-left:850px;">
				<form class="form-group">
				
					<div style="display: none;" id="findPw">
					
						<div>
							<input class="form-control" type="text" name="mem_id" placeholder="아이디(이메일)" id="mem_id">
						</div>

      <div>
       <input class="form-control" type="text" name="mem_name" placeholder="이름" id="pw_name"> 
      </div>						

      <div>
       <input class="form-control" type="date" name="birthdate" id="pwbirthdate"> 
      </div>
      
						<div >
							<input class="form-control" type="button" value="찾기" onClick="fn_findMyPw(this.form)">
						</div>

					</div>
				</form>
    </div>

			</div>
		</div>
	</div>

 
	<script>

		function fn_findId() {
			$('#findId').css('display', "table-cell");
			$('#findPw').css('display', "none");
		}

		function fn_findPw() {
			$('#findId').css('display', "none");
			$('#findPw').css('display', "table-cell");
		}

		function fn_findMyId(obj) {
			var _name = document.getElementById("mem_name").value;
			var _date = document.getElementById("birthdate").value;

			$.ajax({
				url : "${contextPath}/mem/findid",
				type : "post",
				data : {
					name : _name,
					date : _date
				},
				dataType : "text",

				success : function(data) {
					if (data != null && data!="") {
						alert('회원님의 아이디는'+data+'입니다' );
					} else {
						alert('존재하지 않는 회원입니다.');
					}
				},
				error : function(data) {
				 alert('error');
				},
			});
		}
		
		 function fn_findMyPw(obj) {

			   var _id = document.getElementById("mem_id").value;
			   var _name = document.getElementById("pw_name").value;
			   var _date = document.getElementById("pwbirthdate").value;
      
			   
			   $.ajax({
			    url : "${contextPath}/mem/findpw",
			    type : "post",
			    data : {
			     name : _name,
			     id : _id,
			     date : _date
			    },
			    dataType : "text",

			    success : function(data) {
			     if (data != null && data!="") {
			      alert('회원님의 비밀번호는'+data+'입니다' );
			     } else {
			      alert('존재하지 않는 회원입니다.');
			     }
			    },
			    error : function(data) {
			     alert('error');
			    },
			   });
			  }

	</script>
<%@include file="../include/footer.jsp"%>