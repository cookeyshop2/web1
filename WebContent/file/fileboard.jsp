<%@page import="f_board.BoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="f_board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="f_board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Project</title>
<script type="text/javascript">
function fnRead(num){
	
	document.read.num.value = num;
	document.read.submit();
	
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
<%
	//게시판에 글을 추가 했다면 ? notice.jsp페이지에 추가한 글 정보를 검색해서 
	//현재 화면에 출력!
	
	//전체글 갯수 검색해서 얻자.
	BoardDAO bdao = new BoardDAO();
	
	String f_search="";
	
	if(request.getParameter("f_search")!=null){
		f_search=request.getParameter("f_search");
	}
	//전체글 개수 얻기
	int count = bdao.getBoardCount(); 
	
	//하나의 화면(페이지)마다 보여줄 글의 갯수 = 10개
	int pageSize = 5;
	
	//아래의 페이지 번호중 선택한 페이지 번호 얻기
	String pageNum = request.getParameter("pageNum");
	
	//아래의 페이지 번호중 선택한 페이지가 없다면 ? 첫 notice.jsp화면을 1페이지로 지정
	if(pageNum == null){
		pageNum = "1";
	}
	
	//위의 pageNum변수의 값을 정수로 변환해서 저장
	int currentPage = Integer.parseInt(pageNum); //현재 선택한 페이지 번호를 정수로 변환해서 저장
		// 현재 선택한 페이지 번호 = 현재 보여지는 페이지 번호
	//각 페이지마다 가장 첫번째로 보여질 시작 글번호 구하기	
	//(현재 보여지는 페이지 번호 - 1) * 한 페이지당 보여줄 글의 갯수(10)
	int startRow = (currentPage - 1) * pageSize;
	
	//board게시판 테이블의 글 정보들을 검색하여 가져와서 저장 할 ArrayList 생성
	//BoardBean객체만 저장할 수 있는 ArrayList생성
	List<BoardBean> list = null;
	
	//만약 게시판에 글이 존재 한다면?
	if(count > 0){
		
		//글정보 검색해오기
		//			getBoardList(각 페이지마다 첫번째로 보여지는 시작글번호, 한페이지당 보여줄 글 개수)
		list = bdao.getBoardList(startRow,pageSize, f_search);
	}
	
	SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd");
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
	<h1>자료게시판 [전체글개수 : <%=count%>]</h1>
	<h4>자료게시판은 회원만 글을 쓸 수 있습니다.</h4>
	<table id="notice">
		<tr>
			<th class="tno">No.</th>
		    <th class="ttitle">Title</th>
		    <th class="twrite">Writer</th>
		    <th class="tdate">Date</th>
		    <th class="tread">Read</th>
		</tr>
	<%
		if(count > 0){ //만약 board게시판테이블에 글이 존재 한다면?
			for(int i=0;i<list.size();i++){
				BoardBean memberbean = list.get(i);
	%>
		<tr onclick="location.href='f_read.jsp?num=<%=memberbean.getNum()%>'">
			<td><%=memberbean.getNum() %></td>
			<td class="left">
			<%
				int wid=0;
			
			if(memberbean.getRe_lev() > 0){
				wid=memberbean.getRe_lev() * 10;
			%>
			<img src="../images/center/level.gif" width="<%=wid %> height="15">
			<img src="../images/center/re.gif">
			<%}%>
				<%=memberbean.getSubject() %>
			</td>
			<td><%=memberbean.getName() %></td>
			<td><%=new SimpleDateFormat("yy-MM-dd").format(memberbean.getDate())%></td>
			<td><%=memberbean.getReadcount() %></td>
		</tr>
	<%			
			}
		}else{ // 만약 board게시판테이블에 글이 존재하지 않다면 ?
	%>
		<tr>
			<td colspan="5">글이 존재하지 않습니다.</td>
		</tr>
	<%		
		}
	%>	   
	</table>
<%
	if(session.getAttribute("id")!=null){
		String id=(String)session.getAttribute("id");

			
	
	 //세션영역에 id값이 저장되어 있다면?
%> 
	<div id="table_search">
		<input type="button" value="글쓰기" class="btn" onclick="location.href='f_write.jsp'">
	</div>
<%	
		}
%> 
<div id="table_search">
<form action="fileboard.jsp">
<input type="text" name="f_search" class="input_box">
<input type="submit" value="search" class="btn">
</form>
</div>
<div class="clear"></div>
<div id="page_control">
<%
	if(count > 0){ //게시판에 글이 존재한다면 ?
		//전체 페이지수 구하기 ex) 글이 20개가 존재한다면 한페이지당 보여줄 글의 수가 10개 = 2페이지
		//					글이 25개가 있다고했을 때 한페이지당 보여줄 글의수가 10개 = 3페이지
		//조건 삼항연산자      ->조건에 만족하면 참, 아닐 시 거짓   조건 ? 참 : 거짓 
		//전체 페이지수 = 전체글 / 한페이지에 보여 줄 글수 + (전체 글수를 한페이지에 보여줄 글 수로 나눈 나머지 값)
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
											// 나머지값이 0일때? 1을 사용하고 0이 아닐 때 1을 사용함
		//한 블럭에 묶여질 페이지 번호수 설정
		int pageBlock = 2;  //페이지 번호가 1개나옴
		
		//시작 페이지 번호 구하기
		//1 ~ 10 페이지가 있을 때 시작 페이지 번호는 1 , 11~20 페이지 번호가 있을때 시작 페이지 번호는 11
		//21 ~ 30 페이지가 있을 때 시작 페이지 번호는 21
		//공식 -> ((선택한 페이지 번호 / 한블럭에 보여지는 페이지번호 수) - 
				//(선택한 페이지번호를 한 화면에 보여 줄 페이지수로 나눈 나머지값)) * 한 블럭에 보여줄 페이지수 + 1;
		int startPage = 
	((currentPage / pageBlock) - (currentPage%pageBlock == 0 ? 1 : 0)) * pageBlock + 1 ; 
		
		//끝 페이지번호 구하기
		//1~10페이지가 있을 때 끝페이지 번호는 10, 11~20페이지 번호가 있을 때 끝페이지 번호는 20
		//21 ~ 30 페이지가 있을 때 끝 페이지 번호는 30
		//시작페이지번호 + 현재블럭에 보여줄 페이지수 - 1
		int endPage = startPage + pageBlock - 1;
		
		//끝 페이지번호가 전체 페이지수보다 클 때
		if(endPage > pageCount){
			//끝페이지 번호를 전체페이지수로 저장
			endPage = pageCount;
		}
		
		//[이전] 시작페이지 번호가 한 화면에 보여줄 페이지수 보다 클 때..
		if(startPage > pageBlock){
	%>
		<a href="fileboard.jsp?pageNum=<%=startPage-pageBlock%>&f_search=<%=f_search%>">[이전]</a>
	<%		
		}
		//[1][2][3]...[10] 을 나타내야함
		for(int i=startPage; i<=endPage; i++){
	%>
		<a href="fileboard.jsp?pageNum=<%=i%>&f_search=<%=f_search%>">[<%=i%>]</a>
	<%			
			
		}
		
		//[다음] 끝 페이지번호가 전체 페이지수 보다 작을 때..
		if(endPage < pageCount){
	%>
		<a href="fileboard.jsp?pageNum=<%=startPage+pageBlock%>&f_search=<%=f_search%>">[다음]</a>
	<%		
		}
	}
%>

<form action="f_read.jsp" name="read" method="post">
	<input type="hidden" name="num" /> <%--수정할 글번호 전달 --%>
	<input type="hidden" name="currentPage" />
</form>
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