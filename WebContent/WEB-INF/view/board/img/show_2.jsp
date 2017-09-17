<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : List" contents="${param.contents }">

<div class="contents">
<div class="section">
<div class="article board-show">


<table class="artn-board list">
<thead>
	<tr>
		<th colspan="3">${showData.subject}</th> 
	</tr>
	<tr>				
		<th>글쓴이 : ${showData.user_name }(${showData.id_user })</th>
		<th>조회수 : ${showData.view_count }</th>
		<th>작성일 : ${showData.date_upload_fmt }</th>		
	</tr>
	<tr>
		<th>첨부파일</th>
		<th colspan="2">${showData.ori_img }</th>
	</tr>
</thead>
<tbody>

<tr>
<td colspan="6"><a:img src="/upload/board/img/${showData.file_img }" alt="이미지" srcNone="/img/none.png" altNone="이미지 없음 - 이미지 등록 후 적용 됩니다." width="100" height="35" /></td>
</tr>

<tr>
<td colspan="6">${showData.contents}</td>
</tr>

</tbody>
</table>
<input type="hidden" name="view_count" value="${showData.view_count}"/>
<a href="edit?id=${showData.id }&board_no=${param.board_no}&view=${param.view}&amp;contents=${param.contents}" class="artn-button board">수정</a>
<s:if test="showData.depth < 1"><a href="write?id=${param.id}&board_no=${param.board_no}&depth=${showData.depth+1}&re=re&subject=${showData.subject}&view=${param.view}&amp;contents=${param.contents}" class="artn-button board">답글</a></s:if>
<a href="delete?id=${param.id}&board_no=${param.board_no}&view=${param.view}&amp;contents=${param.contents}" class="artn-button board">삭제</a>
<s:if test="auth.isAdmin"><a href="list?board_no=${param.board_no}&view=${view}&amp;contents=${param.contents}" class="artn-button board">목록</a></s:if>
</div>
</div>
</div>
</a:html>