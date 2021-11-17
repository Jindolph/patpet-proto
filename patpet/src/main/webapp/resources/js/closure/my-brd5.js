var brdService = (function() {
	function getAllArticlesWithPaging(path, callback, error) {
		$.getJSON("/pp/board/all/"+path.type+"/"+path.page+".json", function(data) {
			if (callback) {
				callback(data);
			}
		});
	}
	function getAllMyQnAList(id, callback, error) {
		$.getJSON("/pp/board/all/QNA/"+id+".json",function(data) {
			if (callback) {
				callback(data);
			}
		});
	}
	function getArticleView(code, callback) {
		$.get("/pp/board/atc/"+code, function(data) {
			if (callback) {
				callback(data);
			}
		});
	}
	function getArticleView2(code, callback) {
		$.get("/pp/board/atc/BOOK/"+code+".json", function(data) {
			if (callback) {
				callback(data);
			}
		});
	}
	function writeNewArticle(article, callback, error){
		$.ajax({
			type: 'POST',
			url: '/pp/board/atc/new',
			data: JSON.stringify(article), 
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}
			}
		});
	}
	function modArticle(article, callback, error){
		$.ajax({
			type: 'PUT',
			url: '/pp/board/atc/'+article.atc_no,
			data: JSON.stringify(article), 
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}
			}
		});
	}
	function modArticle2(content, callback, error){
		$.ajax({
			type: 'PUT',
			url: '/pp/board/atc/BOOK/'+content.atcnum+".json",
			data: JSON.stringify(content), 
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}
			}
		});
	}
	function heartMaker(obj, callback, error){
		$.ajax({
			type: 'PATCH',
			url: '/pp/board/atc/'+obj.atcNO+'/hearts/'+obj.memId+'.json',
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}
			}
		});
	}
	function hitsUpArticle(code, callback, error){
		$.ajax({
			type: 'PATCH',
			url: '/pp/board/atc/'+code+"/hits",
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}
			}
		});
	}
	function deleteArticle(code, callback, error){
		$.ajax({
			type: 'DELETE',
			url: '/pp/board/atc/'+code,
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}
			}
		});
	}
	function getAllCommentsWithPaging(path, callback, error) {
		$.getJSON("/pp/board/cmts/"+path.atc_no+"/"+path.page+".json", function(data) {
			if (callback) {
				callback(data);
			}
		});
	}
	
	function getCommentView(atcnum, callback) {
		$.getJSON("/pp/board/cmts/"+atcnum+".json",
				function(data) {
			if (callback) {
				callback(data);
			}
		});
	}
	function checkCountComments(atc_no, callback, error){
		$.get("/pp/board/cmts/count/"+atc_no, function(data) {
			console.log(data);
			return json={data:data};
		});
	}
	function writeNewComment(comment, callback, error){
		$.ajax({
			type: 'POST',
			url: '/pp/board/cmt/new',
			data: JSON.stringify(comment), 
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}
			}
		});
	}
	function modComment(comment, callback, error){
		$.ajax({
			type: 'PUT',
			url: '/pp/board/cmt/'+comment.cmt_no,
			data: JSON.stringify(comment), 
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}
			}
		});
	}
	function deleteComment(code, callback, error){
		$.ajax({
			type: 'DELETE',
			url: '/pp/board/cmt/'+code,
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
	
	function reportArticle(obj, callback, error){
		$.ajax({
			type: 'POST',
			url: '/pp/board/atc/'+obj.atcNO+'/reports/'+obj.memId+'.json',
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}
			}
		});
	}

	
	return {
		getAllArticlesWithPaging:getAllArticlesWithPaging,
		getAllMyQnAList:getAllMyQnAList,
		getArticleView:getArticleView,
		writeNewArticle:writeNewArticle,
		modArticle:modArticle,
		heartMaker:heartMaker,
		hitsUpArticle:hitsUpArticle,
		deleteArticle:deleteArticle,
		getAllCommentsWithPaging:getAllCommentsWithPaging,
		writeNewComment:writeNewComment,
		modComment:modComment,
		deleteComment:deleteComment,
		showLastModTime:showLastModTime,
		getArticleView2:getArticleView2,
		modArticle2:modArticle2,
		getCommentView:getCommentView,
		checkCountComments:checkCountComments,
		reportArticle:reportArticle
	};
})();