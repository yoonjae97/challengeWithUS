<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/inc/viewsCss/accountView.css?v=230728"
	type="text/css" />

<main class="depositContain">

	<div class="deposit-management">
		<div class="Ellipse5"></div>
		<div class="center">
			<div class="title">예치금 관리</div>
		</div>
	</div>
	<div></div>

	<div class="account-container">
		<div class="account-LatestTransaction">
			<div class="amount">${mdto.memberDeposit }</div>
			<div class="type">예치금</div>
		</div>
		<div class="account-WalletAmount">
			<div class="charge-text">
				<a href="${pageContext.request.contextPath }/myPage/payForm">충전하기</a>
			</div>
			<div class="challenge-text">challenge with us</div>
		</div>
		<div class="account-Ellipse5"></div>
		<div class="LeftSide">
			<div class="username">${mdto.memberName }</div>
		</div>


	</div>
	
	<div class="list-box">
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/inc/viewsCss/boardList.css"
		type="text/css" />
	<div class="board-box">
		<ul class="board_list">
			<li>회원아이디</li>
			<li>결제금액</li>
			<li>결제내용</li>
			<li>결제일</li>
			<li>잔액</li>
			<c:forEach var="dto" items="${list}" varStatus="status">
				<li>${dto.memberId }</li>
				<li>${dto.depositAmount }</li>
				<li>${dto.depositContent }</li>
				<li>${dto.depositpayDate.split(' ')[0] }</li>
				<li>${dto.depositBalance }</li>
			</c:forEach>
		</ul>
	</div>
	</div>

</main>
