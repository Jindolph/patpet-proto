<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%
	request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
<meta charset="UTF-8">
<title>선물 사용</title>
<script type="text/javascript" src="/pp/resources/js/closure/my-gift2.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
function showAllGifts(){
	giftService.getAllGifts(
		function(gifts){
			var strLi = "";
			if(gifts == null || gifts.length == 0){
				return; //리스트가 없으면, 함수 종료
			}
			for (var i = 0, listLen = gifts.length; i < listLen; i++) {
				strLi += "<li class='left clearfix'>"
					    + "    <div>"
						  + "        <div class='header'>"
					 	 	+ "            <small class='text-muted' style='padding-left:10px;'>기프트코드: </small>"
					 	 	+ "            <small class='text-muted'>"
					 	 	+                  gifts[i].gift_code
					 	 	+ "            </small>"
					 	 	+ "            <small class='text-muted' style='padding-left:10px;'>소유자: </small>"
					 	 	+ "            <small class='text-muted'>"
					 	 	+                  gifts[i].owner_id
					  	+ "            </small>"
					  	+ "            <small class='text-muted' style='padding-left:10px;'>종류: </small>"
					  	+ "            <small class='text-muted'>"
					  	+                  gifts[i].gift_type
					  	+ "            </small>"
					  	+ "            <small class='text-muted' style='padding-left:10px;'>값(코드/개월수): </small>"
					  	+ "            <small class='text-muted'>"
					  	+                  gifts[i].gift_value
					  	+ "            </small>"
					  	+ "            <small class='text-muted' style='padding-left:10px;'>사용여부: </small>"
					  	+ "            <small class='text-muted'>"
					  	+                  gifts[i].is_opened
					  	+ "            </small>"
					  	+ "            <small class='text-muted' style='padding-left:10px;'>생성일자: </small>"
					  	+ "            <small class='text-muted'>"
					  	+                  giftService.showLastModTime(gifts[i].regDate)
					  	+ "            </small>"
					  	+ "            <small class='text-muted'>"
							+ "							<button id='btnUseGift' type='button'>사용</button>"
							+ "            </small>"
					  	+ "        </div>"
					  	+ "    </div>"
					  	+ "    <input type='hidden' value='"+gifts[i].gift_code+"'/>"
					  	+ "</li><hr>";
			}
			$(".showGiftsUL").html(strLi);
		})
}
</script>
</head>
<body>
	<ul class="showGiftsUL" style="list-style: none; padding-left: 0px;"></ul>
	
<script type="text/javascript">
$(document).ready(function () {
	showAllGifts();
});

$("#btnUseGift").on("click", function(e) {
	var li = $(this).closest("li");
	var giftCode = li.find("input").val();
	
	giftService.useGift(
		giftCode,
		function() {
			alert('gift used!');
			location.href = "/pp/gift/my"
		})//uploadNewFileUsingUtils 콜백함수 종료.
});
</script>
</body>
</html>