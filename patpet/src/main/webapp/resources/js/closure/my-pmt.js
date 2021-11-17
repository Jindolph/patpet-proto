/*결제 모듈 클로져 정의*/

var pmtService = (function() {

	function getPmtById(id, callback, error) {

		$.ajax({
			type : 'post',
			url : '/pp/pmt/pmtInfo.do',

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
		getPmtById : getPmtById
	};

})();