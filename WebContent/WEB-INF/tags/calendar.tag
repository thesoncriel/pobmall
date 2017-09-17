<%@tag import="java.io.StringWriter"%>
<%@ tag import="artn.common.tag.TestCalendarMaker_ver01"%>
<%@ tag body-content="scriptless" pageEncoding="UTF-8" description="달력 페이지" trimDirectiveWhitespaces="true" %>
<%@ attribute name="id" %>
<%@ attribute name="cssClass" %>
<%@ attribute name="style" %>
<%@ attribute name="date" %>
<%@ attribute name="uri" %>
<%@ attribute name="extra" %>
<%@ attribute name="showBefore"%>
<%@ attribute name="list" type="java.lang.Object" required="true" rtexprvalue="true" %>
<%
JspWriter jspWriter = getJspContext().getOut();
StringWriter stringWriter = new StringWriter();
getJspBody().invoke(stringWriter);

TestCalendarMaker_ver01 calendar = new TestCalendarMaker_ver01(id, cssClass, style, date, uri);
calendar.setDate(date).setUri(uri).setExtra(extra).setShowBefore(showBefore).setTemplateToken(stringWriter.getBuffer().toString()).setList(list);
out.print(calendar.make().toString());
%>
