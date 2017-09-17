<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<%
String sContents = request.getParameter("contents");
//System.out.println(sContents + ":::::");
if ((sContents == null) || (sContents.equals("") == true)){
	response.sendRedirect("/main");
	return;
}
%>
<a:html title=" - 메인 페이지" contents="${param.contents }">
<div class="contents">
	<s:if test="hasContents(#parameters.contents)">
	<jsp:include page="/WEB-INF/include/contents/${param.contents}.htmlpart" flush="false"/>
	</s:if>
	<s:else>
	요청한 컨텐츠 페이지가 존재하지 않습니다.
	</s:else>
</div>
</a:html>