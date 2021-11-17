<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<script type="text/javascript" src="${contextPath}/resources/js/closure/my-brd6.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/closure/my-del.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/closure/my-file.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/closure/my-gift3.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/closure/my-mem.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/closure/my-pdt.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/closure/my-pmt.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/closure/my-subs3.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/closure/my-qna.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.13.0/js/all.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="${contextPath}/resources/css/style.css" />
</head>

<body>
	<div class="row" style="height: 10%">
		<nav class="navbar navbar-default">
			<div class="container-fluid" style="background-color:black;">
				<!-- 메뉴에서 가장 왼쪽, 모바일에서 표시되는 제목 -->
				<div class="navbar-header">
					<!-- 메뉴의 홈페이지 이름 -->
					<a class="navbar-brand" href="/pp" style="color:white;">Pat Pet</a>
				</div>
				<div class="collapse navbar-collapse"
					id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav">
						<li><a href="${contextPath}/board/layout" style="color:white;">게시판
								<span class="sr-only"></span>
						</a></li>
						
						<li><a href="${contextPath}/board1/qna" style="color:white;">고객센터</a></li>
						<!-- <li class="active"><a href="#">상품 <span class="sr-only"></span></a></li> -->
					</ul>
					<!-- 오른쪽 정렬 -->
					<ul class="nav navbar-nav navbar-right">
						<c:choose>
							<c:when test="${isLogOn==true}">
								<li><a
									href="${contextPath}/mem/myMain" style="color:white;">마이페이지</a></li>
								<li><a href="${contextPath}/mem/logout.do" style="color:white;">로그아웃</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="${contextPath}/mem/login" style="color:white;">로그인</a></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
			</div>
		</nav>
	</div>