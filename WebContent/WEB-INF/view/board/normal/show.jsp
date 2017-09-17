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
<table class="board-show">
<thead>	
	<tr class="delimiter">
		<td class="category"> </td>
		<td class="name">글쓴이 : ${showData.user_name}(${showData.id_user})</td>
		<td class="view-cnt">조회수 : ${showData.view_count}</td>
		<td class="date">작성일 : ${showData.date_upload_fmt}</td>
		<td>&nbsp;</td>
	</tr>
</thead>
<tbody>
<tr>
	<td colspan="5">
		${showData.contents}
	</td>	
</tr>
</tbody>
<tfoot>
<tr class="delimiter comment">
	<th>댓글</th>
	<td colspan="4">${showData.comment_count} 건</td>
</tr>
</tfoot>
</table>

<div class="comment-list">
	<s:iterator value="subData.commentList">
	<div class="comment-item">
		
		<table class="comment-wrap">
			<tbody>
				<tr>
					<td rowspan="2" class="comment-depth comment-depth${depth }"><s:if test='%{depth > 0}'><span class="artn-icon-16 comment"></span></s:if></td>
					<td rowspan="2" class="user-img"><a:img src="/upload/user/img/${user_img }" alt="이미지" srcNone="/img/none.png" altNone="이미지 없음 - 이미지 등록 후 적용 됩니다."/></td>
					<td class="name">${user_name }</td>
					<td class="date">${date_update_kor }</td>
					<td class="buttons">
						<a class="reply" href="#">댓글</a>
						<s:if test="(auth.isAdmin) || (id_user == #user.id)">
							<a class="modify-reply" href="#">작성취소</a>							
							<a class="modify-cancel" href="#">수정취소</a>
							<a class="modify" href="#">수정</a>
							<a class="delete" href="commentDelete?comment_id=${id}&id=${param.id}&board_no=${param.board_no}&amp;contents=${param.contents}">삭제</a>
						</s:if>
					</td>
				</tr>
				<tr>
					<td colspan="5">
						<s:if test="(status == 0) || (auth.isAdmin) || (id_user == #user.id)">
							<p class="comment-contents"><s:property value="comment" escapeHtml="false"/></p>
							<form action="commentModify" class="comment-modify">
								<input type="hidden" name="comment_id" value="${id}"/>
								<input type="hidden" name="id_board" value="${showData.id}"/>
								<input type="hidden" name="board_no" value="${showData.board_no}"/>
								<input type="hidden" name="contents" value="${param.contents}"/>
								<input type="hidden" name="depth" value="${depth }"/>								
								<table class="wrap">
									<tr>
									<td><textarea name="comment" class="comment-by-comment"></textarea></td>
									<td class="comment-button-area"><button type="submit" class="comment-submit">댓글입력</button></td>
									</tr>
								</table>
							</form>
						</s:if>
						<s:else>					
							<p class="comment-contents">비밀글 입니다.</p>
						</s:else>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	</s:iterator>
