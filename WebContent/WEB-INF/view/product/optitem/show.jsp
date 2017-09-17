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
<h1>옵션 그룹</h1>
<fieldset>
<table>
<tbody>
    <tr>
        <th>상품 옵션 이름</th>
        <td>${showData.opt_name }</td>
    </tr>
    <tr>
        <th>상품 옵션 메모</th>
        <td>${showData.opt_memo }</td>
    </tr>
    <tr>
        <th>상품 옵션 형태</th>
        <td>${showData.opt_type }</td>
    </tr>
    <tr>
        <th>상품 옵션 이름</th>
        <td>${showData.items_name }</td>
    </tr>
    <tr>
        <th>상품 옵션 가격</th>
        <td>${showData.items_price }</td>
    </tr>
</tbody>
</table>
</fieldset>
<a href="/product/optitem/edit?id_opt_item=${showData.id_opt_item }">수정</a>
</div>
</a:html>