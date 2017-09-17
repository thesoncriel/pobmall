<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - Product Action Test : Edit" contents="${contentsCode }">
<script>
$(document).ready(function(){
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
	});
	$("[name='product_count']").on("spinstop",function(){
		var sText = $(".sum_price").contents().filter(function(){ return this.nodeType === 3; });
		var iPrice = $("#price").val();
		var iCount = parseInt($("[name='product_count']").attr("aria-valuenow"));
		sText.get(0).nodeValue = (iPrice*iCount).format();
	});
});
</script>
	<div class="header">
		<h1>상품 정보</h1>
		<div id="breadcrumbs" data-sub="*상품 정보"></div>
	</div>
<div class="section">	
	<div class="article product-show">
		<h2>${showData.name }</h2>		
		<div class="price-info">
			<div>
				<div class="preview" data-rule="tabContents">
					<div class="preview_tab">
						<a href="#"><span class="artn-icon-32 carat-1-n"></span></a>
						<ul class="tab">
							<li><a href="#tab1"><a:img src="/download?path=upload/thumnail/&fileName=${subData.imgList[0].file_img }" alt="상품 사진" srcNone="/img/none.png" altNone="상품 사진 없음 - 상품 등록 후 적용 됩니다." width="103" height="105"/></a></li>
							<li><a href="#tab2"><a:img src="/download?path=upload/thumnail/&fileName=${subData.imgList[1].file_img }" alt="상품 사진" srcNone="/img/none.png" altNone="상품 사진 없음 - 상품 등록 후 적용 됩니다." width="103" height="105"/></a></li>
							<li><a href="#tab3"><a:img src="/download?path=upload/thumnail/&fileName=${subData.imgList[2].file_img }" alt="상품 사진" srcNone="/img/none.png" altNone="상품 사진 없음 - 상품 등록 후 적용 됩니다." width="103" height="105"/></a></li>
						</ul>
						<a href="#"><span class="artn-icon-32 carat-1-s"></span></a>
					</div>
					<div class="preview_contents">
						<div class="content" id="tab1"> 
							<a:img src="/download?path=upload/thumnail/&fileName=${subData.imgList[0].file_img }" alt="상품 사진" srcNone="/img/none.png" altNone="상품 사진 없음 - 상품 등록 후 적용 됩니다."/>
						</div>
						<div class="content" id="tab2"> 
							<a:img src="/download?path=upload/thumnail/&fileName=${subData.imgList[1].file_img }" alt="상품 사진" srcNone="/img/none.png" altNone="상품 사진 없음 - 상품 등록 후 적용 됩니다."/>
						</div>
						<div class="content" id="tab3"> 
							<a:img src="/download?path=upload/thumnail/&fileName=${subData.imgList[2].file_img }" alt="상품 사진" srcNone="/img/none.png" altNone="상품 사진 없음 - 상품 등록 후 적용 됩니다."/>
						</div>
						<div class="rating-wrap">
							구매 만족도 : <span id="rating_show" date-name="rating" data-length="5" data-onevalue="2" data-mouse="no" data-value="${showData.rating_avg }"/>
						</div>
					</div>
				</div>
				<form action="cart/modify" method="post" enctype="multipart/form-data">
					<table class="product-opt">
						<tbody class="row-scope">
							<tr>
								<th>판매가</th>
								<td><strong class="price price_ori">${showData.price }<sub>원</sub></strong></td>						
							</tr>
							<s:iterator value="subData.productOpt" var="item" status="s">
			                    <s:if test=" (#itemid == null) || (#itemid != #item.id_opt_item)">
				                    <s:set name="itemid" value="#item.id_opt_item"/>
			                        <tr>
	                                    <th><label><s:property value="#item.opt_name"/></label></th>
	                                    <td><s:select name="opt_detail" list="subData.productOpt.{? (#this.id_opt_item == #item.id_opt_item) }" listKey='%{item_name + ":" +item_price}' listValue='%{item_name + ":" +item_price}' theme="simple" headerKey="선택안함:0" headerValue="-----선택-----"></s:select></td>
	                                </tr>
			                    </s:if>
		                    </s:iterator>
							<tr>
								<th>구매수량</th>
								<td>
									<input type="text" id="spinner_product" name="product_count" data-min="1" value="1" readonly="readonly"/><span> 개</span>
									<span class="remain">판매수량: ${showData.product_count }개<em>(남은수량: ${showData.sold_count }개)</em></span>
								</td>
							</tr>
						</tbody>
					</table>
					
					<div class="total-price">
						<span>총 상품 금액</span>
						<strong class="price sum_price">${showData.price }<sub>원</sub></strong>
					</div>
					<div class="buttons"><button class="artn-button" type="submit">장바구니에 담기</button></div>
					
					<%-- 숨김항목 --%>
					<input type="hidden" name="id_product" value="${showData.id }"/>
					<input type="hidden" name="opt" value=""/>
					<!-- <input type="hidden" name="opt_detail" value=""/> -->
					<input type="hidden" name="opt_detail_seq" value=""/>
					<!-- <input type="hidden" name="price" value=""/> -->
					<input type="hidden" name="file_img" value="${showData.file_img }"/>
					<input type="hidden" name="price_opt" value=""/>
					<input type="hidden" id="price" name="price" value="${showData.price }"/>
					<input type="hidden" name="subject" value="${showData.name }"/>
					<%-- 숨김항목 --%>					
				</form>
			</div>			
		</div>
		<div class="footer board">
			<div class="buttons">					
				<s:if test='%{auth.isGroupAdmin(id_group)}'>
					<a href="edit?id=${showData.id }" class="artn-button board">수정</a>
				</s:if>					
				<a href="grid" class="artn-button board">목록</a>
			</div>
		</div>
		<div class="desc">
			${showData.contents }
		</div>
		<div class="footer board">
			<div class="buttons">					
				<s:if test='%{auth.isGroupAdmin(id_group)}'>
					<a href="edit?id=${showData.id }" class="artn-button board">수정</a>
				</s:if>					
				<a href="grid" class="artn-button board">목록</a>
			</div>
		</div>
		

	</div>
</div>
</a:html>