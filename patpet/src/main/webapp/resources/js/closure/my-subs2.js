var subsService = (function() {
	function getSubsById(id, callback, error) {
		$.get("/pp/subs/" + id + ".json", function(data) {
			if (callback) {
				callback(data);
			}
		});
	}
	
	function getAllSubsById(id, callback, error) {
		$.getJSON("/pp/subs/all/" + id + ".json", function(data) {
			if (callback) {
				callback(data);
			}
		});
	}

	function modSubsInfo(model, callback, error) {
		$.ajax({
			type : 'PUT',
			url : '/pp/subs/' + model.subs_code,
			data : JSON.stringify(model),
			contentType : "application/json; charset=utf-8",
			success : function(updateResult, status, xhr) {
				if (callback) {
					callback(updateResult);
				}
			}
		});
	}
	
	function newSubscription(subs, callback, error){
		$.ajax({
			type: 'POST',
			url: '/pp/subs/new',
			data: JSON.stringify(subs), 
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
	    error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}

	function cancelSubs(json, callback) {
		$.ajax({
			type : 'PATCH',
			url : '/pp/subs/'+json.subs_code+'.json',
			data : json,
			dataType : "text",
			success : function(Result, status, xhr) {
				if (callback) {
					callback(Result);
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
		getAllSubsById : getAllSubsById,
		getSubsById : getSubsById,
		modSubsInfo : modSubsInfo,
		newSubscription : newSubscription,
		cancelSubs : cancelSubs,
		showLastModTime : showLastModTime
	};
})();
