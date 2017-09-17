<%@ tag body-content="empty" pageEncoding="UTF-8" description="파일 업로드 관련 자동 생성 태그" trimDirectiveWhitespaces="true" %>
<%@ attribute name="id" %>
<%@ attribute name="name" required="true" %>
<%@ attribute name="value" %>
<%@ attribute name="oriValue" %>
<%@ attribute name="cssClass" %>
<%@ attribute name="buttonClass" %>
<%@ attribute name="style" %>
<%@ attribute name="path" %>
<%@ attribute name="thumbWidth" type="java.lang.Integer" %>
<%@ attribute name="thumbHeight" type="java.lang.Integer" %>
<%@ attribute name="deleteUrl" %>
<%@ attribute name="action" %>
<%@ attribute name="toImg" %>
<%@ attribute name="downloader" %>
<span class="${cssClass }">
<%
	StringBuilder sbInputOtherAttr = new StringBuilder();
	boolean isNullPath = (path == null) || (path.equals("") == true);
	String sFilePath = "";
	
	if (isNullPath == false){
		if (path.endsWith("/") == false){
			path = path + '/';
		}
		
		if (downloader == null){
			sFilePath = "/download?path=" + path + name.replace("file_", "") + "/&amp;fileName=";
		}
		else{
			sFilePath = downloader + path + "fileName=";
		}
	}

	if (isNullPath == false){
		
		sbInputOtherAttr.append("data-path=\"").append(path).append("\"" );
	}
	if ((action != null) && (action.equals("") == false)){
		sbInputOtherAttr.append("data-action=\"").append(action).append("\"" );
	}
	if ((toImg != null) && (toImg.equals("") == false)){
		sbInputOtherAttr.append("data-to-img=\"").append(toImg).append("\"" );
	}
%>
<input type="file" id="${id }" name="${name }" <%=sbInputOtherAttr.toString() %>/> 
<%
	if( isNullPath == false ){
		if ((value != null) && (value.isEmpty() == false)){
			out.print("<a href=\"" + sFilePath + value + "\" class=\"file-link\">" + value + "</a> ");
		}
		if ((deleteUrl != null) && (deleteUrl.equals("") == false)) {
			out.print("<button type=\"button\" class=\"" + buttonClass + "\" data-deleteUrl=\"" + deleteUrl + "\">삭제</button>");
		}
	}
%>
<input type="hidden" name="${name }_exists" value="${value }"/>
<input type="hidden" name="thumbWidth" value="${thumbWidth }"/>
<input type="hidden" name="thumbHeight" value="${thumbHeight }"/>
<input type="hidden" name="${name }_orivalue" value="${oriValue }"/>
</span>