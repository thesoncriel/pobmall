<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<%-- <a:html title=" - Validation Check">

<div class="article">
<h1>권한 오류 입니다.</h1>
<p>본 페이지에 접근 할 권한이 없습니다.<br/>올바른 권한을 가진 계정으로 다시 로그인 하시길 바랍니다.</p>
<s:if test="showIsNull || hasLogin">
<a href="/login">로그인 하기</a><br/>
</s:if>
<s:else>
<a href="/main">메인 페이지로</a><br/>
<a href="/logout">다른 계정으로 로그인 하기</a>
</s:else>
<br/>
<a href="#" data-rule="gotoback">이전 화면으로 돌아가기</a>
</div>

</a:html> --%>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="/css/jglovis/error.css" />
	<title>Error 404</title>
</head>
<body class="error">
	<div class="article">
		<h1><a href="/index.jsp">POB MALL</a></h1>		
		<img src="/img/jglovis/error/404.jpg" alt="" usemap="#map" />
		<map name="map">
			<area shape="rect" coords="817, 8, 1016, 30" href="mailto:master@jglovis.com"/>
		    <area shape="rect" coords="444, 228, 578, 249" href="/index.jsp"/>
		    <area shape="rect" coords="445, 199, 578, 223" href="javascript:history.go(-1);"/>
		</map>
	</div>
</body>
</html>