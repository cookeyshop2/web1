<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="dao" class="member.MemberDAO"/>

<jsp:useBean id="memberbean" class="member.MemberBean"/>
<jsp:setProperty property="*" name="memberbean"/>

<%
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	
	int check = dao.loginMember(id, passwd);
	
	if(check == 1){
	session.setAttribute("id",id);
%>
	<script>
		alert("환영합니다 ");
		location.href="../index.jsp";
	</script>
<%
	}
	if(check==0){
%>
	<script>
		alert("비밀번호가 틀립니다.");
		history.back();
	</script>
<%	
	}
	if(check==-1){
%>
	<script>
		alert("존재하지 않는 아이디입니다.");
		history.back();
	</script>
<%		
	}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>