<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - Purchase Action Test : List" contents="${contentsCode }">
<style>
#search_frm .date_btn.selected
{
    border-color: red;
}
</style>
<div class="header">
	<h1>구매 목록</h1>
	<div id="breadcrumbs" data-sub="${contentsCode }" data-target="auto"></div>
	
</div>
<div class="article payment-list">
<form id="search_frm" action="list" method="post">
	<input type="hidden" id="delivery_price" value="<s:property value="deliveryInfo[1].delivery_price"/>"/>
    <input type="hidden" id="free_condition" value="<s:property value="deliveryInfo[1].free_condition"/>"/>
    <input type="hidden" id="delivery_status" value="<s:property value="deliveryInfo[1].status"/>"/>
<s:select name="status" list="#{
                            '': '전체 목록',
                            '1': '입금 대기',
                            '2': '입금 확인',
                            '3': '배송 중',
                            '4': '배송 완료',
                            '10': '구매 완료',
                            '-2': '구매 취소',
                            '-3': '환불 요청',
                            '-4': '교환 요청',
                            '-9': '교환 완료',
                            '-10': '환불 완료'
                            }" theme="simple">
</s:select>
<input type="hidden" name="contents" value="${param.contents }"/>
<input type="hidden" id="date" name="date" value="${param.date }"/>
<input type="button" class="artn-button board date_btn" data-value ="allday" value="전체"/>
<input type="button" class="artn-button board date_btn" data-value ="today" value="오늘"/>
<input type="button" class="artn-button board date_btn" data-value ="1week" value="1주일"/>
<input type="button" class="artn-button board date_btn" data-value ="1month" value="1개월"/>
<input type="button" class="artn-button board date_btn" data-value ="3month" value="3개월"/>
<input type="button" class="artn-button board date_btn" data-value ="6month" value="6개월"/>
<input type="button" class="artn-button board date_btn" data-value ="1year" value="1년"/>
<s:if test="auth.isAdmin">
<s:select name="search_div" headerKey="" headerValue="전체" list="#{'pay_user_name':'구매자명',
                                                                  'id_user':'구매자 ID',
                                                                  'id_payment':'주문번호',
                                                                  'delivery_num':'배송번호'
                                                                  }" theme="simple"/>
