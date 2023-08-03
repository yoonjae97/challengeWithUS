<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/inc/viewsCss/boardList.css" type="text/css"/>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">


<main>
<div class="board-box">
	<div class="board-title">
    <div class="board-Ellipse5"></div>
    <div class="board-center">
      <div class="board-text">고객 문의</div>
    </div>
  </div>
	
	
	
	<div style="color:white;">총 레코드 수 : ${pDTO.totalRecord }개</div>
	
	<ul class="board_list">
		<li>글번호</li>
		<li>글제목</li>
		<li>아이디</li>
		<li>날짜</li>
		<li>조회수</li>
		<!--       변수       데이터(리스트)->modelandview에 설정한 변수 -->
		<c:forEach var="dto" items="${list}">
			<li>${dto.qaNo }</li>
			<li><a href='/home/board/qaBoardView?no=${dto.qaNo }&nowPage=${pDTO.nowPage}<c:if test="${pDTO.searchWord!=null}">&searchKey=${pDTO.searchKey}&searchWord=${pDTO.searchWord}</c:if>'>${dto.qaTitle}</a></li>
			<li>${dto.memberId}</li>
			<li>${dto.qaDate }</li>
			<li>${dto.qaHit }</li>
		</c:forEach>
		
	</ul>	
	
	<c:if test="${logId!=null}">
		<div class="CheckButton">
			<a class="ButtonText" href="/home/board/qaBoardWrite">글쓰기</a>
		</div>
	</c:if>
	
	<div class="page">
		<ul>
		<!-- 이전 페이지 -->
		<c:if test="${pDTO.nowPage==1}">
			<li>prev</li>
		</c:if>
		<c:if test="${pDTO.nowPage>1}">
			<li><a href='/home/board/boardList?nowPage=${pDTO.nowPage-1}<c:if test="${pDTO.searchWord!=null}">&searchKey=${pDTO.searchKey }&searchWord=${pDTO.searchWord }</c:if>'>prev</a>
		</c:if>
		<!-- 페이지 번호 -->
		<!--              변수          시작값                          끝값    증가값 -->
		<c:forEach var = "p" begin = "${pDTO.startPageNum }" end ="${pDTO.startPageNum+pDTO.onePageNumCount-1}" step = "1">
			<c:if test="${p<=pDTO.totalPage}"><!-- totalPage보다 큰 페이지 번호는 출력하지 않는다. -->
				<c:if test="${p==pDTO.nowPage }">
					<li ><a href = '/home/board/boardList?nowPage=${p}<c:if test="${pDTO.searchWord!=null}">&searchKey=${pDTO.searchKey }&searchWord=${pDTO.searchWord }</c:if>'>${p}</a></li>
				</c:if>
				<c:if test = "${p!=pDTO.nowPage }">
					<li><a href = '/home/board/boardList?nowPage=${p}<c:if test="${pDTO.searchWord!=null}">&searchKey=${pDTO.searchKey }&searchWord=${pDTO.searchWord }</c:if>'>${p}</a></li>
				</c:if>
			</c:if>
		</c:forEach>
		
		<!-- 다음페이지 -->
		<c:if test="${pDTO.nowPage>=pDTO.totalPage}">
			<li>next</li>
		</c:if>
		<c:if test="${pDTO.nowPage<pDTO.totalPage }">	
			<li><a href='/home/board/boardList?nowPage=${pDTO.nowPage+1}<c:if test="${pDTO.searchWord!=null}">&searchKey=${pDTO.searchKey }&searchWord=${pDTO.searchWord }</c:if>'>next</a></li>
		</c:if>
		</ul>
	</div>
	<div class = "search">
		<form action = "/home/board/boardList">
			<select name = "searchKey">
				<option value = "qatitle">제목</option>
				<option value = "qacontent">글내용</option>
				<option value = "memberid">글쓴이</option>
			</select>
			<input type = "text" name = "searchWord"/>
			<input type = "submit" value = "Search"/>
		</form>
	</div>

</div>
</main>