<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 팝업 관리" contents="${contentsCode }">
<div class="header">
	<h1>팝업 목록</h1>
	<div id="breadcrumbs" data-sub="${contentsCode }" data-target="auto"></div>
</div>
<div class="article">
	<%--<form action="list" method="post">
	<fieldset>
		<s:select name="search_div" list="#{
                            '': '전체 목록',
                            'name': '상품명'
                            }" theme="simple">
		</s:select>
		<input type="text" name="search_text"/>
		<input type="button" class="artn-button board search_btn" value="검색"/>
	</fieldset>
	</form> --%>
	<table class="board-list">
		<thead>
		<tr>			
			<th>순서</th>			
			<th>제목</th>
			<th>시작일</th>
			<th>종료일</th>
			<th>생성일</th>
			<th>상세 정보</th>
			<th>사용유무</th>
		</tr>
		</thead>
		<tbody>
		<s:if test="listIsNull">
		<tr><td colspan="8">팝업 내역이 존재하지 않습니다.</td></tr>
		</s:if>
		<s:else><s:iterator value="listData">
		<tr>						
			<td><s:property value="popup_seq"/></td>			
			<td><s:property value="title"/></td>
			<td><s:property value="date_start_fmt"/></td>
			<td><s:property value="date_end_fmt"/></td>
			<td><s:property value="date_upload_fmt"/></td>
			<td><a class="artn-button board" href="edit?id=${id }&amp;contents=${contentsCode }&amp;id_group=${id_group }">수정</a></td>
			<td><s:if test="( (popup_opt & 0x1) > 0)">사용</s:if><s:else>미사용</s:else></td>
		</tr>
		</s:iterator></s:else>
		</tbody>
	</table>
	<div class="footer board">
		<div class="buttons">
			<%--<s:if test='%{auth.isGroupAdmin(id_group)}'> --%>
			<a class="artn-button board" href="write?contents=${contentsCode }&id_group=${id_group }">팝업 등록</a>
			<%--</s:if> --%>
		</div>
	</div>
	<a:pagenav page="${param.page }" params="${params}" rowCount="${rowCount }" rowLimit="10" navCount="10" id="pagecontroller" cssClass="page-controller" font="symbol" />
</div>
</a:html>