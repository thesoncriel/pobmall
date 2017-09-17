<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - Group Action Test : Edit" contents="${contentsCode }">
<script>
	$(document).ready(function(){
		$(".thkim").click(function(){
			$(this).parent().find("input[name='ori_img']").val("");
			$(this).parent().find("input[name='file_img']").val("");
			$(this).parent().find($(".file-link")).text("");
			$(this).parent().children($(".file_img3")).attr("src","/img/none.png");
		});
	});
</script>
<div class="header">
<s:if test="showIsNull">
	<h1>상품 등록</h1>
	<div id="breadcrumbs" data-sub="*상품 등록"></div>
</s:if>
<s:else>
	<h1>상품 수정</h1>
	<div id="breadcrumbs" data-sub="*상품 수정"></div>
</s:else>
</div>
<div class="article">
<form action="modify" method="post" enctype="multipart/form-data" class="validator">
<fieldset>


<%-- 상품 일반 정보 [시작] /////////////////////////////////////////////////////////////////////////////// --%>
<table class="board-edit product-edit style2">

<tbody class="row-scope">

<tr>
	<th><label for="file_img">사진</label></th>
	<td>
	   <div id="sortable_file_img" class="sortable-grid">
        <div class="item">
            <span class="seq square"></span>
            <input type="hidden" name="seq"/>
            <a:img cssClass="file_img3" src="/download?path=/upload/thumnail/&fileName=${subData.imgList[0].file_img }" alt="상품 사진" srcNone="/img/none.png" altNone="상품 사진 없음 - 상품 등록 후 적용 됩니다." width="240" height="180" /><br/>
 			<button type="button" class="artn-button board thkim">이미지 삭제</button>           
            <a:file id="ajaxupload_file_img3" name="file_img" path="/upload" toImg=".file_img3" value="${subData.imgList[0].file_img }" thumbWidth="343" thumbHeight="321" />
        </div>
        <div class="item">
            <span class="seq square"></span>
            <input type="hidden" name="seq"/>
            <a:img cssClass="file_img3" src="/download?path=/upload/thumnail/&fileName=${subData.imgList[1].file_img }" alt="상품 사진" srcNone="/img/none.png" altNone="상품 사진 없음 - 상품 등록 후 적용 됩니다." width="240" height="180" /><br/>
            <button type="button" class="artn-button board thkim">이미지 삭제</button>
            <a:file id="ajaxupload_file_img3" name="file_img" path="/upload" toImg=".file_img3" value="${subData.imgList[1].file_img }" thumbWidth="343" thumbHeight="321"/>
        </div>
        <div class="item">
            <span class="seq square"></span>
            <input type="hidden" name="seq"/>
            <a:img cssClass="file_img3" src="/download?path=/upload/thumnail/&fileName=${subData.imgList[2].file_img }" alt="상품 사진" srcNone="/img/none.png" altNone="상품 사진 없음 - 상품 등록 후 적용 됩니다." width="240" height="180" /><br/>
            <button type="button" class="artn-button board thkim">이미지 삭제</button>
            <a:file id="ajaxupload_file_img3" name="file_img" path="/upload" toImg=".file_img3" value="${subData.imgList[2].file_img }" thumbWidth="343" thumbHeight="321"/>
        </div>
        <div class="item">
            <span class="seq square"></span>
            <input type="hidden" name="seq"/>
            <a:img cssClass="file_img3" src="/download?path=/upload/thumnail/&fileName=${subData.imgList[3].file_img }" alt="상품 사진" srcNone="/img/none.png" altNone="상품 사진 없음 - 상품 등록 후 적용 됩니다." width="240" height="180" /><br/>
            <button type="button" class="artn-button board thkim">이미지 삭제</button>
            <a:file id="ajaxupload_file_img3" name="file_img" path="/upload" toImg=".file_img3" value="${subData.imgList[3].file_img }" thumbWidth="343" thumbHeight="321"/>
        </div>
        <div class="item">
            <span class="seq square"></span>
            <input type="hidden" name="seq"/>
            <a:img cssClass="file_img3" src="/download?path=/upload/thumnail/&fileName=${subData.imgList[4].file_img }" alt="상품 사진" srcNone="/img/none.png" altNone="상품 사진 없음 - 상품 등록 후 적용 됩니다." width="240" height="180" /><br/>
            <button type="button" class="artn-button board thkim">이미지 삭제</button>
            <a:file id="ajaxupload_file_img3" name="file_img" path="/upload" toImg=".file_img3" value="${subData.imgList[4].file_img }" thumbWidth="343" thumbHeight="321"/>
        </div>
        <div class="item">
            <span class="seq square"></span>
            <input type="hidden" name="seq"/>
            <a:img cssClass="file_img3" src="/download?path=/upload/thumnail/&fileName=${subData.imgList[5].file_img }" alt="상품 사진" srcNone="/img/none.png" altNone="상품 사진 없음 - 상품 등록 후 적용 됩니다." width="240" height="180" /><br/>
            <button type="button" class="artn-button board thkim">이미지 삭제</button>
            <a:file id="ajaxupload_file_img3" name="file_img" path="/upload" toImg=".file_img3" value="${subData.imgList[5].file_img }" thumbWidth="343" thumbHeight="321"/>
        </div>
       </div>
    </td>
