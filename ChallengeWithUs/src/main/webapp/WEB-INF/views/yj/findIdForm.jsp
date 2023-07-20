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
<form method="post" action="${pageContext.request.contextPath}/yj/idSearchOk">
<ul>
	<li>이름<input type="text" name="MemberName" id="MemberName"/></li>
	<li>이메일<input type="text" name="MemberEmail", id="MemberEmail"/></li>
</ul>
<button type="submit">로그인</button>
</form>
</body>
</html>