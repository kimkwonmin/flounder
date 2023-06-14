<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
<title>05 share</title>
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
.feed-box {
	border: 1px solid #5AD5C8;
}

.rounded-input {
	border-radius: 30px;
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

.left-section {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
}

.left-section .feed-card {
	margin-bottom: 20px;
	width: 60%;
}

@media (max-width: 576px) {
	.left-section .feed-card {
		width: 100%;
	}
}
</style>

<script type="text/javascript">
$(document).ready(() => {
	var pageForm = $("#pageForm");
	// 상세보기로 이동
	$(".move").on("click", function (e) {
		e.preventDefault(); // a tag의 고유한 기능을 막는 방법
		var c_id = $(this).attr("href");
		var tag = "<input type='hidden' name='c_id' value='" + c_id + "'>";
		pageForm.append(tag);
		pageForm.attr("action", "${cpath}/share_detail");
		pageForm.attr("method", "post");
		pageForm.submit(); // 폼을 전송
	});
});
</script>

</head>
<body>
	<jsp:include page="96_menu_btn.jsp" />
	<div class="card-body">
		<div style="min-height: 200px;">
			<div class="row">
				<div class="col-lg-9">
					<div class="feed-box">
						<h5 class="header"
							style="text-align: center; margin-bottom: 10px;">
							<br />
							<strong>정보 공유</strong>
						</h5>
						<div style="padding: 20px;"
							class="d-flex flex-column align-items-center">
							<c:forEach var="vo" items="${list_comm}">
								<div class="col-lg-6 col-md-6 col-sm-12 mb-4">
									<div class="card h-100" style="padding: 20px;">
										<div class="card-img-container"
											style="width: 100%; height: 400px; overflow: hidden;">
											<a class="move" href="${vo.c_id}"> <img
												src="${cpath}/resources${vo.img_path}" class="card-img-top"
												alt="이미지"
												style="width: 100%; height: 100%; object-fit: cover;">
											</a>
										</div>
										<br />
										<h5 class="card-text"
											style="font-size: 14px;">${vo.m_name}</h5>
										<p class="card-title">${vo.title}</p>
										<p class="card-text">
											<small class="text-muted"><fmt:formatDate
													value="${vo.c_date}" pattern="yyyy-MM-dd HH:mm:ss" /></small>
										</p>
									</div>
								</div>
							</c:forEach>

							<form id="pageForm"></form>
						</div>
					</div>
				</div>
				<div class="col-lg-3">
					<jsp:include page="97_right.jsp" />
				</div>
			</div>
		</div>
	</div>
	<div class="container-fluid fixed-bottom mb-4">
		<div class="row justify-content-end">
			<div class="col-lg-9">
				<div class="text-center">
					<a href="${cpath}/writer" class="btn btn-lg btn-primary mr-2">글쓰기</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
