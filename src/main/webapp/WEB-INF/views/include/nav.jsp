<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<script>
  function userDelCheck() {
  	let ans = confirm("회원 탈퇴하시겠습니까?");
  	if(ans) {
  		ans = confirm("탈퇴하시면 1개월간 같은 아이디로는 다시 가입하실수 없습니다.\n그래도 탈퇴 하시겠스니까?");
  		if(ans) {
  			$.ajax({
  				url  : '${ctp}/member/userDel',
  				type : "post",
  				success: (res) => {
  					if(res != "0") {
  						alert("회원에서 탈퇴 되셨습니다.");
  						location.href = '${ctp}/member/memberLogin';
  					}
  					else alert("회원 탈퇴신청 실패~~");
  				},
  				error : () => alert("전송오류!")
  			});
  		}
  	}
  }
</script>

<div class="w3-top">
  <div class="w3-bar w3-black w3-card">
    <a class="w3-bar-item w3-button w3-padding-large w3-hide-medium w3-hide-large w3-right" href="javascript:void(0)" onclick="myFunction()" title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a>
    <%-- <a href="${ctp}/" class="w3-bar-item w3-button w3-padding-large">HOME</a> --%>
    <a href="http://192.168.50.20:9090/greenStudyS" class="w3-bar-item w3-button w3-padding-large">HOME</a>
    <a href="${ctp}/guest/guestList" class="w3-bar-item w3-button w3-padding-large w3-hide-small">GUEST</a>
    <c:if test="${!empty sLevel}">
      <a href="${ctp}/board/boardList" class="w3-bar-item w3-button w3-padding-large w3-hide-small">BOARD</a>
      <a href="${ctp}/pds/pdsList" class="w3-bar-item w3-button w3-padding-large w3-hide-small">PDS</a>
      <div class="w3-dropdown-hover w3-hide-small">
        <button class="w3-padding-large w3-button" title="More">Study1 <i class="fa fa-caret-down"></i></button>     
        <div class="w3-dropdown-content w3-bar-block w3-card-4">
          <a href="${ctp}/study/ajaxForm" class="w3-bar-item w3-button">Ajax 연습</a>
          <a href="${ctp}/user/userList/idxOrderDesc" class="w3-bar-item w3-button">DB Test</a>
          <a href="${ctp}/user2/user2Main" class="w3-bar-item w3-button">Mybatis Test</a>
          <a href="${ctp}/study/fileUpload" class="w3-bar-item w3-button">FileUpload Test</a>
          <a href="${ctp}/study/mailForm" class="w3-bar-item w3-button">메일연습</a>
          <a href="${ctp}/study/passForm" class="w3-bar-item w3-button">비밀번호 암호화</a>
        </div>
      </div>
      <div class="w3-dropdown-hover w3-hide-small">
        <button onclick="location.href='${ctp}/member/memberMain'" class="w3-padding-large w3-button" title="More">MyPage <i class="fa fa-caret-down"></i></button>     
        <div class="w3-dropdown-content w3-bar-block w3-card-4">
          <c:if test="${sLevel != 3}">
            <a href="${ctp}/member/memberList" class="w3-bar-item w3-button">회원리스트</a>
          </c:if>
          <a href="${ctp}/member/memberPwdCheck/p" class="w3-bar-item w3-button">비밀번호변경</a>
          <a href="${ctp}/member/memberPwdCheck/u" class="w3-bar-item w3-button">회원정보수정</a>
          <a href="javascript:userDelCheck()" class="w3-bar-item w3-button">회원탈퇴</a>
          <c:if test="${sLevel == 0}"><a href="${ctp}/admin/adminMain" class="w3-bar-item w3-button">관리자메뉴</a></c:if>
        </div>
      </div>
    </c:if>
    <c:if test="${empty sLevel}">
      <a href="${ctp}/member/memberLogin" class="w3-padding-large w3-button" title="More">Login</a>     
      <a href="${ctp}/member/memberJoin" class="w3-padding-large w3-button" title="More">Join</a>
    </c:if>
    <c:if test="${!empty sLevel}">
      <a href="${ctp}/member/memberLogout" class="w3-padding-large w3-button" title="More">Logout</a>
    </c:if>
    <!-- <a href="javascript:void(0)" class="w3-padding-large w3-hover-red w3-hide-small w3-right"><i class="fa fa-search"></i></a> -->
  </div>
</div>

<!-- Navbar on small screens (remove the onclick attribute if you want the navbar to always show on top of the content when clicking on the links) -->
<div id="navDemo" class="w3-bar-block w3-black w3-hide w3-hide-large w3-hide-medium w3-top" style="margin-top:46px">
  <a href="#band" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">GUEST</a>
  <a href="#tour" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">BOARD</a>
  <a href="#contact" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">PDS</a>
  <a href="#" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">MEMBER</a>
</div>