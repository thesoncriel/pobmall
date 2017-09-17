<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - Group Action Test : Edit" contents="${contentsCode }">
<div class="header">
	<h1>상품 <s:if test="showIsNull">등록</s:if><s:else>수정</s:else></h1>
	<div id="breadcrumbs" data-sub="${contentsCode }" data-target="auto"></div>
</div>
<div class="article">
<h1>상품 <s:if test="showIsNull">등록</s:if><s:else>수정</s:else></h1>
<form action="modify" method="post" enctype="multipart/form-data" class="validator">
<fieldset>
<table>
<tbody>

<tr>
<th><label for="file_img">사진</label></th>
<td><a:img src="/download?path=upload/product/img/&fileName=${showData.file_img }" alt="상품 사진" srcNone="/img/none.png" altNone="상품 사진 없음 - 상품 등록 후 적용 됩니다." width="320" height="240" /><br/>
<a:file id="file_img" name="file_img" width="200" height="100" value="${showData.file_img }"/></td></tr>

<tr>
<th><label for="name">상품명</label></th>
<td><input type="text" name="name" value="${showData.name }" title="상품명을 입력하세요."/></td></tr>

<tr>
<th><label for="name_sub">추가 상품명</label></th>
<td><input type="text" name="name_sub" value="${showData.name_sub }" title="추가 상품명을 입력하세요."/></td></tr>

<tr>
<th><label for="category">카테고리</label></th>
<td><input type="text" name="category" value="${showData.category }" title="카테고리를 입력하세요."/></td></tr>

<tr>
<th><label for="id_opt_gorup">상품 옵션</label></th>
<td>
    <s:select id="selectbox_id_opt_group" name="id_opt_group" value="showData.id_opt_group" list="subData.itemList" listKey="id_opt_group" listValue="name" theme="simple" />
</td>
</tr>

<tr>
<th><label for="price_before">할인 전 가격</label></th>
<td><input type="text" name="price_before" value="${showData.price_before }" title="할인 전 가격을 입력하세요."/> 원</td></tr>

<tr>
<th><label for="price_event">이벤트 가격</label></th>
<td><input type="text" name="price_event" value="${showData.price_event }" title="이벤트 가격을 입력하세요."/> 원</td></tr>

<tr>
<th><label for="price">가격</label></th>
<td><input type="text" name="price" value="${showData.price }" title="가격을 입력하세요."/> 원</td></tr>

<tr>
<th><label for="product_count">상품 개수</label></th>
<td><input type="text" name="product_count" value="${showData.product_count }" title="상품 개수를 입력하세요."/></td></tr>

<%-- <tr>
<th><label for="pay_point">적립 포인트</label></th>
<td><input type="text" name="pay_point" value="${showData.pay_point }" title=" 적립 포인트를 입력하세요."/></td></tr>
 --%>
<tr>
<th><label for="opt_terms_user">이용 약관</label></th>
<td><input type="text" name="opt_terms_user" value="${showData.opt_terms_user }" title=" 이용 약관을 입력하세요."/></td></tr>

<tr>
<th><label for="date_sales_start">상품 개시 기간</label></th>
<td><input type="text" id="datepicker_date_sales_start" name="date_sales_start" required="required" value="${showData.date_sales_start }" data-year="2013" title="상품 개시 시작일을 입력하세요." />-<input type="text" id="datepicker_date_sales_end" name="date_sales_end" required="required" value="${showData.date_sales_end }" data-year="2013" title="상품 개시 종료일을 입력하세요." /></td></tr>

<tr>
<th><label for="contents">상품 설명</label></th>
<td><textarea id="textbox_contents" editor="webnote" name="contents" title="상품 설명을 입력하세요.">${showData.contents }</textarea></td></tr>

<tr>
<th><label for="contents_summary">상품 설명 요약</label></th>
<td><input type="text" name="contents_summary" value="${showData.contents_summary }" title="상품 설명 요약을 입력하세요."/></td></tr>

</tbody>
</table>
<%--숨김 필드 모음--%>
<s:if test="showIsNull == false">
<input type="hidden" name="id" value="${showData.id }"/>
<input type="hidden" name="id_group" value="${showData.id_group }"/>
<input type="hidden" name="sold_count" value="${showData.sold_count }"/>
<input type="hidden" name="rating_count" value="${showData.rating_count }"/>
<input type="hidden" name="rating_sum" value="${showData.rating_sum }"/>
<input type="hidden" name="rating_avg" value="${showData.rating_avg }"/>
<input type="hidden" name="date_upload" value="${showData.date_upload }"/>
</s:if>
<s:else>
<input type="hidden" name="id_group" value="${param.id_group }"/>
</s:else>
</fieldset>
<button type="submit"><s:if test="showIsNull">작성</s:if><s:else>수정</s:else> 완료</button>
<a href="list?id_group=${showData.id_group }">목록</a>
</form>

</div>
</a:html>