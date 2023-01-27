<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Project</title>

<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!-- Bootstrap -->
<link href="../css/bootstrap.min.css" rel="stylesheet">
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
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- Daum postcode API -->

<script type="text/javascript">	
	function checkForm(df){
		if(!document.df.passwd.value){
			alert("비밀번호를 입력해주세요.");
			return false;
		}
		if(document.df.passwd.value == document.df.passwd2.value){
			alert("두 비밀번호가 일치하지 않습니다.");
			return false;
		}
		document.df.submit();
	}

</script>

</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/header.jsp" />
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<%
	request.setCharacterEncoding("utf-8");
	
	String id =null;
	if(session.getAttribute("id")!=null){
	id = (String)session.getAttribute("id");
}
%>
	<jsp:useBean id="dao" class="member.MemberDAO"/>
	<jsp:useBean id="memberbean" class="member.MemberBean"/>
	<jsp:setProperty property="*" name="memberbean"/>
<%
	memberbean = dao.getMember(id);
%>

<%

	if(id==null){

%>
	<li><a href="join.jsp">회원가입</a></li>
<%		
	}else{

%>
	<li><a href="update.jsp?id=<%=id %>">회원정보수정</a></li>
	<li><a href="delete.jsp?id=<%=id %>">회원탈퇴</a></li>
<%
	}
%>
	<li><a href="policy.jsp">개인정보 정책</a></li>

</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>회원탈퇴</h1>
<form action="deleteAction.jsp" id="join" method="post" name="df">
<fieldset>
<legend>회원정보</legend>
<label>ID</label>
<input type="id" name="id" class="id" value="<%=memberbean.getId() %>" readonly> <br>
<label>성명</label>
<input type="text" name="name" value="<%=memberbean.getName()%>" readonly><br>
<label>비밀번호</label>
<input type="password" name="passwd" placeholder="비밀번호입력"><br>
<label>비밀번호확인</label>
<input type="password" name="passwd2" placeholder="다시한번입력"><br>
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="회원탈퇴" class="submit">
<input type="reset" value="다시작성" class="cancel">
</div>
</form>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/footer.jsp" />
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>