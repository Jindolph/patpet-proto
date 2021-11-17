/*배송 모듈 클로져 정의*/

var delService = (function() {

	function getDvrById(id, callback, error) {

		$.ajax({
			type : 'post',
			url : '/pp/dvr/dvrInfo2.do',

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

	return {
		getDvrById : getDvrById
	};

})();