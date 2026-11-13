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
  <title>boardList.jsp</title>
  <link rel="stylesheet" type="text/css" href="${ctp}/css/linkPink.css"/>
  <script>
    'use strict';
    
    function pageChange() {
    	let pageSize = document.getElementById("pageSize").value;
    	location.href = "boardList.bo?pageSize="+pageSize;
    }
  </script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/slide2.jsp" %>
<p><br/></p>
<div class="container">
  <h2 class="text-center">게 시 판 리 스 트</h2>
  <div class="row">
    <div class="col text-start"><a href="boardInput.bo" class="btn btn-success btn-sm mb-1">글쓰기</a></div>
    <div class="col text-end">
    	<select name="pageSize" id="pageSize" onchange="pageChange()">
    	  <option ${vos[0].pageSize==5  ? 'selected' : ''}>5</option>
    	  <option ${vos[0].pageSize==10 ? 'selected' : ''}>10</option>
    	  <option ${vos[0].pageSize==15 ? 'selected' : ''}>15</option>
    	  <option ${vos[0].pageSize==20 ? 'selected' : ''}>20</option>
    	  <option ${vos[0].pageSize==30 ? 'selected' : ''}>30</option>
    	</select>
    </div>
  </div>
  <table class="table table-hover">
    <tr class="table-secondary text-center">
      <th>글번호</th>
      <th>글제목</th>
      <th>글쓴이</th>
      <th>글쓴날짜</th>
      <th>조회수(좋아요)</th>
    </tr>
    <%-- <c:set var="cnt" value="${fn:length(vos)}"/> --%>
    <c:set var="curScrStartNo" value="${curScrStartNo}"/>
    <c:forEach var="vo" items="${vos}" varStatus="st">
      <tr class="text-center">
        <td>${curScrStartNo}</td>
        <td>
          <a href="boardContent.bo?idx=${vo.idx}">${vo.title}</a>
        </td>
        <td>${vo.nickName}</td>
        <td>${vo.wDate}</td>
        <td>${vo.readNum}</td>
      </tr>
      <c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
    </c:forEach>
  </table>
  <br/>
  <%-- 
  <!-- 페이징처리(이전페이지/다음페이지) -->
  <div class="text-center">
    <c:if test="${pag > 1}">
    	<a href="boardList.bo?pag=1&pageSize=${pageSize}">첫페이지</a>
    	<a href="boardList.bo?pag=${pag-1}&pageSize=${pageSize}">이전페이지</a>
    </c:if>
    ${pag}/${totPage}
    <c:if test="${pag < totPage}">
    	<a href="boardList.bo?pag=${pag+1}&pageSize=${pageSize}">다음페이지</a>
    	<a href="boardList.bo?pag=${totPage}&pageSize=${pageSize}">마지막페이지</a>
    </c:if>
  </div>
   --%>
  <!-- 페이징처리(블록페이지) -->
  <div class="text-center">
    <c:if test="${pag > 1}">[<a href="boardList.bo?pag=1&pageSize=${pageSize}">첫페이지</a>]</c:if>
    <c:if test="${curBlock > 0}">[<a href="boardList.bo?pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}">이전블록</a>]</c:if>
    <c:forEach var="i" begin="${(curBlock*blockSize) + 1}" end="${(curBlock*blockSize) + blockSize}" varStatus="st">
      <c:if test="${pag != i}">[<a href="boardList.bo?pag=${i}&pageSize=${pageSize}">${i}</a>]</c:if>
      <c:if test="${pag == i}">[<a href="boardList.bo?pag=${i}&pageSize=${pageSize}" class="text-danger">${i}</a>]</c:if>
    </c:forEach>
    <c:if test="${curBlock < lastBlock}">[<a href="boardList.bo?pag=${(curBlock+1)*blockSize + 1}&pageSize=${pageSize}">다음블록</a>]</c:if>
    <c:if test="${pag < totPage}">[<a href="boardList.bo?pag=${totPage}&pageSize=${pageSize}">마지막페이지</a>]</c:if>
  </div>
</div>
<p><br/></p>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>