<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

</head>
<body>
	<form action="<%=request.getContextPath() %>/yj/MemberRegOk" method="post">
	<ul>
		<li>아이디<input type="text" name="MemberId" id="MemberId" /></li>
		<li>비밀번호<input type="text" name="MemberName" id="MemberName"/></li>
		<li>성별남<input type="radio" value="남" name="MemberGender" id="male">
			여<input type="radio" value="여" name="MemberGender" id="female"></li>
		<li>이름<input type="text" name="MemberPwd" id="MemberPwd"/></li>
		<li>이메일<input type="text" name="MemberEmail" id="MemberEmail"/></li>
		<li>연락처<input type="text" name="MemberTel" id="MemberTel"/></li>
		<li>주소<input type="text" name="MemberAddr" id="MemberAddr"/></li>
		<li>생년월일<input type="text" name="MemberBirth" id="MemberBirth"/></li>
		</ul>
		<button type="submit">회원가입</button>
		<button type="button" id="dupChk">아이디중복확인</button>
	</form>
	<script>
		

			$("#dupChk").on('click', function() {
				var id = document.getElementById("MemberId").value;
				console.log(id);
				$.ajax({
					data : {
						'id' : id
					},
					url : '${pageContext.request.contextPath}/yj/dupChk',
					success : function(result) {
						console.log(result)
						if (result == 1) {
							alert("이미 사용중인 아이디입니다.");
							$('input[name="MemberId"]').val('');
							$("#dupChk").css('color', 'red');
							$("#dupChk").css('font-weight', 'bold');

						} else {
							alert("사용가능한 아이디입니다.");
							$("#dupChk").css('color', 'blue');
							$("#dupChk").css('font-weight', 'bold');
							$("#dupChk").attr("value", "Y");

						}
					},
					error : function(e) {
						console.log(e.responseText);
					}
				})
			});
</script>
</body>

</html>