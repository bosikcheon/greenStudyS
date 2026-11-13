<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>guestInput.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <style>
    th {
      text-align: center;
      background-color: #eee !important;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="text-center mb-4">방명록 글쓰기</h2>
  <form name="form" method="post">
    <table class="table table-bordered">
      <tr>
        <th>성명</th>
        <td><input type="text" name="name" placeholder="성명을 입력하세요" autofocus class="form-control" /></td>
      </tr>
      <tr>
        <th>이메일</th>
        <td><input type="text" name="email" placeholder="이메일을 입력하세요" class="form-control" /></td>
      </tr>
      <tr>
        <th>홈페이지</th>
        <td><input type="text" name="homePage" placeholder="홈페이지(블로그)를 입력하세요" class="form-control" /></td>
      </tr>
      <tr>
        <th>글내용</th>
        <td><textarea rows="5" name="content" placeholder="방문소감을 입력하세요" class="form-control"></textarea></td>
      </tr>
      <tr>
        <td colspan="2" class="text-center">
          <button type="submit" class="btn btn-success">글올리기</button>
          <button type="reset" class="btn btn-warning">다시쓰기</button>
          <button type="button" onclick="location.href='guestList'" class="btn btn-info">돌아가기</button>
        </td>
      </tr>
    </table>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>