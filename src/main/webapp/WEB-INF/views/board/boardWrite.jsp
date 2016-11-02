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
function wformCheck(){
	var f = document.f;
	if (f.b_title.value == "") {
		alert("제목을 입력하세요.");
		f.b_title.focus();
		return;
	}
	if (f.b_name.value == "") {
		alert("이름을 입력하세요.");
		f.b_name.focus();
		return;
	}
	if (f.b_email.value == "") {
		alert("이메일을 입력하세요.");
		f.b_email.focus();
		return;
	}
	if (f.b_tel.value == "") {
		alert("연락처를 입력하세요.");
		f.b_tel.focus();
		return;
	}
	if (f.b_content.value == "") {
		alert("내용을 입력하세요.");
		f.b_content.focus();
		return;
	}
	if (f.b_pass.value == "") {
		alert("해당 게시글의 비밀번호를 등록하세요.");
		f.b_pass.focus();
		return;
	}
	
	if(confirm("정말 등록하시겠습니까?")){
		f.submit();	
	}
}
</script>
<style type="text/css">
body{line-height: 1.0;}
</style>
</head>

<body>
<%@ include file="../top.jsp" %>

<br>

<!-- 글쓰기 -->
<form action="boardWrite" method="post" name="f">
<input type="hidden" name="b_no" value="${count}">
<div class="container">
    <!-- Table -->
 	<table>
  		<tr>
    		<th style="width: 10%">제목</th><td colspan="3"><input type="text" name="b_title"></td>
   		</tr>
   		<tr>
   			<th>작성자</th><td><input type="text" name="b_name" ></td>
   		</tr>
   		<tr>
   			<th>메일</th><td><input type="email" name="b_email"></td>
   		</tr>
   		<tr>
   			<th>연락처</th><td><input type="tel" name="b_tel"></td>
   		</tr>
   		<tr>
   			<th>내용</th>
   			<td><textarea rows="10" style="width: 100%; height: 100%; border: none;" name="b_content"></textarea></td>
   		</tr>
   		<tr>
   			<th>비밀번호</th><td><input type="text" name="b_pass"></td>
   		</tr>
	</table>	
 	<!-- //table -->
  
</div>
</form>

<br><br>
  
<!-- //게시판리스트 -->
<div class="container center">
	<div class="row">
		<div class="col s12 m12 l12">
        	<button type="button" onclick="javascript:wformCheck()" class="btn btn-default">등록완료</button>
        	<button type="button" onclick="javascript:history.back()" class="btn btn-default">돌아가기</button>
        </div>
   	</div>
</div>
<br>

<%@include file="../footer.jsp" %>

</body>
</html>