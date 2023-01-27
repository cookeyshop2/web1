<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.sql.Timestamp"%>
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
	String id =null;
	if(session.getAttribute("id")!=null){
		id = (String)session.getAttribute("id");
	}else{
		response.sendRedirect("../member/login.jsp");
	}
	
	request.setCharacterEncoding("utf-8");
%>
	<jsp:useBean id="boardbean" class="board.BoardBean"/>
	<jsp:setProperty property="*" name="boardbean"/>
<%
	boardbean.setDate(new Timestamp(System.currentTimeMillis()));
	BoardDAO bdao = new BoardDAO();
	
	bdao.insertBoard(boardbean);
%>
<script>
	alert("작성이 완료되었습니다.");
	location.href="notice.jsp";
</script>	
	
</body>
</html>