<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - Group Action Test : Edit" contents="${contentsCode }">
<div class="header">
	<h1>상품 옵션 <s:if test="showIsNull">등록</s:if><s:else>수정</s:else></h1>
	<div id="breadcrumbs" data-sub="${contentsCode }" data-target="auto"></div>
</div>
<div class="article">
<h1>상품 옵션 <s:if test="showIsNull">등록</s:if><s:else>수정</s:else></h1>
<form action="/product/optitem/modify" method="post" enctype="multipart/form-data" class="validator">
<fieldset>
<table>
<tbody>
    <tr>
        <th>상품 옵션 이름</th>
        <td><input type="text" name="opt_name" value="${showData.opt_name }"/></td>
    </tr>
    <tr>
        <th>상품 옵션 메모</th>
        <td><input type="text" name="opt_memo" value="${showData.opt_memo }"/></td>
    </tr>
    <tr>
        <th>상품 옵션 형태</th>
        <td><input type="text" name="opt_type" value="${showData.opt_type }"/></td>
    </tr>
    <tr>
        <th>상품 아이템 이름</th>
        <td><input type="text" name="items_name" value="${showData.items_name }"/></td>
    </tr>
    <tr>
        <th>상품 아이템 가격</th>
        <td><input type="text" name="items_price" value="${showData.items_price }"/></td>
    </tr>
</tbody>
</table>
</fieldset>
<s:if test='%{showIsNull == false}'>
<input type="hidden" name="id_opt_item" value="${showData.id_opt_item }"/>
<input type="hidden" name="id_group" value="${showData.id_group }"/>
</s:if>
<s:else>
<input type="hidden" name="id_group" value="${param.id_group }"/>
</s:else>
<button type="submit"><s:if test="showIsNull">작성</s:if><s:else>수정</s:else> 완료</button>
<%-- <s:if test='%{showIsNull}'><a href="list?id_group=${param.id_group }">목록</a></s:if><s:else><a href="list?id_group=${showData.id_group }">목록</a></s:else> --%>
<a href="list?id_group=${param.id_group }${showData.id_group }">목록</a>
</form>

</div>
</a:html>