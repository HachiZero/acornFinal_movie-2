<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function answerWrite(){
	var f = document.answerF;
	f.action = "answerWrite";
	f.submit();
}
function selectAllDelete(){
	var f = document.answerF;
	f.action = "selectAllDelete";
	f.submit();
}
</script>
</head>
<body>

<form action="" method="post" name="answerF">

<input type="hidden" name="a_no" value="${dto.b_no}">
<div class="container">

 <!-- Table -->
 	<table>
 		<tr><th colspan="2" style="text-align: center;"><h3>관리자</h3></th></tr>
  		<tr>
    		<th style="width: 10%">제목</th><td colspan="3"><input type="text" name="a_title"></td>
   		</tr>
   		<tr>
   			<th>내용</th>
   			<td><textarea rows="10" style="width: 100%; height: 100%; border: none;" name="a_content"></textarea></td>
   		</tr>
	</table>	
 	<!-- //table -->
</div>

<div class="container center">
	<div class="row">
		<div class="col s12 m12 l12">
        	<button type="button" onclick="javascript:answerWrite()" class="btn btn-default">답변 등록</button>
        	<button type="button" onclick="javascript:selectAllDelete()" class="btn btn-default">게시글 삭제</button>
        </div>
   	</div>
</div>

</form>
</body>
</html>