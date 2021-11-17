var productService = (function() {
	function getAllProducts(pdtType, callback, error) {
		$.getJSON("/pp/pdt/list/"+pdtType, function(data) {
			if (callback) {
				callback(data);
			}
		});
	}
	function getProductDetailInfo(code, callback) {
		$.get("/pp/pdt/"+code, function(data) {
			if (callback) {
				callback(data);
			}
		});
	}
	function addNewProduct(product, callback, error){
		$.ajax({
			type: 'POST',
			url: '/pp/pdt/new/'+product.pdt_type,
			data: JSON.stringify(product), 
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}
			}
		});
	}
	function modProductInfo(product, callback, error){
		$.ajax({
			type: 'PUT',
			url: '/pp/pdt/'+product.pdt_code,
			data: JSON.stringify(product), 
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}
			}
		});
	}
	function deleteProduct(code, callback, error){
		$.ajax({
			type: 'DELETE',
			url: '/pp/pdt/'+code,
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}
			}
		});
	}
	function showLastModTime(timeValue) {
		var dateObj = new Date(timeValue);
		var str = "";
		var yy = dateObj.getFullYear();
		var mm = dateObj.getMonth() + 1;
		var dd = dateObj.getDate();

		str = [ yy, '/', (mm > 9 ? '' : '0') + mm, '/',
				(dd > 9 ? '' : '0') + dd ].join('');
		return str;
	}
	return {
		getAllProducts:getAllProducts,
		getProductDetailInfo:getProductDetailInfo,
		addNewProduct:addNewProduct,
		modProductInfo:modProductInfo,
		deleteProduct:deleteProduct,
		showLastModTime:showLastModTime
	};
})();