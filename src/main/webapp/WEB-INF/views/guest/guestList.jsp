<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>guestList.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="stylesheet" type="text/css" href="${ctp}/css/linkOrange.css" />
  <style>
    th {
      text-align: center;
      background-color: #eee !important;
    }
  </style>
  <script>
    'use strict';
    
    function deleteCheck(idx) {
    	let ans = confirm("현재 게시글을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		url  : 'guestDelete',
    		type : 'post',
    		data : {idx : idx},
    		success: (res) => {
    			if(res != 0) {
    				alert("삭제 처리 되었습니다.");
    				location.reload();
    			} else alert("삭제 오류!!!");
    		},
    		error : () => alert('전송오류')
    	});
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="text-center">방명록 리스트</h2>
  <div class="row mb-2">
    <div class="col">
      <a href="${ctp}/guest/guestInput" class="btn btn-success">글올리기</a>
      <c:if test="${sMid == 'ADMINOK'}"><a href="${ctp}/guest/guestAdminLogout" class="btn btn-warning">관리자 로그아웃</a></c:if>
      <c:if test="${sMid != 'ADMINOK'}"><a href="${ctp}/guest/guestAdminCheck" class="btn btn-primary">관리자</a></c:if>
    </div>
    <div class="col text-end">
      <c:if test="${pageVO.pag > 1}">
	      <a href="guestList?pag=1&pageSize=${pageVO.pageSize}" title="첫페이지">◁◁</a>
	      <a href="guestList?pag=${pageVO.pag-1}&pageSize=${pageVO.pageSize}" title="이전페이지">◀</a>
      </c:if>
      ${pageVO.pag}/${pageVO.totPage}
      <c:if test="${pageVO.pag < pageVO.totPage}">
	      <a href="guestList?pag=${pageVO.pag+1}&pageSize=${pageVO.pageSize}" title="다음페이지">▶</a>
	      <a href="guestList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}" title="마지막페이지">▷▷</a>
      </c:if>
    </div>
  </div>
  <c:set var="curScrStartNo" value="${curScrStartNo}"/>
	<c:forEach var="vo" items="${vos}" varStatus="st">
 	  <table class="table table-borderless m-0 p-0">
	    <tr>
	      <td>번호 : ${curScrStartNo}
	        <c:if test="${sMid == 'ADMINOK'}"><a href="javascript:deleteCheck(${vo.idx})" class="btn btn-danger btn-sm">삭제</a></c:if>
	      </td>
	      <td class="text-end">${vo.hostIp}</td>
	    </tr>
		</table>
 	  <table class="table table-bordered">
	    <tr>
	      <th>성명</th>
	      <td>${vo.name}</td>
	      <th>방문일자</th>
	      <td>${fn:substring(vo.visitDate,0,19)}</td>
	    </tr>
    	<tr>
    	  <th>email</th>
    	  <td colspan="3">${vo.email}</td>
    	</tr>
    	<tr>
    	  <th>홈페이지</th>
    	  <td colspan="3">${vo.homePage}</td>
    	</tr>
    	<tr style="height:120px">
    	  <th>글내용</th>
    	  <td colspan="3">${fn:replace(vo.content, newLine, "<br/>")}</td>
    	</tr>
  	</table>
  	<p><br/></p>
    <c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
  </c:forEach>
  
  <%-- 
  <div class="text-center">
    <c:if test="${pag > 1}">[<a href="guestList?pag=1&pageSize=${pageSize}">첫페이지</a>]</c:if>
    <c:if test="${curBlock > 0}">[<a href="guestList?pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}">이전블록</a>]</c:if>
    <c:forEach var="i" begin="${(curBlock*blockSize) + 1}" end="${(curBlock*blockSize) + blockSize}" varStatus="st">
      <c:if test="${i <= totPage && pag != i}">[<a href="guestList?pag=${i}&pageSize=${pageSize}">${i}</a>]</c:if>
      <c:if test="${i <= totPage && pag == i}">[<a href="guestList?pag=${i}&pageSize=${pageSize}" class="text-danger"><b>${i}</b></a>]</c:if>
    </c:forEach>
    <c:if test="${curBlock < lastBlock}">[<a href="guestList?pag=${(curBlock+1)*blockSize + 1}&pageSize=${pageSize}">다음블록</a>]</c:if>
    <c:if test="${pag < totPage}">[<a href="guestList?pag=${totPage}&pageSize=${pageSize}">마지막페이지</a>]</c:if>
  </div>
   --%>
  <!-- 페이징처리(블록페이지 시작) -->
  <div class="text-center">
    <ul class="pagination justify-content-center">
      <c:if test="${pageVO.pag > 1}"><li class="page-item"><a href="guestList?pag=1&pageSize=${pageVO.pageSize}" class="page-link text-secondary">첫페이지</a></li></c:if>
      <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a href="guestList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">이전블록</a></li></c:if>
      <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize) + 1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
        <c:if test="${i <= pageVO.totPage && pageVO.pag != i}"><li class="page-item"><a href="guestList?pag=${i}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">${i}</a></li></c:if>
        <c:if test="${i <= pageVO.totPage && pageVO.pag == i}"><li class="page-item"><a href="guestList?pag=${i}&pageSize=${pageVO.pageSize}" class="page-link active bg-secondary border-secondary"><b>${i}</b></a></li></c:if>
      </c:forEach>
      <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a href="guestList?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">다음블록</a></li></c:if>
      <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a href="guestList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">마지막페이지</a></li></c:if>
    </ul>
  </div>
  <!-- 페이징처리(블록페이지 끝) -->
  
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>