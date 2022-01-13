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
	<%@include file="header2.jsp" %>
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
		String totalcount = request.getParameter("totalcount");
		
		//System.out.println("lng : " + lng + " lat : " + lat +" totalcount : "+totalcount);
	%>

	<div class="container">
		
		<h3>상세 정보</h3>
		<div class="col-md-6 row">
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
				</thead>
			</table>
		</div>
		<div class="col-md-5" id="map" style="width:500px;height:400px;"></div>
			<button class="btn btn-outline-dark" id="findnearbtn">근처 요소수 주유소 찾기</button>
			<button class="btn btn-outline-dark" id="currentbtn">현재 주유소 정보</button>
		
		<input type="hidden" id="lat" value="<%=lat%>">
		<input type="hidden" id="lng" value="<%=lng%>">
		<input type="hidden" id="totalcount2" value="<%=totalcount%>">
	</div>
</body>
</html>