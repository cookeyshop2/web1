<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="dao" class="member.MemberDAO" />
<jsp:useBean id="memberbean" class="member.MemberBean" />
<jsp:setProperty property="*" name="memberbean"/>
<%
	String id =request.getParameter("id");

	MemberBean tempbean = dao.getMember(id);
	
	String StoredPass = tempbean.getPasswd();
	
	String ParamPass = memberbean.getPasswd();
	
	if(!ParamPass.equals(StoredPass)){
%>
	<script>
		alert("비밀번호가 틀렸습니다.");
		history.back();
	</script>
<%		
	}else{
		dao.deleteMember(id);
		session.invalidate();
%>
	<script>
		alert("탈퇴가 완료되었습니다.");
		location.href="../index.jsp";
	</script>
<%
	}
	
%>
