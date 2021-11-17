var qnaService = (function() {
	function getAllArticlesWithPaging(path, callback, error) {
		$.getJSON("/pp/board1/all/"+path.type+"/"+path.page+".json", function(data) {
			if (callback) {
				callback(data);
			}
		});
	}
	function getArticleView(code, callback) {
		$.get("/pp/board1/atc/"+code, function(data) {
			if (callback) {
				callback(data);
			}
		});
	}
	function getArticleView2(code, callback) {
		$.get("/pp/board1/atc/BOOK/"+code+".json", function(data) {
			if (callback) {
				callback(data);
			}
		});
	}
	function writeNewArticle(article, callback, error){
		$.ajax({
			type: 'POST',
			url: '/pp/board1/atc/new',
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
			url: '/pp/board1/atc/'+article.atc_no,
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
			url: '/pp/board1/atc/BOOK/'+content.atcnum+".json",
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
			url: '/pp/board1/atc/'+obj.atcNO+'/hearts/'+obj.memId+'.json',
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
			url: '/pp/board1/atc/'+code+"/hits",
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
			url: '/pp/board1/atc/'+code,
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}
			}
		});
	}
	function getAllCommentsWithPaging(path, callback, error) {
		$.getJSON("/pp/board1/cmts/"+path.atc_no+"/"+path.page+".json", function(data) {
			if (callback) {
				callback(data);
			}
		});
	}
	
	function getCommentView(atcnum, callback) {
		$.getJSON("/pp/board1/cmts/"+atcnum+".json",
				function(data) {
			if (callback) {
				callback(data);
			}
		});
	}

	function writeNewComment(comment, callback, error){
		$.ajax({
			type: 'POST',
			url: '/pp/board1/cmt/new',
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
			url: '/pp/board1/cmt/'+comment.cmt_no,
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
			url: '/pp/board1/cmt/'+code,
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
	
	function getAllBoardsWithPaging(path, callback, error){
		$.getJSON("/pp/board1/qna/"+path.type+"/"+path.page+".json", function(data) {
			if(callback){
				callback(data);
			}
		});
	}
	
	function getBoardView(code, callback) {
		$.get("/pp/board1/brd/"+code, function(data) {
			if(callback){
				callback(data);
			}
		});
	}
	
	function writeNewBoard(board, callback, error) {
		$.ajax({
			type: 'POST',
			url: '/pp/board1/brd/new',
			data: JSON.stringify(board),
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr) {
				if(callback){
					callback(result);
				}
			}
		});
	}
	
	function modBoard(board, callback, error) {
		$.ajax({
			type: 'PUT',
			url: '/pp/board1/brd/'+board.atc_no,
			data: JSON.stringify(board),
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}
			}
		});
	}
	
	function deleteBoard(code, callback, error) {
		$.ajax({
			type: 'DELETE',
			url: '/pp/board1/brd/'+code,
			success: function(result, status, xhr) {
				if(callback){
					callback(result);
				}
			}
		});
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
		getAllBoardsWithPaging:getAllBoardsWithPaging,
		getBoardView:getBoardView,
		writeNewBoard:writeNewBoard,
		modBoard:modBoard,
		deleteBoard:deleteBoard,
		getCommentView:getCommentView,
		reportArticle:reportArticle
	};
})();