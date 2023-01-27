<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Project</title>
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");

		String id = request.getParameter("userid");

		MemberDAO mdao = new MemberDAO();
		     int check = mdao.idCheck(id); 
		if(check==1){
	%>
			<script>	
			alert("사용중인 아이디입니다.");
			</script>	
	<%	
		}else{
	
	%>
		<script>
		alert("사용가능한 아이디입니다.");
		</script>
		
	<%		
		}
	%>
	<div id="table_search">
	<h2>아이디 중복체크 </h2>
	<form action="join_IDCheck.jsp" method="post" name="nfr">   
	<label>User ID : </label><input type="text" name="userid" value="<%=id%>">
			 <input type="submit" value="중복확인" class="btn">
	</form>
	<input type="button" value="사용하기" onclick="result()" class="btn">
	</div>
	<script type="text/javascript">
		function result(){
			
			opener.document.f.id.value = document.nfr.userid.value;
			opener.document.getElementById("id").readOnly = true;
			opener.document.getElementById("authBtn2").disabled = true;
			window.close();
		}	
	</script>
</body>
</html>