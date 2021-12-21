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
	
	<div class="container">
		<div class="row col-md-6 offset-3" style="text-align: center;">
			<input type = "text" class="form-control col-md-10" id = "keyword">
			<input type = "submit" class="btn btn-outline-dark col-md-2" onclick="search();" value="검색">
		</div>
		<%
		String [] aa = new String [1024];
		 List<DateItem> dateList = new ArrayList<>();
		
		 try{
			 URL url = new URL("https://api.odcloud.kr/api/uws/v1/inventory?page=1&perPage=1000&serviceKey=hm1u3zRV0ba96YTa5BqV4zu0jYFV2LGfPe2aRk0NyJVQsoX5FCSjuVth8RKvBvQzOW8ApIHwaxmajW9%2FRaYR5A%3D%3D");
			 BufferedReader bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
			 String rs = bf.readLine();
			 
			 JSONParser jsonParser = new JSONParser();
			 JSONObject jsonObject = (JSONObject) jsonParser.parse(rs);
			 JSONArray DEFArray = (JSONArray) jsonObject.get("data");
			 
			// for(int j=0; j<json2.size(); j++){
			 //}
			 
		 
		%>
		<h3>업데이트 일시 : <span><% %></span></h3>
		<form>
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
				for(int i=0; i < DEFArray.size(); i++){
					JSONObject DEFobject = (JSONObject) DEFArray.get(i);%>
					<tbody>
						<tr>
							<td><a href="DEFdetail.jsp?name=<%=DEFobject.get("name")%>&addr=<%=DEFobject.get("addr")%>&price=<%=DEFobject.get("price")%>&tel=
							<%=DEFobject.get("tel")%>&inventory=<%=DEFobject.get("inventory")%>&openTime=<%=DEFobject.get("openTime")%>&regDt=<%=DEFobject.get("regDt")%>
							&lat=<%=DEFobject.get("lat")%>&lng=<%=DEFobject.get("lng")%>"><%=DEFobject.get("name") %></a></td>
							<td id="addr"><%=DEFobject.get("addr") %></td>
							<td><%=DEFobject.get("price") %></td>
							<td><%=DEFobject.get("tel") %></td>
							<td><%=DEFobject.get("inventory") %></td>
							<td><%=DEFobject.get("lat") %></td>
						</tr>
					</tbody>
					
					
					
					
			<%	}
			 }catch(Exception e){
				 System.out.println(e.getMessage());
			 }
			%>
		</table>
		</form>
	</div>
</body>
</html>