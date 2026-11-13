<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <title>adminLeft.jsp</title>
  <style>
    body {
      background-color: #eee;
    }
  </style>
</head>
<body>
<p><br/></p>
<div class="container text-center">
  <h4>관리자메뉴</h4>
  <hr/>
  <div><a href="${ctp}/" target="_top">홈으로</a></div>
  <hr/>
  <div>회원관리</div>
  <div><a href="memberList" target="adminRight">회원리스트</a></div>
  <hr/>
  <div>게시판관리</div>
  <div><a href="boardList" target="adminRight">게시판리스트</a></div>
  <hr/>  
</div>
<p><br/></p>
</body>
</html>