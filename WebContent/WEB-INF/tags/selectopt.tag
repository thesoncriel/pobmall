<%@ tag import="artn.common.tag.SelectOpt"%>
<%@ tag body-content="scriptless" pageEncoding="UTF-8" description="Item Select" trimDirectiveWhitespaces="true" %>

<%@ attribute name="name" %>
<%@ attribute name="value" %>
<%@ attribute name="text" %>
<%@ attribute name="seq" %>
<%@ attribute name="selected" %>
<%@ attribute name="textdiv" %>
<%@ attribute name="selectdiv" %>
<%
SelectOpt selectOpt = new SelectOpt();
selectOpt.setValue(name, value, text, seq, selected, textdiv, selectdiv);
out.print(selectOpt.make().toString());
%>