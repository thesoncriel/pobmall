<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - Group Action Test : Edit" contents="${contentsCode }">
<div class="header">
	<h1>옵션 그룹</h1>
	<div id="breadcrumbs" data-sub="${contentsCode }" data-target="auto"></div>
</div>
<div class="article">
<h1>옵션 그룹 설정</h1>
<form>
<fieldset>
<table class="board-edit">
	<tbody class="row-scope">
		<tr>
			<th>옵션그룹명</th>
			<td>
				<input type="text" name="name" value="${showData.name }"/>
				<input type="hidden" name="id_group" value="0"/>
			</td>
		</tr>
	</tbody>
</table>
</fieldset>

<fieldset>
<table class="board-list">
    <thead>
		<tr>
			<th>순서</th>
			<th>옵션명</th>
			<th>옵션값</th>
			<th>옵션가격</th>
			<th>필수여부</th>
		</tr>
	</thead>
	<tbody id="sortablelist_productOptItem">
		<s:if test="listIsNull">
		<tr><td colspan="5">자료가 없습니다.</td></tr>
		</s:if>
		<s:else>
		<s:iterator value="listData">
		<tr>
			<td><span class="seq">${seq }</span><input type="hidden" name="seq" value="${seq }"/></td>
			<td><input type="text" name="seq" value="${opt_name }"/></td>
			<td><input type="text" name="seq" value="${items_name }"/></td>
			<td><input type="text" name="seq" value="${items_price }"/></td>
			<td><s:checkbox name="required" key="1" value="opt_type" theme="simple"></s:checkbox></td>
		</tr>
		</s:iterator>
		</s:else>
	</tbody>
</table>
</fieldset>
<div class="footer board">
	<div class="buttons">
		<button class="artn-button board" type="submit">수정완료</button>
	    <a class="artn-button board" href="write?contents=${contentsCode }">추가</a>
	</div>
</div>
</form>
<a href="/product/optgroup/edit?id_opt_group=${id_opt_group }">수정</a>
</div>
</a:html>