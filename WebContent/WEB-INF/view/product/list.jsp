<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - Product Action Test : List" contents="${contentsCode }">
<div class="header">
	<h1>상품 목록</h1>
	<div id="breadcrumbs" data-sub="${contentsCode }" data-target="auto"></div>
</div>
<div class="article">
<div class="search_div">
    <form action="list?contents=adm1000_5_1" method="post">
        <s:select name="search_div" list="#{
                            '': '전체 목록',
                            'name': '상품명'
                            }" theme="simple">
		</s:select>
		<input type="text" name="search_text"/>
		<input type="submit" class="artn-button board search_btn" value="검색"/>
    </form>
</div>
	<table class="board-list">
		<thead>
		<tr>
			<th>상품 번호</th>
			<th>카테고리</th>
			<th>상품명</th>
			<th>가격</th>
			<th>판매 개수</th>
			<th>상품 개수</th>
			<th>상품 시작 일자</th>
			<th>상품 종료 일자</th>	
			<th>구매 평가 평균</th>
			<th>상세 정보</th>
		</tr>
		</thead>
		<tbody>
		<s:if test="listIsNull">
		<tr><td colspan="10">상품이 존재하지 않습니다.</td></tr>
		</s:if>
		<s:else><s:iterator value="listData">
		<tr>
			<td><s:property value="id"/></td>			
			<td><s:property value="category"/></td>
			<td><s:property value="name"/></td>
			<td><s:property value="price"/></td>
			<td><s:property value="sold_count"/></td>
			<td><s:property value="product_count"/></td>
			<td><s:property value="date_sales_start_fmt"/></td>
			<td><s:property value="date_sales_end_fmt"/></td>
			<td><div id="rating_show" date-name="rating" data-length="5" data-onevalue="2" data-mouse="no" data-value="${rating_avg }"/></td>
			<td><a href="show?id=${id }">상세 보기</a>
				<s:if test='%{auth.isGroupAdmin(id_group)}'>
			    <a href="edit?id=${id }">상품 수정</a>
			    <%-- <a href="/product/optgroup/list?id_group=${id_group }">옵션 그룹 목록</a>          
                <a href="/product/optitem/list?id_group=${id_group }">옵션 아이템 목록</a>
                <a href="/product/img/list?id_product=${id}">이미지 목록</a> --%>
			    </s:if>
			</td>
		</tr>
		</s:iterator></s:else>
		</tbody>
	</table>
	<div class="footer board">
		<div class="buttons">
			<s:if test='%{auth.isGroupAdmin(id_group)}'>
			<a class="artn-button board" href="write?contents=${contentsCode }&id_group=${id_group }">상품 등록</a>
			</s:if>
		</div>
	</div>
	<a:pagenav page="${param.page }" params="${params}" rowCount="${rowCount }" rowLimit="10" navCount="10" id="pagecontroller" cssClass="page-controller" font="symbol" />
</div>
<input type="hidden" class="id_group" value="${param.id_group }"/>
</a:html>