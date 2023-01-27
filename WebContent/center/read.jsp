<%@page import="board.CommentBean"%>
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

<%
	request.setCharacterEncoding("utf-8");
	int num = Integer.parseInt(request.getParameter("num"));
	System.out.println(num);
	String pageNum = request.getParameter("pageNum");
	
	BoardDAO dao = new BoardDAO();
	
	dao.updateReadCount(num); 
	
	BoardBean boardbean = dao.getBoardInfo(num);
	
	int ReadCount = boardbean.getReadcount();
	String Name = boardbean.getName();
	Timestamp Date = boardbean.getDate();
	String DBSubject = boardbean.getSubject();
	String Content = "";
	
	if(boardbean.getContent() != null){
		Content = boardbean.getContent().replace("\r\n","<br/>");
	}
	int Re_ref = boardbean.getRe_ref();
	int Re_lev = boardbean.getRe_lev();
	int Re_seq = boardbean.getRe_seq();
	
	
	


%>
<meta charset="UTF-8">
<title>Project</title>
	<script type="text/javascript">

		function fnList() {
			document.list.submit();
		}
	
	</script>
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

</head>

<jsp:useBean id="cmtbean" class="board.CommentBean"/>
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
	<h1>공지사항</h1>
	<table id="notice">
		<tr>
			<td>글번호</td>
			<td><%=num%></td>
			<td>조회수</td>
			<td><%=ReadCount %></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td><%=Name %></td>
			<td>작성일</td>
			<td><%=Date %></td>
		</tr>
		<tr>
			<td>글제목</td>
			<td colspan="3"><%=DBSubject %></td>
		</tr>
		<tr>
			<td>글내용</td>
			<td colspan="3"><%=Content %></td>
		</tr>
	</table>
<%
	String id =null;
	if(session.getAttribute("id")!=null){
		id=(String)session.getAttribute("id");
	 //세션영역에 id값이 저장되어 있다면?
%> 
	<div id="table_search">
	<%
		if(id.equals(boardbean.getName())){
	%>			
		<input type="button" value="수정" class="btn" onclick="location.href='update.jsp?num=<%=num%>'">
		<input type="button" value="삭제" class="btn" onclick="location.href='delete.jsp?num=<%=num%>'">
	<%
	}
	%>
		
		<input type="button" value="답글" class="btn"
		 onclick="location.href='reWrite.jsp?num=<%=num%>&re_ref=<%=Re_ref%>&re_lev=<%=Re_lev%>&re_seq=<%=Re_seq%>'">
	</div>
<%	

	}
%> 
	<div id="table_search">
	<input type="button" value="목록" class="btn" onclick="history.back()">
	</div>
<div>

<div class="clear"></div>
<div id="page_control">
<table id="notice">
	<%			ArrayList<CommentBean> clist = dao.getComment(num);
				if(clist.isEmpty()){
%>					<tr><td colspan="6">등록된 댓글이 없습니다.</td></tr>
<%				} else{
					for(int i=0;i<clist.size();i++){
						CommentBean A = clist.get(i);
%>					<tr>
						<td style="text-align:right;"><%=A.getId() %></td>
						<td colspan="4" style="text-align:center;" width="400px"><%=A.getContent() %></td>
						<td style="text-align:right;">
						<%=new SimpleDateFormat("yy-MM-dd").format(A.getDate())%>&nbsp;&nbsp;		
							<a onclick="location.href='c_delete.jsp?num=<%=num%>&cnum=<%=A.getCnum()%>'">삭제</a>
						</td>				
					</tr>	
<%					}
				}
%>
	
<form action="n_contentAction.jsp?num=<%=num %>" method="post">

	<%
		if(session.getAttribute("id")!=null){	
			
	%>
	<tr>
	
		<td>ID</td>
		<td colspan="4" style="text-align:center;" width="400px">내용</td>
		<td></td>		
	</tr>
	<tr>
		<td><%=id%></td>
			<input type="hidden" name="id" value="<%=id %>">
			
		<td colspan="5">
			<textarea rows="3" cols="70" name="content"></textarea>
				<div id="table_search">
					<input type="submit" class="btn" value="작성">
	<%}%>
				</div>
		</td>
	</tr>
</form>
</table>
</div>
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