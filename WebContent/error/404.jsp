<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true" isErrorPage="true"%>
<%response.setStatus(HttpServletResponse.SC_OK);%>
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