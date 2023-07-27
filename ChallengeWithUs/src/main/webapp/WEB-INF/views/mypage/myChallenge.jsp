<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/inc/viewsCss/myChallenge.css" type="text/css"/>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">


<div class="myChallengebox">
  
    <div class="myChallengeEllipse5"></div>
    <div class="myChallengeTitle">나의 챌린지</div>
  
   <div class="myChallenge1">
       <div class="ex">경험치</div>
      <div class="lv">${dto.achievementCount }회 성공</div>
     
    </div>
    
    <div class="myChallenge2">
      <div class="ex">회원등급</div>
      <div class="lv">${dto.membergradeName }</div>
    </div>
  
    
    <div class="myChallenge-right">
      <div class="myChallengeName">${dto.memberName }</div>
      <div class="designtext">CHALLENGE WITH US</div>
    </div>
   
  </div>
  
  
  <div class="myChallenge2box">
    <div class="myChallenge2box-Ellipse5"></div>
    <div class="center">
      <div class="title">나의 챌린지</div>
    </div>
  </div>
  
  
 
 <div class="cardtable">
  <div class="ChallengeCard">
	  <div class="Fullcard">
	    <img class="Image2" src="<%= request.getContextPath() %>/imgs/card.jpg" />
	    <div class="Content">
	      <div class="Title">미라클 모닝 챌린지</div>
	      <div class="Description">아침에 일찍 일어나고 싶은데 늘 실패하는 분들을 위해 준비한 챌린지 입니다. 부지런한 생활습관을 만들고 싶은 분들은 이 챌린지에 도전하세요</div>
	      <div class="Button">
	        <button><a href="/home/challenge">GO</a></button>
	      </div>
	    </div>
	  </div>
</div>

<c:forEach var="dto" items="${list}" varStatus="status">
<div class="ChallengeCard">
	  <div class="Fullcard">
	  <c:choose>
				<c:when
					test="${dto.chalFilename.endsWith('.jpg') || dto.chalFilename.endsWith('.png')}">
					<img
						class="Image2" src="<%=request.getContextPath()%>/upload/${dto.chalFilename}" />
				</c:when>
				<c:otherwise>
					<img class="Image2" src="<%=request.getContextPath()%>/imgs/card.jpg" />
				</c:otherwise>
			</c:choose>
	    <div class="Content">
	      <div class="Title">${dto.chalTitle }</div>
	      <div class="Description">${dto.chalContent }</div>
	      <div class="Button">
	        <button><a href="/home/ChallengeView?chalNo=${dto.chalNo}">GO</a></button>
	      </div>
	    </div>
	  </div>
</div>
</c:forEach>

</div>