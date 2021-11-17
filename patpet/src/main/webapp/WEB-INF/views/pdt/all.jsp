<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
	request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
<meta charset="UTF-8">
<title>상품 정보 출력창</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.13.0/js/all.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/pp/resources/js/closure/my-pdt.js"></script>
<script type="text/javascript" src="/pp/resources/js/closure/my-file.js"></script>

<script type="text/javascript">
function showAllProducts(pdtType){
	var content = "PDT";
	productService.getAllProducts(
		pdtType,
		function(products){
			var strLi = "";
			if(products == null || products.length == 0)
				return;
			for (var i = 0, listLen = products.length; i < listLen; i++) {
				strLi += "<li class='left clearfix'>"
					    + "    <div>"
					    + "        <div class='header'>"
					    + "            <img src='/pp/file/thumbnail/"+content+"/"+products[i].pdt_code+".json' width='100px' height='100px'>"
					 	 	+ "            <small class='text-muted' style='padding-left:10px;'>상품번호: </small>"
					 	 	+ "            <small class='text-muted'>"
					 	 	+                  products[i].pdt_code
					 	 	+ "            </small>"
					 	 	+ "            <small class='text-muted' style='padding-left:10px;'>종류: </small>"
					 	 	+ "            <small class='text-muted'>"
					 	 	+                  products[i].pdt_type
					  	+ "            </small>"
					  	+ "            <small class='text-muted' style='padding-left:10px;'>이름: </small>"
					  	+ "            <small class='text-muted'>"
					  	+                  products[i].pdt_name
					  	+ "            </small>"
					  	+ "            <small class='text-muted' style='padding-left:10px;'>등록일자: </small>"
					  	+ "            <small class='text-muted'>"
					  	+                  productService.showLastModTime(products[i].regDate)
					  	+ "            </small>"
					  	+ "        </div>"
					  	+ "    </div>"
					  	+ "</li><hr>";
			}
			$(".showGiftsUL").html(strLi);
		})
}
</script>
</head>
<body>
<button id="btnSubsProducts" class='btn btn-primary'>구독상품</button>
<button id="btnRandomProducts" class='btn btn-primary'>랜덤박스</button>
	
<ul class="showGiftsUL" style="list-style: none; padding-left: 0px;"></ul>

<script type="text/javascript">
$("#btnSubsProducts").on('click',function () {
	var pdtType = 'SUBS_PDT';
	showAllProducts(pdtType);
});
$("#btnRandomProducts").on('click',function () {
	var pdtType = 'RD_PDT';
	showAllProducts(pdtType);
});
</script>

<button id="btnNewPdt" class='btn btn-primary'>상품등록</button>

<script>
$("#btnNewPdt").on('click',function(){
	location.href="/pp/pdt/new";
});
</script>

</body>
</html>