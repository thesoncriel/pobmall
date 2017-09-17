<%@tag import="artn.common.tag.WebPageInlineNavigator"%>
<%@tag import="artn.common.tag.WebPageTableNavigator"%>
<%@tag import="artn.common.tag.WebPageNavigator"%>
<%@ tag body-content="empty" pageEncoding="UTF-8" description="페이지 네비게이터" trimDirectiveWhitespaces="true" %>
<%@ attribute name="id" %>
<%@ attribute name="cssClass" %>
<%@ attribute name="style" %>
<%@ attribute name="uri" %>
<%@ attribute name="type" %>
<%@ attribute name="page" type="java.lang.Integer" %>
<%@ attribute name="rowLimit" type="java.lang.Integer" %>
<%@ attribute name="rowCount" type="java.lang.Integer" required="true"%>
<%@ attribute name="navCount" type="java.lang.Integer" %>
<%@ attribute name="font" %>
<%@ attribute name="params" type="java.lang.Object" %>

<%
WebPageNavigator pn = ((type != null) && (type.equals("table") == true))? new WebPageTableNavigator(id, cssClass, style) : new WebPageInlineNavigator(id, cssClass, style );

pn.setUri(uri).setPage(page)
.setRowLimit(rowLimit).setRowCount(rowCount)
.setNavCount(navCount).setParams(params)
.setFont(font);

out.print(pn.make(null).toString());
%>