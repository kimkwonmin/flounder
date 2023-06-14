<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
<title>06 share detail</title>
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
.center-card {
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 80vh;
	border: 1px solid #5AD5C8;
}

.card-body {
	padding: 30px;
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

table {
	border-collapse: collapse;
	width: 100%;
}

th, td {
	padding: 10px;
	border-bottom: 1px solid #CD5C5C;
}

/* 커서 갖다대면 색깔이 바뀌며 직관적으로 표현한다 */
tr:hover {
	background-color: #F5F5F5;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		// 4개의 버튼을 클릭하면 처리하는 부분
		$("button").on("click", function(e) {
			var btn = $(this).data("btn"); // data() = data-에 있는 이름
			var formData = $("#frm");
			if (btn == "list") {
				//location.href="${cpath}/list";
				formData.attr("action", "${cpath}/community");
				formData.attr("method", "get");
				// formData.find("#c_id").remove();
			} else if (btn == "modify") {
				formData.attr("action", "${cpath}/modify"); // ?num=${vo.num}
				formData.attr("method", "get");
			} else if (btn == "remove") {
				//location.href="${cpath}/remove?num="+${vo.num};
				formData.attr("action", "${cpath}/remove"); // ?num=${vo.num}
				formData.attr("method", "get");
			} else if (btn == "reply") {
				formData.attr("action", "${cpath}/reply"); // ?num=${vo.num}
				formData.attr("method", "get");
			}
			formData.submit(); // 전송
		})
	});
</script>

</head>

<body>

	<jsp:include page="96_menu_btn.jsp" />

	<div class="card-body">
		<div style="min-height: 400px;">
			<div class="row">
				<div class="col-lg-9">
					<div class="center-card">
						<div class="card" style="margin: 20px;">

							<h5 class="card-title"
								style="display: flex; justify-content: center; align-items: center;">
								<strong>게시물 상세</strong>
							</h5>
							<br />
							<tr>
								<div style="display: flex; justify-content: center;">

									<td><img alt="이미지" height=400px; width=400px;
										src="${cpath}/resources${share_detail.img_path}"></td>
								</div>
							</tr>
							<table class="table">
								<br />
								<tr>
									<td style="width: 100px">제목</td>
									<td>${share_detail.title}</td>
								</tr>
								<tr>
									<td>내용</td>
									<td>${fn:replace(share_detail.c_text, newLineChar, "<br/>")}</td>
									<!-- vo.content에서 \n를 찾아 <br>로 바꾼다.라는 뜻 -->
									<!-- 그런데 \는 특수한 기호이므로 표현식에는 쓸 수 없다. -->
									<!-- 따라서 \n을 다른 변수에 바인딩 시켜서 그 바인딩 한것을 써줘야 한다. -->
								</tr>
								<tr>
									<td>작성자</td>
									<td>${share_detail.m_name}</td>
								</tr>
								<tr>
									<td>작성일</td>
									<td><fmt:formatDate value="${share_detail.c_date}"
											pattern="yyyy-MM-dd HH:mm:ss" /></td>
								</tr>
							</table>

							<div class="text-center mt-4">
								<button data-btn="list" class="btn btn-sm btn-primary">목록</button>


								<!-- 로그인한 아이디와 게시물의 아이디가 같을경우 -->
								<c:if test="${mvo.m_email eq share_detail.w_email}">
									<button data-btn="modify" class="btn btn-sm btn-primary">
										<input type="hidden" value="${share_detail.c_id}"> 수정
									</button>
									<button data-btn="remove" class="btn btn-sm btn-primary">
										<input type="hidden" value="${share_detail.c_id}"> 삭제
									</button>
								</c:if>





								<c:if test="${!empty mvo}">
									<div class="card-body"
										style="margin: 10px; display: flex; align-items: center;">
										<form action="${cpath}/reply" method="post"
											style="flex: 1; width: 100%;">
											<div class="form-group"
												style="display: flex; flex-direction: row;">
												<label for="replyText"
													style="flex: 0 0 auto; margin-right: 10px;"></label>
												<textarea class="form-control" id="reply" name="reply"
													rows="1" style="flex: 1; resize: none; height: auto;"></textarea>

												<input type="hidden" name="c_id"
													value="${share_detail.c_id}"> <input type="hidden"
													name="r_email" value="${mvo.m_email}">
												<button type="submit" class="btn btn-primary"
													style="margin-left: 10px; align-self: flex-end;">입력</button>
												<br />

											</div>
											<c:if test="${not empty reply}">
												<ul class="list-group" style="text-align: left">
													<c:forEach var="reply" items="${reply}">

														<li class="list-group-item">
															<div>
																<strong>${reply.r_name}</strong>
															</div>
															<p>${reply.reply}
																<!-- 	<button data-btn="remove" class="btn btn-sm btn-primary">
										삭제
									</button>-->
															</p> <span><fmt:formatDate value="${reply.r_date}"
																	pattern="yyyy.MM.dd HH:mm" /></span>

																<button type="button" class="btn btn-sm btn-primary ml-auto">
																	삭제
																</button>
														</li>
													</c:forEach>
												</ul>
											</c:if>
										</form>
									</div>
								</c:if>

							</div>

							<form id="frm">
								<input type="hidden" id="c_id" name="c_id"
									value="${share_detail.c_id}">
							</form>

						</div>
					</div>
				</div>

				<div class="col-lg-3">
					<jsp:include page="97_right.jsp" />
				</div>
			</div>
		</div>
	</div>



</body>
</html>
