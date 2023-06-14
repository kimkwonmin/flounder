<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
  
  <head>
    
    <title> 04 search </title>
    
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
    
    <!-- 여기부터 -->
    <script
    src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script
    src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- 여기까지 -->
    
  </head>
  <body>
    
    <jsp:include page="96_menu_btn.jsp" />
    
    
		<div class="card-body">
			<div class="row">
			
				<div class="col-lg-9">
					<div class="card">
            
            <!-- 질병검색 -->
						<div class="card-body">
              
							<div class="input-group mb-3" >
 
                <iframe src="${search_url}" width="100%" height="800px"  ></iframe>

                
                
                <!-- 							
                  <form action="${cpath}/search" method="post">
                  <input type="text" name="str_search" class="form-control" id="dis_search"
									placeholder="Search" value="1234">
                  <div class="input-group-append">
									<a id="search" type="button" class="btn btn-secondary">Go</a>
                  </div>
                  </form>
                -->								
								
								
              </div>
              <!-- 질병검색 끝 -->
            </div>
          </div>
        </div>
				<div class="col-lg-3">
					<jsp:include page="97_right.jsp" />
        </div>
      </div>
    </div>
		<div class="card-footer">권벤저스</div>
  </div>
 <script>
	function display(){
		if($("#${vo.ds_id}").css("display")=="none"){
			$("#${vo.ds_id}").css("display", "block")
		}else{
			$("#${vo.ds_id}").css("display", "none")
		}
	}
 </script>
</body>
</html>