<%@tag import="artn.common.tag.EmailboxMaker"%>
<%@ tag body-content="empty" pageEncoding="UTF-8" description="이메일 그룹 자동 생성 태그" trimDirectiveWhitespaces="true" %>
<%@ attribute name="wrap" %>
<%@ attribute name="id" %>
<%@ attribute name="cssClass" %>
<%@ attribute name="style" %>
<%@ attribute name="name" %>
<%@ attribute name="value" %>
<%@ attribute name="required" %>
<%
EmailboxMaker email = new EmailboxMaker(id, cssClass, style, name, value);
email.setWrap(wrap).setRequired(required);
out.print(email.make().toString());
%>