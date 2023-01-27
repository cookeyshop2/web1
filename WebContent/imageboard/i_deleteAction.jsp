<%@page import="i_board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");

	int num = Integer.parseInt(request.getParameter("num"));	
%>
<jsp:useBean id="bdao" class="i_board.BoardDAO"/>
<jsp:useBean id="boardbean" class="i_board.BoardBean"/>
<jsp:setProperty property="*" name="boardbean"/>

<%
	BoardBean tmpBean = bdao.getBoardInfo(num);

	String StoredPass = tmpBean.getPasswd();
	
	String ParamPass = boardbean.getPasswd();
	
	if(!ParamPass.equals(StoredPass)){

%>
	<script type="text/javascript">
		window.alert("입력한 비밀번호가 틀립니다.");
		history.back();
	</script>
<%
	}else{
		
		bdao.deleteBoard(num); 
%>	 
		<script type="text/javascript">
		window.alert("삭제가 완료되었습니다.");
		location.href="imageboard.jsp";
	</script>
<%
	}
%>






<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>

</body>
</html>