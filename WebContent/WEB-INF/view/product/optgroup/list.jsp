<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>

<a:html title=" - Product Action Test : List" contents="${contentsCode }">
<div class="header">
	<h1>상품옵션그룹 관리</h1>
	<div id="breadcrumbs" data-sub="${contentsCode }" data-target="auto"></div>
</div>
<div class="article">

<h2>옵션그룹 목록</h2>
<table class="board-list">
	<thead>
		<tr>
			<th>순번</th>
			<th>그룹번호</th>
			<th>이름</th>
			<th>수정</th>
		</tr>
	</thead>
	<tbody>
		<s:if test="listIsNull">
		<tr><td colspan="4">자료가 없습니다.</td></tr>
		</s:if>
		<s:else>
		<s:iterator value="listData">
		<tr>
			<td>${row_number }</td>
			<td>${id_group }</td>
			<td>${name }</td>
			<td><a href="edit?id_opt_group=${id_opt_group }&amp;contents=${contentsCode }">수정</a></td>
		</tr>
		</s:iterator>
		</s:else>
	</tbody>
</table>
<div class="footer board">
	<div class="buttons">
	    <a class="artn-button board" href="write?contents=${contentsCode }">추가</a>
	</div>
	<a:pagenav page="${param.page }" params="${params}" rowCount="${rowCount }" rowLimit="10" navCount="10" id="pagecontroller" cssClass="page-controller" font="symbol" />
</div>
</div>


</a:html>