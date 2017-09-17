<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - Group Action Test : List" contents="${param.contents }">
<div class="contents">
<div class="section">
<div class="article group-list">
<h1>그룹 목록</h1>
<table class="artn-board list">
<thead><tr>
<th>번호</th>
<th>그룹명</th>
<th>연락처</th>
<th>생성일</th>
<th>그룹 정보</th>
<th>사용자 목록</th>
<th>기타</th>
</tr></thead>

<tbody>
<s:if test="listIsNull">
<tr><td colspan="7">그룹이 없습니다 ^^;</td></tr>
</s:if>
<s:else><s:iterator value="listData">
<tr>
<td><s:property value="row_number"/></td>
<td><s:property value="name"/></td>
<td><s:property value="phone_group"/></td>
<td><s:property value="date_create_fmt"/></td>
<td><a href="show?id=${id }">정보 보기</a></td>
<td><a href="/groupuser/list?id_group=${id }">목록 보기</a></td>
<td><a href="/groupuser/edit?id_group=${id }">그룹 회원 추가</a></td>
</tr>
</s:iterator></s:else>
</tbody>
</table>
<a href="write">그룹 추가</a>
<a:pagenav page="${param.page }" rowCount="${rowCount }" rowLimit="10" navCount="10" id="pagecontroller" />
</div>
</div>
</div>
</a:html>