<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<%-- TODO: 미니 로그인 기능 만들 것 --%>
</head>
<body>
<s:if test="hasLogin">
${user.id }님 환영합니다. <a href="/user/menu" target="_top">메뉴</a> <a href="/user/myinfo" target="_top">내 정보</a> <a href="/user/logout?mini=true">로그아웃</a>
</s:if>
<s:else>
<form action="/user/login" method="post">
ID: <input type="text" name="id" id="textbox_id"/> 
PW: <input type="text" name="pw" id="textbox_pw"/> 
<button type="submit">로그인</button> 
<a href="/user/join" target="_top">회원가입</a>
<input type="hidden" name="mini" value="true" />
</form>

</s:else>
</body>
</html>