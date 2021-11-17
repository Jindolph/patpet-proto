<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@include file="include/header.jsp"%>
<div class="mainImg">
<!-- <div style="text-align:center; background-image:url(main2.jpg);">
<input type="email" style="width:40%; font-size:30px;">
<button style="font-size:30px; background-color:black; color:white;">구독하러가기></button>
</div> -->
<img src="${contextPath}/resources/img/main2.jpg" width="100%" height="80%"> 
</div>
<%@include file="include/footer.jsp"%>
