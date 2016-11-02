<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" type="text/css" href="resources/css/index.css">
<script type="text/javascript">

function serach(){
	if(document.searchFrm.sword.value == ""){
		document.searchFrm.sword.focus();
		alert("검색어를 입력하세요!");
		return;
	}
	document.searchFrm.submit();
}

function getPassword(no) {
	var f = document.f;
	$('#modalPass').openModal();
	$('#b_pass').focus();
	f.b_no.value = no;
	f.action = "boardDetail";
}

function checkPwd() {
	var f = document.f;
	if (f.b_pass.value == "") {
		alert("비밀번호를 입력해 주세요.");
		f.b_pass.focus();
		return;
	}
	
	f.submit();		
}

function closePwd() {
	$('#modalPass').closeModal();
}

</script>

<!-- 메인 메뉴바 가운데 정렬 -->

<body>

<%@ include file="../top.jsp" %>

<!-- 검색창 -->
<div class="container">
   <div class="row"></div>
   <div class="row">
      <div class="col s12 m6 l6"></div>
      <div class="col s12 m6 l6">
            <form action="boardSearch" name="searchFrm" method="post" >
               <div class="col s1 m1 l1">
                  <a href="boardList"><i class="material-icons" id="boardicon">view_list</i></a>
               </div>
               <div class="col s4 m4 l4">   
                  <select name="stype" class="browser-default" > <!-- style="width: 25%" -->
                     <option value="b_title" selected="selected">글제목</option>
                     <option value="b_name">글작성자</option>
                  </select>
               </div>
               <div class="col s5 m5 l5">
                  <input type="text" name="sword" placeholder="검색어를 입력하세요" class="validate">
               </div>
               <div class="col s1 m1 l1">
                  <a href="javascript:serach();"><i class="material-icons" id="boardicon">search</i></a>&nbsp;&nbsp;
               </div>
               <div class="col s1 m1 l1" >                  
                  <a href="boardWrite"><i class="material-icons" id="boardicon">mode_edit</i></a>
               </div>
            </form>
      </div>
   </div>
</div>
<!-- //검색창 -->

<!-- 게시판리스트 -->
<div class="container">
<!-- Table -->
<table class="highlight">
	<tr style="font-weight: bold">
		<th style="width: 15%">번호</th><th style="width: 45%">제목</th><th style="width: 15%">작성자</th><th style="width: 15%">작성일</th><th style="width: 10%">답변</th>
	</tr>
<c:forEach var="b" items="${list}">
	<tr>
		<td>${b.b_no}</td>
		<c:if test="${admin != null}">
			<td><a href="boardDetail?b_no=${b.b_no})">${b.b_title}<i  id="boardlock" class="material-icons">lock_outline</i></a></td>
		</c:if>
		<c:if test="${admin == null}">
			<td><a href="javascript:getPassword(${b.b_no})">${b.b_title}<i  id="boardlock" class="material-icons">lock_outline</i></a></td>
		</c:if>
		</td>
		<td>${b.b_name}</td>
		<td>${fn:substring(b.b_date, 0, 10)}</td>
		<c:if test="${b.b_state == 0}">
			<td>미답변</td>
		</c:if>
		<c:if test="${b.b_state == 1}">
			<td>답변완료</td>
		</c:if>
	</tr>
</c:forEach>
  	
</table>
 <!-- //table -->
</div>

