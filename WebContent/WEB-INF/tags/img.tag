<%@ tag import="artn.common.tag.ImgMaker" %>
<%@ tag body-content="empty" pageEncoding="UTF-8" description="이메일 그룹 자동 생성 태그" trimDirectiveWhitespaces="true" %>
<%@ attribute name="id" %>
<%@ attribute name="cssClass" %>
<%@ attribute name="style" %>
<%@ attribute name="alt" %>
<%@ attribute name="altNone" %>
<%@ attribute name="src" %>
<%@ attribute name="srcNone" %>
<%@ attribute name="title" %>
<%@ attribute name="width" type="java.lang.Integer" %>
<%@ attribute name="height" type="java.lang.Integer" %>
<%
ImgMaker img = new ImgMaker(id, cssClass, style);
img.setAlt(alt).setAltNone(altNone).setSrc(src).setSrcNone(srcNone).setWidth(width).setHeight(height).setTitle(title);
out.print(img.make().toString());
%>