<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
	request.setCharacterEncoding("UTF-8");
%>
   <div class="cols col-lg-1">
    <div class="panel panel-default content-section-panel-side" style="float:center;">
     <div class="panel-heading">마이페이지</div>
      <div class="panel-body">
    
       <h4 style="color:black">회원정보<br></h4>
        <a href="#" id="myInfo">회원정보관리</a><br>
        <a href="#" id="myGuestBook">내 방명록</a><br>
        <a href="#" id="myPdt">선물함</a><br>
        <a href="#" id="dropMyInfo">회원탈퇴</a><br>
     
       <h4 style="color:black">구독정보<br></h4>
        <a href="#" id="mySubsInfo">구독관리 </a><br>
     
       <h4 style="color:black">배송지정보<br></h4>
        <a href="#" id="myDvr">배송지관리</a><br>
     
       <h4 style="color:black">거래정보<br></h4>
        <a href="#" id="myPmt">결제정보관리</a><br>
     
       <h4 style="color:black">문의정보<br></h4>
        <a href="#" id="myQnA">내 문의내역</a><br>
     </div>
    </div>
   </div>