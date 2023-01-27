<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<header>
<%
	String id = null;
	if(session.getAttribute("id")!=null){
		id = (String)session.getAttribute("id");
	}
	if(id==null){
%>
	<div id="login">
	<a href="../member/login.jsp">로그인</a> | 
	<a href="../member/join.jsp">회원가입</a>
	</div>

<%	
	}else{
%>
	<div id="login">
	<%=id%>님 로그인 중입니다!!
	<a href="../member/update.jsp?id=<%=id %>">회원정보수정</a> |
	<a href="../member/logout.jsp">로그아웃</a>
	</div>
<%		
	}
%>


<div class="clear"></div>
<!-- 로고들어가는 곳 -->
<div id="logo"><img src="../images/under_logo.gif" width="265" height="62" alt="Fun Web" onclick="location.href='../index.jsp'"></div>
<!-- 로고들어가는 곳 -->
<nav id="top_menu">
<ul>
	<li><a href="../index.jsp">HOME</a></li>
	<li><a href="../center/notice.jsp">공지사항</a></li>
	<li><a href="../imageboard/imageboard.jsp">이미지게시판</a></li>
	<li><a href="../file/fileboard.jsp">자료게시판</a></li>
	<li><a href="../member/policy.jsp">고객센터</a></li>
</ul>
</nav>
</header>
</body>
</html>