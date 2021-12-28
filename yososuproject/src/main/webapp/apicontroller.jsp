<%@page import="yososuproject.DataArrays"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.URL"%>
<%@page import="yososuproject.Databases"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
   
<%
URL url = new URL("https://api.odcloud.kr/api/uws/v1/inventory?page="+k+"&perPage="+j+"&serviceKey=hm1u3zRV0ba96YTa5BqV4zu0jYFV2LGfPe2aRk0NyJVQsoX5FCSjuVth8RKvBvQzOW8ApIHwaxmajW9%2FRaYR5A%3D%3D");
BufferedReader bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
String rs = bf.readLine();

JSONParser jsonParser = new JSONParser();
JSONObject jsonObject = (JSONObject) jsonParser.parse(rs);
JSONArray DEFArray = (JSONArray) jsonObject.get("data");

//객체로 담아서 해당 반경의 주유소 찾기
double lat = Double.parseDouble(request.getParameter("lat4")); //경도
double lon = Double.parseDouble(request.getParameter("lon4")); //위도
System.out.print("lataaa : "+lat);
System.out.print("lonaaa : "+lon);

ArrayList<Databases> arr = new ArrayList<>();

System.out.print( DataArrays.parselist());
System.out.print( DataArrays.getArrayList());

for(int i =0; i<arr.size();i++){
	System.out.print("getLat : "+arr.get(i).getLat());
}
/* for(int i =0; i<a2.size(); i++){
	System.out.print(a2.get(i).addr);
} */
%>