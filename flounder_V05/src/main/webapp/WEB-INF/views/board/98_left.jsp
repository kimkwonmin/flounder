<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<style>
  .btn-primary {
    width: 100%;
    margin-top: 20px;
    border-radius: 5px;
    background-color: #000a2e;
    color: white;
    font-weight: bold;
    border: 1px solid white;
  }
   .btn-primary:hover {
    background-color: none;
    cursor: pointer;
  }
</style>
<body>
<div class="card" >
  <div class="row">
    <div class="card-body text-center">
      <h4 class="card-title">LEFT</h4>
      <div>
        
        <c:if test="${!empty mvo}">
          <p class="card-title">${mvo.m_name}</p>
          <p class="card-text">회원님, 환영합니다.</p>
          <form action="${cpath}/logout" method="post">
            <button class="btn btn-primary">로그아웃</button>
             </c:if>
          </form>
      </div>
    </div>
  </div>
</div>

</body>
         
        
