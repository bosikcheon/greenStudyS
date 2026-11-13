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
  <link rel="stylesheet" type="text/css" href="${ctp}/css/linkOrange.css"/>
  <script>
    'use strict';
    
    function pageChange() {
    	let pageSize = document.getElementById("pageSize").value;
    	location.href = "boardList?pageSize="+pageSize;
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
    <div class="col text-start"><a href="boardInput" class="btn btn-success btn-sm mb-1">글쓰기</a></div>
    <div class="col text-end">
    	<select name="pageSize" id="pageSize" onchange="pageChange()">
    	  <option ${pageVO.pageSize==5  ? 'selected' : ''}>5</option>
    	  <option ${pageVO.pageSize==10 ? 'selected' : ''}>10</option>
    	  <option ${pageVO.pageSize==15 ? 'selected' : ''}>15</option>
    	  <option ${pageVO.pageSize==20 ? 'selected' : ''}>20</option>
    	  <option ${pageVO.pageSize==30 ? 'selected' : ''}>30</option>
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
    <c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"/>
    <c:forEach var="vo" items="${vos}" varStatus="st">
      <tr class="text-center">
        <td>${pageVO.curScrStartNo}</td>
        <td class="text-start">
          <a href="boardContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}">${vo.title}</a>
          <c:if test="${vo.replyCnt != 0}">(${vo.replyCnt})</c:if>
          <c:if test="${vo.hour_diff <= 24}"><img src="${ctp}/images/new.gif"/></c:if>
        </td>
        <td>${vo.nickName}</td>
        <td>${fn:substring(vo.WDate,0,19)}</td>
        <td>${vo.readNum}(${vo.good})</td>
      </tr>
      <c:set var="curScrStartNo" value="${pageVO.curScrStartNo - 1}"/>
    </c:forEach>
  </table>
  <br/>
  
  <!-- 페이징처리(블록페이지 시작) -->
  <div class="text-center">
    <c:if test="${pageVO.pag > 1}">[<a href="boardList?pag=1&pageSize=${pageVO.pageSize}">첫페이지</a>]</c:if>
    <c:if test="${pageVO.curBlock > 0}">[<a href="boardList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">이전블록</a>]</c:if>
    <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize) + 1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
      <c:if test="${i <= pageVO.totPage && pageVO.pag != i}">[<a href="boardList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a>]</c:if>
      <c:if test="${i <= pageVO.totPage && pageVO.pag == i}">[<a href="boardList?pag=${i}&pageSize=${pageVO.pageSize}" class="text-danger"><b>${i}</b></a>]</c:if>
    </c:forEach>
    <c:if test="${pageVO.curBlock < pageVO.lastBlock}">[<a href="boardList?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">다음블록</a>]</c:if>
    <c:if test="${pageVO.pag < pageVO.totPage}">[<a href="boardList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막페이지</a>]</c:if>
  </div>
  <!-- 페이징처리(블록페이지 끝) -->
  
  <br/>
  <!-- 검색기 시작 -->
  <div class="container text-center">
    <form name="searchForm" method="post" action="boardSearchList">
      <select name="search" id="search">
        <option value="title">글제목</option>
        <option value="nickName">글쓴이</option>
        <option value="content">글내용</option>
      </select>
      <input type="text" name="searchString" id="searchString" required />
      <input type="submit" value="검색"/>
     
    </form>
  </div>
  <!-- 검색기 끝 -->
</div>
<p><br/></p>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>