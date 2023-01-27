<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Project</title>

<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
  <script type="text/javascript">
 function check() {
	   if (document.dr.passwd.value == "") {
		 alert("삭제을 위해 패스워드를 입력하세요.");
	     dr.passwd.focus();
		 return false;
		 }
	   document.dr.submit();
	}
 </script>
</head>
<%
	String id =(String)session.getAttribute("id");
	if(id==null){
		response.sendRedirect("../member/login.jsp");
	}
	
	request.setCharacterEncoding("utf-8");

	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	BoardDAO dao = new BoardDAO();
	
	BoardBean boardbean = dao.getBoardInfo(num);
	
	String Name = boardbean.getName();
	Timestamp Date = boardbean.getDate();
	String DBSubject = boardbean.getSubject();
	String Content = "";
	
	if(boardbean.getContent() != null){
		Content = boardbean.getContent().replace("\r\n","<br/>");
	}

%>

<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/header.jsp" />
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="notice.jsp">공지사항</a></li>
<li><a href="imageboard.jsp">이미지게시판</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<article>
	<h1>글삭제</h1>
	<form action="deleteAction.jsp" method="post" name="dr">
	<input type="hidden" name="num" value="<%=num%>" />
	
	<table id="notice">
		<tr>	
			<td>비밀번호</td>
			<td><input type="password" name="passwd"></td>
		</tr>
	</table>
<%

%> 
	<div id="table_search">
		<input type="submit" value="삭제" class="btn">
		<input type="reset" value="다시작성" class="btn" >
		<input type="button" value="목록" class="btn" onclick="history.back()">
	</div>

</form>
<div class="clear"></div>
<div id="page_control">

</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/footer.jsp" />
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>