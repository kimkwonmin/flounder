<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
  <head>
    
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${cpath}/resources/css/style.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script
    src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script
    src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    
    
  <script>
  
    function readImage(input)
    {
    	if(input.files && input.files[0]) {
    		var reader = new FileReader();
    		reader.onload = function(e)
    		{
    			document.getElementById('preview_img').src = e.target.result;
    		};
    		reader.readAsDataURL(input.files[0]);
    	} else {
    		document.getElementById('preview_img').src = "";
    	}
    	
    }
  
  </script>
    
  </head>
  
  <body>
  
     
    <div class="card-body">
      <div class="row">
        
        <div class="col-lg-6">
          <div class="card">
          
            <h4> image upload return json </h4> 
	          <div class="row justify-content-center">
               <form action="http://121.179.7.40:5000/return_json" method="post" enctype="multipart/form-data">	
<!-- 	             <form action="http://121.179.83.133:5000/process_image" method="post" enctype="multipart/form-data">  -->
	                 <div class="form-group">
	                   <label>내용:</label>
	                   <input type="text" name="title" />
	                 </div>
	                 <div class="form-group">
	                   <label>업로드 이미지:</label>
                     <input type="file" name="image" id="file" accept="image/*" onchange="readImage(this);" />
                       <img id = "preview_img" height = 200px/>
	                   
	                 </div>
	                 <button type="submit" class="btn btn-sm btn-primary">플라스크 upload</button>
	             </form>
	          </div>
              
          </div>
          
        </div>
          
      </div>
      
      <div class="row">
      
        <div class="col-lg-6">
          <div class="card">
          
            <h4> image upload return image </h4> 
	          <div class="row justify-content-center">
 	             <form action="http://121.179.7.40:5000/return_image" method="post" enctype="multipart/form-data">
<!-- 	             <form action="http://121.179.83.133:5000/return_image" method="post" enctype="multipart/form-data">  -->
	                 <div class="form-group">
	                   <label>내용:</label>
	                   <input type="text" name="title" />
	                 </div>
	                 <div class="form-group">
	                   <label>업로드 이미지:</label>
                     <input type="file" name="image" id="file" accept="image/*" onchange="readImage(this);" />
                       <img id = "preview_img" height = 200px/>
	                   
	                 </div>
	                 <button type="submit" class="btn btn-sm btn-primary">플라스크 upload</button>
	             </form>
	          </div>
              
          </div>
          
        </div>
        
      </div>
        
        
      <div class="row">
      
        <div class="col-lg-6">
          <div class="card">
          
            <h4> image upload return image </h4> 
	          <div class="row justify-content-center">
 	             <form action="http://121.179.7.40:5000/detect_disease" method="post" enctype="multipart/form-data">
<!-- 	             <form action="http://121.179.83.133:5000/return_image" method="post" enctype="multipart/form-data">  -->
	                 <div class="form-group">
	                   <label>내용:</label>
	                   <input type="text" name="title" />
	                 </div>
	                 <div class="form-group">
	                   <label>업로드 이미지:</label>
                     <input type="file" name="image" id="file" accept="image/*" onchange="readImage(this);" />
                       <img id = "preview_img" height = 200px/>
	                   
	                 </div>
	                 <button type="submit" class="btn btn-sm btn-primary">플라스크 upload</button>
	             </form>
	          </div>
          </div>
        </div>
      </div>        
        
        
    </div>  
  </body>
</html>    