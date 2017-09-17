<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - Group Action Test : Create" contents="${contentsCode }">

<div class="article">
<h1>그룹 생성 완료</h1>
${params.name } 그룹이 생성 완료 되었습니다.
<s:if test="auth.isAdmin"><a href="list?contents=${contentsCode }_2">목록</a></s:if>
</div>
</a:html>