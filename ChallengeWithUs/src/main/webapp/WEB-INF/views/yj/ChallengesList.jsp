<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.ChallengesList, .page>ul {
	overflow: auto;
}

.ChallengesList>li {
	float: left;
	height: 40px;
	line_height: 40px;
	border-bottom: 1px solid #ddd;
	width: 10%;
}

.ChallengesList>li:nth-child(6n+3) {
	width: 50%;
	/* 말줄임표시 */
	white-space: nowrap; /* 줄바꾸지 않기 */
	overflow: hidden; /* 넘친 값 숨기기 */
	text-overflow: ellipsis; /* ... 표시하기 */
}

.page li {
	float: left;
	width: 40px;
	height: 40px;
	text-align: center;
}

.search {
	text-align: center;
}
</style>
<main>
	<h1>게시판 목록</h1>
	<%-- 	<c:if test="${logId!=null}">
		<div>
			<a href="/home/board/boardWrite">글쓰기</a>
		</div>
	</c:if> --%>
	<div>
		<a href="/home/yj/ChallengesWrite">글쓰기</a>
	</div>
	<div>총 레코드 수 : ${pDTO.totalRecord }개</div>
	<ul class="ChallengesList">
		<li>&nbsp;</li>
		<li>챌린지번호</li>
		<li>챌린지타이틀</li>
		<li>챌린지등록자</li>
		<li>챌린지설명</li>
		<li>챌린지파일</li>
		<!--       변수       데이터(리스트)->modelandview에 설정한 변수 -->
		<c:forEach var="dto" items="${list}" varStatus="status">
			<li><input type="checkbox" /></li>
			<li>${dto.chalNo}</li>
			<li><a
				href='/home/board/boardView?no=${dto.chalNo}&nowPage=${pDTO.nowPage}${pDTO.searchWord != null ? "&searchKey=" + pDTO.searchKey + "&searchWord=" + pDTO.searchWord : ""}'>
					${dto.chalTitle} </a></li>
			<li>${dto.memberId}</li>
			<li>${dto.chalContent}</li>
			<li><img
				src="${pageContext.request.contextPath}/upload/${dto.chalFilename}"></img></li>
			<c:if test="${status.last}">
				<script>
                let lastNo = ${dto.chalNo}; // 마지막 DTO의 chalNo를 JavaScript 변수 lastNo에 저장
            </script>
			</c:if>
		</c:forEach>

	</ul>
	<div class="loadMoreBtn">
		<button onclick="loadMoreData()">더보기</button>
	</div>

	<div class="search">
		<form action="/home/yj/ChallengesList">
			<select name="searchKey">
				<option value="chalTitle">제목</option>
				<option value="chalContent">글내용</option>
				<option value="memberId">글쓴이</option>
			</select> <input type="text" name="searchWord" id="searchWord" /> <input
				type="submit" value="Search" />
		</form>
	</div>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<script>
	let nowPage = parseInt(${pDTO.nowPage}); // 현재 페이지 변수 선언
    let isLoading = false;
	nowPage = nowPage + 1;
	console.log(nowPage, lastNo);
    function loadMoreData() {
        if (!isLoading) {
            isLoading = true;
            const url = "${pageContext.request.contextPath}/yj/ChallengesListMore?nowPage="+nowPage+"&lastNo="+lastNo;
            $.ajax({
                method: 'GET',
                url: url,
                success: function (result) {
                    // 성공적으로 데이터를 받아왔을 때 실행되는 콜백 함수
                	const challengesList = result;
					console.log(result);
                    // challengesList를 반복하여 HTML 생성 및 추가
                    for (const dto of challengesList) {
                      const newListItem = `
                        <li>
                          <input type="checkbox" />
                        </li>
                        <li>${dto.chalNo}</li>
                        <li>
                          <a href="/home/board/boardView?no=${dto.chalNo}&nowPage=${nowPage}">
                            ${dto.chalTitle}
                          </a>
                        </li>
                        <li>${dto.memberId}</li>
                        <li>${dto.chalContent}</li>
                        <li>
                          <img src="${pageContext.request.contextPath}/upload/${dto.chalFilename}" />
                        </li>
                      `;
                      const challengesListElem = document.querySelector('.ChallengesList');
                      challengesListElem.insertAdjacentHTML('beforeend', newListItem);
                    }

                    nowPage += 1; // 현재 페이지 변수 업데이트
                    isLoading = false;
                  },
                error: function (e) {
                    // 에러 처리
                    alert("데이터를 가져오는데 실패했습니다.");
                    console.log(e.responseText);
                    isLoading = false;
                }
            });
        }
    }

	</script>
</main>