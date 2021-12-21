<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style type="text/css">
		td{
			border: 1px solid #cccccc;
		}
	</style>
</head>
<body>
	<%@include file="header.jsp" %>
	<%
		String name = request.getParameter("name");
		String addr = request.getParameter("addr");
		String price = request.getParameter("price");
		String inventory = request.getParameter("inventory");
		String openTime = request.getParameter("openTime");
		String regDt = request.getParameter("regDt");
		String lat = request.getParameter("lat");
		String lng = request.getParameter("lng");
		String tel = request.getParameter("tel");
		System.out.println("lng : " + lng + " lat : " + lat);
	%>

	<div class="container">
		<h3>상세 정보</h3>
		<table class="table">
			<thead class="thead-dark">
				<tr>
					<th>상호명</th><td><%=name %></td>
				</tr>
				<tr>
					<th>주소</th><td><%=addr %></td>
				</tr>
				<tr>
					<th>영업시간</th><td><%=openTime %></td>
				</tr>	
				<tr>	
					<th>가격</th><td><%=price %></td>
				<tr>	
					<th>재고량</th><td><%=inventory %></td>
				</tr>
				<tr>
					<th>전화번호</th><td><%=tel %></td>
				</tr>
				<tr>
					<td colspan="8" id="map" style="width:500px;height:400px;"></td>
				</tr>
			</thead>
		</table>
		
		<input type="hidden" id="lat" value="<%=lat%>">
		<input type="hidden" id="lng" value="<%=lng%>">
	</div>
</body>
</html>