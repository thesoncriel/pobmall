<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<%!
	public String getBrowser(String header) {
		if ( header.indexOf("MSIE") >= 0) {
	         return "MSIE";
	    } else if ( header.indexOf("Chrome") > -1) {
	         return "Chrome";
	    } else if ( header.indexOf("Opera") > -1) {
	         return "Opera";
	    } else if ( header.indexOf("Safari") > -1) {
	     	return "Safari";
	    }
	    
		return "Firefox";
	}
%>
<%
session.setAttribute("ipv6", request.getRemoteAddr());
session.setAttribute("ip", request.getRemoteAddr());
session.putValue("referer", request.getHeader("referer"));
session.setAttribute("browser", getBrowser(request.getHeader("User-Agent")));
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="refresh" content="0; URL=/user/loginbysession?redirect=${params.redirect }"/>
</head>
<body>
</body>
</html>