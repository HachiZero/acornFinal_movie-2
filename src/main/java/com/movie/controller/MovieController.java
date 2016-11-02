package com.movie.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.XML;
/*
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.XML;
*/
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.movie.resources.Constant;

import kr.or.kobis.kobisopenapi.consumer.rest.KobisOpenAPIRestService;

@Controller
public class MovieController {
//	 @RequestMapping(value="/movieList", method=RequestMethod.POST)
//	 public ModelAndView movieList_daum(@RequestParam("keyword") String keyword, 
//			 							@RequestParam(value="pageNum", defaultValue="1") String pageNum,
//			 							HttpSession session) throws ParseException{
//	 HashMap<String, Object> daum_result = null;
//	 List<Object> list = new ArrayList<Object>();
//	 int totalCnt = 0;
//	
//	 //JSON Handling
//	 ObjectMapper mapper = new ObjectMapper();
//	
//	 String url = Constant.DAUM_URL + Constant.DAUM_TYPE + Constant.DAUM_KEY +
//	 Constant.DAUM_URL_Q;
//	 try {
//		 String sEncoded = URLEncoder.encode(keyword , "UTF-8");
//		 daum_result = mapper.readValue(new URL(url + sEncoded +
//		 Constant.DAUM_PAGE + pageNum + Constant.DAUM_CNT), HashMap.class);
//		 daum_result.put("pageNum", pageNum);
//	 } catch (Exception e) {
//		 System.out.println("movieList_daum Error : " + e);
//	 }
//	 session.setAttribute("movie_detail", daum_result);
//	 return new ModelAndView("movieList", "movie_info", daum_result);
//	 }

	@RequestMapping(value = "/movieList", method = RequestMethod.POST)
	public ModelAndView movieList_kobis(@RequestParam("keyword") String keyword,
			@RequestParam(value = "pageNum", defaultValue = "1") String pageNum,
			HttpSession session) throws ParseException {

		KobisOpenAPIRestService service = new KobisOpenAPIRestService(Constant.KOBIS_KEY);

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("movieNm", keyword);
		map.put("curPage", pageNum);
		map.put("itemPerPage", "12");

		JSONObject movie_datas = new JSONObject();
		try {
			String kobis_List = service.getMovieList(true, map);
			System.out.println(kobis_List);
			JSONParser parser = new JSONParser();
			JSONObject obj = (JSONObject) parser.parse(kobis_List);
			System.out.println(obj);
			JSONObject movieList_Result = (JSONObject) obj.get("movieListResult"); // movieListResult
			System.out.println(movieList_Result);
			String totalCnt = "" + movieList_Result.get("totCnt"); // long 타입이라
																	// String으로
																	// cast 필욘
			System.out.println(totalCnt);
			JSONArray koMovieList = (JSONArray) movieList_Result.get("movieList");
			System.out.println(koMovieList);

			JSONArray movieList = new JSONArray();
			System.out.println(koMovieList.size());
			for (int i = 0; i < koMovieList.size(); i++) { // 각 kobis 영화 정보 파싱
				JSONObject koMovie = (JSONObject) koMovieList.get(i);
				System.out.println(koMovie);
				String movieNm = (String) koMovie.get("movieNm"); // 영화 이름
				String movieNmEn = (String) koMovie.get("movieNmEn"); // 영문 영화 이름
				String prdtYear = (String) koMovie.get("prdtYear"); // 출시 연도?
				String openDt = (String) koMovie.get("openDt"); // openDate. 없는
																// 영화가 많다.
				System.out.println("**KOBIS result [영화제목 : " + movieNm + "] [제작년도 : " + prdtYear + "] [개봉일자 : " + openDt + "]");
				
				String url = Constant.DAUM_URL + Constant.DAUM_TYPE + Constant.DAUM_KEY + Constant.DAUM_URL_Q;
				String sEncoded = URLEncoder.encode(movieNm, "UTF-8");

				InputStream is = new URL(url + sEncoded).openStream();
				BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
				String jsonText = readAll(rd);
				is.close();

				JSONObject daumList = (JSONObject) parser.parse(jsonText);
				JSONObject channel = (JSONObject) daumList.get("channel");
				String totalCount = "" + (channel.get("totalCount"));
				String question = (String) channel.get("q");
				System.out.println("**총 갯수 : " + totalCount + ", 키워드 : " + question);
				JSONArray item = (JSONArray) channel.get("item");
				System.out.println(item);

				// kobis data에 더할 daum data 선언
				String koThumbNail = "";
				String daumLink = "", story = "", daum_year = "", eng_title = "";
				JSONObject photos = new JSONObject();
				JSONArray actors = new JSONArray();
				
				for (int j = 0; j < item.size(); j++) { // kobis data별 daum data
														// 검색
					JSONObject daumMovie = (JSONObject) item.get(j);
					System.out.println("daumMovie : " + daumMovie);
					daum_year = (String) ((JSONObject) (((JSONArray) daumMovie.get("year")).get(0))).get("content");
					eng_title = (String) ((JSONObject) (((JSONArray) daumMovie.get("eng_title")).get(0))).get("content");
					
					System.out.println("prdtYear.equals(daum_year) : " + prdtYear + ", " + daum_year);
					System.out.println("movieNmEn.equals(eng_title) : " + movieNmEn + ", " + eng_title);
					
					if(prdtYear.equals(daum_year) || movieNmEn.equals(eng_title)){
						System.out.println("===============================" + daumMovie + "===============================");
						String title = (String) ((JSONObject) (((JSONArray) daumMovie.get("title")).get(0))).get("content");
						daumLink = (String) ((JSONObject) (((JSONArray) daumMovie.get("story")).get(0))).get("link");
						String audience_date = (String) ((JSONObject) (((JSONArray) daumMovie.get("audience_date")).get(0)))
								.get("content");
						String daumStory = (String) ((JSONObject) (((JSONArray) daumMovie.get("story")).get(0)))
								.get("content");
						String photo1 = (String) ((JSONObject) daumMovie.get("photo1")).get("content");
						String photo2 = (String) ((JSONObject) daumMovie.get("photo2")).get("content");
						String photo3 = (String) ((JSONObject) daumMovie.get("photo3")).get("content");
						String photo4 = (String) ((JSONObject) daumMovie.get("photo4")).get("content");
						String photo5 = (String) ((JSONObject) daumMovie.get("photo5")).get("content");
						story = daumStory;
						photos.put("photo1", photo1);
						photos.put("photo2", photo2);
						photos.put("photo3", photo3);
						photos.put("photo4", photo4);
						photos.put("photo5", photo5);
						actors = (JSONArray) daumMovie.get("actor");
						String audience_year = "";
						if (audience_date.length() > 1) {
							audience_year = audience_date.substring(0, 3);
						}
						System.out.println(audience_date + " " + audience_year);
						String thumbNail = (String) ((JSONObject) (((JSONArray) daumMovie.get("thumbnail")).get(0)))
								.get("content");
						System.out.println(title + " " + daumLink + " " + audience_date + " " + thumbNail);
						
						/*
						 * if (openDt.length() > 1) { //출시일로 구분
						 * if(openDt.equals(audience_date.replace("-", ""))){
						 * System.out.println(openDt + " " +
						 * audience_date.replace("-", "")); koThumbNail = thumbNail;
						 * }else { koThumbNail = thumbnail_default; } } else {
						 * if(prdtYear.equals(audience_year)){ koThumbNail =
						 * thumbNail; }else { koThumbNail = thumbnail_default; } }
						 */
						koThumbNail = thumbNail;
					}
				}
				// 새 데이터 삽입
				koMovie.put("thumbnail", koThumbNail);
				koMovie.put("link", daumLink);
				koMovie.put("story", story);
				koMovie.put("photos", photos);
				koMovie.put("actors", actors);

				movieList.add(koMovie);
			}
			movie_datas.put("movieListResult", movieList);
			movie_datas.put("keyword", keyword);
			movie_datas.put("pageNum", pageNum);
			System.out.println("movie_datas : " + movie_datas);
		} catch (Exception e) {
			e.printStackTrace();
		}
		session.setAttribute("movie_detail", movie_datas);
		return new ModelAndView("movieList", "movie_info", movie_datas);
	}

