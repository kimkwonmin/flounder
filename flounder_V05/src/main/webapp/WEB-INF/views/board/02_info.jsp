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

<style>
    .card {
        min-height: 400px;
        max-height: 1600px;
        border: 1px solid #5AD5C8;
        padding: 30px;
    }
</style>
</head>
 <jsp:include page="96_menu_btn.jsp" />
<div class="card-body">
    <div class="row">
        <div class="col-lg-9">
            <div class="card">
                <div class="left-section text-center">
                    <img src="./resources/images/info2.png" alt="이미지_3" style="max-width: 100%; height: auto; ">
                </div>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="card">
                <img src="./resources/images/right.jpg" alt="광고배너" style="max-height: 1600px;">
            </div>
        </div>
    </div>
</div>
	
</body>
</html>