<%@tag import="artn.common.tag.ValueListMaker"%>
<%@ tag body-content="empty" pageEncoding="UTF-8" description="값에 따른 유동적 출력 기능" trimDirectiveWhitespaces="true" %>
<%@ attribute name="id" %>
<%@ attribute name="value" type="java.lang.Integer" %>
<%@ attribute name="zero" %>
<%@ attribute name="cssClass" %>
<%@ attribute name="cssCheckedClass" %>
<%@ attribute name="cssUncheckedClass" %>
<%@ attribute name="style" %>
<%@ attribute name="wrap" %>
<%@ attribute name="icon" type="java.lang.Boolean" %>
<%@ attribute name="list" type="java.lang.Object" required="true" %>
<%@ attribute name="offset" type="java.lang.Integer" %>
<%@ attribute name="listKey" %>
<%

ValueListMaker valuebox = new ValueListMaker(id, cssClass, style, value);
valuebox.setWrap(wrap).setZero(zero).setIcon(icon).setCssCheckedClass(cssCheckedClass).setCssUncheckedClass(cssUncheckedClass).setOffset(offset).setList(list).setListKey(listKey);

out.print(valuebox.make().toString());
%>