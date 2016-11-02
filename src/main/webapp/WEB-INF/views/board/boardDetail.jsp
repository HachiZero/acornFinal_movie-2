<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
var reconfirm = "";

function getPassword(mode) {
	var f = document.f;
	$('#modalPass').openModal();
	$('#b_pass').focus();
	f.action = mode;
	if(mode == "boardUpdate") reconfirm = "수정";
	if(mode == "boardDelete") reconfirm = "삭제";
}

function checkPwdFrm() {
	var f = document.f;
	if (f.b_pass.value == "") {
		alert("비밀번호를 입력해 주세요.");
		f.b_pass.focus();
		return;
	}
	
	if(confirm("정말 " + reconfirm + "하시겠습니까?")) {
		f.submit();		
	}
}

function closePwd() {
	$('#modalPass').closeModal();
}

</script>
<style>
th {
	font-weight: bold;	
}
td {
	font-family: 'Abel', sans-serif;
}

</style>

</head>
<body>

<%@ include file="../top.jsp" %>

<br><br>

<div class="container">
 <!-- Table -->
 	<table class="bordered" border="1">
  		<tr>
    		<th style="width: 100px">제목</th><td colspan="3">${dto.b_title}</td>
   		</tr>
   		<tr>
   			<th>작성자</th>
   			<c:if test="${admin != null}">
				<td title="${dto.b_tel}">${dto.b_name}</td>
			</c:if>
			<c:if test="${admin == null}">
				<td>${dto.b_name}</td>
			</c:if>
   			<th style="width: 100px">작성일</th><td>${fn:substring(dto.b_date, 0, 10)}</td>
   		</tr>
   		<tr>
   			<th>메일</th><td>${dto.b_email}</td> 
   			<th style="width: 100px">답변</th>
   			<c:if test="${dto.b_state == 0}">
				<td>미답변</td>
			</c:if>
			<c:if test="${dto.b_state == 1}">
				<td>답변완료</td>
			</c:if>
   		</tr>
   		<tr>
   			<th rowspan="4">내용</th>
   			<td colspan="3" rowspan="4"><textarea rows="10" style="width: 100%; height: 100%; border: none;" readonly="readonly">${dto.b_content}</textarea></td>
   		</tr>
	</table>
<!-- //table -->  
</div>

<!-- 답변 -->

<c:if test="${admin != null and dto.b_state == 0}">
	<%@include file="answer/answerWrite.jsp" %>
</c:if>

<c:if test="${param.mode == null and dto.b_state == 1}">
	<%@include file="answer/answerDetail.jsp" %>
</c:if>

<c:if test="${param.mode != null and dto.b_state == 1}">
	<%@include file="answer/answerUpdate.jsp" %>
</c:if>

<!-- //답변 -->

<!-- //게시판리스트 -->
<br><br>

<div class="container center">
<div class="row">
	<div class="col s12 m12 l12">
        	<button type="button" onclick="javascript:getPassword('boardUpdate')" class="btn btn-default">수정</button>
        	<button type="button" onclick="javascript:getPassword('boardDelete')" class="btn btn-default">삭제</button>
        	<button type="button" onclick="javascript:history.back();" class="btn btn-default">돌아가기</button>
		</div>
</div>
</div>


<!-- 비밀번호 폼 -->
<!-- Modal Structure -->
<div id="modalPass" class="modal center" style="width: 300px; height: 250px;">
	<div class="modal-content">
		<div>
		<form name="f" id="f" method="get">
			<input type="hidden" name="b_no" id="b_no" value="${dto.b_no}"/>
			<h4>비밀번호</h4>
			<label>해당 게시글의 비밀번호를 입력해주세요</label>
	        <input type="password" maxlength="20" name="b_pass" id="b_pass">
	       	<button type="button" onclick="javascript:closePwd();" class="btn btn-default">Close</button>
	        <button type="button" onclick="javascript:checkPwdFrm();" class="btn btn-default">OK</button>
		</form>
		</div>
	</div>
</div>
<!-- //비밀번호 폼 -->

<%@include file="../footer.jsp" %>

</body>
</html>