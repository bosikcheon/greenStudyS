<%@page import="java.time.LocalDate"%>
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
  <title>memberUpdate.jsp</title>
  <script src="//t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  
  <script>
    'use strict';
    
    let nickCheckSw = 0;
    let emailCheckSw = 0;
    let certificationIdSw = 0;
    let email1 = $("#email1").val();

  	// 정규식을 통한 유효성 검사처리...
    let regNickName = /^[가-힣0-9_]{2,20}$/;		// 닉네임은 2~20자의 한글, 숫자, 밑줄만 가능
    let regName = /^[가-힣a-zA-Z]{2,20}$/;			// 이름은 2~20자의 한글/영문 가능
    const regEmail = /^[a-zA-Z0-9._%+\-]+$/; 	// 이메일은 email형식에 맞도록 처리...
    const regUrl = /^https?:\/\/([a-z0-9-]+\.)+[a-z]{2,}(\/[^\s]*)?$/i; // 홈페이지입력시는 url형식에 맞도록 처리...
    const regTel = /^\d{3,4}$/; 						// 전화번호입력시는 전화번호형식에 맞도록처리
    
    function fCheck() {
    	// 유효성 검사(아이디, 닉네임, 성명, 이메일, 홈페이지, 전화번호, 비밀번호 등등.....)
    	let nickName = document.myform.nickName.value;
    	let name = document.myform.name.value;
    	
    	let email1 = document.myform.email1.value.trim();
    	let email2 = document.myform.email2.value;
    	let email = email1 + "@" + email2;
    	
    	let tel1 = document.myform.tel1.value;
    	let tel2 = document.myform.tel2.value.trim();
    	let tel3 = document.myform.tel3.value.trim();
    	let tel = '';
    	
    	let postcode = document.myform.sample6_postcode.value;
    	let roadAddress = document.myform.sample6_address.value;
    	let detailAddress = document.myform.sample6_detailAddress.value;
    	let extraAddress = document.myform.sample6_extraAddress.value;
    	let address = postcode + " /" + roadAddress + " /" + detailAddress + " /" + extraAddress + " ";
    	
    	let homePage = document.myform.homePage.value.trim();
    	
      if(!regNickName.test(nickName)) {
        alert("닉네임은 한글만 사용가능합니다.");
        document.myform.nickName.focus();
        return false;
      }
      else if(!regName.test(name)) {
        alert("성명은 한글과 영문대소문자만 사용가능합니다.");
        document.myform.name.focus();
        return false;
      }
			
    	if(tel2 != "" && !regTel.test(tel2)) {
    		alert("전화번호(국번호)를 확인하세요.");
        document.getElementById("tel2").focus();
        return false;
			} 
    	if(tel2 == "") tel2 = " ";
    	
    	if(tel3 != "" && !regTel.test(tel3)) {
    		alert("전화번호를 확인하세요.");
        document.getElementById("tel3").focus();
        return false;
			}
    	if(tel3 == "") tel3 = " ";
			
  		tel = tel1 + "-" + tel2 + "-" + tel3;
			 
  	  // 선택된 목록에서 value 찾기
  	  const query = 'input[name="hobby"]:checked';
  	  const selectedEls =  document.querySelectorAll(query);
  	  
  	  let hobbys = '';
  	  selectedEls.forEach((el) => {
  	  	hobbys += el.value + '/';
  	  });
  	  hobbys = hobbys.substring(0,hobbys.length-1);
    	
			// 전송전에 파일에 관련된 사항들을 체크해준다.
			let fName = document.getElementById("file").value;
			if(fName.trim() != "") {
				let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
				let maxSize = 1024 * 1024 * 10;
				let fileSize = document.getElementById("file").files[0].size;
				
				if(ext != 'jpg' && ext != 'gif' && ext != 'png') {
					alert("그림파일만 업로드 가능합니다.");
					return false;
				}
				else if(fileSize > maxSize) {
					alert("업로드할 파일의 최대용량은 10MByte입니다.");
					return false;
				}
			}
			
			// 아이디/닉네임 중복버튼 눌렀는지 체크
			let tempNickName = $("#nickName").val();
			let tempEmail = '${vo.email}'.split('@');
			
    	if(tempNickName != '${sNickName}' && nickCheckSw == 0) {
    		alert("닉네임 중복체크버튼을 눌러주세요");
    		document.getElementById("nickNameBtn").focus();
    	}
    	else if(emailCheckSw == 0 && tempEmail[0] != $("#email1").val()) {
    		alert("이메일 인증 버튼을 눌러주세요");
    		document.getElementById("emailId").focus();
    	}
    	/* 
    	else if(certificationEmailSw == 0) {
    		alert("이메일 인증번호 확인 버튼을 눌러주세요");
    		document.getElementById("certificationId").focus();
    	}
    	 */
    	else {
    		myform.email.value = email;
    		myform.tel.value = tel;
    		myform.address.value = address;
    		myform.hobbys.value = hobbys;
    		
    		myform.submit();
    	}
    }
    
    // 이메일 확인체크
    function certificationEmailCheck() {
    	certificationIdSw = 1;
    }
    
    // 닉네임 중복체크
    function nickCheck() {
    	let nickName = myform.nickName.value;
    	
    	if(nickName.trim() == "") {
    		alert("닉네임을 입력하세요!");
    		myform.nickName.focus();
    	}
    	else {
    		$.ajax({
    			url  : "memberNickCheck",
    			type : "post",
    			data : {nickName : nickName},
    			success: (res) => {
    				if(res != '0') {
    					alert("이미 사용중인 닉네임 입니다. 다시 입력하세요.");
    					myform.nickName.focus();
    				}
    				else {
    					alert("사용 가능한 닉네임 입니다.");
    					nickCheckSw = 1;
    				}
    			},
    			error : () =>	alert("전송 오류!")
    		});
    	}
    }
    
    // 닉네임/이메일 확인처리시, 닉네임/이메일 체크확인
    $(function(){
    	$("#nickName").on("blur", () => nickCheckSw = 0);
    	$("#certificationId").on("blur", () => emailCheckSw = 0);
    	$("#email1").on("blur", () => {
    		if($("#email1").val() != email1) {
      		alert("이메일이 변경되었습니다. 다시 인증처리 하세요.");
    			location.reload();
    		}
    	});
    });
    
    // 선택된 사진 미리보기
    function imgCheck(e) {
    	if(e.files && e.files[0]) {
    		let reader = new FileReader();
    		reader.onload = function(e) {
    			document.getElementById("photoDemo").src = e.target.result;
    		}
    		reader.readAsDataURL(e.files[0]);
    	}
    }
    
    // 이메일 인증번호 체크하기
    function emailCheck() {
    	// 이메일까지 유효성 검사 체크할것
    	let nickName = myform.nickName.value;
    	let name = myform.name.value;
    	let email1 = myform.email1.value.trim();
    	let email2 = myform.email2.value;
    	let email = email1 + "@" + email2;
    	
    	if(!regNickName.test(nickName)) {
        alert("닉네임은 한글만 사용가능합니다.");
        myform.nickName.focus();
        return false;
      }
      else if(!regName.test(name)) {
        alert("성명은 한글과 영문대소문자만 사용가능합니다.");
        myform.name.focus();
        return false;
      }
    	
    	// 인증번호 호출 버튼 가리기..(로딩을 알리는 spiner를 표시시켜준ㄴ다.)
    	$("#emailId").hide();
    	let spin = "<div class='text-center'><div class='spinner-border text-muted'></div> 메일 발송중입니다. 잠시만 기다려주세요 <div class='spinner-border text-muted'></div></div>";
      $("#demoSpin").html(spin);
    	    	
    	// aJax() 호출
    	$.ajax({
    		url  : '${ctp}/member/memberEmailCheck',
    		type : 'post',
    		data : {email : email},
    		success: (res) => {
    			if(res != 0) {
    				alert("인증번호가 발송되었습니다.\n메일 확인후 아래 인증폼에 인증번호를 입력해 주세요.");
    				let str = '<div class="input-group">';
    				str += '<input type="text" name="checkKey" id="checkKey" class="form-control"/>';
    				str += '<input type="button" value="인증번호확인" onclick="emailCertificationOk()" class="btn btn-secondary btn-sm"/>';
    				str += '</div>';
    				$('#demoSpin').html(str);
    				emailCheckSw = 1;
    			}
    		},
    		error : () => alert("전송오류")
    	});
    }
    
    // 발송된 인증번호 확인처리
    function emailCertificationOk() {
    	let checkKey = $("#checkKey").val();
    	
    	if(checkKey.trim() == "") {
    		alert("전송받은 메일에서 인증키를 찾아서 입력해 주세요");
    		return false;
    	}
    	
    	$.ajax({
    		url  : 'memberEmailCheckOk',
    		type : 'post',
    		data : {checkKey : checkKey},
    		success: (res) => {
    			if(res != '0') {
    				$('#demoSpin').hide();
    				$('#addContent').show();
    				certificationIdSw = 1;
    			}
    			else alert("인증코드 오료!!\n인증코드 확인후 다시 전송처리해 주세요.");
    		},
    		error : () => alert("전송오류")
    	});
    }
  </script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/slide2.jsp" %>
