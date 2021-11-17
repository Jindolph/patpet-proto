<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
 request.setCharacterEncoding("UTF-8");
%>
<h1>"${memId}"님 환영합니다.</h1>
 <!-- 검색폼 시작 -->
 <div align="right">
  <form role="form" method="get" style="margin: auto;">
  
   <select name="searchType">
   
    <option value="n"<c:out value="${pagingDTO.searchType == null ? 'selected' : ''}"/>>-----</option>
   
    <option value="t"<c:out value="${pagingDTO.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
    
    <option value="w"<c:out value="${pagingDTO.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
    
    <option value="tc"<c:out value="${pagingDTO.searchType eq 'tc' ? 'selected' : ''}"/>>제목+작성자</option>
  
   </select>
   <input type="text" name="keyword" id="keywordInput" value="${pagingDTO.keyword}" />
   
   <button id="searchBtn" type="submit" onclick="search(this.form)">검색</button>
  </form>
  <script>
  $(function search(obj){
         $('#searchBtn').click(function() {
           self.location = "redirect:user" + '${PagingCreatorDTO.addPagingParamsToURI(1)}' + "&searchType=" + $("select option:selected").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val());
         });
       });
  </script>
 <script>
 function fn_loginChk(){
	 alert('로그인해주세요');
 }
 </script>
  
 </div>
 <!-- 검색 종료 -->

 <table style="margin: auto;">
  <tr align="center" bgcolor="lightpink">
   <td width="10%"><b>글번호</b></td>
   <td width="35%"><b>제목</b></td>
   <td width="25%"><b>작성자ID</b></td>
   <td width="15%"><b>등록일</b></td>
   <td width="10%"><b>조회수</b></td>
   <td width="5%"><b>좋아요</b></td>
  </tr>
  
  <c:choose>
   <c:when test="${boardsList==null}">
    <tr height="10">
     <td colspan="6">
      <p align="center">
       <b><span style="font-size: 9pt;">등록된 글이 없습니다.</span></b>
      </p>
     </td>
    </tr>
   </c:when>
  
  <c:when test="${boardsList!=null}">
   <c:forEach var="obj" items="${boardsList}">
    <tr align="center">
     <td>${obj.atc_no}</td>
     
     <c:choose>
     <c:when test="${isLogOn==true}">
     <td><a href="${contextPath}/brd/view?atc_no=${obj.atc_no}">${obj.title}</a></td>
     </c:when>
     <c:when test="${isLogOn!=false}">
     <td><a href="javascript:fn_loginChk();">${obj.title}</a></td>
     </c:when>
     </c:choose>
 
     <td>${obj.writer}</td>
     <td><fmt:formatDate value="${obj.regDate}" pattern="yyyy-MM-dd" /></td>
     <td>${obj.hits}</td>
     <td>${obj.hearts}</td>
    </tr>
   </c:forEach>
  </c:when>
  
 </c:choose>
 </table>
 
 <!-- 페이징 시작 -->
 <div style="margin:auto; text-align:center;">
  <c:if test="${pagingCreatorDTO.isPrev}">
    <a href="/pp/brd/user${pagingCreatorDTO.addPagingParamsToURI(pagingCreatorDTO.startPageNoOfGroup - 1) }">«이전</a>
  </c:if>
  <c:forEach begin="${pagingCreatorDTO.startPageNoOfGroup}"
       end="${pagingCreatorDTO.endPageNoOfGroup}" var="pageNo">
   <c:out value="${pagingCreatorDTO.pagingDTO.currentPageNo == pageNo ? '' : '' }" />
   <a href="/pp/brd/user${pagingCreatorDTO.addPagingParamsToURI(pageNo)}">${pageNo}</a>
  </c:forEach>
  <c:if test="${pagingCreatorDTO.isNext && pagingCreatorDTO.endPageNoOfGroup > 0}">
   <a href="/pp/brd/user${pagingCreatorDTO.addPagingParamsToURI(pagingCreatorDTO.endPageNoOfGroup +1) }">다음»</a>
  </c:if>
 </div>
 <!-- 페이징 끝 -->
 
 <!-- 버튼 시작 -->
 <div align="center">
 <c:choose>
 <c:when test="${isLogOn==true}">
 <a href="${contextPath}/brd/postView">글쓰기</a>
 </c:when>
 <c:when test="${isLogOn!=true}">
  <a href="javascript:fn_loginChk();">글쓰기</a>
 </c:when>
 </c:choose>
 </div>
 <!-- 버튼 끝 -->
