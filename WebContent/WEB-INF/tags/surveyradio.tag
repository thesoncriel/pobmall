<%@tag import="artn.common.tag.SurveyRadioMaker"%>
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
<%@ attribute name="required" %>
<%@ attribute name="unchecked" type="java.lang.Boolean" %>
<%@ attribute name="labelShow" type="java.lang.Boolean" %>
<%@ attribute name="disabled" %>
<%

SurveyRadioMaker radio = new SurveyRadioMaker(id, cssClass, style, name, value);
radio.setOffset(offset).setWrap(wrap).setSubWrap(subWrap).setUnchecked(unchecked).setLabelShow(labelShow).setDisabled(disabled).setRequired(required);

out.print(radio.make().toString());
%>