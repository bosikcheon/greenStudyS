<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>ajaxTest3.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script>
    'use strict';
    
    function dodoCheck() {
    	let dodo = $("#dodo").val();
    	if(dodo.trim() == "") {
    		alert("지역명을 선택하세요");
    		return false;
    	}
    	
    	$.ajax({
    		url  : "ajaxTest3",
    		type : "post",
    		dataType: "json",
    		data : {dodo : dodo},
    		success: (res) => {
    			console.log("res", res);
    			console.log("res", res.length);
    			let str = '<option value="">도시선택</option>';
    			for(let i=0; i<res.length; i++) {
    				if(res[i] == null) break;
    				str += '<option>'+res[i]+'</option>';
    			}
    			$("#city").html(str);
    		},
    		error : () => alert("전송오류!")
    	});
    }
    
    function fCheck() {
    	if($("#city").val() == "") {
    		alert("도/지역(을)를 먼저 선택해 주세요");
    		return false;
    	}
    	
    	let str = "선택하신 지역은 <font color='red'><b>" + $("#dodo").val() + " : " + $("#city").val() + "</b></font> 입니다.";
    	$("#demo").html(str);
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <h2>aJaxText3(배열처리)</h2>
  <form>
    <h2>도시를 입력하세요.</h2>
    <select name="dodo" id="dodo" onchange="dodoCheck()">
      <option value="">지역선택</option>
      <option>서울</option>
      <option>경기</option>
      <option>충북</option>
      <option>충남</option>
    </select>
    <select name="city" id="city">
      <option value="">도시선택</option>
    </select>
    <input type="button" value="선택" onclick="fCheck()" class="btn btn-success me-3 mb-3">
    <input type="button" value="돌아가기" onclick="location.href='ajaxForm'" class="btn btn-info me-3 mb-3">
  </form>
  <hr/>
  <div id="demo"></div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>