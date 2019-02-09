<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登录页面</title>
</head>
<body>
	<form action="${pageContext.request.contextPath}/User/doLogin" method="post">
		用户名：<input type="text" name="username">
		密码：<input type="password" name="password">
		<input type="submit" value="登录"> <input type="reset">
	</form>
	<img src="../views/static/images/drip.png" />
</body>
</html>