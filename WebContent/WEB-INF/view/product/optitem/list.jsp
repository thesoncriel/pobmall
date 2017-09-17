<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>

<a:html title=" - Product Action Test : List" contents="${contentsCode }">
<div class="header">
	<h1>상품 옵션 목록</h1>
	<div id="breadcrumbs" data-sub="${contentsCode }" data-target="auto"></div>
</div>
<div class="article">
<h1>상품 옵션 목록</h1>
	<table>
		<tr>
		    <th>옵션 그룹</th>
			<th>상품 옵션명</th>
			<th>옵션 가격</th>
			<th>옵션 수량</th>
			<th>기타</th>
		</tr>
		<tr>
		<s:if test="listIsNull">
		<tr><td colspan="10">옵션이 존재하지 않습니다.</td></tr>
		</s:if>
		<s:else><s:iterator value="listData">
		<tr>
			<td><s:property value="id_opt_item"/></a></td>
			<td><s:property value="item_name"/></td>
			<td><s:property value="item_price"/></td>
			<td><s:property value="item_count"/></td>
			<td><a href="delete?id_opt_item=${id_opt_item }&id_group=${id_group }">삭제</a></td>
		</tr>
		</s:iterator></s:else>
	</table>
	<a href="/product/optitem/write?id_group=${id_group }">상품 옵션 등록</a>
	<a href="/group/list?contents=sub2_1">그룹목록</a>
	<a:pagenav page="${param.page }" rowCount="${rowCount }" rowLimit="10" navCount="10" id="pagecontroller" />
</div>

</a:html>