<%@page import="java.io.InputStreamReader"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String keyword = request.getParameter("keyword");
	//System.out.println(keyword+" : keyword");
	String str = "";
	try{
		 URL url = new URL("https://api.odcloud.kr/api/uws/v1/inventory?page=1&perPage=1000&serviceKey=hm1u3zRV0ba96YTa5BqV4zu0jYFV2LGfPe2aRk0NyJVQsoX5FCSjuVth8RKvBvQzOW8ApIHwaxmajW9%2FRaYR5A%3D%3D");
		 BufferedReader bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
		 String rs = bf.readLine();
		 
		 JSONParser jsonParser = new JSONParser();
		 JSONObject jsonObject = (JSONObject) jsonParser.parse(rs);
		 JSONArray DEFArray = (JSONArray) jsonObject.get("data");
		// System.out.println(keyword+" : keyword2");
		 for(int i=0; i < DEFArray.size(); i++){
				JSONObject DEFobject = (JSONObject) DEFArray.get(i);
				str = (String)DEFobject.get("addr");
				if(str.contains(keyword)){
					out.print(str);
					//System.out.println(keyword+" : keyword3");
				}
					
		}
		 
		 
		 
	}catch(Exception e){
		 System.out.println(e.getMessage());
	}
%>
