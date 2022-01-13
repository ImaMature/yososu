<%@page import="yososuproject.Databases"%>
<%@page import="java.util.Arrays"%>
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

	<%@include file="header2.jsp" %>
	
	<div id="app">
	  <p>{{ message }}</p>
	</div>
	<%
		
		String keyword = request.getParameter("keyword");
		String pagenum = request.getParameter("pagenum");
		String searchnum = request.getParameter("searchnum");
		if( pagenum == null ){ 	// pagenum가 없다면 = 게시물 첫화면
			pagenum = "1";		//1페이지 설정
		}
		
		String s= "";
		String [] aa = new String [1024];
		ArrayList<Databases> a1 = new ArrayList<>();
		
				
		Databases db = new Databases();
		
	%>
	
	
	
	<div class="container">
		<form class="row col-md-6 offset-3" style="text-align: center;" action="AppMain2.jsp" method="get">
			<input type = "text" class="form-control col-md-10" name = "keyword">
			<input type = "submit" class="btn btn-outline-dark col-md-2" value="검색">
		</form>
		<%
		
		int k =0;
		int j =2000;		
		
		 //List<DateItem> dateList = new ArrayList<>();
		 	
			 URL url = new URL("https://api.odcloud.kr/api/uws/v1/inventory?page="+k+"&perPage="+j+"&serviceKey=hm1u3zRV0ba96YTa5BqV4zu0jYFV2LGfPe2aRk0NyJVQsoX5FCSjuVth8RKvBvQzOW8ApIHwaxmajW9%2FRaYR5A%3D%3D");
			 BufferedReader bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
			 String rs = bf.readLine();
			 
			 JSONParser jsonParser = new JSONParser();
			 JSONObject jsonObject = (JSONObject) jsonParser.parse(rs);
			 JSONArray DEFArray = (JSONArray) jsonObject.get("data");
			 
			 	s = String.valueOf(jsonObject.get("totalCount"));
			 	//System.out.println(s );
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
		 		
		 		//System.out.println( lastpage );
		 		int currentpage = Integer.parseInt(pagenum);
		 		//System.out.print(currentpage);
				int startrow = (currentpage-1)*listsize;
				//System.out.print(startrow);
				int endrow = currentpage*listsize;
				
				
		 		//System.out.print(lastrow);
		 		//화면당 표시할 게시물 수
		 		int ls = 0;
		 		//마지막 페이지
		 		int lp = 0;
		 		//총 게시물 수
		 		int lr = 0;
		 		//현재 페이지
		 		int cp = 0;
		 		//System.out.print(currentpage);
				int sr = 0;
				//System.out.print(startrow);
				int er = 0;
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
					//System.out.print("asdasd");
				for(int i=startrow+1; i < endrow; i++){
					JSONObject DEFobject = (JSONObject) DEFArray.get(i);%>
					<tbody id="page">
						<tr>
							<td><a href="DEFdetail.jsp?name=<%=DEFobject.get("name")%>&addr=<%=DEFobject.get("addr")%>&price=<%=DEFobject.get("price")%>&tel=
							<%=DEFobject.get("tel")%>&inventory=<%=DEFobject.get("inventory")%>&openTime=<%=DEFobject.get("openTime")%>&regDt=<%=DEFobject.get("regDt")%>
							&lat=<%=DEFobject.get("lat")%>&lng=<%=DEFobject.get("lng")%>&totalcount=<%=lastrow%>"><%=DEFobject.get("name") %></a></td>
							<td id="addr"><%=DEFobject.get("addr") %></td>
							<td><%=DEFobject.get("price") %></td>
							<td><%=DEFobject.get("tel") %></td>
							<td><%=DEFobject.get("inventory") %></td>
						</tr>
					</tbody>
			<%	} } else{ // 검색을 하면 새로 페이징
						String str = "";
						
						for(int i=0; i< Integer.parseInt(s); i++){
							JSONObject DEFobject = (JSONObject) DEFArray.get(i);
							
							str = (String)DEFobject.get("name");
							String str2 = (String)DEFobject.get("inventory");
							
							
							String str3 = (String)DEFobject.get("addr");
							// String str3 = str3.split(" ")[0]; //array인덱스 자르기
							String str4 = (String)DEFobject.get("price");
							String str5 = (String)DEFobject.get("regDt");
							String str6 = (String)DEFobject.get("lat");
							String str7 = (String)DEFobject.get("lng");
							String str8= (String)DEFobject.get("tel");
							String str9= (String)DEFobject.get("openTime");
							
							Databases db2 = new Databases(str, str2, str3, str4, str5, str6, str7, str8, str9);
							
							String[] stt = db2.getAddr().split(" ");
							
							try{
								
								
								if(stt[0].matches(".*" +keyword+ ".*") || stt[1].matches(".*" +keyword+ ".*")){
									a1.add(db2);
								}
								
							}catch(Exception e){}
							
							
						}
						
						//위에 전역변수로 설정이 되어있으니까 새로 변수로 다시값을 바꿔주기
						//총 게시물 수
				 		lr = a1.size();
				 		//System.out.print(lastrow);
				 		//화면당 표시할 게시물 수
				 		ls = 30;
				 		//마지막 페이지
				 		lp = 0;
				 		//System.out.println(lastpage);

				 		cp = Integer.parseInt(pagenum);
				 		//System.out.print(currentpage);
						sr = (cp-1)*ls;
						//System.out.print(startrow);
						er = cp*ls;
						System.out.println(lr);
					
						if( lr % ls == 0 ){		// 만약에 총게시물/페이지당게시물 나머지가 없으면
				 			lp = lr / ls;		// * 총게시물/페이당게시물 
						}else{
							lp = lr / ls+1;	// * 총게시물/페이당게시물+1
						}
						
						//시작점          총게시물수
					 for(int i=sr; i < er; i++){
							%>
							 <tbody id="page">
								<tr>
									<td><a id="detail" href="DEFdetail.jsp?name=<%=a1.get(i).getName()%>&addr=<%=a1.get(i).getAddr()%>&price=<%=a1.get(i).getPrice()%>&tel=
									<%=a1.get(i).getTel()%>&inventory=<%=a1.get(i).getInventory()%>&openTime=<%=a1.get(i).getOpenTime()%>&regDt=<%=a1.get(i).getRegDt()%>
									&lat=<%=a1.get(i).getAddr()%>&lng=<%=a1.get(i).getAddr()%>"><%=a1.get(i).getName() %></a></td>
									<td id="addr"><%=a1.get(i).getAddr() %></td>
									<td><%=a1.get(i).getPrice() %></td>
									<td><%=a1.get(i).getTel() %></td>
									<td><%=a1.get(i).getInventory() %></td>
								</tr>
							</tbody>  
						<%
							
					}
							//총 게시물 수
				 		lastrow = lr;
				 		//System.out.print(lastrow);
				 		//화면당 표시할 게시물 수
				 		listsize = ls;
				 		//마지막 페이지
				 		
						lastpage = lp;
						System.out.print("마지막페이지:"+lastpage);
				 		currentpage = cp;
				 		//System.out.print(currentpage);
						startrow = sr;
						//System.out.print(startrow);
						endrow = er;
					}
			%>
						
		</table>
		<!-- 페이징 -->
			<div class="row">
				<div class="col-md-10 offset-2 justify-content-center my-3">
					<ul class="pagination"> <!-- 게시판 페이징 번호 -->
							<!-- 첫페이지에서 이전 페이지 눌렀을 때  첫페이지 고정-->
						<% if( currentpage == 1 ){%>
							<%if ( keyword==null ) {%>
								<li class="page-item"> <a href= "AppMain2.jsp?pagenum=<%=currentpage %>"  class="page-link">이전</a> </li>
							<%}else{ %>
								<li class="page-item"> <a href= "AppMain2.jsp?pagenum=<%=currentpage %>&keyword<%=keyword %>"  class="page-link">이전</a> </li>
							<%} %>	
						<%}else{ %>
							<li class="page-item"> <a href= "AppMain2.jsp?pagenum=<%=currentpage-1 %>&keyword<%=keyword %>"  class="page-link">이전</a> </li>
						<%} %>														<!-- 현재페이지번호-1 -->
						
							<!-- 게시물의 수만큼 페이지 번호 생성 -->
						<% for(int i=1; i<=lastpage; i++){ %>
						
							<% if( keyword == null ){ %>
							<li class="page-item"><a href="AppMain2.jsp?pagenum=<%=i %>" class="page-link"> <%=i %> </a> </li>
									<!-- i 클릭했을때 현재 페이지 이동 [ 클릭한 페이지번호 ] -->
							<%}else{%>
							<li class="page-item"><a href="AppMain2.jsp?pagenum=<%=i %>&keyword=<%=keyword %>" class="page-link"> <%=i %> </a> </li>
							<%} %>
							
						<%} %>
						
							<!-- 마지막페이지에서 다음버튼 눌렀을때 마지막 페이지 고정 -->
						<% if( currentpage == lastpage ){%>	
						<% if( keyword == null ){ %>
							<li class="page-item"><a href="AppMain2.jsp?pagenum=<%=currentpage+1%>" class="page-link"> 다음 </a> </li>
							<%}else{%>
							<li class="page-item"><a href="AppMain2.jsp?pagenum=<%=currentpage+1%>&keyword=<%=keyword %>" class="page-link"> 다음 </a> </li>	
							<%} %>
						<%}else{ %>
							<li class="page-item"><a href="AppMain2.jsp?pagenum=<%=currentpage+1 %>&keyword=<%=keyword %>" class="page-link">다음 </a> </li>
						<%} %>	
					
					</ul>
				</div>
			</div>	
		</form>
	</div>
</body>
</html>