</div>
<%--
<div id="comment-area">		
	<div id="comment">
		<s:iterator value="subData.commentList">						
	<form action="commentModify">
		<input type="hidden" name="id_board" value="${showData.id}"/>
		<input type="hidden" name="board_no" value="${showData.board_no}"/>
		<input type="hidden" name="contents" value="${param.contents}"/>
		
		<div id="commentList">
				<div class="commentItem">												
					<a:img src="/upload/user/img/${user_img }" alt="이미지" srcNone="/img/none.png" altNone="이미지 없음 - 이미지 등록 후 적용 됩니다." cssClass="re-img"/>
					<!-- <img src="/upload/user/img/${user_img}" class="re-img" alt="이미지" /> -->
					<span class="reply_info">
						<input type="hidden" name="comment_id" value="${id}"/>
						<span class="reply_name"><s:property value="user_name"/></span>
						<span><s:property value="date_update_kor"/></span>
					</span>
					
					<span class="commentWrap">
						<s:if test="(auth.isAdmin) || (id_user == #session.user.id)">				
							<span class="before"><a class="comment_edit" href="#">수정</a></span>
							<span class="before"><a class="comment_delete" href="commentDelete?comment_id=${id}&id=${param.id}&board_no=${param.board_no}&amp;contents=${param.contents}">삭제</a></span>
							<span class="commentWrapForm" style="display:none"><!--  <input type=text name=comment size=70 value="${comment}"/>--><textarea name="comment">${comment}</textarea><span class="artn-button board"><input type="submit" value="댓글입력"/></span><span class="artn-button board"><a href="#" class=comment_cancel>수정취소</a></span></span>
						</s:if>
					</span>
					<s:if test="(status == 0) || (auth.isAdmin) || (id_user == #session.user.id)">
						<p class="comment_contents"><s:property value="comment" escapeHtml="false"/></p>
					</s:if>
					<s:else>					
						<p class="comment_contents">비밀글 입니다.</p>
					</s:else>
				</div> 
			
			
		</div>
		</form> 
</s:iterator>

	</div>
</div>
 --%>
<s:if test="showIsNull || hasLogin">
<form class="comment-write" action="commentWrite">

<!-- 댓글 숨김항목 시작 -->
<input type="hidden" name="id_board" value="${showData.id}"/>
<input type="hidden" name="board_no" value="${showData.board_no}"/>
<input type="hidden" name="contents" value="${param.contents}"/>
<!-- 댓글 숨김항목 끝 -->

<input type="hidden" name="id_user" value="${user.id}"/>
<input type="hidden" name="user_name" value="${user.name}"/>
<input type="hidden" name="user_img" value="${user.fileImg }"/>
<input type="hidden" name="user_ip" value="${user.ip}"/>
<div class="wrap">
<textarea name="comment"></textarea>
<button type="submit" class="comment-submit">댓글입력</button>
</div>
<input id="checkbox_SecretComment" type="checkbox" name="status" value="1" /><label for="checkbox_SecretComment">비밀글 기능</label>

<!-- <input type=text name="comment" size="100" /> -->
</form>
</s:if>

<div class="footer board">
<div class="buttons show">
	<s:if test="(auth.isAdmin) || (showData.id_user == #user.id)">
		<a href="edit?id=${showData.id }&amp;board_no=${param.board_no}&amp;contents=${param.contents}" class="artn-button board">수정</a>
		<a href="delete?id=${param.id}&amp;board_no=${param.board_no}&amp;contents=${param.contents}" class="artn-button board">삭제</a>
	</s:if>
	<s:if test="showData.depth < 10"><a href="write?id=${param.id}&board_no=${param.board_no}&depth=${showData.depth+1}&re=re&subject=${showData.subject}&amp;contents=${param.contents}" class="artn-button board">답글</a></s:if>
	<a href="list?board_no=${param.board_no}&amp;contents=${param.contents}" class="artn-button board">목록</a>
</div>	
</div>




<!-- <table>
	<tr>
		<th>작성자</th>
		<th>내용</th>
		<th>작성일자</th>
	</tr>
	<s:if test="subData.replyList == null">
		<tr><td colspan="2">답글이 없습니다 답글을 작성해주세요.</td></tr>
	</s:if>
	<s:else><s:iterator value="subData.replyList">
	<tr>
		<td><span style="color: blue"><s:property value="name_user"/></span></td>
		<td><s:property value="contents_reply"/></td>
		<td><s:property value="date_update"/></td>
		<s:if test="(auth.isAdmin) || (id_user == #session.user.id)">
		<td><a href="#">수정</a></td>
		<td><a href="replyDelete?reply_id=${id}&id=${param.id}&board_no=${param.board_no}">삭제</a></td>
		</s:if>
	</tr>
	</s:iterator></s:else>
</table> -->


</div>
</div>

</a:html>