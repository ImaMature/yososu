<%@page import="dao.BoardDao"%>
<%@page import="dto.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String b_title = request.getParameter("b_title");
b_title = b_title.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\S)*(/)?","");
b_title = b_title.replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>");
String b_contents = request.getParameter("b_contents");
b_contents = b_contents.replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>");



String b_password = request.getParameter("b_password");
String b_writer = request.getParameter("b_writer");
//System.out.println("b_title : "+ b_title + "b_contents : " + b_contents + "b_title : "+b_title+
		"b_password : "+b_password + "b_writer : " + b_writer);

// 객체화
Board board = new Board( b_password, b_title , b_contents, b_writer);

// DB처리
boolean result = BoardDao.getBoardDao().boardwrite( board);
if(result){
   out.print(1);
}else{
	out.print(2);
}

%>