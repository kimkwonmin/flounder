<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<head>
 <style>
    body {
      background-image: url("./resources/images/sea03.gif");
      background-size: cover;
      background-repeat: no-repeat;
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      flex-direction: column;
    }
    
    .start-button {
      color: white;
      font-weight: bold;
      font-size: 26px;
      padding: 10px;
      border-radius: 5px;
      transition: background-color 0.3s;
      background-color: #5AD5C8;
      border: 2px solid white; /* 테두리 추가 */
      border-radius: 5px; /* 테두리를 각지게 만들기 */
      border-width: 3px; /* 테두리 선 굵기 조정 */
    }
    
    .start-button:hover {
      background-color: transparent; /* 배경 없애기 */
    }
  </style>
</head>

<body>
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-md-6 col-sm-8 col-xs-12">
        <button class="start-button btn btn-block" onClick="location.href='./04'">Welcome</button>
      </div>
    </div>
  </div>
</body>

</html>
