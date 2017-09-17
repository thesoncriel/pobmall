<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : List" contents="${param.contents }">

<div class="article">
<h1>게시판 <s:if test="showIsNull">등록</s:if><s:else>수정</s:else></h1>
<form action="modify" method="post" enctype="multipart/form-data">
<fieldset>
<table>
<tbody>

<tr>
<th><label for="textbox_id">아이디</label></th>
<s:if test="(showIsNull || hasLogin)">
	<td>
		<input type="hidden" id="textbox_id" maxlength="16" name="id_user" required="required" data-minlen="5" data-rule="id" data-url="/user/show?json=true" value="${user.id }" title="영문, 숫자로 16자 이내로 입력 하세요. (작성 후 포커스 이동 시 ID 사용 가능 여부 자동 확인함)" />
		${user.id}
	</td>
	</s:if>
<s:else >
<td><input type="text" id="textbox_id" value="${showData.id }" disabled="disabled"/><input type="hidden" name="id_user" value="${user.id }" /></td></s:else>
</tr>

<tr>
<th><label for="textbox_subject">제목</label></th>
<td><input type="text" id="textbox_subject" name="subject" required="required" title="제목을 입력하세요" value="${showData.subject}"/><br/></td></tr>
 
<tr>
<th><label for="textbox_contents"></label></th>
<td><textarea id="textbox_contents" name="contents">${showData.content}</textarea></td></tr>

</tbody>
</table>
<%--숨김 필드 모음--%>

<s:if test="showIsNull">
<input type="hidden" name="board_type" value="${params.board_type }"/>
</s:if>
<s:else>
<input type="hidden" name="board_type" value="${showData.board_type }"/>
<input type="hidden" name="id" value="${showData.id}"/>
</s:else>

</fieldset>
<button type="submit"><s:if test="showIsNull">작성</s:if><s:else>수정</s:else> 완료</button>
</form>

</div>
</a:html>