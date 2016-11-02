<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="answerUpdate" method="post" name="update">

<input type="hidden" name="a_no" value="${dto.b_no}">
<div class="container">

 <!-- Table -->
 	<table>
 		<tr><th colspan="2" style="text-align: center;"><h3>관리자</h3></th></tr>
  		<tr>
    		<th style="width: 10%">제목</th><td colspan="3"><input type="text" name="a_title" value="${answer.a_title}"></td>
   		</tr>
   		<tr>
   			<th>내용</th>
   			<td><textarea rows="10" style="width: 100%; height: 100%; border: none;" name="a_content">${answer.a_content}</textarea></td>
   		</tr>
	</table>	
 	<!-- //table -->
</div>

<div class="container center">
	<div class="row">
		<div class="col s12 m12 l12">
        	<button type="submit" class="btn btn-default">수정 완료</button>
        	<a href=""><button type="button" class="btn btn-default">게시글 삭제</button></a>
        </div>
   	</div>
</div>

</form>

</body>
</html>