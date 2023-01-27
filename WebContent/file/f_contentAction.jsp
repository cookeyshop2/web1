<%@page import="java.sql.Timestamp"%>
<%@page import="f_board.CommentBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Project</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="dao" class="f_board.BoardDAO"/>


<%
	CommentBean cbean = new CommentBean();
	cbean.setId(request.getParameter("id"));
	cbean.setContent(request.getParameter("content"));
	cbean.setNum(Integer.parseInt(request.getParameter("num")));
	int num = Integer.parseInt(request.getParameter("num"));
	dao.insertComment(cbean);
	response.sendRedirect("f_read.jsp?num="+num);
%>
</body>
</html>