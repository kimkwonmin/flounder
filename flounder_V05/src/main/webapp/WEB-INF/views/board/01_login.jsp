<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">

<head>
  <title>01 login</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet"
    href="https://stackpath.bootstrapcdn.com/bootstrap/4.6.2/dist/css/bootstrap.min.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Dongle&display=swap" rel="stylesheet">

 <style>
 
    body {
      background-image: url("./resources/images/backsea.gif");
      background-size: cover;
      background-repeat: no-repeat;
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
     	font-family: 'Dongle', sans-serif;
     	
    }

    .card {
      width: 400px;
      border: none;
      border-radius: 30px;
      background-color: rgba(255, 255, 255, 0.3);
      box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    .card-title {
      text-align: center;
      font-size: 40px;
      font-weight: bold;
      color: #002e5b; /* 변경된 색상 */
      margin-bottom: 20px;
    }

    .card-text {
      text-align: center;
      margin-top: 5px;
      font-size: 24px;
      color: #002e5b; /* 변경된 색상 */
      margin-bottom: 10px;
    }

    .form-group {
      display: flex;
      flex-direction: row;
      align-items: center;
      margin-bottom: 10px;
      font-size: 25px;

    }

    .form-group label {
      flex: 0 0 30%;
      text-align: right;
      margin-right: 10px;
      font-weight: bold;
      color: #002e5b; /* 변경된 색상 */
    }

    .form-control {
      border: none;
      border-bottom: 1px solid #fff;
      padding: 10px;
      font-size: 16px;
      width: 70%;
      box-sizing: border-box;
      background-color: transparent;
      color: #fff;
    }

    .form-control::placeholder {
      color: #fff;
    }

    .btn-primary {
      margin-top: 20px;
      margin-right: 15px;
      border-radius: 5px;
      background-color: transparent;
      color: #002e5b; /* 변경된 색상 */
      font-weight: bold;
      border: 1px solid #fff; /* 변경된 색상 */
      font-size: 25px;
      padding: 10px;
      width: 100%;
      transition: background-color 0.3s ease, transform 0.3s ease; /* 변경된 부분 */
      font-family: 'Dongle', sans-serif;
      
    }

    .btn-primary:hover {
      background-color: #1bbca; /* 변경된 색상 */
      cursor: pointer;
      transform: scale(1.03); /* 변경된 부분 */
    }

    /* 새로 추가한 부분 */
    .form-control:focus {
      border-color: #1bbca;
      outline: 0;
      -webkit-box-shadow: 0 0 0 0.2rem rgba(27, 188, 202, 0.25);
      box-shadow: 0 0 0 0.2rem rgba(27, 188, 202, 0.25);
    }

    .btn-primary:focus {
      border-color: #1bbca;
      outline: 0;
      -webkit-box-shadow: 0 0 0 0.2rem rgba(27, 188, 202, 0.25);
      box-shadow: 0 0 0 0.2rem rgba(27, 188, 202, 0.25);
    }
    .logo-container {
  display: flex;
  justify-content: center;
}
.logo-container img {
  width: 200px;  /* 로고 이미지의 가로 크기 */
  /* margin: 10px 0;  /* 위 아래로 20px의 여백 추가 */
}

  </style>
</head>

<body>
  <div class="container" style="padding: 50px; border-radius: 5px;">
    <div class="row justify-content-center">
      <div class="col-md-6">
     
        <div class="card" style="height: 40%; margin-top: 30%;">
         <br/>
          <div class="card-body">
          	<div class="logo-container">
          	
  						<img src="./resources/images/아이콘4.png" alt="Logo">
								</div>
            <br/>
            <br/>
          <!-- <p class="card-text">회원님, 환영합니다.</p> -->  
            <form action="${cpath}/login" method="post">
              <div class="form-group">
                <label for="username">Email:</label>
                <input type="text" name="m_email" class="form-control" id="username" placeholder="Email" required>
              </div>
              <div class="form-group">
                <label for="password">Pw:</label>
                <input type="password" name="m_pw" class="form-control" id="password" placeholder="Password" required>
              </div>
                  <button class="btn btn-primary">LOGIN</button>
                   <div style="margin-bottom: 10px;"></div> 
              <div class="d-flex justify-content-between" style="margin-bottom: 10px; font-size: 20px;"> <!-- 변경된 부분 -->
                <a href="#" style="color: #fff;">Join Us</a>
                  <a href="#" style="color: #fff; margin-left: 150px;">Forget Password</a>
                </div>
              </div>
            </form>
            <div style="margin-bottom: 20px;"></div> <!-- 하단 여백 -->
          </div>
        </div>
      </div>
    </div>
  </div>
</body>

</html>
