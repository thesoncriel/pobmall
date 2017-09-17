<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>

<a:html title=" - Product Action Test : List" contents="${contentsCode }">
<div class="header">
	<h1>상품옵션그룹 관리</h1>
	<div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="article">

<h1>옵션그룹 목록</h1>
<ul id="list_productOptGroup" data-url="/product/optgroup" data-selectable="fixed" data-to="#asyncsearch_productOptGroupItem">
	<li>
		<input type="text" name="name"/>
		<button type="submit">추가</button>
		<input type="hidden" name="id_opt_group" value=""/>
		<input type="hidden" name="id_group" value=""/>
	</li>
	<li>
		<span class="name">제목</span>
		<a href="#" class="edit">수정</a>
		<a href="#" class="delete">삭제</a>
		<input type="hidden" name="id_opt_group" value="1"/>
		</li>
	<li>
		<span class="name">제목</span>
		<a href="#">수정</a>
		<a href="#">삭제</a>
		<input type="hidden" name="id_opt_group" value="2"/>
		</li>
</ul>
<form id="asyncsearch_productOptGroup" action="/product/optgroup/list?json=true" method="post" data-type="list" data-to="#list_productOptGroup">
	<input type="text" name="id_opt_group" value="${param.id_group }"/>
	<button type="submit">목록 가져오기</button>
</form>

<h1>옵션그룹아이템 목록</h1>
<form id="asyncform_productOptGroupItem" action="/product/optgroup/optmodify" method="post">
<ul id="sortablelist_productOptGroupItem">
	<!-- <li>
		<span class="seq"></span>
		<span class="opt_name">{opt_name}</span>
		<span class="opt_required">{opt_required}</span>
		<span class="opt_memo">{opt_memo}</span>
		<input type="hidden" name="seq" value=""/>
		<input type="hidden" name="id_opt_item" value="{id_opt_item}"/>
		<input type="hidden" name="opt_name" value="{opt_name}"/>
		<input type="hidden" name="opt_required" value="{opt_required}"/>
		<input type="hidden" name="opt_memo" value="{opt_memo}"/></li> -->
</ul>
<input type="text" name="id_group" value="${param.id_group }"/>
<button type="submit">수정완료</button>
</form>
<form id="asyncsearch_productOptGroupItem" action="/product/optgroup/optlist?json=true" method="post" data-type="list" data-to="#sortablelist_productOptGroupItem">
	<input type="text" name="id_opt_group"/>
	<button type="submit">목록 가져오기</button>
</form>

<h1>옵션아이템 전체목록</h1>
<ul id="infinitelist_productOptItem" data-from="#asyncsearch_productOptItem" data-to="#sortablelist_productOptGroupItem">
	<!-- <li>
		<span class="opt_name">{opt_name}</span>
		<span class="opt_memo">{opt_memo}</span>
		<input type="hidden" name="id_opt_item" value="{id_opt_item}"/>
		<input type="hidden" name="opt_name" value="{opt_name}"/>
		<input type="hidden" name="opt_required" value="n"/>
		<input type="hidden" name="opt_memo" value="{opt_memo}"/></li> -->
</ul>
<form id="asyncsearch_productOptItem" action="/product/optitem/list?json=true" method="post" data-type="infinite" data-to="#infinitelist_productOptItem">
	<input type="text" name="name"/>
	<button type="submit">검색</button>
	<%--<input type="hidden" name="id_group" value="${param.id_group }"/> --%>
</form>
<%--
<form id="product_opt_group">
<h1>옵션 그룹 목록</h1>
    <div id="shop_product_list_group" data-itemlist="#product_list_item" data-url="/product/optgroup" data-view="#list_group_view" data-idgroup="${param.id_group }" data-to="#product_list">
    <!-- <tr><td>
    <input type="text" class="name" name="name" readonly="readonly" style="border: none;" value="{name}"/>
    <input type="hidden" class="id_group" name="id_group" style="border: none;" value="{id_group}"/>
    <input type="hidden" class="id_opt_group" name="id_opt_group" style="border: none;" value="{id_opt_group}"/>
    </td><td><input type="button" class="update_complete" style="display: none;" value="변경"/><input type="button" class="group_update" value="수정"/>
    <input type="button" class="group_delete" value="삭제"/></td></tr>  -->
    </div>
    <table>
    <tr id="list_group_view"><th colspan="2">아이템 그룹 이름</th></tr>
    </table>
    <div><span><input type="text" class="name" name="name" value=""/></span><span><input type="button" class="group_insert" value="추가"/></span></div>
</form>
</div>
<div class="article">
<form id="product_opt" action="/product/optgroup/optmodify" method="post">
<h1>옵션 조합 목록</h1>
    <div id="product_list" data-url="/product/optgroup" data-view="#product_list_view" data-idgroup="${param.id_group }">
    아이템 그룹 명 : <input type="text" id="comb_name" value=""/><input type="hidden" id="comb_id_opt_group" value=""/>
    <!-- <tr><td><input type="text" class="opt_name" name="opt_name" value="{opt_name}"/></td>
    <td><input type="text" class="opt_memo" name="opt_memo" value="{opt_memo}"/></td>
    <td><input type="text" class="items_name" name="items_name" value="{items_name}"/></td>
    <td><input type="text" class="items_price" name="items_price" value="{items_price}"/></td>
    <td><input type="hidden" class="id_opt_group" name="id_opt_group" value="{id_opt_group}"/>
    <input type="hidden" class="id_opt_item" name="id_opt_item" value="{id_opt_item}"/>
    <input type="hidden" class="seq" name="seq" value="{seq}"/>
    <input type="checkbox" class="opt_required" name="opt_required" value="{opt_required}"/>
    </td>
    <td>
    <input type="button" class="item_delete" value="삭제"/>
    </td>
    </tr> -->
    </div>
    <table id="sortable_productItem">
    <tr id="product_list_view"><th>아이템 이름</th><th>메모</th><th>가격</th><th>이름</th><th>필수체크</th><th>기타</th></tr>
    </table>
    <input type="button" id="product_opt_submit" value="등록"/>
</form>
</div>
<div class="article">
<form id="product_opt_item">
<h1>옵션 아이템 목록</h1>
    <div id="product_list_item" data-url="/product/optitem" data-view="#list_item_view" data-idgroup="${param.id_group }">
        <!-- <tr><td><input type="text" class="opt_name" readonly="readonly" name="opt_name" style="border: none;" value="{opt_name}"/></td>
        <td><input type="text" class="opt_memo" readonly="readonly" name="opt_memo" style="border: none;" value="{opt_memo}"/></td>
        <td><input type="text" class="items_price" readonly="readonly" name="items_price" style="border: none;" value="{items_price}"/></td>
        <td><input type="text" class="items_name" readonly="readonly" name="items_name" style="border: none;" value="{items_name}"/></td>
        <td><input type="hidden" class="id_opt_item" name="id_opt_item" value="{id_opt_item}"/>
        <input type="button" class="product_item_insert" value="추가"/></td></tr> -->
    </div>
    <table>
    <tr id="list_item_view"><th>아이템 이름</th><th>메모</th><th>가격</th><th>이름</th><th>기타</th></tr>
    </table>
</form>
 --%>
</div>
<a href="/group/list?contents=sub2_1">그룹목록</a>

</a:html>