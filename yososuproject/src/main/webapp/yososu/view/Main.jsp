<%@page import="dto.Databases"%>
<%@page import="org.jsoup.nodes.Element"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.URL"%>
<%@page import="org.jsoup.Jsoup" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 	<head>
 	
    </head>
	
    <%
		String keyword = request.getParameter("keyword");
		String pagenum = request.getParameter("pagenum");
		String searchnum = request.getParameter("searchnum");
		if( pagenum == null ){ 	// pagenum가 없다면 = 게시물 첫화면
			pagenum = "1";		//1페이지 설정
		}
		String s= "";
		String [] aa = new String [1024];
		
		//Database ArrayList
		ArrayList<Databases> a1 = new ArrayList<>();
		
		Databases db = new Databases();
		//totalCount 빼오기 위한 api
		URL url2 = new URL("https://api.odcloud.kr/api/uws/v1/inventory?page=1&perPage=100&serviceKey=hm1u3zRV0ba96YTa5BqV4zu0jYFV2LGfPe2aRk0NyJVQsoX5FCSjuVth8RKvBvQzOW8ApIHwaxmajW9%2FRaYR5A%3D%3D");
		BufferedReader bf2 = new BufferedReader(new InputStreamReader(url2.openStream(), "UTF-8"));
		String rs2 = bf2.readLine();
		JSONParser jsonParser2 = new JSONParser();
		JSONObject jsonObject2 = (JSONObject) jsonParser2.parse(rs2);
		 JSONArray DEFArray2 = (JSONArray) jsonObject2.get("data");
		int s2 = Integer.parseInt(String.valueOf(jsonObject2.get("totalCount")));
	%>
    <body id="page-top">
	    <!-- kakao 지도 api -->
        <%@include file="header.jsp" %>
        
        <!-- 페이지 내용들-->
        <div class="container-fluid p-0">
		<%
			int k =0;
			 	//요소수 API 가져오기
				 URL url = new URL("https://api.odcloud.kr/api/uws/v1/inventory?page="+k+"&perPage="+s2+"&serviceKey=hm1u3zRV0ba96YTa5BqV4zu0jYFV2LGfPe2aRk0NyJVQsoX5FCSjuVth8RKvBvQzOW8ApIHwaxmajW9%2FRaYR5A%3D%3D");
				 BufferedReader bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
				 String rs = bf.readLine();
				 
				 JSONParser jsonParser = new JSONParser();
				 JSONObject jsonObject = (JSONObject) jsonParser.parse(rs);
				 JSONArray DEFArray = (JSONArray) jsonObject.get("data");
				 	s = String.valueOf(jsonObject.get("totalCount"));
			 		//총 게시물 수
			 		int lastrow = Integer.parseInt(s);
			 		//화면당 표시할 게시물 수
			 		int listsize = 100;
			 		//마지막 페이지
			 		int lastpage = 0;
			 		if( lastrow % listsize == 0 ){		// 만약에 총게시물/페이지당게시물 나머지가 없으면
						lastpage = lastrow / listsize;		// * 총게시물/페이당게시물 
					}else{
						lastpage = lastrow / listsize+1;	// * 총게시물/페이당게시물+1
					}
			 		int currentpage = Integer.parseInt(pagenum);
					int startrow = (currentpage-1)*listsize;
					int endrow = currentpage*listsize; //현재페이지 마지막 번호
			 		//화면당 표시할 게시물 수
			 		int ls = 0;
			 		//마지막 페이지
			 		int lp = 0;
			 		//총 게시물 수
			 		int lr = 0;
			 		//현재 페이지
			 		int cp = 0;
					int sr = 0;
					//마지막 페이지
					int er = 0;
			%>
            <!-- 메인페이지-->
            <section class="resume-section" id="DEFmain"> <!-- section 시작 -->
            	<div class="resume-section-content">
	                <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
						<div class="card shadow mb-4">
							<!-- 테이블 헤더 -->
							<div class="card-header py-3">
		                        <h5 class="m-0 font-weight-bold text-primary">요소수 주유소 목록</h5>
		                    </div>
		                    <!-- card-body 시작 -->
		                    <div class="card-body">
			                    <div class="table-responsive col-12 p-2">
			                    	<!-- 검색창 시작 -->
									<form class="row col-12 m-1"  style="text-align: center;" action="Main.jsp" method="get">
						               	<div class="col-5">
											<input type = "text" class="form-control col-md-10 px-0" name = "keyword">
										</div>
										<div class="col-1 ">
											<input type = "submit" class="btn btn-primary" style="color: white;" value="검색">
										</div>
										<div class="col-6 px-4" style="text-align: right;">
										</div>	
									</form>
									
									<!-- 검색창 끝 -->
									<!-- form 시작 -->
									<form action="DEFdetail.jsp" class="m-3">
										<!-- 테이블 시작-->
										<table class="table table-sprited"  id="dataTable">
											<thead class="table-primary">
												<tr>
													<th>상호명</th>
													<th>주소</th>
													<th>가격</th>
													<th>전화번호</th>
													<th>재고량</th>
												</tr>
											</thead>
											<%
												//DEFdetail에 넘겨지는 값들
												if( keyword == null || keyword==""){ // 검색이 안되면
												for(int i=startrow+1; i < endrow; i++){
													JSONObject DEFobject = (JSONObject) DEFArray.get(i);
													%>
													<tbody id="page">
														<tr>
															<td><a href="#mainmap" onclick="detailmap(<%=DEFobject.get("lat") %>, <%=DEFobject.get("lng")%>, <%=DEFobject.get("tel")%>);"><%=DEFobject.get("name") %></a></td>
															<td id="addr"><%=DEFobject.get("addr") %></td>
															<td><%=DEFobject.get("price") %></td>
															<td><%=DEFobject.get("tel") %></td>
															<td><%=DEFobject.get("inventory") %></td>
															<td id="inputLat" style="display: none;"><%=DEFobject.get("lat") %></td>
														</tr>
													</tbody>
													
											<%	} } else { // 검색을 하면 새로 페이징
													String str = "";
													
													int cnt = 0;
													for(int i=0; i< Integer.parseInt(s); i++){
														
														JSONObject DEFobject = (JSONObject) DEFArray.get(i);
														str = (String)DEFobject.get("name");
														int a11 = Integer.parseInt(s);
														cnt ++;
														String str2 = (String)DEFobject.get("inventory");
														String str3 = (String)DEFobject.get("addr");
														String str4 = (String)DEFobject.get("price");
														String str5 = (String)DEFobject.get("regDt");
														String str6 = (String)DEFobject.get("lat");
														String str7 = (String)DEFobject.get("lng");
														String str8= (String)DEFobject.get("tel");
														String str9= (String)DEFobject.get("openTime");
														Databases db2 = new Databases(str, str2, str3, str4, str5, str6, str7, str8, str9);
														String[] stt = db2.getAddr().split(" ");
														try{
															if(stt[0].matches(".*" +keyword+ ".*") || stt[1].matches(".*" +keyword+ ".*") || stt[2].matches(".*" +keyword+ ".*") || stt[3].matches(".*" +keyword+ ".*")){
																a1.add(db2);
															}
														}catch(Exception e){
														}
													}
													//위에 전역변수로 설정이 되어있으니까 새로 변수로 다시값을 바꿔주기
													//총 게시물 수
											 		lr = a1.size();
											 		//화면당 표시할 게시물 수
											 		ls = 18;
											 		//마지막 페이지
											 		lp = 0;
											 		cp = Integer.parseInt(pagenum);
													sr = (cp-1)*ls;
													er = cp*ls;
													if( lr % ls == 0 ){		// 만약에 총게시물/페이지당게시물 나머지가 없으면
											 			lp = lr / ls;		// * 총게시물/페이당게시물 
													}else{
														lp = lr / ls+1;	// * 총게시물/페이당게시물+1
													}
													//시작점          총게시물수
													 for(int i=sr; i < er; i++){
															%>
															 <tbody >
																<tr>
																	<td>
																	<a href="#mainmap" onclick="detailmap(<%=a1.get(i).getLat()%>, <%=a1.get(i).getLng()%>);"><%=a1.get(i).getName() %></a>
																	</td>
																	<td id="addr"><%=a1.get(i).getAddr() %></td>
																	<td><%=a1.get(i).getPrice() %></td>
																	<td><%=a1.get(i).getTel() %></td>
																	<td><%=a1.get(i).getInventory() %></td>
																	<td id="" style="display: none;"></td>
																</tr>
															</tbody>  
														<%
													}
														//총 게시물 수
											 		lastrow = lr;
											 		//화면당 표시할 게시물 수
											 		listsize = ls;
											 		//마지막 페이지
													lastpage = lp;
											 		currentpage = cp;
													startrow = sr;
													endrow = er;
												}
										%>
										</table>
										<!-- 테이블 끝 -->
									
										<!-- 게시판 페이징 -->
										<div class="row container-fluid dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
											<ul class="pagination"> 
												<!-- 첫페이지에서 이전 페이지 눌렀을 때  첫페이지 고정-->
												<!-- 현재페이지번호-1 -->
												<% if( currentpage == 1 ){%>
													<%if ( keyword==null ) {%>
														<li class="paginate_button page-item previous" id="dataTable_previous" > <a href="Main.jsp?pagenum=<%=currentpage %>"  aria-controls="dataTable" class="page-link">이전</a> </li>
													<%}else{ %>
														<li class="paginate_button page-item previous" id="dataTable_previous"> <a href="Main.jsp?pagenum=<%=currentpage %>&keyword=<%=keyword%>"  aria-controls="dataTable" class="page-link">이전</a> </li>
													<%} %>	
												<%}else{ %>
													<!-- 1페이지가 아닌데 키워드 없음 -->
													<%if(keyword==null) {%>
													<li class="paginate_button page-item previous" id="dataTable_previous" > <a href="Main.jsp?pagenum=<%=currentpage-1 %>"  aria-controls="dataTable" class="page-link">이전</a> </li>
												<%	// 1페이지가 아닌데 키워드 있음
													}else{%>
														<li class="paginate_button page-item previous" id="dataTable_previous" > <a href="Main.jsp?pagenum=<%=currentpage-1 %>&keyword=<%=keyword%>"  aria-controls="dataTable" class="page-link">이전</a> </li>
												<%	
													}
												}
												%>														
													
													<!-- 게시물의 수만큼 페이지 번호 생성 -->
												<% for(int i=1; i<=lastpage; i++){ %>
												
													<% if( keyword == null ){ %>
													<li class="paginate_button page-item"><a href="Main.jsp?pagenum=<%=i %>" aria-controls="dataTable" class="page-link"> <%=i %> </a> </li>
															<!-- i 클릭했을때 현재 페이지 이동 [ 클릭한 페이지번호 ] -->
													<%}else{%>
													<li class="paginate_button page-item"><a href="Main.jsp?pagenum=<%=i %>&keyword=<%=keyword %>"  aria-controls="dataTable" class="page-link"> <%=i %> </a> </li>
													<%} %>
													
												<%} %>
												
													<!-- 마지막페이지에서 다음버튼 눌렀을때 마지막 페이지 고정 -->
												<% if( currentpage == lastpage ){%>	
												<% 	if( keyword == null ){ %>
													<li class="paginate_button page-item next" id="dataTable_next"><a href="Main.jsp?pagenum=<%=currentpage%>" aria-controls="dataTable" class="page-link"> 다음 </a> </li>
													<%}else{%>
													<li class="paginate_button page-item next" id="dataTable_next"><a href="Main.jsp?pagenum=<%=currentpage%>&keyword=<%=keyword%>" aria-controls="dataTable" class="page-link"> 다음 </a> </li>	
													<%} %>
												<%}else{ %>
													<!-- 마지막 페이지가 아닌데 키워드 없음  -->
													<%if(keyword==null) {%>
													<li class="paginate_button page-item next" id="dataTable_next"><a href="Main.jsp?pagenum=<%=currentpage+1 %>" aria-controls="dataTable" class="page-link">다음 </a> </li>
												<%	//마지막 페이지 아닌데 키워드 있음
													}else{%>
													<li class="paginate_button page-item next" id="dataTable_next"><a href="Main.jsp?pagenum=<%=currentpage+1 %>&keyword=<%=keyword%>" aria-controls="dataTable" class="page-link">다음 </a> </li>
												<%			
													}
												}
												%>	
											</ul>
										</div><!-- 페이징 끝 -->
									</form><!-- form 끝 -->
								</div>	<!-- table-responsive끝 -->
							</div><!-- card body 끝 --> 
						</div><!-- card 끝 -->
					</div><!-- dataTable_wrapper 끝 -->
				</div> <!-- col-md-12 끝 -->
            </section> <!-- 메인 section 끝 -->
            <hr class="m-0" />
            
            <!-- 메인 지도 나오는 곳(a태그) -->
            
            <section class="resume-section" id="mainmap">
	         <div class="resume-section-content">
	             <h2 class="mb-1 text">요소수 지도</h2>
	             <p>메인 페이지에서 상호명을 클릭하시면 여기에 지도가 표시됩니다.</p>
	             <div class="d-flex flex-column flex-md-row justify-content-between mb-5">
	                 <div class="resume-section" id ="education">
						<div class="resume-section-content">
							<div>
								<button class="btn btn-primary mx-0 my-4" style="color:white;" id="findnearbtn">근처 요소수 주유소 찾기</button>
							</div>
							<div id="map" style="width:80vw; height:32vw; border: 1px solid black;"></div>
							
							</div>
						</div>
	              </div>
	          </div>
	      </section>
            
            <%
            int page3 = 2;
    		
    		//오늘 날짜 가져오기
    		SimpleDateFormat dtf = new SimpleDateFormat("yyyyMMdd"); //url 최신일자 기사용 
    		SimpleDateFormat dtf2 = new SimpleDateFormat("yyyy-MM-dd"); //날짜 표시용
            Calendar calendar = Calendar.getInstance();

            Date dateObj = calendar.getTime();
            String formattedDate = dtf.format(dateObj);
            String formattedDate2 = dtf2.format(dateObj);
    		for(int j=1; j < page3; j++) {
    			String url3 = "https://news.naver.com/main/list.naver?mode=LS2D&sid2=263&sid1=101&mid=shm&date="+formattedDate+"&page=" + j;
    			Document doc;
    			try {
    				doc = Jsoup.connect(url3).get();
    				Elements elements = doc.getElementsByAttributeValue("class", "list_body newsflash_body");
    				
    				Element element = elements.get(0);
    				Elements photoElements = element.getElementsByAttributeValue("class", "photo");
    				
 				%>
    					
    		<!-- 뉴스 페이지 시작 -->	
            <section class="resume-section" id="news">
                <div class="resume-section-content">
                    <h2 class="mb-5">뉴스</h2>
                    <%for(int i=0; i<photoElements.size(); i++) {
    					Element articleElement = photoElements.get(i);
    					Elements aElements = articleElement.select("a");
    					Element aElement = aElements.get(0);
    					String articleUrl = aElement.attr("href");		// 기사링크
    					Element imgElement = aElement.select("img").get(0);
    					String imgUrl = imgElement.attr("src");			// 사진링크
    					String title = imgElement.attr("alt");			// 기사제목
    					String imgUrl2 = imgUrl.split("106_72")[0];		// 기사 큰 사진 가져오기
    					Document subDoc = Jsoup.connect(articleUrl).get();
    					Element contentElement = subDoc.getElementById("articleBodyContents");
    					String content = contentElement.text();			// 기사내용%>
    					
                    <div class="d-flex flex-column flex-md-row justify-content-between mb-5">
                        <div class="flex-grow-1">
		                    <div class="flex-shrink-0 mb-2"><span class="text-primary" style="font-size: 0.3rem;">날짜 : <%=formattedDate2 %></span></div>
                            <h4 class="mb-4"><%=title %></h4>
                            <div class="row"> 
	                            <div class="mb-3"><img src="<%=imgUrl2%>" style="height: 14vw;"></img></div>
	                            <div><p id="newscontent">&nbsp;&nbsp;<%=content %></p></div>
                            </div>
                        </div>
                            <span style="font-size: 0.2rem;"><a href="<%=articleUrl %>" class="-bs-gray-800"><img src="../assets/img/http.png"></a></span>
                    </div>
                 	<%}
    			
    			} catch (Exception e) {
    				// TODO Auto-generated catch block
    				e.printStackTrace();
    			}
    		}
            %>
                </div>
            </section>
            <!-- 뉴스페이지 끝 -->
            <hr class="m-0" />
   		<!--   	/* 	
   		$(document).ready(function(){
   	       $("#keyword").keyup(function() {
   	           var k = $(this).val();
   	           $("#data-table > tbody > tr").hide();
   	           var temp = $("#item-table > tbody > tr > td:nth-child(5n+2):contains('" + k + "')");
   	           var temp1 = $("#item-table > tbody > tr > td:nth-child(5n+3):contains('" + k + "')");
   	           $(temp).parent().show();
   	           $(temp1).parent().show();
   	     })
   	}) */ -->
   	
   		<%@include file="footer.jsp" %>
   		</div>	
    </body>
</html>