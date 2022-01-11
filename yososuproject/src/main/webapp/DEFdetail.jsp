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
		String lat = request.getParameter("lat");
		String lng = request.getParameter("lng");
		String totalcount = request.getParameter("totalcount");
		
		//System.out.println("lng : " + lng + " lat : " + lat +" totalcount : "+totalcount);
	%>

	<section class="resume-section" id="education">
         <div class="resume-section-content">
             <h2 class="mb-1 text-primary">요소수 지도</h2>
             <div class="d-flex flex-column flex-md-row justify-content-between mb-5">
                 <div class="resume-section" id ="education">
					<div class="resume-section-content">
						<div>
						</div>
						<div id="map" style="width:80vw; height:30vw; border: 1px solid black;"></div>
							<input type="hidden" id="lat" value="<%=lat%>">
							<input type="hidden" id="lng" value="<%=lng%>">
							<input type="hidden" id="totalcount2" value="<%=totalcount%>">
						</div>
					</div>
              </div>
          </div>
      </section>
</body>
</html>