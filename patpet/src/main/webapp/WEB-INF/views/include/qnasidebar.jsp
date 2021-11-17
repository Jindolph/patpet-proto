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
     <div class="panel-heading">고객센터</div>
     <div class="panel-body">
      <a id="noticeBrd">공지사항</a><br><br>
      <a id="qnaBrd">QnA</a><br><br>
     </div>
    </div>
   </div>