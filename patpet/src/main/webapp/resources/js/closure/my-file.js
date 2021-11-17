var fileService = (function() {
	function getAllFiles(data, callback, error) {
		$.getJSON("/pp/file/"+data.content+"/"+data.id+".json", function(data) {
			if (callback) {
				callback(data);
			}
		});
	}
	function uploadNewFile(formData,pathData,callback,error) {
		$.ajax({
	        type: "POST",
	        enctype: 'multipart/form-data',
	        url: "/pp/file/"+pathData.content+'/'+pathData.id,
	        data: formData,
	        processData: false,
	        contentType: false,
	        cache: false,
	        timeout: 600000,
	        dataType: "text",
	        success: function(data){
	            if(callback){
	            	callback(data);
	            }
	        },
	        error: function(e){
	            console.log("ERROR : ", e);
	        }
	    });
	}
	function uploadNewFileUsingUtils(formData,pathData,callback,error) {
		$.ajax({
			type: "POST",
			enctype: 'multipart/form-data',
			url: "/pp/file/upload/"+pathData.content+'/'+pathData.id,
			data: formData,
			processData: false,
			contentType: false,
			cache: false,
			timeout: 600000,
			dataType: "text",
			success: function(data){
				if(callback){
					callback(data);
				}
			},
			error: function(e){
				console.log("ERROR : ", e);
			}
		});
	}
	function modAndUpload(formData,pathData,callback,error) {
		$.ajax({
			type: "POST",
			enctype: 'multipart/form-data',
			url: "/pp/file/modupload/"+pathData.content+'/'+pathData.id,
			data: formData,
			processData: false,
			contentType: false,
			cache: false,
			timeout: 600000,
			dataType: "text",
			success: function(data){
				if(callback){
					callback(data);
				}
			},
			error: function(e){
				console.log("ERROR : ", e);
			}
		});
	}
	function deleteUploadedFiles(jsonData,callback,error) {
		$.ajax({
			type: "DELETE",
			url: "/pp/file/"+jsonData.content+'/'+jsonData.id+'/'+jsonData.fileName+".json",
			dataType: "text",
			success: function(deleteResult, status, xhr) {
  			if (callback) {
  				callback(deleteResult);
  			}
  		},
  		error : function(xhr, status, er) {
  		  if (error) {
  			  error(er);
  		  }
		  }
		});
	}
	function deleteFilesFromDir(data,callback,error) {
		$.ajax({
			type: "DELETE",
			url: "/pp/file/"+data.content+'/'+data.id+".json",
			dataType: "text",
			success: function(deleteResult, status, xhr) {
				if (callback) {
					callback(deleteResult);
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
		getAllFiles : getAllFiles,
		uploadNewFile : uploadNewFile,
		uploadNewFileUsingUtils : uploadNewFileUsingUtils,
		modAndUpload : modAndUpload,
		deleteUploadedFiles : deleteUploadedFiles,
		deleteFilesFromDir:deleteFilesFromDir,
		getAllFiles : getAllFiles
	};
})();