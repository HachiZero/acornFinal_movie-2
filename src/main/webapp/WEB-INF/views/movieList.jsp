<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>[영화검색]goodbye acorn - :)</title>
</head>
<div class="row">
<body>
<%@include file="/WEB-INF/views/top.jsp" %>
<!-- 
<div class="preloader-wrapper big active">
	<div class="spinner-layer spinner-blue-only">
		<div class="circle-clipper left">
			<div class="circle"></div>
		</div><div class="gap-patch">
			<div class="circle"></div>
		</div><div class="circle-clipper right">
			<div class="circle"></div>
		</div>
	</div>
</div>
 -->
    
<!-- 영화 리스트 -->
<div class="row"></div>
<c:set var="SQUOT" value="'" />
<c:set var="c" value="0"/>
<c:if test="${not empty movie_info.movieListResult }">
	<c:forEach var="l" items="${movie_info.movieListResult }"> 
		<c:set var="c" value="${c+1 }"/>
		<c:if test="${c == 1 }">
			<div class="row">
		</c:if>
		<div class="col s12 m3 l3">
        	<div class="card">
        		<c:set var="directors" value=""/>
        		<c:forEach var="d" items="${l.directors }">
        			<c:set var="directors" value="${directors}${d.peopleNm}|"/>
        		</c:forEach>
        	
			    <div class="card-image waves-effect waves-block waves-light">
		    		<c:set var="poster" value="${l.thumbnail}" />
					<c:choose>
						<c:when test="${poster == null or poster == ''}">
							<img class="activator" src="http://bja.or.kr/core/images/etc/noimg_main.gif"  style="height: 450px">
						</c:when>
						<c:otherwise>
							<img class="activator" src="${poster}"  style="height: 450px">
						</c:otherwise>
					</c:choose>
			    </div>
			    <div class="card-content">
			        <c:set var="title" value="${l.movieNm}" />
	   				<c:set var="titlecut" value="${fn:substring(title, 0, 12) }" />
			      	<p>
			      		<!-- Modal Trigger -->
			      		<c:set var="engTitle" value="${fn:replace(l.movieNmEn, SQUOT, '&#39;')}" />
			      		<%-- <a href='javascript:mymodal("${title}", "${engTitle}", "${l.prdtYear}")'> --%>
			      		<a href='javascript:mymodal("${title}", "${engTitle}", "${l.prdtYear}", " ${l.genreAlt }", "${l.nationAlt }", "${l.story}", "${directors }", "${poster }")'>
			      			${titlecut }
			      			<c:if test="${fn:length(title) > 12 }">...</c:if>
			      		</a>
			      		<!-- <i class="card-title activator material-icons right">more_vert</i> -->
			      	</p>
			    </div>
			    <div class="card-reveal">
					<span class="card-title grey-text text-darken-4">${title }<i class="material-icons right">close</i></span>
					<p>
						&#40;${l.movieNmEn }&#41;<br/>
						장　 　르 ㅣ ${l.genreAlt }<br/>
				    	감　 　독 ㅣ <c:forEach var="d" items="${l.directors }">${d.peopleNm} </c:forEach><br/>
				    	제작년도 ㅣ ${l.prdtYear }<br/>
				    	제작국가 ㅣ ${l.nationAlt }<br/>
				    	줄 거 리  ㅣ${l.story}<br/>				    						    						    						    	
					</p>
			    </div>
			</div>
        </div>
        
		<c:if test="${c == 4 }">
			</div>
			<c:set var="c" value="0"/>
		</c:if>	 
	</c:forEach>      			
</c:if>    
    
<!-- 리스트 페이징 -->
<div class="row paging">
	<div class="col s12 m12 l12">
		<form name="frm_page" method="post" action="../controller/movieList">
			<input type="hidden" name="keyword"/>
			<input type="hidden" name="pageNum"/>
			<ul class="pagination">
				<li class="disabled"><a href="#!"><i class="material-icons">chevron_left</i></a></li>
				<c:set var="startNum" value="1"/>
				<c:forEach var="page" begin="${startNum }" end="5">
					<c:choose>
						<c:when test="${movie_info.pageNum == startNum}">
							<li class="active">  <!-- blue-grey -->
						</c:when>
						<c:otherwise>
							<li class="waves-effect">
						</c:otherwise>
					</c:choose>
					<a href="javascript:page_move(${startNum },'${movie_info.keyword}');">${startNum}</a>
					</li>
					<c:set var="startNum" value="${startNum+1 }"/>
				</c:forEach>
				<li class="waves-effect"><a href="../movieList?pageNum"><i class="material-icons">chevron_right</i></a></li>
			</ul>
		</form>
	</div>
</div>

<!-- Modal Structure -->
<div id="modal1" class="modal modal-fixed-footer">
	<div class="modal-content">
		<div id="modal_detail"></div>
		<!-- <iframe src="" id='iframe' width="100%" height="500px" scrolling="auto" frameborder="0"></iframe>  -->
	</div>
	<div class="modal-footer">
		<a href="#!" class="modal-action modal-close waves-effect waves-green btn-flat ">Close</a>
	</div>
</div>
 
<%@include file="/WEB-INF/views/footer.jsp" %>
</body>
</div>
</html>