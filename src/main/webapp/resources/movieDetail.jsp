<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head>
<title></title>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Compiled and minified CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/css/materialize.min.css">
          
<!--Let browser know website is optimized for mobile-->
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>

</head>
<div class="row">
<body>


<!-- 영화 리스트 -->

<c:if test="${not empty movie_detail.movieListResult }">
	<c:forEach var="l" items="${movie_detail.movieListResult }">
		<c:if test="${param.dtitle == l.movieNm && (param.detitle == l.movieNmEn || param.prdtYear == l.prdtYear)}">
			<div class="row blur" style="background-image: url('${l.thumbnail }'); background-size: cover;">
				<div class="row">
					<div class="col s12 m5 l5">
					   	<img src="${l.thumbnail }">	
					</div>	    
				
					<div class="col s12 m7 l7">
						<%-- <h3>${l.movieNm}</h3> --%>
						<p>
							장　 　르 ㅣ ${l.genreAlt }<br/>
					    	감　 　독 ㅣ <c:forEach var="d" items="${l.directors }">${d.peopleNm} </c:forEach><br/>
					    	<%-- 출연배우 ㅣ <c:forEach var="a" items="${l.actor }">${a.content} </c:forEach><br/> --%>
					    	제작년도 ㅣ ${l.prdtYear }<br/>
					    	제작국가 ㅣ ${l.nationAlt }<br/>
					    	평　 　점 ㅣ ${param.userRating }<br/>
					    	<br>
					    	줄 거 리 ㅣ ${l.story}<br/>
						</p>
				   </div>	
				</div>	
			</div>
        </c:if>
	</c:forEach>
	<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
</c:if>
</div>

   <!--Import jQuery before materialize.js-->
   <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
   <!-- Compiled and minified JavaScript -->
   <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/js/materialize.min.js"></script>

</body>
</div>
</html>




 