<%@page import="i_board.CommentBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="dao" class="i_board.BoardDAO"/>

<%
	int cnum = Integer.parseInt(request.getParameter("cnum"));
	int num = Integer.parseInt(request.getParameter("num"));

	CommentBean cbean = new CommentBean();
	cbean.setCnum(Integer.parseInt(request.getParameter("cnum")));
	cbean.setNum(Integer.parseInt(request.getParameter("num")));

	dao.deleteComment(num, cnum);
	response.sendRedirect("i_read.jsp?num="+num);
	System.out.println(num);
	System.out.println(cnum);
%>
</body>
</html>