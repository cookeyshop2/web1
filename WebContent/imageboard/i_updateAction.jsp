<%@page import="i_board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String pageNum = request.getParameter("pageNum");
%>
	<jsp:useBean id="boardbean" class="i_board.BoardBean"/>
	<jsp:setProperty property="*" name="boardbean"/>
<%
	BoardDAO bdao = new BoardDAO();

	int check=bdao.updateBoard(boardbean); 
	
	if(check==1){
		
	response.sendRedirect("imageboard.jsp");
	}else{
%>
	<script>
		alert("비밀번호가 틀립니다.");
		history.back();
	</script>
<%		
	}
%>