</tr>
<tr>
<th><label for="name">상품명</label></th>
<td><input type="text" name="name" value="${showData.name }" required="required" title="상품명을 입력하세요."/></td></tr>

<tr>
<th><label for="name_sub">추가 상품명</label></th>
<td><input type="text" name="name_sub" value="${showData.name_sub }" title="추가 상품명을 입력하세요."/></td></tr>

<tr>
<th><label for="category">카테고리</label></th>
<td>
대분류:<a:checkboxlist name="category" list="POB, 악세사리" value="${showData.category }" /><br/>
중분류:<a:checkboxlist name="category" list="갤럭시(S3/S4/N2/N3), 아이폰, LG" value="${showData.category }" offset="8"/><br/>
소분류:<a:checkboxlist name="category" list="프리미엄, 스페셜" value="${showData.category }" offset="16"/><br/>
<%-- <input type="text" name="category" value="${showData.category }" data-rule="num" required="required" title="카테고리를 입력하세요."/> --%>
</td>
</tr>

<tr>
<th><label for="id_opt_gorup">상품 옵션</label></th>
<td>
    <jsp:include page="optgroup/edit_inner.jsp" flush="false"></jsp:include>
</td>
</tr>

<tr>
<th><label for="price_before">할인 전 가격</label></th>
<td><input type="text" name="price_before" value="${showData.price_before }" data-rule="num" required="required" title="할인 전 가격을 입력하세요."/> 원</td></tr>

<tr>
<th><label for="price_event">이벤트 가격</label></th>
<td><input type="text" name="price_event" value="${showData.price_event }" data-rule="num" required="required" title="이벤트 가격을 입력하세요."/> 원</td></tr>

<tr>
<th><label for="price">가격</label></th>
<td><input type="text" name="price" value="${showData.price }" data-rule="num" required="required" title="가격을 입력하세요."/> 원</td></tr>

<tr>
<th><label for="product_count">상품 개수</label></th>
<td><input type="text" name="product_count" value="${showData.product_count }" data-rule="num" required="required" title="상품 개수를 입력하세요."/></td></tr>

<%-- <tr>
<th><label for="pay_point">적립 포인트</label></th>
<td><input type="text" name="pay_point" value="${showData.pay_point }" title=" 적립 포인트를 입력하세요."/></td></tr>
 --%>
<tr>
<th><label for="opt_terms_user">이용 약관</label></th>
<td><input type="text" name="opt_terms_user" value="${showData.opt_terms_user }" data-rule="num" title=" 이용 약관을 입력하세요."/></td></tr>

<tr>
<th><label for="date_sales_start">상품 개시 기간</label></th>
<td><input type="text" id="datepicker_date_sales_start" name="date_sales_start" required="required" value="${showData.date_sales_start }" data-year="2013" data-max-year="10" title="상품 개시 시작일을 입력하세요." />-<input type="text" id="datepicker_date_sales_end" name="date_sales_end" required="required" value="${showData.date_sales_end }" data-year="2013" data-max-year="10" title="상품 개시 종료일을 입력하세요." /></td></tr>
<tr>
<th colspan="2"><label for="contents">상품 설명 (※ 이미지 삽입 시 높이(height)가 자동으로 맞추어 집니다.)</label></th>
</tr>
<tr>
<td colspan="2" style="padding-left:0px"><textarea id="textbox_contents" editor="webnote" name="contents" title="상품 설명을 입력하세요." data-height-remove="true">${showData.contents }</textarea></td></tr>

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
<button type="submit" class="artn-button board"><s:if test="showIsNull">작성</s:if><s:else>수정</s:else> 완료</button>
<%-- <a href="list?id_group=${showData.id_group }" class="artn-button board">목록</a> --%>
<a href="list?contents=adm1000_5_1" class="artn-button board">목록</a>
</form>


<%-- 상품 옵션 다이얼로그 기능 [시작] /////////////////////////////////////////////////////////////////////////////// --%>
<jsp:include page="optgroup/edit_dialog.jsp" flush="false"></jsp:include>
<%-- 상품 옵션 다이얼로그 기능 [종료] /////////////////////////////////////////////////////////////////////////////// --%>


</div>
</a:html>