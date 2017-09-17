<%@tag import="artn.common.tag.CheckboxListMaker"%>
<%@ tag body-content="empty" pageEncoding="UTF-8" description="값에 따른 유동적 출력 기능" trimDirectiveWhitespaces="true" %>
<%@ attribute name="id" %>
<%@ attribute name="name" required="true" %>
<%@ attribute name="value" type="java.lang.Integer" %>
<%@ attribute name="cssClass" %>
<%@ attribute name="style" %>
<%@ attribute name="wrap" %>
<%@ attribute name="subWrap" %>
<%@ attribute name="listKey" %>
<%@ attribute name="type" %>
<%@ attribute name="offset" type="java.lang.Integer" %>
<%@ attribute name="list" type="java.lang.Object" required="true" rtexprvalue="true" %>
<%
CheckboxListMaker chkbox = new CheckboxListMaker(id, cssClass, style, name, value);
chkbox.setWrap(wrap).setSubWrap(subWrap).setOffset(offset).setType(type).setList(list).setListKey(listKey);

out.print(chkbox.make().toString());
%>