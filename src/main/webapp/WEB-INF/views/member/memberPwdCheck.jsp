<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberPwdCheck.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script>
    'use strict';
    
    $(function() {
    	$("#pwdDemo").hide();
    });
    
    function pwdCheck() {
    	let pwd = $("#pwd").val().trim();
    	if(pwd == "") {
    		alert("현재 비밀번호를 입력하세요");
    		$("#pwd").focus();
    		return false;
    	}
    	
    	$.ajax({
    		url  : '${ctp}/member/memberPwdCheckOk',
    		type : 'post',
    		data : {
    			pwd : pwd,
    			mid : '${sMid}'
    		},
    		success: (res) => {
    			if(res != "0") {
    				if('${pwdFlag}' == 'p') {
    					$("#pwdConfirmForm").hide();
    					$("#pwdDemo").show();
    				}
    				else location.href = "${ctp}/member/memberUpdate";
    			}
    			else alert("비밀번호 오류!!!");
    		},
    		error : () => alert('전송오류')
    	});
    }
    
    function pwdChangeCheck() {
    	let pwdCheck = $("#pwdCheck").val();
    	let pwdCheckRe = $("#pwdCheckRe").val();
    	
    	if(pwdCheck.trim() == "" || pwdCheckRe.trim() == "") {
    		alert("변경할 비밀번호를 입력하세요");
    		$("#pwdCheck").focus();
    		return false;
    	}
    	else if(pwdCheck != pwdCheckRe) {
    		alert("새로 입력한 비밀번호가 틀립니다. 확인하세요");
    		$("#pwdCheckRe").focus();
    		return false;
    	}
    	
    	$.ajax({
    		url  : '${ctp}/member/memberPwdChangeOk',
    		type : 'post',
    		data : {
    			pwd : pwdCheck,
    			mid : '${sMid}'
    		},
    		success: (res) => {
    			if(res != "0") {
    				alert("비밀번호가 변경되었습니다.\n다시 로그인 하세요.");
    				location.href = '${ctp}/member/memberLogout';
    			}
    			else alert("비밀번호 변경오류!!!");
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
  <form name="pwdConfirmForm" id="pwdConfirmForm">
    <h2 class="text-center">비밀번호 확인</h2>
    <table class="table table-bordered text-center">
      <tr>
        <td colspan="2">
          <b>비밀번호 확인</b>
          <div>(회원 정보 수정을 하기 위해서는 현재 비밀번호를 확인합니다.)</div>
        </td>
      </tr>
      <tr>
        <td>현재 비밀번호</td>
        <td><input type="password" name="pwd" id="pwd" class="form-control" autofocus required /></td>
      </tr>
      <tr>
        <td colspan="2">
          <input type="button" value="비밀번호 확인" onclick="pwdCheck()" class="btn btn-success"/>
          <input type="reset" value="다시입력" class="btn btn-warning"/>
          <input type="button" value="돌아가기" onclick="location.href='memberMain'" class="btn btn-danger"/>
        </td>
      </tr>
    </table>
  </form>
  <div id="pwdDemo">
    <form name="pwdChangeForm" method="post">
      <h2 class="text-center">비밀번호 확인</h2>
      <table class="table table-bordered text-center">
        <tr>
          <td colspan="2">
            <b>비밀번호 변경</b>
          </td>
        </tr>
        <tr>
          <td>변경할 비밀번호</td>
          <td><input type="password" name="pwdCheck" id="pwdCheck" placeholder="변경할 비밀번호를 입력하세요." class="form-control" required /></td>
        </tr>
        <tr>
          <td>비밀번호 확인</td>
          <td><input type="password" name="pwdCheckRe" id="pwdCheckRe" placeholder="비밀번호 확인.." class="form-control" required /></td>
        </tr>
        <tr>
          <td colspan="2">
            <input type="button" value="비밀번호변경" onclick="pwdChangeCheck()" class="btn btn-success"/>
            <input type="reset" value="다시입력" class="btn btn-warning"/>
            <input type="button" value="돌아가기" onclick="location.href='memberMain'" class="btn btn-danger"/>
          </td>
        </tr>
      </table>
    </form> 
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>