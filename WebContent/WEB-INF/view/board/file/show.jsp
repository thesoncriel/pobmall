<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : List" contents="${boardInfo.contentsCode }">
	<div class="header">
		<h1>${boardInfo.name }</h1>
		<div id="breadcrumbs" data-sub="${boardInfo.contentsCode }"></div>
	</div>
<div class="section">
<div class="article">

<h2>${showData.subject}</h2>
<table class="board-show">
<thead>	
	<tr class="delimiter">
		<td class="category"> </td>
		<td class="name">글쓴이 : ${showData.user_name}(${showData.id_user})</td>
		<td class="view-cnt">조회수 : ${showData.view_count}</td>
		<td class="date">등록일 : ${showData.date_upload_fmt}</td>
		<td>&nbsp;</td>		
	</tr>
<s:iterator value="subData.fileList">
	<tr class="attach-file">
		<th>첨부파일</th>
		<td colspan="4">${ori_name }<a href="/download?path=upload/board/name/&fileName=${file_name }&oriName=${ori_name }"> [다운]</a></td>
	</tr>
</s:iterator>
</thead>
<tbody>
<tr><td colspan="5">${showData.contents}</td></tr>

<s:iterator value="listData">
	<s:property value="file_name"/>
</s:iterator>
</tbody>
</table>
<input type="hidden" name="view_count" value="${showData.view_count}"/>
<div class="footer board show">
	<div class="buttons">
		<s:if test="(auth.isAdmin) || (showData.id_user == #user.id)"><a href="edit?id=${showData.id }&amp;board_no=${param.board_no}&amp;view=${param.view}&amp;contents=${param.contents}" class="artn-button board">수정</a>
		<!--<s:if test="showData.depth < 1"><span class="artn-button board"><a href="write?id=${param.id}&amp;board_no=${param.board_no}&amp;depth=${showData.depth+1}&amp;re=re&amp;subject=${showData.subject}&amp;view=${param.view}&amp;contents=${param.contents}">답글</a></span></s:if>-->
		<a href="delete?id=${param.id}&board_no=${param.board_no}&amp;view=${param.view}&amp;contents=${param.contents}" class="artn-button board">삭제</a></s:if>
		<a href="list?board_no=${param.board_no}&amp;view=${view}&amp;contents=${param.contents}" class="artn-button board">목록</a>
	</div>
</div>
</div>
</div>
</a:html>