<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/inc/viewsCss/registerStyle.css"
	type="text/css" />
</head>
<script type="text/javascript"
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<main>
	<form id="UpdateForm">
		<div class="register-form">
			<div class="sign_font">회원가입</div>
			<input type="text" class="name" placeholder="이름" name="memberName" id="username" value="${dto.memberName}">
			<div class="name_text" >이름</div>
			<input type="text" class="phone" placeholder="연락처" name="memberTel" value="${dto.memberTel}">
			<div class="phone_text">연락처</div>
			<input type="email" class="email" placeholder="이메일"
				name="memberEmail" id="useremail" value="${dto.memberEmail}">
			<div class="email_text">이메일</div>
			<input type="password" class="password" placeholder="비밀번호"
				id="userpwd" name="memberPwd" value="${dto.memberPwd}">
			<div class="pw_text" >비밀번호</div>
			<div class="sex_text">성별</div>
			<input type="radio" class="radio1" value="여" name="memberGender" ${dto.memberGender == '여' ? 'checked' : ''}>
			<input type="radio" class="radio2" value="남" name="memberGender" ${dto.memberGender == '남' ? 'checked' : ''}>
			<div class="male_font">남</div>
			<div class="female_font">여</div>
			<input type="text" class="birthday" placeholder="생년월일"
				name="memberBirth" value="${dto.memberBirth}">
			<div class="birth_text">생년월일</div>
			<input type="text" readonly class="id" placeholder="아이디" id="userid"
				name="memberId" value="${dto.memberId}" >
			<div class="id_text">아이디</div>
			<div class="double-check" id="doubleChk" >
				<div class="dochk" id="dochk" onclick="doubleChk()" data-value="N">중복확인</div>
			</div>
			<input type="text" id="sample6_postcode" class="postnum"
				placeholder="우편번호" name="zipcode"> <input type="text"
				id="sample6_extraAddress" class="conf" placeholder="참고항목"
				name="zipcodeSub"> <input type="text" class="address"
				placeholder="도로명 주소" id="sample6_address" name="streetAdr">
			<input type="text" id="sample6_detailAddress" class="detail_add"
				placeholder="상세주소" name="detailAdr">
			<div class="add_text">주소</div>
			<div class="find-address" onclick="sample6_execDaumPostcode()">
				<div class="fadd_text">주소검색</div>
			</div>
			<div class="login-button" >
				<button class="check_text" type="button" onclick="submitForm()">
					확인
				</button>
			</div>
		</div>
	</form>
	<script>
	function submitForm() {
		var formData = $("#UpdateForm").serialize();
		$.ajax({
		    type: "POST",
		    url: "${pageContext.request.contextPath}/myPage/myInfoOk",
		    data: formData,
		    success: function(result) {
		    	console.log(result);
		      // 서버에서 보낸 결과를 처리하는 부분
		      if (result == "success") {
		        alert("수정 성공!");
		        window.location.href = "${pageContext.request.contextPath}/mypage";
		      } else {
		        alert("수정 실패!");
		      }
		    },
		    error: function(xhr, status, error) {
		      console.error(xhr.responseText);
		      alert("서버 오류로 인해 회원가입에 실패했습니다.");
		    }
		  });
	}
	</script>
</main>