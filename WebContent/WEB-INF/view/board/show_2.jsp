<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - Board Action Test : List" contents="${param.contents }">
<script>
$(document).ready(function(){	
	$(".commentItem .comment_edit").click(function(){		
		var jqThis = $(this);
		var jqCommentItem = null;
		var jqCommentConmmentWrapForm = null;
		var jqButtonClickBefore = null;
		var jqCommentContents = null;		
		var jqCancel = null;
		//var sCommentContentsHTML = "";		
		
		//console.log("aaa" + jqThis.parents(".commentItem").length);
		//jqCommentItem = jqThis.parents(".commentItem");
		//jqCommentContents = jqCommentItem.find(".comment_contents");
		//sCommentContentsHTML = jqCommentContents.html();
		//jqCommentContents.replaceWith("<input type=\"text\" name=\"comment\" size=\"70\" value=\"" + jqCommentContents.text() + "\"/>");				
		//jqCommentItem.find(".comment_delete").replaceWith("<a href=\"#\" class=\"comment_cancel\">취소</a>");
		//jqThis.replaceWith("<input type=\"submit\"/>");
		jqCommentItem = jqThis.parents(".commentItem");
		jqCommentConmmentWrapForm = jqCommentItem.find(".commentWrapForm");
		jqCommentContents = jqCommentItem.find(".comment_contents")
		jqButtonClickBefore = jqCommentItem.find(".before");
		jqButtonAround = $("#comment-area").find(".before");
		
		jqCommentConmmentWrapForm.show();
		jqCommentContents.hide(); 
		jqButtonClickBefore.hide();
		jqButtonAround.hide();
		
		jqCancel = $(".commentItem .comment_cancel");
		//jqCancel.data("beforeStructure", sCommentContentsHTML);		
		
		jqCancel.click(function(){
			//location.reload();
			jqCommentConmmentWrapForm.hide();
			jqCommentContents.show();
			jqButtonClickBefore.show();
			jqButtonAround.show();
		});
		return false;
	});	
});
	
</script>
<div class="contents">
<div class="section">
<div class="article board-show">

<table class="artn-board list">
<thead>
	<tr>
		<th colspan="3">${showData.subject }</th>
	</tr>
	<tr>
		<th>글쓴이 : ${showData.user_name}</th>
		<th>조회수 : ${showData.view_count }</th>
		<th>등록일 : ${showData.date_upload_fmt}</th>		
	</tr>
</thead>
<tbody>
<tr>
	<td colspan="3">
		${showData.contents}
	</td>	
</tr>
</tbody>
</table>


<s:if test="(auth.isAdmin) || (showData.id_user == #session.user.id)">
	<a href="edit?id=${showData.id }&amp;amp;board_no=${param.board_no}&amp;contents=${param.contents}" class="artn-button board">수정</a>
	<span class="artn-button board"><a href="delete?id=${param.id}&amp;board_no=${param.board_no}&amp;contents=${param.contents}">삭제</a></span>
</s:if>
<s:if test="showData.depth < 1"><span class="artn-button board"><a href="write?id=${param.id}&board_no=${param.board_no}&depth=${showData.depth+1}&re=re&subject=${showData.subject}&amp;contents=${param.contents}">답글</a></span></s:if>
<span class="artn-button board"><a href="list?board_no=${param.board_no}&amp;contents=${param.contents}">목록</a></span>



<div id="comment-area">
	<div id="comment">
	<s:iterator value="subData.commentList">
	<form action="commentModify">
		<input type="hidden" name="id_board" value="${showData.id}"/>
		<input type="hidden" name="board_no" value="${showData.board_no}"/>
		<input type="hidden" name="contents" value="${param.contents}"/>	
		<ul id="commentList">		
			<li>			
				<div class="commentItem">
					<input type="hidden" name="comment_id" value="${id}"/>
					<span class="reply_name"><s:property value="user_name"/></span>
					<span> </span>
					<span class="commentWrap">
						<span class="comment_contents"><s:property value="comment"/></span>
						<s:if test="(auth.isAdmin) || (id_user == #session.user.id)">				
							<span class="artn-button board before"><a class="comment_edit" href="#">수정</a></span>
							<span class="artn-button board before"><a class="comment_delete" href="commentDelete?comment_id=${id}&id=${param.id}&board_no=${param.board_no}&amp;contents=${param.contents}">삭제</a></span>
							<span class="commentWrapForm" style="display:none"><!--  <input type=text name=comment size=70 value="${comment}"/>--><textarea name="comment">${comment}</textarea><span class="artn-button board"><input type="submit" value="보내기"/></span><span class="artn-button board"><a href="#" class=comment_cancel>수정취소</a></span></span>
						</s:if>
					</span>
				</div>
				<div>
					<span><s:property value="date_update_fmt"/></span>					
				</div>							
			</li>							
		</ul>
		</form>
		</s:iterator>
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

<form action="commentWrite">

<!-- 댓글 숨김항목 시작 -->
<input type="hidden" name="id_board" value="${showData.id}"/>
<input type="hidden" name="board_no" value="${showData.board_no}"/>
<input type="hidden" name="contents" value="${param.contents}"/>
<!-- 댓글 숨김항목 끝 -->

<s:if test="showIsNull || hasLogin">
<input type="hidden" name="id_user" value="${user.id}"/>
<input type="hidden" name="user_name" value="${user.name}"/>
<textarea name="comment"></textarea>
<span class="artn-button board"><input type="submit" value="보내기"/></span>
</s:if>
<s:else>

</s:else>

<!-- <input type=text name="comment" size="100" /> -->

</form>
</div>
</div>
</div>
</a:html>