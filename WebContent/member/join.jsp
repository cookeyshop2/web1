<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Project</title>

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
 
function winopen(){
	if(document.f.id.value==""){	//아이디를 입력하지 않았다면?
		alert("아이디를 입력해주세요.");
		document.f.id.focus();
		return;
	}
	//아이디를 입력했다면 ? 입력한 아이디 값을 얻는다.
	var fid = document.f.id.value;
					
		//새창을 join_IDCheck.jsp로 띄우며 전달값으로 바로 위에 입력한 아이디(fid)를 전달함.
		//새창의 크기를 600px, 높이를 200px로 지정하여서 띄움.
		window.open("join_IDCheck.jsp?userid=" + fid, "","width=600,height=200");
	
	}//winopen() end

function authEmail(){
	
	var email = $("#email").val();

	if(email == ""){
		alert("메일주소를 입력하셔야 합니다.");
	}else{
		$.ajax({
			type : 'POST',
			url  : '/MyProject2/EmailCheck',
			data: {email: email}, 
			success: function(result){
				var str;
				if(result == "false"){ // 사용할 수 있는 email (DB와 중복되지 않음)
					str = "<font color='green'><b>사용 가능한 이메일 입니다.</b></font>";
					$('#checkEmail').html(str);
					window.open('email_auth.jsp?email='+email, 'Email 인증요청',
    				'width=500, height=400, menubar=no, status=no, toolbar=no');
				}else{
					str = "<font color='red'><b>이미 사용중인 메일주소입니다.</b></font>";
					$('#checkEmail').html(str);
				}}, error: function(){
				alert("ERROR!!");
			}
		});
	}
}

		function checkForm(){
		
		if($("#id").val()==""){
			alert("ID를 입력하지 않으셨습니다.");
			$("#id").focus();
			return false;
		}else if($("#name").val()==""){
			alert("이름을 입력하지 않으셨습니다.");
			$("#name").focus();
			return false;
		}else if($("#email").val()==""){
			alert("메일주소를 입력하지 않으셨습니다.");
			$("#email").focus();
			return false;
		}else if(document.getElementById("authBtn2").disabled==false){
	    	alert("ID중복확인이 완료되지 않았습니다.");
	    	$("#id").focus();
	    	return false;
		}else if(document.getElementById("authBtn").disabled==false){
			alert("메일 인증이 완료되지 않았습니다.");
			$("#email").focus();
			return false;
		}else if($("#passwd").val()==""){
			alert("비밀번호를 입력하지 않으셨습니다.");
			$("#passwd").focus();
			return false;
		}else if($("#passwd2").val()==""){
			alert("비밀번호 확인을 입력하지 않으셨습니다.");
			$("#passwd2").focus();
			return false;
		}else if(!result_pwd){
			alert("비밀번호를 올바르게 입력하지 않으셨습니다.");
			$("#passwd1").focus();
			return false;
		}else if($("#zip").val()==""){
			alert("주소를 입력하지 않으셨습니다.");
			$("#search").focus();
			return false;
		}else if($("#address2").val()==""){
			alert("나머지 주소를 입력하지 않으셨습니다.");
			$("#address2").focus();
			return false;
		}else {return;}
	}		
	    /* 비밀번호 유효성 검사 메서드*/
	    function checkPwd(){
	    	var pwd1 = $("#passwd").val();
	    	var checkSpan = $("#checkPwd1");
	    	var reg = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/;
	    	
	     	if(!reg.test(pwd1)){
	     		checkSpan.html("<font color='red'><b>영문,특문,숫자 조합으로 8자이상</b></font>");
	     	}else{
	     		checkSpan.html("<font color='green'><b>사용가능한 비밀번호</b></font>");
	     		result_pwd = true;
	     	}
	    }
	    
	   /* 비밀번호 재입력 일치 검사 메서드 */
	  function checkPwd2(){
	   	var pwd1 = document.getElementById("passwd").value;
	    var pwd2 = document.getElementById("passwd2").value;
	    var checkSpan = document.getElementById("checkPwd2");
	    if(pwd2 != ""){
		   	if(pwd2 == pwd1){
		    	checkSpan.innerHTML = "<font color='green'><b>비밀번호가 일치합니다.</b></font>";
		    }else{
		   		checkSpan.innerHTML = "<font color='red'><b>비밀번호가 일치하지 않습니다.</b></font>";
		   	}
	    }
   }
	  function checkMtel(){
	    	var mtel = $("#mtel").val();
	    	var checkSpan2 = $("#checkMtel");
	    	var regPhone = /^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/;
	    	
	     	if(!regPhone.test(mtel)){
	     		checkSpan2.html("<font color='red'><b>형식이 맞지 않습니다.</b></font>");
	     	}else{
	     		checkSpan2.html("<font color='green'><b>사용가능한 전화번호</b></font>");
	     		result_pwd = true;
	     	}
	    }
	  
	  function checkName(){
	    	var name = $("#name").val();
	    	var checkSpan3 = $("#checkName");
	    	var regName = /^[가-힣]{2,4}$/;
	    	
	     	if(!regName.test(name)){
	     		checkSpan3.html("<font color='red'><b>형식이 맞지 않습니다.</b></font>");
	     	}else{
	     		checkSpan3.html("<font color='green'><b>사용가능한 성명</b></font>");
	     		result_pwd = true;
	     	}
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
<li><a href="join.jsp">회원가입</a></li>
<li><a href="policy.jsp">개인정보 정책</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>회원가입</h1>
<form action="joinAction.jsp" id="join" method="post" name="f" onsubmit="return checkForm()">
<fieldset>
<legend>회원정보</legend>
<label>ID</label>
<input type="text" id ="id" name="id" class="id" placeholder="ID를 입력하세요.">
<input type="button" value="중복확인" class="dup" onclick="winopen()" id="authBtn2">   <br>
<label>비밀번호</label>
<input type="password" id="passwd" name="passwd" placeholder="8자리 이상 입력하세요" class="io" onblur="checkPwd()"><span id="checkPwd1">&nbsp;</span><br>
<label>비밀번호확인</label>
<input type="password" id="passwd2" name="passwd2" placeholder="비밀번호 확인" class="io" onblur="checkPwd2()"><span id="checkPwd2">&nbsp;</span><br>
<label>성명</label>
<input type="text" id="name" name="name" placeholder="홍길동" class="io" onblur="checkName()"><span id="checkName">&nbsp;</span><br>
<label>E-Mail</label>
<input type="email" id="email" name="email" placeholder="abc@email.com" class="io">
<input type="button" value="이메일인증" id="authBtn" class="dup" onclick="authEmail()" >
<span id="checkEmail">&nbsp;</span>
<br>

<label>휴대전화</label>
<input type="text" id="mtel" name="mtel" class="io" placeholder="-를 제외하고 입력하세요." onblur="checkMtel()"><span id="checkMtel">&nbsp;</span><br>
<label>주소</label>
<input type="text" id="zip" name="zip" class="io" readonly>
<input type="button" id="search" class="dup" onclick="daumPostcode()" value="우편번호찾기"><br>
<label>&nbsp;</label><input type="text" id="address1" name="address1" value="" class="address1" readonly><br>
<label>&nbsp;</label><input type="text" id="address2" name="address2" class="address2" placeholder="상세주소를 입력하세요." required="">

</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="회원가입" class="submit" >
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