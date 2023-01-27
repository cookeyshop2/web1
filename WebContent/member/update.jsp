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
<script type="text/javascript">

	var result_pwd = false;
	
	// Daum postcode API
	 function daumPostcode() {
	     new daum.Postcode({
	         oncomplete: function(data) {
	             // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	             // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	             // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	             var addr = ''; // 주소 변수
	             var extraAddr = ''; // 참고항목 변수
	
	             //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	             if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                 addr = data.roadAddress;
	             } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                 addr = data.jibunAddress;
	             }
	
	             // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	             if(data.userSelectedType === 'R'){
	                 // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                 // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                 if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                     extraAddr += data.bname;
	                 }
	                 // 건물명이 있고, 공동주택일 경우 추가한다.
	                 if(data.buildingName !== '' && data.apartment === 'Y'){
	                     extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                 }
	                 // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                 if(extraAddr !== ''){
	                     extraAddr = ' (' + extraAddr + ')';
	                 }
	              // 참고항목의 유무에 따라 최종 주소를 만든다.
	                 addr += (extraAddr !== '' ? extraAddr : '');
	             
	             } 
	
	             // 우편번호와 주소 정보를 해당 필드에 넣는다.
	             document.getElementById("zip").value = data.zonecode;
	             document.getElementById("address1").value = addr;
	             // 커서를 상세주소 필드로 이동한다.
	             document.getElementById("address2").focus();
	         }
	     }).open();
	 }
</script>

<script type="text/javascript">	
	function checkForm(f){
		if(!document.f.passwd.value){
			alert("비밀번호를 입력해주세요.");
			return false;
		}
		document.f.submit();
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
<h1>회원정보수정</h1>
<form action="updateAction.jsp" id="join" method="post" name="f">
<fieldset>
<legend>회원정보</legend>
<label>ID</label>
<input type="id" name="id" class="id" value="<%=memberbean.getId() %>" readonly> <br>
<label>비밀번호</label>
<input type="password" name="passwd" placeholder="변경할 비밀번호입력"><br>
<label>성명</label>
<input type="text" name="name" value="<%=memberbean.getName()%>" readonly><br>
<label>E-Mail</label>
<input type="email" id="email" name="email" value="<%=memberbean.getEmail()%>"readonly><br>
<label>휴대전화</label>
<input type="text" name="mtel" value="<%=memberbean.getMtel()%>" placeholder="-를 제외하고 입력해주세요"><br>
<label>주소</label>
<input type="text" id="zip" name="zip" value="<%=memberbean.getZip() %>" readonly>
<input type="button" id="search" class="dup" onclick="daumPostcode()" value="우편번호찾기"><br>
<label>&nbsp;</label><input type="text" id="address1" name="address1" class="address1" value="<%=memberbean.getAddress1() %>" readonly><br>
<label>&nbsp;</label><input type="text" id="address2" name="address2" class="address2" value="<%=memberbean.getAddress2()%>" placeholder="나머지 주소를 입력하세요." required="">
 
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="정보수정" class="submit">
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