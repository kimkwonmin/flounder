</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<head>
<title>08 history detail</title>
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

<style>
.container {
	border: 1px solid #5AD5C8;
	border-radius: 10px;
	
}

.card2 {
	margin-bottom: 20px;
	border-radius: 10px;
	overflow: hidden;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	width: 100%;
	margin: 0 auto;
	background-color: white;
	padding: 10px;
	border: 1px solid #5AD5C8;
	
}



.btn-primary {
	background-color: #5AD5C8;
	border-color: #5AD5C8;
	color: white;
}
 .btn-primary:hover {
    background-color: transparent;
    color: #5AD5C8;
}
 
</style>

 <script>
        function goBack() {
            window.history.back(); // 이전 페이지로 이동
        }
    </script>

</head>

<body>
	<jsp:include page="96_menu_btn.jsp" />

	<div class="card-body">
		<div class="row">
			<div class="col-lg-9 " >
				<div class="card">
			
	<div class="row justify-content-center mt-4">
		<div class="col-lg-6" >
						<h5 class="card-title" style="text-align: center;"><strong>게시판 작성</strong></h5>
					<br/>
			<div class="card">
				<div class="card-body">
					
					
					
					<form action="${cpath}/write" method="post" enctype="multipart/form-data">
						<div class="form-group">
							<label for="author">제목</label>
							<input type="text" class="form-control" id="title" name="title" required>
						</div>
						<div class="form-group">
							<label for="content">내용</label>
							<textarea class="form-control" id="c_text" name="c_text" rows="5" required></textarea>
						</div>
						<div class="form-group">
							<label for="media">미디어 (이미지 또는 동영상)</label>
							<input type="file" name="file" class="form-control-file" id="img_path" name="img_path" accept="image/*,video/*" required>
						</div>
						<div class="d-flex justify-content-end">
										<button data-btn="list" class="btn btn-sm btn-primary mr-2" onclick="goBack()">취소</button>
										<button type="submit" class="btn btn-sm btn-primary mr-2">
											<input type="hidden" name="w_email" value="${mvo.m_email}">
											제출
										</button>
						</div>
					</form>
							
				</div>
			</div>
				<br />		
		</div>
	</div>
</div>
					
							
						</div>
	
			
			<div class="col-lg-3">
					<jsp:include page="97_right.jsp" />
			</div>
		</div>
	</div>

</body>

</html>
