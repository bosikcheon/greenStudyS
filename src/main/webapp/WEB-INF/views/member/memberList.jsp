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
  <title>memberList.jsp</title>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/slide2.jsp" %>
<p><br/></p>
<div class="container">
  <h2 class="text-center mb-3">회 원 리 스 트</h2>
  <table class="table table-hover">
    <tr class="table-secondary">
      <th>번호</th>
      <th>닉네임</th>
      <th>아이디</th>
      <th>성명</th>
      <th>이메일</th>
      <th>생일</th>
      <th>직업</th>
    </tr>
    <c:forEach var="vo" items="${vos}" varStatus="st">
	    <tr>
	      <td>${vo.idx}</td>
	      <td>${vo.nickName}</td>
        <c:if test="${vo.userInfor == '공개' || vo.mid == sMid || sLevel == 0}">
  	      <td><a href="memberContent?mid=${vo.mid}">${vo.mid}</a></td>
  	      <td>${vo.name}</td>
  	      <td>${vo.email}</td>
  	      <td>${fn:substring(vo.birthday, 0, 10)}</td>
  	      <td>${vo.job}</td>
        </c:if>
        <c:if test="${vo.userInfor != '공개' && vo.mid != sMid && sLevel != 0}">
          <td colspan="5" class="text-center">정보 미공개</td>
        </c:if>
	    </tr>
    </c:forEach>
  </table>
  
  <!-- 페이징처리(블록페이지 시작) -->
  <div class="text-center">
    <ul class="pagination justify-content-center">
      <c:if test="${pageVO.pag > 1}"><li class="page-item"><a href="memberList?pag=1&pageSize=${pageVO.pageSize}" class="page-link text-secondary">첫페이지</a></li></c:if>
      <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a href="memberList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">이전블록</a></li></c:if>
      <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize) + 1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
        <c:if test="${i <= pageVO.totPage && pageVO.pag != i}"><li class="page-item"><a href="memberList?pag=${i}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">${i}</a></li></c:if>
        <c:if test="${i <= pageVO.totPage && pageVO.pag == i}"><li class="page-item"><a href="memberList?pag=${i}&pageSize=${pageVO.pageSize}" class="page-link active bg-secondary border-secondary"><b>${i}</b></a></li></c:if>
      </c:forEach>
      <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a href="memberList?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">다음블록</a></li></c:if>
      <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a href="memberList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">마지막페이지</a></li></c:if>
    </ul>
  </div>
  <!-- 페이징처리(블록페이지 끝) -->
  
</div>
<p><br/></p>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>