<!-- //게시판리스트 -->
<div class="container">
<div class="row">
<div class="col s12 m12 l12">
	<ul class="pagination"  style="text-align: center;">
	
		<!-- 첫페이지로 가기 -->
		<c:if test="${pageNum <= 1}"> 
			<li class="disabled"><a href="#">First</a></li>
		</c:if>		 
		<c:if test="${pageNum > 1}">
			<c:if test="${sword != null}">
				<li class="waves-effect"><a href="boardSearch?page=&list=${pageList}&stype=${stype}&sword=${sword}">First</a></li>
			</c:if>
			<c:if test="${sword == null}">
				<li class="waves-effect"><a href="boardList?page=&list=${pageList}">First</a></li>	
			</c:if>
		</c:if>
		<!-- //첫페이지로 가기 -->
		
		<!-- 이전 10개 -->	
		<c:if test="${block <= 1}">
			<li class="disabled"><a href="#!"><i class="material-icons">chevron_left</i></a></li>
		</c:if>
		<c:if test="${block > 1}">
			<c:if test="${sword != null}">
				<li class="waves-effect"><a href="boardSearch?page=${b_start_page - 1}&list=${pageList}&stype=${stype}&sword=${sword}"><i class="material-icons">chevron_left</i></a></li>
			</c:if>
			<c:if test="${sword == null}">
				<li class="waves-effect"><a href="boardList?page=${b_start_page - 1}&list=${pageList}"><i class="material-icons">chevron_left</i></a></li>
			</c:if>
		</c:if>
		<!-- //이전 10개 -->
		
		<!-- 페이지 리스트 -->
		<c:forEach var="i" begin="${b_start_page}" end="${b_end_page}">
			<c:if test="${pageNum == i}">
				<li class="active"><a href="#!">${i}</a></li>
			</c:if>
			
			<c:if test="${pageNum != i}">
				<c:if test="${sword != null}">
					<li class="waves-effect"><a href="boardSearch?page=${i}&list=${pageList}&stype=${stype}&sword=${sword}">${i}</a></li>
				</c:if>
				<c:if test="${sword == null}">
					<li class="waves-effect"><a href="boardList?page=${i}&list=${pageList}">${i}</a></li>
				</c:if>
			</c:if>
		</c:forEach>
		<!-- //페이지 리스트 -->
		
		<!-- 다음 10개 -->
		<c:if test="${block >= totalBlock}">
			<li class="disabled"><a href="#!"><i class="material-icons">chevron_right</i></a></li>
		</c:if>
		<c:if test="${block < totalBlock}">
			<c:if test="${sword != null}">
				<li class="waves-effect"><a href="boardSearch?page=${b_end_page + 1}&list=${pageList}&stype=${stype}&sword=${sword}"><i class="material-icons">chevron_right</i></a></li>
			</c:if>
			<c:if test="${sword == null}">
				<li class="waves-effect"><a href="boardList?page=${b_end_page + 1}&list=${pageList}"><i class="material-icons">chevron_right</i></a></li>
			</c:if>
			
		</c:if>
		<!-- //다음 10개 -->
		
		<!-- 마지막페이지 -->
		<c:if test="${pageNum >= totalPage}">
			<li class="disabled"><a href="#!">Last</a></li>
		</c:if>
		<c:if test="${pageNum < totalPage}">
			<c:if test="${sword != null}">
				<li class="waves-effect"><a href="boardSearch?page=${totalPage}&list=${pageList}&stype=${stype}&sword=${sword}">Last</a></li>
			</c:if>
			<c:if test="${sword == null}">
				<li class="waves-effect"><a href="boardList?page=${totalPage}&list=${pageList}">Last</a></li>
			</c:if>
		</c:if>
		<!-- //마지막페이지 -->
	</ul>

</div>
</div>
</div>


<!-- 비밀번호 폼 -->
<!-- Modal Structure -->
<div id="modalPass" class="modal center" style="width: 300px; height: 250px;">
	<div class="modal-content">
		<div>
		<form name="f" id="f" method="get">
			<input type="hidden" name="b_no" id="b_no"/>
			<br>
			<h4>비밀번호</h4>
			<label>해당 게시글의 비밀번호를 입력해주세요</label>
	        <input type="password" maxlength="20" name="b_pass" id="b_pass">
	       	<button type="button" onclick="javascript:closePwd();" class="btn btn-default">Close</button>
	        <button type="button" onclick="javascript:checkPwd();" class="btn btn-default">OK</button>
		</form>
		</div>
	</div>
</div>
<!-- //비밀번호 폼 -->


<%@include file="../footer.jsp" %>

</body>
</html>