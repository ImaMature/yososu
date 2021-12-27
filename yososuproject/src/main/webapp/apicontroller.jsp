<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//객체로 담아서 해당 반경의 주유소 찾기
int lat = Integer.parseInt(request.getParameter("lat"));
int lon = Integer.parseInt(request.getParameter("lon"));


%>