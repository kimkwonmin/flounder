<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<head>
<title>07 history</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="${cpath}/resources/css/style.css">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>


<script>
$(document).ready(function () {
	var pageForm = $("#pageForm");
	// 상세보기로 이동
	$(".move").on("click", function(e){ 
		e.preventDefault(); // a tag의 고유한 기능을 막는 방법
		var dd_id = $(this).attr("href");
		var tag = "<input type='hidden' name='dd_id' value='"+dd_id+"'>";
		pageForm.append(tag);
		pageForm.attr("action", "${cpath}/history_detail");
		pageForm.attr("method", "post");
		pageForm.submit(); // 폼을 전송
	});
	
	
	var loading = false;
	var page = 1;
	var container = $('#contentContainer');

	function loadMoreContent() {
		if (loading) {
			return;
		}

		loading = true;

		$.ajax({
			url: 'path/to/endpoint', // 실제 엔드포인트 URL로 교체하세요.
			type: 'GET',
			data: {page: page},
			success: function (response) {
				container.append(response);
				loading = false;
				page++;
			},
			error: function () {
				loading = false;
			}
		});
	}

	$(window).scroll(function () {
		if ($(window).scrollTop() + $(window).height() >= $(document).height()) {
			loadMoreContent();
		}
	});

	loadMoreContent();
});
</script>

<style>
.container {
	border: 1px solid #5AD5C8;
}

.card2 {
	margin-bottom: 20px;
	border-radius: 5px;
	overflow: hidden;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	width: 90%;
	margin: 0 auto;
	background-color: #white;
	padding: 10px;
	border: 1px solid #5AD5C8;
}

.card2 .content .title {
	font-weight: bold;
	margin-bottom: 10px;
}

.card2 .content .name {
	font-size: 14px;
}

.card2 img {
	width: 95%;
	height: auto;
	margin: 0 auto;
}

table.table-bordered {
	border: 1px solid #5AD5C8;
}

table.table-bordered th, table.table-bordered td {
	border: 1px solid #5AD5C8;
}

table.table-bordered tbody tr {
	background-color: transparent;
}

.chat-bubble {
	background-color: #FFFFFF;
	border-radius: 10px;
	padding: 10px;
	margin-bottom: 10px;
}

.chat-content {
	color: #333333;
}

.chat-content .title {
	font-weight: bold;
	margin-bottom: 5px;
}

.chat-content .date {
	font-size: 12px;
	color: #999999;
}

.chat-content .name {
	font-size: 12px;
	color: #000000;
	font-weight: bold;
}

.chat-window {
	max-width: 600px;
	margin: 0 auto;
}

.feed-box {
	border: 1px solid #5AD5C8;
}
</style>
</head>

<body>
<jsp:include page="96_menu_btn.jsp" />
<div class="card-body">
	<div style="min-height: 200px;"> 
		<div class="row">
			<div class="col-lg-9">
				<div class="feed-box">
					<br/>
					<h5 class="header"
						style="text-align: center; margin-bottom: 10px;">
						<strong>나의 질병 히스토리</strong>
					</h5>
					<div style="padding: 20px; " class="d-flex flex-column align-items-center">
						<c:forEach var="vo" items="${list_detect}">
							<div class="col-lg-6 col-md-6 col-sm-12 mb-4">
								<div class="card2">
									<div class="card-img-container"
										style="width: 100%; height: 100%; overflow: hidden;">
										<a class="move" href="${vo.dd_id}">
											<img alt="이미지"
												src="${cpath}/resources/${vo.org_img}"
												class="card-img-top"
												style="width: 100%; height: 100%; object-fit: cover;">
										</a>
									</div>
									<div class="content">
									<br/>
										<div class="name">${vo.m_name}</div>
										<div class="title">${vo.dd_comment}</div>
										<div class="date">
											<fmt:formatDate value="${vo.dd_date}"
												pattern="yyyy-MM-dd HH:mm:ss" />
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<div class="col-lg-3">
				<jsp:include page="97_right.jsp" />
			</div>
		</div>
	</div>
</div>
<form id="pageForm">
</form>
</body>
</html>
