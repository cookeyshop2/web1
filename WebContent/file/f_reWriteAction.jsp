<%@page import="f_board.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
%>
	<jsp:useBean id="boardbean" class="f_board.BoardBean"/>
	<jsp:setProperty property="*" name="boardbean"/>
<%
	boardbean.setDate(new Timestamp(System.currentTimeMillis()));

	BoardDAO bdao = new BoardDAO();
	
	bdao.reInsertBoard(boardbean); 
	
	response.sendRedirect("fileboard.jsp");
%>
</body>
</html>