<%@ tag import="artn.common.tag.DialogMaker" %>
<%@ tag body-content="empty" pageEncoding="UTF-8" description="이메일 그룹 자동 생성 태그" trimDirectiveWhitespaces="true" %>
<%@ attribute name="id" %>
<%@ attribute name="cssClass" %>
<%@ attribute name="style" %>
<%@ attribute name="title" %>
<%@ attribute name="width" type="java.lang.Integer" %>
<%@ attribute name="height" type="java.lang.Integer" %>
<%@ attribute name="popupOpt" type="java.lang.Integer" %>
<%@ attribute name="index" type="java.lang.Integer" %>
<%@ attribute name="positionX" type="java.lang.Integer" %>
<%@ attribute name="positionY" type="java.lang.Integer" %>
<%@ attribute name="popupContent" %>
<%
DialogMaker dialog = new DialogMaker(id, cssClass, style);
dialog.setPopupContent(popupContent).setPopupOpt(popupOpt).setHeight(height).setWidth(width).setIndex(index).setPositionX(positionX).setPositionY(positionY).setTitle(title).setId(id).setCssClass(cssClass).setStyle(style);
out.print(dialog.make().toString());
/* dialog.setWidth(width).setHeight(height).setTitle(title).setPopupOpt(popupOpt);
out.print(dialog.make().toString()); */
%>