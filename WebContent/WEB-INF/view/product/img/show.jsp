<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - Product Action Test : Edit" contents="${contentsCode }">
<script>
$(document).ready(function(){
	$("#purchase_count").keyup(function(){
		var iValue = $("#amount").val() * $(this).val();
		$("[name='price']").val(iValue);
		$("select[name^='opt_'] option:selected").each(function(){
			if($(this).val() == ""){
				iValue += 0;
			}else{
				iValue += parseInt($(this).val());	
			}
				
		});
		$("#amount_adjust").val(iValue);
	});
	$("select[name^='opt_']").change(function(){
		var iValue = 0;
        $("select[name^='opt_'] option:selected").each(function(){
            if($(this).val() == ""){
                iValue += 0;
            }else{
                iValue += parseInt($(this).val());  
            }
        });
        $("[name='price_opt']").val(iValue);
        iValue += $("#amount").val() * $("#purchase_count").val();
        $("#amount_adjust").val(iValue);
	});
	
	$("[type='submit']").click(function(){
        var sSeq = "";
        var sOptVal = "";
        $("select[name^='opt_'] option:selected").each(function(){
            if(sSeq != ""){
            	sSeq += "/";
            	sOptVal += "/";
            }
            sSeq += $(this).attr("seq");
            sOptVal += $(this).text();
        });
        $("[name='opt_detail_seq']").val(sSeq);
        $("[name='opt_detail']").val(sOptVal);
	});
});
</script>
<div class="header">
	<h1>상품 정보</h1>
	<div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="article">
<h1>상품 정보</h1>
<form action="/purchase/write" method="post" enctype="multipart/form-data">
<fieldset>
<table>
<tbody>

<tr>
<th>사진</th>
<td><a:img src="/download?path=upload/product/img/&fileName=${showData.file_img }" alt="상품 사진" srcNone="/img/none.png" altNone="상품 사진 없음 - 상품 등록 후 적용 됩니다." width="320" height="240" /></td></tr>

<tr>
<th><label for="subject">상품명</label></th>
<td><input type="text" name="subject" readonly="readonly" style="border: none;" value="${showData.name }"/></td></tr>

<tr>
<th><label>상품 옵션</label></th><td></td></tr>
<s:iterator value="subData.productOpt">
<tr>
<th><label><s:if test='%{opt_required == "y"}'>*필수* </s:if> <s:property value="opt_name"/></label></th>
<%-- <td><span class="selectOpt" data-name="opt_${seq }" data-value="${items_price }" data-text1="${items_name }" data-text2="${items_price }" data-div=","></span> </td> --%>
<td><a:selectopt name="opt_${seq }" value="${items_price }" text="${items_name }" textdiv=","/></td>
</tr>
</s:iterator>

<tr>
<th>할인 전 가격</th>
<td>${showData.price_before } 원</td></tr>
<tr>
<th>이벤트 가격</th>
<td>${showData.price_event } 원</td></tr>
<tr>
<th><label for="amount">구매 가격</label></th>
<td><span><input type="text" id="amount" name="amount" readonly="readonly" style="border: none;" value="${showData.price }"/></span> 원</td></tr>

<tr>
<th><label for="purchase_count">주문 개수</label></th>
<td><span><input type="text" id="purchase_count" name="purchase_count" value="1"/></span> 개</td></tr>

<tr>
<th>총 구매 가격</th>
<td><input type="text" id="amount_adjust" name="amount_adjust" value="${showData.price }" readonly="readonly" style="border: none;"/> 원</td></tr>

<tr>
<th>전달 메시지</th>
<td><input type="text" name="comment"/></td></tr>

<%-- <tr>
<th>적립 포인트</th>
<td>${showData.pay_point }</td></tr> --%>

<tr>
<th>이용 약관</th>
<td>${showData.opt_terms_user }</td></tr>

<tr>
<th>상품 설명</th>
<td>${showData.contents }</td></tr>

<tr>
<th>상품 설명 요약</th>
<td>${showData.contents_summary }</td></tr>

</tbody>
</table>
</fieldset>
<!-- 숨김 필드 모음 -->
<input type="hidden" name="product_count" value="${showData.product_count }"/>
<input type="hidden" name="id_product" value="${showData.id }"/>
<input type="hidden" name="id_group" value="${showData.id_group }"/>
<input type="hidden" name="id_opt_detail_group" value="${showData.id_opt_group}"/>
<input type="hidden" name="opt_detail" value=""/>
<input type="hidden" name="opt_detail_seq" value=""/>
<input type="hidden" name="price" value=""/>
<input type="hidden" name="price_opt" value=""/>
<s:if test='%{showData.date_sales_diff >= 0}'>
<button type="submit">구매</button>
</s:if>
<s:if test='%{auth.isGroupAdmin(id_group)}'>
 <a href="edit?id=${showData.id }">수정</a>
</s:if>
<a href="list?id_group=${showData.id_group }">목록</a>
</form>
</div>
</a:html>