<input type="text" name="search_text"/>
<input type="submit" class ="artn-button board serch_btn" value="검색"/>
<input type="button" class ="artn-button board serch_btn print" value="프린트" onclick=""/>
<a href="/exceldown?fileName=payment" class="artn-button board serch_btn">Excel</a>
</s:if>
</form>
<form id="update_frm" action="update" method="post">
<input type="hidden" name="id_purchase"/>
<input type="hidden" name="id_user"/>
<input type="hidden" name="pay_user_name"/>
<input type="hidden" name="pay_phone"/>
<input type="hidden" name="status"/>
<input type="hidden" name="id_payment"/>
<input type="hidden" name="id_product"/>
<input type="hidden" name="transaction_num"/>
<input type="hidden" name="delivery_num"/>
<input type="hidden" name="rowlimit" value="${param.rowlimit }"/>
<input type="hidden" name="page" value="${param.page }"/>
<div id="printarea">
	<table class="board-list style2 m-list">
		<thead>
			<tr class="m-hdn-hdn">
				<th>주문 번호</th>
				<th>구매자</th>
				<th>주문 내역</th>
				<th>상품 개수</th>
				<th>총 가격/배송비</th>
				<th>구매 날짜</th>
				<!-- <th>구매 유효 기간</th> -->
				<th>입금 확인 날짜</th>
				<th width="90">구매 상태</th>
				<s:if test="auth.isAdmin">
					<th>입금자/카드취소</th>
				</s:if>
			</tr>
			<tr class="m-show">
				<th class="m-col-65">주문정보</th>
				<th class="m-col-35">결제정보</th>
			</tr>
		</thead>
		<tbody id="list_purchase">	
			<s:if test="listIsNull">
			<tr><td colspan="10">주문 내역이 존재하지 않습니다.</td></tr>
			</s:if>
			<s:else><s:iterator value="listData" var="paymentList">
			<tr class="payment-list">
				<td class="m-hdn-hdn">${paymentList.id }</td>
				<td class="col-user">${paymentList.to_name }(${paymentList.id_user })</td>
				<td class="col-subject"><a href="#" class="payment-subject">${paymentList.subject } 등 ${paymentList.product_count }<span>개</span><span class="artn-icon-16 circle-caret-2-s"></span></a></td>
				<td class="m-hdn-hdn">${paymentList.product_count }<span>개</span></td>
				<td class="col-amount">
					<span class="price amount">${paymentList.amount }</span><span>원</span>/
					<input type="hidden" class="delivery-status" value="${delivery_status }"/>
					<span class="pay-free"></span>					
					<%-- <s:if test="delivery_status == 1">
						<span style="color:blue;">무료</span>
					</s:if>
					<s:else>
						<span style="color:red;">유료</span>
					</s:else> --%>
					<input type="hidden" class="total-price" value="${paymentList.amount }"/>
				</td>
				<td class="col-date">${paymentList.date_start_fmt }</td>
				<%-- <td>${paymentList.date_end_fmt }</td> --%>
				<td class="m-hdn-hdn">${paymentList.date_confirm_fmt }</td>
				<td></td>
				<s:if test="auth.isAdmin">
					<td class="m-hdn-hdn"><s:if test="(#paymentList.transaction_num == '') || (#paymentList.transaction_num == null)">${paymentList.pay_bank_user }</s:if></td>
					<td class="m-show"><s:if test="(#paymentList.transaction_num == '') || (#paymentList.transaction_num == null)">입금자: ${paymentList.pay_bank_user }</s:if></td>	
				</s:if>
			</tr>
			<s:iterator value="subData.purchaseAll">				
			<s:if test="id == id_payment">	
							
			<tr class="item-sub" style="display: none;">
				<td class="m-hdn-hdn"></td>	
				<td class="m-hdn-hdn"></td>		
				<td class="col-subject-sub"><a href="/purchase/show?id_purchase=${id_purchase }&id_payment=${id_payment }&id_user=${id_user }&contents=${params.contents }"><s:property value="subject"/></a><br/><s:property value="opt_detail_name" escapeHtml="false"/></td>
				<td class="m-hdn-hdn"><s:property value="product_count"/><span>개</span></td>
				<td class="col-price"><span class="price"><s:property value="sum_price"/></span><span>원</span></td>
				<td class="m-hdn-hdn"><s:property value="date_start_fmt"/></td>
				<%-- <td><s:property value="date_end_fmt"/></td> --%>
				<td class="m-hdn-hdn"><s:property value="date_confirm_fmt"/></td>
				<td class="col-buttons"><input type="hidden" class="id_purchase" value="${id_purchase }"/>
	       			<input type="hidden" class="id_user" value="${id_user }"/>
	       			<input type="hidden" class="id_payment" value="${id_payment }" />
	       			<input type="hidden" class="id_product" value="${id_product }" />
	       			<input type="hidden" class="opt_indices" value="${opt_indices }"/>
	       			<input type="hidden" class="pay_user_name" value="${pay_user_name }"/>
	       			<input type="hidden" class="pay_phone" value="${pay_phone }"/>			
					<s:if test='%{auth.isAdmin}'>
					    <s:if test='%{status == 1}'>
					        <span>입금 중</span>
					        <input type="button" class="artn-button board update_btn" data-status="-2" value="구매 취소"/>
					        <input type="button" class="artn-button board update_btn" data-status="2" value="입금 확인"/>
					    </s:if>
				        <s:elseif test='%{status == 2}'>
				            <span>배송 준비 중</span>
				            <input type="button" class="artn-button board update_btn" data-status="-2" value="구매 취소"/>
				            <button type="button" class="artn-button board update_btn edit" data-status="3" data-rule="dialogButton" data-dialog="#dialog_delivery">배송 시작</button>
				        </s:elseif>
				        <s:elseif test='%{status == 3}'>
				            <span>배송 중</span>
				            <input type="button" class="artn-button board update_btn" data-status="4" value="배송 완료"/>
	                    </s:elseif>
	                    <s:elseif test='%{status == 4}'>
	                        <span>배송 완료</span>
	                        <input type="button" class="artn-button board update_btn" data-status="-10" value="환불 완료"/>
	                    </s:elseif>
	                    <s:elseif test='%{status == 10}'>
	                        <span>판매 완료</span>
	                    </s:elseif>
	                    <s:elseif test='%{status == -2}'>
	                        <span>구매 취소</span>
	                    </s:elseif>
	                    <s:elseif test='%{status == -3}'>
	                        <span>환불 요청</span>
	                        <input type="button" class="artn-button board update_btn" data-status="-10" value="환불 완료"/>
	                    </s:elseif>
	                    <s:elseif test='%{status == -4}'>
                            <span>교환 요청</span>
                            <input type="button" class="artn-button board prod_exchange select" value="옵션 변경"/>
                            <input type="button" class="artn-button board update_btn" data-status="-9" value="교환 완료"/>
                        </s:elseif>
                        <s:elseif test='%{status == -9}'>
                            <span>교환 완료</span>
                        </s:elseif>
	                    <s:elseif test='%{status == -10}'>
	                        <span>환불 완료</span>
	                    </s:elseif>
	                    <input type="hidden" class="transaction_num" value="${transaction_num }"/>
						<s:if test="status == 2 && transaction_num != ''">						
							<button type="submit" class="artn-button board paymentCancel m-show">결제 취소</button>
						</s:if>
					</s:if>
					<s:else>
					    <s:if test='%{status == 1}'>
	                        <span>입금 확인 중</span>
	                        <input type="button" class="artn-button board update_btn" data-status="-2" value="구매 취소"/>
	                    </s:if>
	                    <s:elseif test='%{status == 2}'>
	                        <span>배송 준비 중</span>
	                        <input type="button" class="artn-button board update_btn" data-status="-2" value="구매 취소"/>
	                    </s:elseif>
	                    <s:elseif test='%{status == 3}'>
	                        <span>배송 중</span>
	                    </s:elseif>
	                    <s:elseif test='%{status == 4}'>
	                        <span>배송 완료</span>
	                        <input type="button" class="artn-button board update_btn" data-src="/product/board/write" data-status="-4" value="교환 요청"/>
                            <input type="button" class="artn-button board update_btn" data-src="/product/board/write" data-status="-3" value="환불 요청"/>
	                        <input type="button" class="artn-button board update_btn" data-status="10" value="구매 결정"/>
	                    </s:elseif>
	                    <s:elseif test='%{status == 10}'>
	                        <span>구매 완료</span>
	                    </s:elseif>
	                    <s:elseif test='%{status == -2}'>
	                        <span>구매 취소</span>
	                    </s:elseif>
	                    <s:elseif test='%{status == -3}'>
	                        <span>환불 요청 중</span>
	                    </s:elseif>
	                    <s:elseif test='%{status == -4}'>
                            <span>교환 요청 중</span>
                        </s:elseif>
                        <s:elseif test='%{status == -9}'>
                            <span>교환 완료</span>
                            <input type="button" class="artn-button board update_btn" data-src="/product/board/write" data-status="-4" value="교환 요청"/>
                            <input type="button" class="artn-button board update_btn" data-src="/product/board/write" data-status="-3" value="환불 요청"/>
                            <input type="button" class="artn-button board update_btn" data-status="10" value="구매 결정"/>
                        </s:elseif>
	                    <s:elseif test='%{status == -10}'>
	                        <span>환불 완료</span>
	                    </s:elseif>
					</s:else>					
				</td>
				<s:if test="auth.isAdmin">						
					<td class="m-hdn-hdn">
						<input type="hidden" class="transaction_num" value="${transaction_num }"/>
						<s:if test="transaction_num != ''">						
							<button type="submit" class="artn-button board paymentCancel">결제 취소</button>
						</s:if>
					</td>
				</s:if>				
			</tr>
			</s:if>
			</s:iterator>
			</s:iterator></s:else>
		</tbody>	
	</table>
</div>	
</form>
	<a:pagenav page="${param.page }" params="${params}" rowCount="${rowCount }" rowLimit="10" navCount="10" id="pagecontroller" cssClass="page-controller" font="symbol" />
</div>
<input type="hidden" id="id_group" value="${id_group}"/>

<div id="dialog_delivery" data-height="200">
	<h3>운송장 번호입력</h3>
	<input type="text" class="delivery_num"/>
	<button class="artn-button board delivery">확인</button>
</div>
<div id="dialog_exchange" title="상품 옵션 교환" data-width="200" data-height="176" data-openBy=".prod_exchange">
    <form action="/purchase/update" method="post">
       <input type="hidden" name="status" value="-9"/>
       <input type="hidden" name="id_product"/>
       <input type="hidden" name="opt_indices"/>
       <input type="hidden" name="id_purchase"/>
       <input type="hidden" name="id_user"/>
       <input type="hidden" name="id_payment"/>
       
       <div id="exchange_select"></div>
       <input type="submit" class="artn-button board" value="변경"/>
       <input type="button" class="artn-button board close_dialog" value="취소"/> 
    </form>
    <!--
        <option value={item_name}:{item_price}:{item_seq}>{item_name}:{item_price}원</option>
     -->
</div>

</a:html>