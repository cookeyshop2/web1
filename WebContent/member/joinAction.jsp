<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="dao" class="member.MemberDAO"/>

<jsp:useBean id="memberbean" class="member.MemberBean"/>
<jsp:setProperty property="*" name="memberbean"/>

<%
	dao.insertMember(memberbean);
%>
<script>
	alert("가입이 완료되었습니다.");
	location.href="../index.jsp";
</script>