<%@tag import="artn.common.tag.ValueboxMaker"%>
<%@ tag body-content="empty" pageEncoding="UTF-8" description="값에 따른 유동적 출력 기능" trimDirectiveWhitespaces="true" %>
<%@ attribute name="type" %>
<%@ attribute name="id" %>
<%@ attribute name="value" %>
<%@ attribute name="unit" %>
<%@ attribute name="zero" %>
<%@ attribute name="cssClass" %>
<%@ attribute name="style" %>
<%@ attribute name="digit" type="java.lang.Integer" %>
<%@ attribute name="index" type="java.lang.Integer" %>
<%@ attribute name="list" type="java.lang.Object" %>
<%

ValueboxMaker valuebox = new ValueboxMaker(id, cssClass, style, value);
valuebox.setType(type).setUnit(unit).setZero(zero).setDigit(digit).setIndex(index);

out.print(valuebox.make().toString());
%>