<%@page import="java.util.Arrays"%>
<%@page import="yososuproject.SimpleTesing.DateItem"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	
</head>
<body>

	<%@include file="header.jsp" %>
	
	<%
		String keyword = request.getParameter("keyword");
		String pagenum = request.getParameter("pagenum");
		String searchnum = request.getParameter("searchnum");
		if( pagenum == null ){ 	// pagenum가 없다면 = 게시물 첫화면
			pagenum = "1";		//1페이지 설정
		}
		
		String s= "";
		String [] aa = new String [1024];
	%>
	
	<div class="container">
		<form class="row col-md-6 offset-3" style="text-align: center;" action="Main.jsp" method="get">
			<input type = "text" class="form-control col-md-10" name = "keyword">
			<input type = "submit" class="btn btn-outline-dark col-md-2" value="검색">
		</form>
		<%
		
		int k =0;
		int j =2000;		
		
		 List<DateItem> dateList = new ArrayList<>();
		 	
			 URL url = new URL("https://api.odcloud.kr/api/uws/v1/inventory?page="+k+"&perPage="+j+"&serviceKey=hm1u3zRV0ba96YTa5BqV4zu0jYFV2LGfPe2aRk0NyJVQsoX5FCSjuVth8RKvBvQzOW8ApIHwaxmajW9%2FRaYR5A%3D%3D");
			 BufferedReader bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
			 String rs = bf.readLine();
			 
			 JSONParser jsonParser = new JSONParser();
			 JSONObject jsonObject = (JSONObject) jsonParser.parse(rs);
			 JSONArray DEFArray = (JSONArray) jsonObject.get("data");
			 //System.out.print(jsonObject.get("data"));

			// for(int j=0; j<json2.size(); j++){
			 //}
				
		 		//System.out.println(jsonObject.get("totalCount"));
		 		s = String.valueOf(jsonObject.get("totalCount"));	
		 		//총 게시물 수
		 		int lastrow = Integer.parseInt(s);
		 		//System.out.print(lastrow);
		 		//화면당 표시할 게시물 수
		 		int listsize = 100;
		 		//마지막 페이지
		 		int lastpage = 0;
		 		//System.out.println(lastpage);
		 		if( lastrow % listsize == 0 ){		// 만약에 총게시물/페이지당게시물 나머지가 없으면
					lastpage = lastrow / listsize;		// * 총게시물/페이당게시물 
				}else{
					lastpage = lastrow / listsize+1;	// * 총게시물/페이당게시물+1
				}
		 		int currentpage = Integer.parseInt(pagenum);
		 		//System.out.print(currentpage);
				int startrow = (currentpage-1)*listsize;
				//System.out.print(startrow);
				int endrow = currentpage*listsize;
		%>
		<form action="DEFdetail.jsp">
			<table class="table mt-3">
				<thead class="thead-dark">
					<tr>
						<th>상호명</th>
						<th>주소</th>
						<th>가격</th>
						<th>전화번호</th>
						<th>재고량</th>
					</tr>
				</thead>
			<%
				//a태그로 상세정보로 이동할때, 많은 값들을 전달해야하는데 어떻게 해야하는지...form submit?
						//그냥 밑에 처럼 a태그로 넘기면 해당 정보가 인터넷 주소창에 표시가됩니다. 구글링을 하면 get방식은 위험하고 post방식을 이용해야 된다고 합니다. form을 써서 넘기고 싶은데 a태그는 value가 지정되지 않습니다.
						//input type hidden???
								//DEFdetail에 넘겨지는 값들
				if( keyword == null ){ // 검색이 안되면
				for(int i=startrow+1; i < endrow; i++){
					JSONObject DEFobject = (JSONObject) DEFArray.get(i);%>
					<tbody id="page">
						<tr>
							<td><a href="DEFdetail.jsp?name=<%=DEFobject.get("name")%>&addr=<%=DEFobject.get("addr")%>&price=<%=DEFobject.get("price")%>&tel=
							<%=DEFobject.get("tel")%>&inventory=<%=DEFobject.get("inventory")%>&openTime=<%=DEFobject.get("openTime")%>&regDt=<%=DEFobject.get("regDt")%>
							&lat=<%=DEFobject.get("lat")%>&lng=<%=DEFobject.get("lng")%>"><%=DEFobject.get("name") %></a></td>
							<td id="addr"><%=DEFobject.get("addr") %></td>
							<td><%=DEFobject.get("price") %></td>
							<td><%=DEFobject.get("tel") %></td>
							<td><%=DEFobject.get("inventory") %></td>
						</tr>
					</tbody>
			<%	} } else{ // 검색을 하면
					String str = "";
					
					 for(int i=startrow+1; i < endrow; i++){
							JSONObject DEFobject = (JSONObject) DEFArray.get(i);
							
							str = (String)DEFobject.get("addr");
							String addSplit1= str.split(" ")[0]; //array인덱스 자르기
							String addSplit2= str.split(" ")[1];
							//System.out.println("addSplit1 : " + addSplit1);
							//System.out.println("addSplit2 : " + addSplit2);
							//addSplit1 : 경기
							//addSplit2 : 안성시
							if(addSplit1.contains(keyword)){
								
								String aaa = String.valueOf(keyword);
								System.out.println("aaa :"+ aaa);
								aa[i] = aaa;
								System.out.println(String.valueOf(aa[i]));
								
							%>
								<tbody id="page">
									<tr>
										<td><a href="DEFdetail.jsp?name=<%=DEFobject.get("name")%>&addr=<%=DEFobject.get("addr")%>&price=<%=DEFobject.get("price")%>&tel=
										<%=DEFobject.get("tel")%>&inventory=<%=DEFobject.get("inventory")%>&openTime=<%=DEFobject.get("openTime")%>&regDt=<%=DEFobject.get("regDt")%>
										&lat=<%=DEFobject.get("lat")%>&lng=<%=DEFobject.get("lng")%>"><%=DEFobject.get("name") %></a></td>
										<td id="addr"><%=DEFobject.get("addr") %></td>
										<td><%=DEFobject.get("price") %></td>
										<td><%=DEFobject.get("tel") %></td>
										<td><%=DEFobject.get("inventory") %></td>
									</tr>
								</tbody>
							<%
							}
					}
			%>
						
						
			
			<% }  %>
			
		</table>
		<!-- 페이징 -->
			<div class="row">
				<div class="col-md-10 offset-2 justify-content-center my-3">
					<ul class="pagination"> <!-- 게시판 페이징 번호 -->
							<!-- 첫페이지에서 이전 페이지 눌렀을 때  첫페이지 고정-->
						<% if( currentpage == 1 ){%>
							<%if ( keyword==null ) {%>
								<li class="page-item"> <a href= "Main.jsp?pagenum=<%=currentpage %>"  class="page-link">이전</a> </li>
							<%}else{ %>
								<li class="page-item"> <a href= "Main.jsp?pagenum=<%=currentpage %>&keyword<%=keyword %>"  class="page-link">이전</a> </li>
							<%} %>	
						<%}else{ %>
							<li class="page-item"> <a href= "Main.jsp?pagenum=<%=currentpage-1 %>&keyword<%=keyword %>"  class="page-link">이전</a> </li>
						<%} %>														<!-- 현재페이지번호-1 -->
						
							<!-- 게시물의 수만큼 페이지 번호 생성 -->
						<% for(int i=1; i<=lastpage; i++){ %>
						
							<% if( keyword == null ){ %>
							<li class="page-item"><a href="Main.jsp?pagenum=<%=i %>" class="page-link"> <%=i %> </a> </li>
									<!-- i 클릭했을때 현재 페이지 이동 [ 클릭한 페이지번호 ] -->
							<%}else{%>
							<li class="page-item"><a href="Main.jsp?pagenum=<%=i %>&keyword=<%=keyword %>" class="page-link"> <%=i %> </a> </li>
							<%} %>
							
						<%} %>
						
							<!-- 마지막페이지에서 다음버튼 눌렀을때 마지막 페이지 고정 -->
						<% if( currentpage == lastpage ){%>	
						<% if( keyword == null ){ %>
							<li class="page-item"><a href="Main.jsp?pagenum=<%=currentpage%>" class="page-link"> 다음 </a> </li>
							<%}else{%>
							<li class="page-item"><a href="Main.jsp?pagenum=<%=currentpage%>&keyword=<%=keyword %>" class="page-link"> 다음 </a> </li>	
							<%} %>
						<%}else{ %>
							<li class="page-item"><a href="Main.jsp?pagenum=<%=currentpage+1 %>&keyword=<%=keyword %>" class="page-link">다음 </a> </li>
						<%} %>	
					
					</ul>
				</div>
			</div>	
		</form>
	</div>
	<%@include file="footer.jsp" %>
</body>
</html>