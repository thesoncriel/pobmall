<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : List" contents="${boardInfo.contentsCode }">
	<div class="header">
		<h1>${boardInfo.name }</h1>
		<%-- <div id="breadcrumbs" data-sub="${boardInfo.contentsCode }"></div> --%>
		<div id="breadcrumbs" data-sub="${param.contents }"></div>
	</div>
<!--<script>
$(document).ready(function(){	
	$(".commentItem .comment_edit").click(function(){		
		var jqThis = $(this);		
		console.log($(".comment_contents").text());		
		jqThis.siblings(".comment_contents").replaceWith("<input type=\"text\" name=\"comment\" size=\"70\" value=\"" + jqThis.siblings(".comment_contents").text() + "\"/>");
		jqThis.siblings(".comment_delete").replaceWith("<a href=\"#\" class=\"comment_cancel\">취소</a>");
		jqThis.replaceWith("<input type=\"submit\"/>");		
		
		$(".commentItem .comment_cancel").click(function(){
			location.reload();			
		});
		return false;
	});	
});
	
</script>-->
<div class="section">
<div class="article">

<h2>${showData.subject}</h2>
<table class="board-show">
<thead>
<tr class="delimiter">
	<td class="category">${showData.category}</td>
	<td class="name">글쓴이 : ${showData.user_name}(${showData.id_user})</td>
	<td class="view-cnt">조회수 : ${showData.view_count}</td>
	<td class="date">작성일 : ${showData.date_upload_fmt}</td>
	<td>&nbsp;</td>
</tr>
<%--
<tr class="attach-file">
	<th>첨부파일</th>
	<td colspan="4">파일이당.png</td>
</tr>
 --%>
</thead>
<tbody>
<tr>
	<td colspan="5">${showData.contents}</td>
</tr>
</tbody>
</table>

<div class="footer board">
<div class="buttons">

<!--<s:if test="showData.depth < 1"><span class="artn-button board"><a href="write?id=${param.id}&board_no=${param.board_no}&depth=${showData.depth+1}&re=re&subject=${showData.subject}&amp;contents=${param.contents}">답글</a></span></s:if>-->
<a href="list?board_no=${param.board_no}&amp;view=${param.view}&amp;contents=${param.contents}" class="artn-button board">목록</a>
<s:if test="(auth.isAdmin)">
	<a href="edit?id=${showData.id }&board_no=${param.board_no}&amp;contents=${param.contents}" class="artn-button board">수정</a>
	<a href="delete?id=${param.id}&board_no=${param.board_no}&amp;contents=${param.contents}" class="artn-button board">삭제</a>
</s:if>
</div>
</div>



</div>
</div>

</a:html>