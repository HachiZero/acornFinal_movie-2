<%@page import="java.util.HashMap"%>
<%@page import="org.codehaus.jackson.map.ObjectMapper"%>
<%@page import="kr.or.kobis.kobisopenapi.consumer.rest.KobisOpenAPIRestService"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>	
<!DOCTYPE html>
<html>
<head>
    <!--Import Google Icon Font-->
    <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!--Import materialize.css-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/css/materialize.min.css">
	<link rel="stylesheet" href="../resources/css/index.css">
	
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!--Let browser know website is optimized for mobile-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
	<title>[영화검색]goodbye acorn - :)</title>
</head>
<style>
html,body {
  position: absolute;
  top: 0px;
  left: 0px;
  height: 1000px;
  width: 100%;
}
</style>
<body>
<%
	java.util.Calendar cal = java.util.Calendar.getInstance();
	SimpleDateFormat dateformat = new SimpleDateFormat("yyyyMMdd");
	//현재 년도, 월, 일
	cal.add(cal.DATE,-1);
	String yesterday = dateformat.format(cal.getTime());
	System.out.println(yesterday);
	
	//일별 박스오피스
	String targetDt = request.getParameter("targetDt") == null?yesterday:request.getParameter("targetDt");
	String itemPerPage = request.getParameter("itemPerPage") == null?"10":request.getParameter("itemPerPage");
	String multiMovieYn = request.getParameter("multiMovieYn") == null?"":request.getParameter("multiMovieYn");
	String repNationCd = request.getParameter("repNationCd") == null?"":request.getParameter("repNationCd");
	String wideAreaCd = request.getParameter("wideAreaCd") == null?"":request.getParameter("wideAreaCd");
	
	String key = "e4b048bc2090d7234c54d044ed8f83af";
	KobisOpenAPIRestService service = new KobisOpenAPIRestService(key);
	
	String dailyResponse = service.getDailyBoxOffice(true, targetDt, itemPerPage, multiMovieYn, repNationCd, wideAreaCd);
	
	ObjectMapper mapper = new ObjectMapper();
	HashMap<String,Object> dailyResult = mapper.readValue(dailyResponse, HashMap.class);
	
	request.setAttribute("dailyResult", dailyResult);
	
	String codeResponse = service.getComCodeList(true, "0105000000");
	HashMap<String,Object> codeResult = mapper.readValue(codeResponse, HashMap.class);
	request.setAttribute("codeResult", codeResult);
%>
	<!-- 재생 -->
	<div style="text-align: center;">
	<embed width="320" height="25" src="http://www.youtube.com/v/mLtSzudHz-U?list=RDEMvSWR6x0oOZr3rUvv_2v5Eg?version=2&autoplay=1&loop=1" type="application/x-shockwave-flash" wmode="opaque"></embed>
	</div>
	<!-- //재생 -->
	
	<div class="row"></div>
	<div class="row">
		<div class="col s12 main_icon_position">
			<a href="index.jsp"><i class="large material-icons" id="img_icon">movie</i></a>	
		</div>
	</div>
	<div class="row">
		<h5 class="center-align">영화 보기 전에, 예매 하기 전에</h5>
	</div>
	<div class="row"></div>	
	<div class="row"></div>
	<div class="row">
		<div class="col s12 m1 l2"></div>
		<div class="col s12 m10 l8">
			<nav class="searchBar">
			  <div class="nav-wrapper">
			    <form id="form-action" method="post" action="../movieList"> <!-- method="post" -->
			      <div class="input-field">
			        <input type="search" name="keyword" id="search" class="autocomplete" placeholder="영화 제목을 검색하세요" required>
			        <label for="search"><i class="material-icons" id="search_keyword">search</i></label>
			        <i class="material-icons" id="search_clear">close</i>
			      </div>
			    </form>
			  </div>
			</nav>
		</div>
		<div class="col s12 m1 l2"></div>
	</div>
	
	
	<a href="../boardList">QnA</a>
	<a href="../adminLogin">admin</a>
	
<!-- 박스오피스 표시부분 -->
<div class="row">
	<div class="col s12 m1 l2"></div>
	<div class="col s12 m10 l8" id="dailyBoxOffice">
		<p class="lead" id="lead">Daily Box Office</p>
		<c:if test="${not empty dailyResult.boxOfficeResult.dailyBoxOfficeList }">
			<c:forEach var="boxoffice" items="${dailyResult.boxOfficeResult.dailyBoxOfficeList }">
				<!-- <div> -->
					<div class="col s1 m1">
					<c:out value="${boxoffice.rank }"/>
					</div>
					<div class="col s2 m2">
					<c:if test="${boxoffice.rankInten > 0}">
						<b style="color: blue;"><i class="tiny material-icons">call_made</i><c:out value="${boxoffice.rankInten }"/></b>					
					</c:if>
					<c:if test="${boxoffice.rankInten == 0}">
						<b><c:out value="-"/></b>
					</c:if>
					<c:if test="${boxoffice.rankInten < 0}">
						<b style="color: red;"><i class="tiny material-icons">call_received</i><c:out value="${fn:substring(boxoffice.rankInten,1,2) }"/></b>
					</c:if>
					</div>
					<div class="col s5 m5">
					<b><c:out value="${boxoffice.movieNm }"/></b>
					</div>
					<div class="col s4 m4" style="text-align: right;">
					<!--<c:out value="${boxoffice.salesAcc } 명"/>-->
					<fmt:formatNumber value="${boxoffice.salesAcc }" pattern="#,###"/> 명
					</div>
				<!-- </div> -->
			</c:forEach>
			<div></div>
		</c:if>
	</div>
	<div class="col s12 m1 l2"></div>
</div>	

<%@include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>