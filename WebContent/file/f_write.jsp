<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
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
	function file_check(){
		var chk = document.getElementById("file");
		var chk1 = document.getElementById("subject");
		var chk2 = document.getElementById("content");
		var chk3 = document.getElementById("passwd");
		
		if(!chk.value){
			alert("파일을 선택하세요!");
			document.ff.file.foucs();
			return false;
		}else if(!chk1.value){
			alert("제목을 입력하세요!");
			document.ff.subject.foucs();
			return false;
		}else if(!chk2.value){
			alert("내용을 입력하세요!");
			document.ff.content.foucs();
			return false;
		}else if(!chk3.value){
			alert("게시글 비밀번호를 입력하세요!");
			document.ff.passwd.foucs();
			return false;
		}else{
			document.ff.submit();
		}
	}
</script>
</head>
<%

	String id =null;
	if(session.getAttribute("id")!=null){
		id =(String)session.getAttribute("id");
	}else{
		response.sendRedirect("../member/login.jsp");
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
<li><a href="fileboard.jsp">자료게시판</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->

<article>
	<h1>자료게시판</h1>
	<form action="uploadAction.jsp" method="post" enctype="multipart/form-data" name="ff">
	<table id="notice">
		<tr>
			<td>작성자</td>
			<td><input type="text" name="name" value="<%=id %>" readonly></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="passwd" id="passwd"></td>
		</tr>
		<tr>
			<td>제목</td>
			<td><input type="text" name="subject" id="subject"></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><textarea name="content" cols="40" rows="13" id="content">  </textarea></td>
		</tr>
		<tr>
			<td>파일</td>
			<td><input type="file" name="file" id="file">
		</tr>	
	</table>
	<div id="table_search">
		<input type="button" value="글쓰기" class="btn" onclick="file_check()">	
		<input type="reset" value="다시쓰기" class="btn">
		<input type="button" value="글목록" class="btn" onclick="location.href='fileboard.jsp'">
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