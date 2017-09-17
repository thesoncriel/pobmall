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

<h2>${showData.subject }</h2>
<table class="board-show img">
<thead>	
	<tr class="delimiter">
		<td class="category"> </td>
		<td class="name">글쓴이 : ${showData.user_name }(${showData.id_user })</td>
		<td class="view-cnt">조회수 : ${showData.view_count }</td> 
		<td class="date">작성일 : ${showData.date_upload_fmt }</td>
		<td>&nbsp;</td>		
	</tr>
	<%-- <tr class="attach-file">
		<th>첨부파일</th>
		<td colspan="4">${showData.ori_img }<a href="/upload/board/img/${showData.ori_img }"> [다운]</a></td>
	</tr>--%>
</thead>
<tbody>

<%-- <tr class="image-field">
<td colspan="5"><a:img src="/upload/board/img/${showData.file_img }" alt="이미지" srcNone="/img/none.png" altNone="이미지 없음 - 이미지 등록 후 적용 됩니다." /></td>
</tr>--%>

<tr>
<td colspan="5">${showData.contents}</td>
</tr>

</tbody>
</table>
<input type="hidden" name="view_count" value="${showData.view_count}"/>
<div class="footer board show">
	<div class="buttons">
		<s:if test="(auth.isAdmin) || (id_user == #user.id)"><a href="edit?id=${showData.id }&board_no=${param.board_no}&view=${param.view}&amp;contents=${param.contents}" class="artn-button board">수정</a>
		<!--<s:if test="showData.depth < 1"><span class="artn-button board"><a href="write?id=${param.id}&board_no=${param.board_no}&depth=${showData.depth+1}&re=re&subject=${showData.subject}&view=${param.view}&amp;contents=${param.contents}">답글</a></span></s:if>-->
		<a href="delete?id=${param.id}&board_no=${param.board_no}&view=${param.view}&amp;contents=${param.contents}" class="artn-button board">삭제</a></s:if>
		<a href="list?board_no=${param.board_no}&view=${view}&amp;contents=${param.contents}" class="artn-button board">목록</a>
	</div>
</div>
</div>
</div>
</a:html>