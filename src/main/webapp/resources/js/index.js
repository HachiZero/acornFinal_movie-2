/**
index.jsp : search page
 */
$(document).ready(function() {
	$(".button-collapse").sideNav();
	
	$("#search_clear").click(function(){
		document.getElementById("search").value="";
		$("#search").focus();
	});
	
	$("#search_keyword").click(function(){
		var keyword = $("#search").val();
		if(keyword != ""){
			$('#form-action').submit();
		}/*else{
			Materialize.toast("검색어를 입력하세요.", 1200);
		}*/
	});

	$.getJSON("http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json?key=fbfb0ceafa07f356234a048e8614c3a7&itemPerPage=500", function(movieJson){
		var movieData = new Object();		
		for(var i=0, item; item=movieJson.movieListResult.movieList[i]; i++) {
			var movieNm = item.movieNm;
			movieData[movieNm] = null;
		}
		var parsedJson = JSON.stringify(movieData);
		//console.log(parsedJson);
		
		$('input.autocomplete').autocomplete({
			data : parsedJson
		});
	});		
	
	// the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
    $('.modal-trigger').leanModal({
    	opacity: .5
    });
});

function page_move(s_page, s_name){
	var f = document.frm_page;
	f.keyword.value = s_name; 
	f.pageNum.value = s_page; 
	f.submit();
}

//movielist modal
function mymodal(title, eng_title, prdtYear, genre, nation, story, directors, poster){//
	$.ajax({
		type : "post",
		url : "naver.do",
		data : {'title' : title, 'prdtYear' : prdtYear},
		dataType:"json",
		success:function(data){
//			$('#iframe').attr('src', "resources/movieDetail.jsp?dtitle=" + title + "&detitle=" + 
//					eng_title + "&prdtYear=" + prdtYear + "&userRating=" + data);
//			$('#modal_title').text(title);
//			$('#modal1').openModal();
		///==========================================================================================================
			$('#modal_detail').html("");
			var html_form = "";
			html_form += "<h4>";
			html_form += title;
			html_form += "</h4>";
			html_form += "<div class='row'>";
			html_form += "<div class='row bgBlur' id='blurImg' style='background-image: url(" + poster + "); background-size: cover;'>"; 
			html_form += "<div class='row'>"; 
			html_form += "<div class='col s12 m5 l5'>";
			html_form += "<img src=" + poster + ">"; 
			html_form += "</div>";
			html_form += "<div class='col s12 m7 l7'>"; 
			html_form += "<p>"; 
			html_form += "장　 　르 ㅣ " + genre + "<br/>";
			html_form += "감　 　독 ㅣ " + directors + "<br/>"; 
			html_form += "제작년도 ㅣ " + prdtYear + "<br/>"; 
			html_form += "제작국가 ㅣ " + nation + "<br/>"; 
			html_form += "평　 　점 ㅣ  " + data + "<br/>"; 
			html_form += "<br>"; 
			html_form += "줄 거 리 ㅣ" + story + "<br/>"; 
			html_form += "</p>"; 
			html_form += "</div>"; 
			html_form += "</div>"; 
			html_form += "</div>"; 
			html_form += "</div>"; 
			html_form += "</p>"; 
			$('#modal_detail').append(html_form);
			$('#modal1').openModal();
		},
		error : function(){
		}
	});
}