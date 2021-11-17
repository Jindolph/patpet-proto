var giftService = (function() {
	function getAllGifts(callback, error) {
		$.getJSON("/pp/gift/all", function(data) {
			if (callback) {
				callback(data);
			}
		});
	}
	function showAllHavingGifts(id, callback) {
		$.get(
				"/pp/gift/"+id+".json", 
				function(data) {
					if (callback) {
						callback(data);
					}
				});
	}
	function newGiftToUser(vo, callback, error) {
		$.ajax({
			type:"POST",
			url:"/pp/gift/new",
			data:JSON.stringify(vo),
			contentType:"application/json; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		})
	}
	function useGift(code, callback, error) {
		$.ajax({
			type:"PATCH",
			url:"/pp/gift/"+code+".json",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		})
	}
	function deleteGift(code, callback, error) {
		$.ajax({
			type:"DELETE",
			url:"/pp/gift/"+code+".json",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		})
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
		getAllGifts:getAllGifts,
		showAllHavingGifts:showAllHavingGifts,
		newGiftToUser:newGiftToUser,
		useGift:useGift,
		deleteGift:deleteGift,
		showLastModTime:showLastModTime
	};
})();