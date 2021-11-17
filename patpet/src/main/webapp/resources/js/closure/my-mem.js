/*멤버 모듈 클로져 정의*/

var memService = (function() {

	function getmemInfo(id, callback, error) {

		$.ajax({
			type : 'post',
			url : '/pp/mem/getmyinfo.do',
			data : {
				id : id
			},

			success : function(data, status, xhr) {
				if (callback) {
					callback(data);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}
	
	function showLastModTime(timeValue) {
		//JSON 날짜시간을 그대로 표시하면 1594169682000 이렇게 표시됩니다.
		var dateObj = new Date(timeValue);//전달된 수정날짜시간값 저장

		var str ="";
		
		var yy = dateObj.getFullYear(); //YYYY
		var mm = dateObj.getMonth() + 1; // getMonth() is zero-based
		var dd = dateObj.getDate();

		var hh = dateObj.getHours();
		var mi = dateObj.getMinutes();
		var ss = dateObj.getSeconds();
		
		str= [yy, '/', 
			 (mm > 9 ? '' : '0') + mm, '/',
			 (dd > 9 ? '' : '0') + dd].join('');
			 /*(hh > 9 ? '' : '0') + hh, ':', 
			 (mi > 9 ? '' : '0') + mi,	':', 
			 (ss > 9 ? '' : '0') + ss].join('');*/ //배열값으로 하나의 문자열로 합침
		console.log(str);
		return str ;
		
	}

	return {
		getmemInfo : getmemInfo,
		showLastModTime : showLastModTime
	};

})();