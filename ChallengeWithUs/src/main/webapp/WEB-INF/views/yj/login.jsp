<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form method="post" action="${pageContext.request.contextPath}/yj/loginOk">
<ul>
	<li>아이디<input type="text" name="MemberId" id="MemberId"/></li>
	<li>비밀번호<input type="text" name="MemberPwd", id="MemberPwd"/></li>
</ul>
<button type="submit">로그인</button>
</form>
</body>
</html>