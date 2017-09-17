<%@tag import="artn.common.tag.PhoneboxMaker"%>
<%@ tag body-content="empty" pageEncoding="UTF-8" description="이메일 그룹 자동 생성 태그" trimDirectiveWhitespaces="true" %>
<%@ attribute name="wrap" %>
<%@ attribute name="type" %>
<%@ attribute name="id" %>
<%@ attribute name="cssClass" %>
<%@ attribute name="style" %>
<%@ attribute name="name" %>
<%@ attribute name="value" %>
<%@ attribute name="required" %>
<%
PhoneboxMaker phone = new PhoneboxMaker(id, cssClass, style, name, value);
phone.setWrap(wrap).setType(type).setRequired(required);
out.print(phone.make().toString());
%>