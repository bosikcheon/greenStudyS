<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <title>memberContent.jsp</title>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2>회원 상세 정보 보기</h2>
  <table class="table table-bordered">
    <tr>
      <th>아이디</th>
      <td>${vo.mid}</td>
    </tr>
    <tr>
      <th>닉네임</th>
      <td>${vo.nickName}</td>
    </tr>
    <tr>
      <th>성명</th>
      <td>${vo.name}</td>
    </tr>
    <tr>
      <th>성별</th>
      <td>${vo.gender}</td>
    </tr>
    <tr>
      <th>생일</th>
      <td>${fn:substring(vo.birthday,0,10)}</td>
    </tr>
    <tr>
      <th>전화번호</th>
      <td>${vo.tel}</td>
    </tr>
    <tr>
      <th>주소</th>
      <td>${vo.address}</td>
    </tr>
    <tr>
      <th>이메일</th>
      <td>${vo.email}</td>
    </tr>
    <tr>
      <th>홈페이지</th>
      <td>${vo.homePage}</td>
    </tr>
    <tr>
      <th>직업</th>
      <td>${vo.job}</td>
    </tr>
    <tr>
      <th>취미</th>
      <td>${vo.hobby}</td>
    </tr>
    <tr>
      <th>사진</th>
      <td><img src="${ctp}/member/${vo.photo}" width="100px" /></td>
    </tr>
    <tr>
      <th>자기소개</th>
      <td>${vo.content}</td>
    </tr>
    <tr>
      <th>포인트</th>
      <td>${vo.point}</td>
    </tr>
    <tr>
      <th>등급</th>
      <td>
        <c:if test="${vo.level == 0}">관리자</c:if>
        <c:if test="${vo.level == 1}">우수회원</c:if>
        <c:if test="${vo.level == 2}">정회원</c:if>
        <c:if test="${vo.level == 3}">준회원</c:if>
      </td>
    </tr>
    <tr>
      <th>총방문수</th>
      <td>${vo.visitCnt}</td>
    </tr>
    <tr>
      <th>최초가입일</th>
      <td>${fn:substring(vo.startDate,0,10)}</td>
    </tr>
    <tr>
      <th>최종접속일</th>
      <td>${vo.lastDate}</td>
    </tr>
    <tr>
      <th>오늘 방문수</th>
      <td>${vo.todayCnt}</td>
    </tr>
  </table>
  <hr/>
  <div class="text-center"><a href="javascript:history.back()" class="btn btn-success">돌아가기</a></div>
</div>
<p><br/></p>
</body>
</html>