<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/inc/viewsCss/FindIdForm.css"
	type="text/css" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap"
	rel="stylesheet">

<div class="FindId-container">
	<div class="FindId-title">아이디 찾기</div>
	<div class="FindId-rectangle"></div>
	<div class="FindId-saction">

		<c:if test="${MemberId != null}">
			<div class="FindId-message">회원님의 아이디는 아래와 같습니다</div>
			<div class="FindId-id">${MemberId}</div>
		</c:if>
	</div>

	<div class="FindId-check">
		<button class="FindId-text">로그인</button>
	</div>
</div>
