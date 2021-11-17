<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
 request.setCharacterEncoding("UTF-8");
%>
   <div class="cols col-lg-1">
    <div class="panel panel-default content-section-panel-side">
     <div class="panel-heading">게시판</div>
     <div class="panel-body">
      <a id="userBrd">자유게시판</a><br><br>
      <a id="tradeBrd">교환게시판</a><br><br>
      <a id="noticeBrd">공지사항</a><br><br>
      <a id="#">상품</a><br><br>
     </div>
    </div>
   </div>