<p><br/></p>
<div class="container">
  <form name="myform" method="post" class="was-validated" enctype="multipart/form-data">
    <h2>회 원 정 보 수 정</h2>
    <br/>
    <div class="input-group mb-3">
      <div class="input-group-text"><label for="mid">아이디</label></div>
      <input type="text" class="form-control" name="mid" id="mid" value="${vo.mid}" readonly />
    </div>
    <div class="input-group mb-3">
      <div class="input-group-text"><label for="nickName">닉네임</label></div>
      <input type="text" class="form-control" id="nickName" name="nickName" value="${vo.nickName}" required />
      <input type="button" id="nickNameBtn" value="닉네임 중복체크" class="btn btn-secondary btn-sm" onclick="nickCheck()"/>
    </div>
    <div class="input-group mb-3">
      <div class="input-group-text"><label for="name">성명 :</label></div>
      <input type="text" class="form-control" id="name" name="name" value="${vo.name}" required />
    </div>
    <div class="input-group mb-3">
      <div class="input-group-text"><label for="email1">Email address:</label></div>
      <c:set var="email" value="${fn:split(vo.email,'@')}" />
      <input type="text" class="form-control" id="email1" name="email1" value="${email[0]}" required />
      <div class="input-group-text">@</div>
      <select name="email2" id="email2" class="form-select">
        <option ${email[1]=='naver.com'   ? 'selected' : ''}>naver.com</option>
        <option ${email[1]=='hanmail.net' ? 'selected' : ''}>hanmail.net</option>
        <option ${email[1]=='hotmail.com' ? 'selected' : ''}>hotmail.com</option>
        <option ${email[1]=='gmail.com'   ? 'selected' : ''}>gmail.com</option>
        <option ${email[1]=='nate.com'    ? 'selected' : ''}>nate.com</option>
        <option ${email[1]=='yahoo.com'   ? 'selected' : ''}>yahoo.com</option>
      </select>
      <input type="button" value="인증번호받기" onclick="emailCheck()" id="emailId" class="btn btn-secondary btn-sm"/>
    </div>
    <div id="certification" class="input-group mb-3" style="display:none">
      <div class="input-group-text">인증번호</div>
      <input type="text" name="certificationId" id="certificationId" class="form-control"/>
      <input type="button" value="이메일인증번호확인" onclick="certificationEmailCheck()"  class="btn btn-secondary btn-sm"/>
    </div>
    <div id="demoSpin"></div>
    <div id="addContent">
      <div class="input-group mb-3">
        <span class="input-group-text">성별 :</span> &nbsp; &nbsp;
        <div class="form-check"><input type="radio" name="gender" value="남자" ${vo.gender=='남자' ? 'checked' : ''} class="me-1" checked />남자</div>
        <div class="form-check"><input type="radio" name="gender" value="여자" ${vo.gender=='여자' ? 'checked' : ''} class="ms-3 ms-4 me-1" />여자</div>
      </div>
      <div class="input-group mb-3">
        <div class="input-group-text"><label for="birthday">생일</label></div>
        <input type="date" name="birthday" value="${fn:substring(vo.birthday,0,10)}" class="form-control"/>
      </div>
      <div class="input-group">
        <div class="input-group mb-3">
          <c:set var="tel" value="${fn:split(vo.tel,'-')}" />
          <span class="input-group-text">전화번호 :</span> &nbsp;&nbsp;
          <select name="tel1" id="tel1" class="custom-select">
            <option value="010" ${tel[0]=='010' ? 'selected' : ''}>010</option>
            <option value="02"  ${tel[0]=='02'  ? 'selected' : ''}>서울</option>
            <option value="031" ${tel[0]=='031' ? 'selected' : ''}>경기</option>
            <option value="032" ${tel[0]=='032' ? 'selected' : ''}>인천</option>
            <option value="041" ${tel[0]=='041' ? 'selected' : ''}>충남</option>
            <option value="042" ${tel[0]=='042' ? 'selected' : ''}>대전</option>
            <option value="043" ${tel[0]=='043' ? 'selected' : ''}>충북</option>
            <option value="051" ${tel[0]=='051' ? 'selected' : ''}>부산</option>
            <option value="052" ${tel[0]=='052' ? 'selected' : ''}>울산</option>
            <option value="061" ${tel[0]=='061' ? 'selected' : ''}>전북</option>
            <option value="062" ${tel[0]=='062' ? 'selected' : ''}>광주</option>
          </select>-
          <input type="text" name="tel2" id="tel2" value="${tel[1]}" size=4 maxlength=4 class="form-control"/>-
          <input type="text" name="tel3" id="tel3" value="${tel[2]}" size=4 maxlength=4 class="form-control"/>
        </div>
      </div>
      <div class="input-group mb-3">
        <c:set var="address" value="${fn:split(vo.address,'/')}" />
        <label for="address">주소</label>
        <div class="input-group mb-1">
          <input type="text" id="sample6_postcode" value="${address[0]}" class="form-control">
  				<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-success">
  			</div>
  			<div class="input-group mb-1">
  				<input type="text" id="sample6_address" value="${address[1]}" class="form-control"><br>
  			</div>
  			<div class="input-group mb-1">
  				<input type="text" id="sample6_detailAddress" value="${address[2]}" class="form-control">
  				<input type="text" id="sample6_extraAddress" value="${address[3]}" class="form-control">
        </div>
      </div>
      <div class="input-group mb-3">
        <div class="input-group-text"><label for="homepage">Homepage address:</label></div>
        <input type="text" class="form-control" name="homePage" value="${vo.homePage}" id="homePage"/>
      </div>
      <div class="input-group mb-3">
        <div class="input-group-text"><label for="job">직업</label></div>
        <select class="form-select" id="job" name="job">
          <option ${vo.job=='학생' ? 'selected' : ''}>학생</option>
          <option ${vo.job=='회사원' ? 'selected' : ''}>회사원</option>
          <option ${vo.job=='공무원' ? 'selected' : ''}>공무원</option>
          <option ${vo.job=='군인' ? 'selected' : ''}>군인</option>
          <option ${vo.job=='의사' ? 'selected' : ''}>의사</option>
          <option ${vo.job=='법조인' ? 'selected' : ''}>법조인</option>
          <option ${vo.job=='세무인' ? 'selected' : ''}>세무인</option>
          <option ${vo.job=='자영업' ? 'selected' : ''}>자영업</option>
          <option ${vo.job=='기타' ? 'selected' : ''}>기타</option>
        </select>
      </div>
      <div class="input-group mb-3">
        <span class="input-group-text">취미</span>
        <c:set var="varHobbys" value="${fn:split('등산/낚시/수영/독서/영화감상/바둑/축구/기타','/')}"/>
        <c:forEach var="tempHobby" items="${varHobbys}" varStatus="st">
          <input type="checkbox" name="hobby" value="${tempHobby}" <c:if test="${fn:contains(vo.hobby,varHobbys[st.index])}">checked</c:if> /> ${tempHobby}&nbsp;
        </c:forEach>
      </div>
      <div class="input-group mb-3">
        <div class="input-group-text"><label for="content">자기소개</label></div>
        <textarea rows="5" class="form-control" id="content" name="content">${vo.content}</textarea>
      </div>
      <div class="input-group mb-3">
        <span class="input-group-text">정보공개</span>  &nbsp; &nbsp;
        <div class="form-check"><input type="radio" name="userInfor" value="공개"  ${vo.userInfor=='공개' ? 'checked' : ''} class="me-1" />공개</div>
        <div class="form-check"><input type="radio" name="userInfor" value="비공개" ${vo.userInfor=='비공개' ? 'checked' : ''} class="ms-3 ms-4 me-1" />비공개</div>
      </div>
      <div class="row">
        <div class="col"><img src="${ctp}/member/${vo.photo}" width="100px"/></div>
        <div class="col text-end"><img id="photoDemo" width="100px"/></div>
      </div>
      <div  class="input-group mb-3">
        <div class="input-group-text">회원 사진(파일용량:2MByte이내) : </div>
        <input type="file" name="fName" id="file" onchange="imgCheck(this)" class="form-control border"/>
      </div>
      <div>
        <button type="button" class="btn btn-success" onclick="fCheck()">회원정보수정</button> &nbsp;
        <button type="button" onclick="location.reload()" class="btn btn-secondary">다시작성</button> &nbsp;
        <button type="button" class="btn btn-warning" onclick="location.href='memberLogin';">돌아가기</button>
      </div>
    </div>
    <input type="hidden" name="email"/>
    <input type="hidden" name="address"/>
    <input type="hidden" name="tel"/>
    <input type="hidden" name="hobbys"/>
    <input type="hidden" name="photo" value="${vo.photo}"/>
  </form>
</div>
<p><br/></p>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>