	public String readAll(Reader rd) throws IOException { // 다음에서 json 읽기
		StringBuilder sb = new StringBuilder();
		int cp;
		while ((cp = rd.read()) != -1) {
			sb.append((char) cp);
		}
		return sb.toString();
	}

	public Map<String, Object> toMap(JSONObject object) {
		Map<String, Object> map = new HashMap<String, Object>();

		Iterator<String> iter = object.keySet().iterator();
		while (iter.hasNext()) {
			String key = iter.next();
			Object value = object.get(key);

			if (value instanceof JSONArray) {
				value = toList((JSONArray) value);
			}

			else if (value instanceof JSONObject) {
				value = toMap((JSONObject) value);
			}
			map.put(key, value);
		}
		return map;
	}

	public List<Object> toList(JSONArray array) {
		List<Object> list = new ArrayList<Object>();
		for (int i = 0; i < array.size(); i++) {
			Object value = array.get(i);
			if (value instanceof JSONArray) {
				value = toList((JSONArray) value);
			}

			else if (value instanceof JSONObject) {
				value = toMap((JSONObject) value);
			}
			list.add(value);
		}
		return list;
	}
	
	@RequestMapping(value="/naver.do", method = RequestMethod.POST)
	@ResponseBody
	public String movieList_naver(@RequestParam("title")String title, @RequestParam("prdtYear")String prdtYear){		
		String xml = "";
		Double userRating = 0.0;
		String utf_title = "";
		int year = Integer.parseInt(prdtYear);
		try {
			utf_title = URLEncoder.encode(title , "UTF-8");
		} catch (Exception e) {
			System.out.println("title encoding to UTF-8 Err : " + e);
		}
		
		HttpClient client = HttpClientBuilder.create().build();
		HttpGet request = new HttpGet(Constant.NAVER_URL + Constant.NAVER_QUERY + utf_title + 
									  Constant.NAVER_YEAR_FROM + (year-1) + 
									  Constant.NAVER_YEAR_TO + (year+1));
		request.addHeader("X-Naver-Client-Id", Constant.NAVER_CLIENT_ID);
		request.addHeader("X-Naver-Client-Secret", Constant.NAVER_CLIENT_SECRET);
		
		try {
			HttpResponse response = client.execute(request);
			xml = EntityUtils.toString(response.getEntity());
			
			org.json.JSONObject xmlJsonObj = null;
			xmlJsonObj = XML.toJSONObject(xml);
			
			System.out.println("=====xmlJsonObj : " + xmlJsonObj + "=====");
			
			org.json.JSONObject testResult = xmlJsonObj.getJSONObject("rss").getJSONObject("channel").getJSONObject("item");
			userRating = testResult.getDouble("userRating");
			System.out.println("userRating : " + userRating);
		} catch (Exception e) {
			System.out.println("movieList_naver err: " + e);
		}
		return Double.toString(userRating);
	}

}


