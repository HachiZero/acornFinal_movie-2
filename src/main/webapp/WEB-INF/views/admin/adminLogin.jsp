<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function confirm(){
	var f = document.f;
	if (f.id.value == "") {
		alert("아이디를 입력해 주세요.");
		f.id.focus();
		return;
	}
	
	if (f.password.value == "") {
		alert("비밀번호를 입력해 주세요.");
		f.password.focus();
		return;
	}
	f.submit();
}
</script>
</head>
<body>
<%@ include file="../top.jsp" %>
<br>

<c:if test="${admin != null}">
	
</c:if>

<div class="container">
	<div class="row">
		<div class="col s12 m12 l12">
		<form action="adminLogin" method="post" name="f">
			<div class="center">
			<h2>관리자</h2>
			</div>
			관리자 아이디 : <input type="text" name="id">
			관리자 비밀번호 : <input type="password" name="password">
			<input type="button" value="확인" class="btn" onclick="javascript:confirm()">
		</form>
		</div>
	</div>
</div>
	
<%@include file="../footer.jsp" %>

</body>
</html>