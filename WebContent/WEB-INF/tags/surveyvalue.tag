<%@tag import="artn.common.tag.SurveyValueMaker"%>
<%@ tag body-content="empty" pageEncoding="UTF-8" description="각종 셀렉트박스 자동 생성 태그" trimDirectiveWhitespaces="true" %>
<%--
	
--%>
<%@ attribute name="id" %>
<%@ attribute name="name" %>
<%@ attribute name="value" type="java.lang.Integer"  %>
<%@ attribute name="cssClass" %>
<%@ attribute name="style" %>
<%@ attribute name="offset" type="java.lang.Integer" %>
<%@ attribute name="wrap" %>
<%@ attribute name="subWrap" %>
<%@ attribute name="dual" type="java.lang.Boolean" %>
<%@ attribute name="radioShow" type="java.lang.Boolean" %>
<%@ attribute name="cssClassChecked" %>
<%@ attribute name="cssClassUnchecked" %>

<%

SurveyValueMaker radio = new SurveyValueMaker(id, cssClass, style, name, value);
radio.setOffset(offset).setWrap(wrap).setSubWrap(subWrap).setDual(dual).setRadioShow(radioShow)
.setCssClassChecked(cssClassChecked).setCssClassUnchecked(cssClassUnchecked);

out.print(radio.make().toString());
%>