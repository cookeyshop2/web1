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
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>


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
<h1>개인정보 정책</h1>
<fieldset>
개인정보의 수집 및 이용목적, 수집하는 개인정보의 항목 및 수집방법
개인정보를 제3자에게 제공하는 경우 제공받는 자의 성명(법인의 경우 법인의 명칭),
제공받는 자의 이용목적 및 제공하는 개인정보 항목
개인정보의 보유 및 이용기간, 개인정보의 파기절차 및 방법(제29조 단서의 규정에
따라 개인정보를 보존하려는 경우에는 그 보존근거 및 보존하는 개인정보 항목을 포함)
개인정보취급위탁을 하는 업무의 내용 및 수탁자(해당되는 경우에 한)
이용자 및 법정대리인의 권리와 그 행사방법
인터넷 접속정보파일 등 개인정보 자동 수집 장치의 설치․운영 및 그 거부에 관한 사항
개인정보관리책임자의 성명 또는 개인정보보호 업무 및 관련 고충사항을 처리하는 부서의
명칭과 그 전화번호 등 연락처
</fieldset>
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