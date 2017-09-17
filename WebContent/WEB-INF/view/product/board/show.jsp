<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : List" contents="${param.contents }">
	<div class="header">
	   <s:if test="params.board_no == 3">
	       <h1>환불 요청</h1>
	   </s:if>
	   <s:elseif test="params.board_no == 4">
	       <h1>교환 요청</h1>
	   </s:elseif>
		<div id="breadcrumbs" data-sub="${param.contents }"></div>
	</div>
<div class="section">
<div class="article">

<h2>${showData.subject }</h2>
<table class="board-show">
	<thead>	
		<tr class="delimiter">
			<td class="category">${showData.category }</td>
			<td class="name">글쓴이 : ${showData.user_name}(${showData.id_user})</td>
			<td class="view-cnt">조회수 : ${showData.view_count}</td>
			<td class="date">작성일 : ${showData.date_upload_fmt}</td>
			<td>&nbsp;</td>
		</tr>
	</thead>
	<tbody>
	<s:if test="(params.board_no == 3) || (params.board_no == 4)">
	    <tr class="delimiter comment">
	        <th>상품</th>
	        <td colspan="4">${showData.name}(${showData.name_sub})</td>
	    </tr>   
	</s:if>
	<tr>
		<td colspan="5">
			${showData.contents}
		</td>	
	</tr>
	</tbody>
</table>

<s:if test="auth.isAdmin">
	<form class="comment-write" action="contentsReply">
		<input type="hidden" name="id" value="${showData.id}"/>
		<input type="hidden" name="board_no" value="${showData.board_no}"/>
		<input type="hidden" name="contents" value="${param.contents}"/>
		<input type="hidden" name="myposts" value="${param.myposts }"/>
		
		<div class="wrap">
			<textarea name="contents_reply">${showData.contents_reply }</textarea>
			<button type="submit" class="comment-submit">답변입력</button>
		</div>
	</form>
</s:if>
<s:else>
    <textarea name="contents_reply" readonly="readonly" style="width:95%; height:100%">${showData.contents_reply }</textarea>
</s:else>
<div class="footer board">
	<div class="buttons show">
		<s:if test="(auth.isAdmin) || (showData.id_user == #user.id)">
			<a href="edit?id=${showData.id }&amp;board_no=${param.board_no}&amp;contents=${param.contents}&amp;myposts=${param.myposts}" class="artn-button board">수정</a>
		</s:if>
		<s:if test="showData.depth < 10"><a href="write?id=${param.id}&board_no=${param.board_no}&depth=${showData.depth+1}&re=re&subject=${showData.subject}&amp;contents=${param.contents}&amp;myposts=${param.myposts}" class="artn-button board">답글</a></s:if>
		<a href="list?board_no=${param.board_no}&amp;contents=${param.contents}&amp;myposts=${param.myposts}" class="artn-button board">목록</a>
	</div>	
</div>
</div>
</div>

</a:html>