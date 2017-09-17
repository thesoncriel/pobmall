<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : List" contents="${param.contents }">

<div class="article">
<h1>권한 목록 수정</h1>
<table>
<thead><tr>
<th>번호</th>
<th>권한명칭</th>
<th>권한코드</th>
<th>메뉴 권한</th>
<th>그룹 아이디</th>
<th>사용자 정보 수정 권한</th>
<th>수정</th>
</tr></thead>

<tbody>
<s:if test="listIsNull">
<tr><td colspan="6">권한 정보가 없습니다.</td></tr>
</s:if>
<s:else><s:iterator value="listData">
<tr>
<td><s:property value="row_number"/></td>
<td><s:property value="auth_user_kor"/></td>
<td><s:property value="auth_user_hex"/></td>
<td><s:property value="restrict_menu_hex"/></td>
<td><s:property value="id_group"/></td>
<td><s:property value="restrict_user_edit_hex"/></td>
<td><a href="edit?id=${id }">권한 수정</a></td>
</tr>
</s:iterator></s:else>
</tbody>
</table>
<a:pagenav page="${param.page }" rowCount="${rowCount }" rowLimit="10" navCount="10" id="pagecontroller" />
<a href="write">권한 추가</a>
</div>

</a:html>