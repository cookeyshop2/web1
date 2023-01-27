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
<link href="css/default.css" rel="stylesheet" type="text/css">
<link href="css/front.css" rel="stylesheet" type="text/css">

<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->

<!--[if IE 6]>
 <script src="script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]--> 
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="dao" class="member.MemberDAO"/>
<jsp:useBean id="memberbean" class="member.MemberBean"/>
<jsp:setProperty property="*" name="memberbean"/>

<%	
	BoardDAO bdao = new BoardDAO();

	//전체글 개수 얻기
	int count = bdao.getBoardCount();
	
	int pageSize = 5;
	
	String pageNum = request.getParameter("pageNum");
	
	if(pageNum == null){
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);

	int startRow = (currentPage - 1) * pageSize;
	
List<BoardBean> list = null;
	
	//만약 게시판에 글이 존재 한다면?
	if(count > 0){
		
		list = bdao.getBoardList(startRow,pageSize);
	} 
%>
</head>

<body>
<div id="wrap">
<!-- 헤더파일들어가는 곳 -->
<header>
<%
	String id = null;
	if(session.getAttribute("id")!=null){
		id = (String)session.getAttribute("id");
	}
	if(id==null){
%>
	<div id="login">
	<a href="member/login.jsp">로그인</a> | 
	<a href="member/join.jsp">회원가입</a>
	</div>

<%	
	}else{
	
	memberbean = dao.getMember(id);
%>
	<div id="login">
	<%=id%>님 로그인 중입니다!!
	<a href="member/update.jsp?id=<%=id %>">회원정보수정</a>
	<a href="member/logout.jsp">로그아웃</a>
	</div>
<%		
	}
%>
<div class="clear"></div>
<!-- 로고들어가는 곳 -->
<div id="logo"><img src="images/under_logo.gif" width="265" height="62" alt="Fun Web" onclick="location.href='#'"></div>
<!-- 로고들어가는 곳 -->
<nav id="top_menu">
<ul>
	<li><a href="index.jsp">HOME</a></li>
	<li><a href="center/notice.jsp">공지사항</a></li>
	<li><a href="imageboard/imageboard.jsp">이미지게시판</a></li>
	<li><a href="file/fileboard.jsp">자료게시판</a></li>
	<li><a href="member/policy.jsp">고객센터</a></li>
</ul>
</nav>
</header>
<!-- 헤더파일들어가는 곳 -->
<!-- 메인이미지 들어가는곳 -->
<div class="clear"></div>
<div id="main_img"><img src="images/main_img.jpg"
 width="971" height="282"></div>
<!-- 메인이미지 들어가는곳 -->
<!-- 메인 콘텐츠 들어가는 곳 -->
<article id="front">
<div id="solution">
<div id="hosting">
<h3><a href="center/notice.jsp">공지사항</a></h3>
<p>게시판 기능 구현 
페이징처리, 
공지사항은 운영진만 글을 쓸 수 있게 구현
댓글기능 구현</p>
</div>
<div id="security">
<h3><a href="imageboard/imageboard.jsp">이미지 게시판</a></h3>
<p>페이징처리, 이미지 업로드,다운로드 가능
글을 작성 시 글목록에 갤러리 형식으로 
이미지와 제목이 보임, 댓글기능 구현</p>
</div>
<div id="payment">
<h3><a href="file/fileboard.jsp">자료게시판</a></h3>
<p>페이징처리, 자료 업로드, 다운로드 가능
글 내용에서 자료제목을 클릭 시 다운로드 가능
댓글기능 구현
</p>
</div>
</div>
<div class="clear"></div>
<div id="sec_news">
<h3><span class="orange">프로젝트 주제</span></h3>
<dl>
<dt>공지사항,자료게시판,이미지게시판</dt>
<dd>
JSP, Ajax, JQuery를 이용한 웹서버 기능구현
<p>회원가입기능, 회원정보수정, 회원탈퇴 기능 구현</p>
<p>게시판들은 페이징처리, 답글기능, 댓글기능</p>
<p>업로드, 다운로드 가능</p>
<p>공지사항은 운영진만 글을 작성할 수 있음</p>
<p>이미지게시판은 이미지업로드 시 썸네일이 만들어짐</p>
</dd>
</dl>
</div>
<div id="news_notice">
<h3 class="brown">공지사항</h3>
<table>
	<tr>
		<th class="tno">No.</th>
		<th class="ttitle">Title</th>
    	<th class="tdate">Date</th>
    </tr>
	<%
		if(count > 0){ //만약 board게시판테이블에 글이 존재 한다면?
			for(int i=0;i<list.size();i++){
				BoardBean memberbean1 = list.get(i);
	%>
		<tr onclick="location.href='center/read.jsp?num=<%=memberbean1.getNum()%>'">
			<td><%=memberbean1.getNum() %></td>
			<td class="left">

				<%=memberbean1.getSubject() %>
			</td>
			<td><%=new SimpleDateFormat("yy-MM-dd").format(memberbean1.getDate())%></td>
		</tr>
	<%			
			}
		}else{ // 만약 board게시판테이블에 글이 존재하지 않다면 ?
	%>
		<tr>
			<td colspan="3">글이 존재하지 않습니다.</td>
		</tr>
	<%		
		}
	%>	   
	</table>
</div>
</article>
<!-- 메인 콘텐츠 들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<footer>
<hr>
<div id="copy">All contents Copyright 2022 
Inc. all rights reserved<br>
Contact mail:admin@admin.com Tel +82 10 1234 5678
</div>
<div id="social"><img src="images/facebook.gif" width="33" 
height="33" alt="Facebook">
<img src="images/twitter.gif" width="34" height="34"
alt="Twitter"></div>
</footer>
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>