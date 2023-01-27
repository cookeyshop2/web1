<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>Project</title>
</head>

<%
	request.setCharacterEncoding("UTF-8");
	String email = request.getParameter("email");
		
	MemberDAO dao = new MemberDAO();
	
	String authNum = dao.authNum(); 
	boolean result = dao.sendEmail(email, authNum); 
	
	if(result==false){
%>		<script type="text/javascript">
			alert("메일 전송 실패!메일주소를 확인 해 주세요.");
			window.close();
		</script>
<% 	}
%>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">

	function checkAuthNum(){
		var checkNum = document.getElementById("authNum").value;
		var authNum = <%=authNum%>
		
		if(!checkNum){
			alert("인증번호를 입력하십시오.")
		}else{
			if(checkNum == authNum){
				alert("성공적으로 인증되었습니다.");
				opener.document.getElementById("email").readOnly = true;
				opener.document.getElementById("authBtn").disabled = true;
				window.close();
			}else{
				alert("인증번호가 잘못되었습니다.");
				return false;
			}
		}
	}
	
</script>
<body>
	<form>
		<div>
			<h1>이메일 인증확인</h1>
			<p><%=email %>로 인증메일이 발송되었습니다.</p>
		</div>
		<div id="table_search">
			<input type="email" id="authNum" name="authNum" placeholder="" autofocus="">
			<label>인증번호를 입력하세요.</label>	
			<button class="btn" type="button" onclick="checkAuthNum()" class="">이메일인증</button>
		</div>
	</form>
</body>
</html>