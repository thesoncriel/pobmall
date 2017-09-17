<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - Product Action Test : List" contents="${contentsCode }">
<script>
$(document).ready(function(){
	$("#fileImg").change(function(){
		console.log(location.pathname);
	});
});
</script>
<div class="header">
	<h1>상품 이미지 목록</h1>
	<div id="breadcrumbs" data-sub="${contentsCode }" data-target="auto"></div>
</div>
<div class="article">
<h1>상품 이미지 목록</h1>
<%-- <s:select name="search_div" list="#{
                            '': '전체 목록',
                            'name': '상품명'
                            }" theme="simple">
</s:select>
<input type="text" name="search_text"/>
<input type="button" class="search_btn" value="검색"/> --%>
	<ul id="sortable_productImg">
	    <s:if test="listIsNull">
        <li>상품이 존재하지 않습니다.</li>
        </s:if>
	    <s:else>
	    <s:iterator value="listData">
        <li><b class="seq">${seq }</b><a:img src="/download?path=upload/product/thumnail/&fileName=${file_img}" alt="이미지" srcNone="/img/none.png" altNone="이미지 없음 - 이미지 등록 후 적용 됩니다." />
            <input type="text" name="desc" value="${desc }"/>
            <a href="#" class="itemup">[▲]</a><a href="#" class="itemdown">[▼]</a></li>
        </s:iterator>
        </s:else>
    </ul>
    <div>
    <img id="result_img" src="/img/none.png"/>
    <input type="file" id="fileImg"/>
    <a:file id="file_img" name="file_img" width="200" height="100" value="${showData.file_img }"/><input type="text" name="desc" value=""/><a href="write?id_product=${id_group }">상품 등록</a>
    </div>
    
	
	<a:pagenav page="${param.page }" params="${params}" rowCount="${rowCount }" rowLimit="10" navCount="10" id="pagecontroller" cssClass="page-controller" font="symbol" />
</div>
<input type="hidden" class="id_group" value="${param.id_group }"/>
</a:html>