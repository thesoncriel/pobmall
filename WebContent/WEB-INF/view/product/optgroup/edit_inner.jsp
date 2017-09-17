<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<input type="hidden" name="id_opt_group" value="${showData.id_opt_group }"/>
<table class="board-list">
    <thead>
		<tr>
			<th>순서</th>
			<th>옵션명</th>
			<th>필수여부</th>
			<th>옵션설정</th>
		</tr>
	</thead>
	<tbody id="sortablelist_productOpt" data-seq-name="opt_seq">
		<s:if test="subIsNull.itemList"></s:if>
		<s:else>
		<s:iterator value="subData.itemList">
		<tr>
			<td><input type="text" name="opt_seq" value="${opt_seq }" readonly="readonly" style="width: 2em;"/></td>
			<td><input type="text" name="opt_name" value="${opt_name }"/><input type="hidden" name="id_opt_item" value="${id_opt_item }"/><input type="hidden" name="opt_type" value="0"/></td>
			<td><s:select name="required" list="#{'0':'아니오','1':'예' }" value="required" theme="simple"/></td>
			<td><button type="button" class="artn-button board edit" data-rule="dialogButton" data-dialog="#dialog_productOptItem">옵션목록</button>
				<button type="button" class="artn-button board delete">삭제</button>
			</td>
		</tr>
		</s:iterator>
		</s:else>
		<!-- 
		@{if defined('opt_name')}
		<tr>
			<td><input type="text" name="opt_seq" value="{opt_seq}" readonly="readonly" style="width: 2em;"/></td>
			<td><input type="text" name="opt_name" value="{opt_name}"/><input type="hidden" name="id_opt_item" value="0"/><input type="hidden" name="opt_type" value="0"/></td>
			<td><s:select name="required" list="#{'0':'아니오','1':'예' }" theme="simple"/></td>
			<td><button type="button" class="artn-button board edit" data-rule="dialogButton" data-dialog="#dialog_productOptItem">옵션목록</button>
				<button type="button" class="artn-button board delete">삭제</button>
			</td></tr>
		@{else}
		<tr>
			<td><input type="text" name="opt_seq" value="1" readonly="readonly" style="width: 2em;"/></td>
			<td><input type="text" name="opt_name" value=""/><input type="hidden" name="id_opt_item" value="0"/><input type="hidden" name="opt_type" value="0"/></td>
			<td><s:select name="required" list="#{'0':'아니오','1':'예' }" theme="simple"/></td>
			<td><button type="button" class="artn-button board edit" data-rule="dialogButton" data-dialog="#dialog_productOptItem">옵션목록</button>
				<button type="button" class="artn-button board delete">삭제</button>
			</td></tr>
		@{/if}
		 -->
	</tbody>
</table>

<div class="footer board">
	<div class="buttons">
		<a id="button_productOpt_add" class="artn-button board" href="#">옵션추가</a>
	</div>
</div>