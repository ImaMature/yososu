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

DataArrays.getArrayList();


//객체로 담아서 해당 반경의 주유소 찾기
double lat = Double.parseDouble(request.getParameter("lat4")); //경도
double lon = Double.parseDouble(request.getParameter("lon4")); //위도
System.out.print("lat : "+lat);
System.out.print("lon : "+lon);

ArrayList<Databases> a1 = new ArrayList<>();

for(int i =0; i<a1.size();i++){
	
	System.out.print("getLat : "+a1.get(i).getLat());
}
/* for(int i =0; i<a2.size(); i++){
	System.out.print(a2.get(i).addr);
} */
%>