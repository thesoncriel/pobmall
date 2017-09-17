<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - Purchase Action Test : List" contents="${contentsCode }">
<div class="header">
	<h1>장바구니</h1>
	<div id="breadcrumbs" data-sub="*장바구니"></div>
</div>
<div class="section">
<div class="article">
    <form action="/payment/modify" id="cart-list" method="post" enctype="multipart/form-data" class="validator">
    <input type="hidden" id="delivery_price" value="<s:property value="deliveryInfo[1].delivery_price"/>"/>
    <input type="hidden" id="free_condition" value="<s:property value="deliveryInfo[1].free_condition"/>"/>
    <input type="hidden" id="delivery_status" value="<s:property value="deliveryInfo[1].status"/>"/>
    <input type="hidden" name="delivery_status"/>
	<div class="article cart-list">
	<h1>01.주문상세내역</h1>
		<table class="board-list m-list">
		   <thead>
			<tr class="m-hdn-hdn">
				<s:if test='%{auth.isAdmin}'>
				<th class="col-id">아이디</th>
				</s:if>
			    <th class="col-img">상품</th>
				<th class="col-name">상품명</th>
				<th class="col-opt">옵션</th>
				<th class="col-price">상품가격</th>
				<th class="col-opt-price">옵션가격</th>
				<th class="col-count">상품개수</th>
				<th class="col-price-sum">전체가격</th>
				<th class="col-etc">기타</th>
			</tr>
			<tr class="m-show">
				<th class="m-col-70">주문상품정보</th>
				<th class="m-col-30">가격/수량</th>
			</tr>
			</thead>
			<tbody id="list_userCart">
			<s:if test="listIsNull">
			<tr><td colspan="<s:if test='%{auth.isAdmin}'>9</s:if><s:else>8</s:else>">장바구니 내역이 존재하지 않습니다.</td></tr>
			</s:if>
			<s:else><s:iterator value="listData" status="s">
			<tr>
				<s:if test='%{auth.isAdmin}'>
					<td class="col-id"><s:property value="id_user"/></td>
				</s:if>
			    <td class="col-img m-hdn-hdn"><input type="hidden" name="seq" value=""/><a:img src="/download?path=/upload/thumnail/&fileName=${file_img }" alt="상품 사진" srcNone="/img/none.png" altNone="상품 사진 없음 - 상품 등록 후 적용 됩니다." width="60" height="60" /></td>
			    <td class="col-name"><s:property value="subject"/></td>	
				<td class="col-opt"><s:property value="opt_detail"/></td>
				<td class="col-price m-hdn-hdn"><span class="price"><s:property value="price"/><span>원</span></span></td>
				<td class="col-opt-price m-hdn-hdn"><s:property value="price_opt"/><span>원</span></td>
				<td class="col-count">
				<s:if test='%{#session.environment.osPlatform == "Desktop"}'>
				    <span class="pc_view"><input type="text" class="product_count" id="spinner_product_count${s.index }" name="product_count" value="${product_count }" data-min="1" style="width: 25px;" readonly="readonly"><span> 개</span></span>
				</s:if>
				<s:else>
                    <span class="mobi_view"><a:selectbox name="product_count" cssClass="select_count" min="1" max="100" value="${product_count }"/>개</span>                    				
				</s:else>
				</td>
				<td class="col-price-sum"><span class="text_sum_price price">0</span><input type="hidden" class="sum_price" name="sum_price" value="" style="border:none" readonly="readonly"/>
				<%-- <span class="sum_price">${(price + price_opt) * product_count}</span> --%><span>원</span>
				</td><td class="col-etc">
				<input type="hidden" name="id_cart" value="${id_cart }"/>
				<input type="hidden" name="id_product" value="${id_product }"/>
				<input type="hidden" name="subject" value="${subject }"/> 
	            <input type="hidden" name="opt_detail" value="${opt_detail }"/>
	            <input type="hidden" name="price" value="${price }"/>
	            <input type="hidden" name="price_opt" value="${price_opt }"/>
	            <input type="hidden" name="file_img" value="${file_img }"/>
	            <input type="hidden" name="opt" value="${opt }"/>
	            <input type="hidden" name="purchase_seq" value="${purchase_seq }"/>
	            <input type="hidden" name="transaction_num" id="transaction_num" value=""/>
	            <input type="hidden" name="opt_indices" value="${opt_indices }"/>	                         
	            <input type="button" class="delete artn-button" value="삭제"/>
	            <input type="hidden" name="paymethod" value=""/>
				</td>
			</tr>
			</s:iterator>
			</s:else>
			</tbody>
			<tfoot>				
				<tr>
					<td colspan="<s:if test='%{auth.isAdmin}'>9</s:if><s:else>8</s:else>">					
						<div class="product_price">상품가격: <span id="text_product_price" class="price">0<sub>원</sub></span></div>
						<span class="plus">+</span>
						<div class="delivery_price">배송비: <span id="text_delivery_price" class="price">0<sub>원</sub></span></div>
						<span class="equals">=</span>
						<div class="total_price">최종 결제 금액: <span id="text_total_price" class="price">0<sub>원</sub></span></div>						
					</td>
				</tr>
			</tfoot>
		</table>
		<input type="hidden" name="amount" id="total_price">
		<%-- <div class="total_price">최종 결제 금액: <span id="text_total_price" class="price">0<sub>원</sub></span></div> --%>
	</div>		
<div class="article cart-list">
    <s:if test='%{#session.user.id != "guest"}'>
	<!-- <div class=""> -->
	<div class="partial-info full">
		<h1>02.배송지 정보</h1>
		<input type="button" class="artn-button" id="my_info" value="주문자와 동일"/>
		<input type="hidden" id="my_id" value="${user.id }"/>
	</s:if>
	<s:else>
	<div class="partial-info left">
	<h1>02.배송지 정보</h1>
	</s:else>	
		   <table class="board-edit border-around delivery">
		       <tbody class="row-scope">
		       <tr>
		           <th><label for="to_name">이름</label></th>
		           <td><input type="text" class="name" name="to_name" required="required" title="이름을 입력하세요" style="width:151px;"/></td>
		       </tr>
		       <tr>
	               <th><label for="to_phone_mobi">휴대폰</label></th>
	               <td><a:phone id="phonebox_phone_mobi" name="to_phone_mobi" type="phone_mobi" required="required" /></td>
	           </tr>
	           <tr>
	               <th><label for="to_phone_home">일반전화</label></th>
	               <td><a:phone id="phonebox_phone_home" name="to_phone_home" type="phone" required="required" /></td>
	           </tr>
	           <tr>
	               <th><label for="to_zipcode">우편번호</label></th>
	               <td><input type="text" id="textbox_zipcode_home" style="width:151px;" class="zipcode_home" name="to_zipcode" maxlength="7" data-rule="zipcode" data-tonew="#textbox_address_home_new" title="거주하는 곳의 우편번호를 선택하세요. (클릭)"/>
	               <s:if test='%{#session.user == null}'>
	               <br/>
	               </s:if>
	               <strong>※상세주소를 같이 입력해 주세요.</strong>
	               </td>
	           </tr>
	           <tr>
	               <th><label for="to_address">주소</label></th>
	               <td><input type="text" id="textbox_address_home_new" class="address_home_new" name="to_address" maxlength="100"  title="우편번호 선택 시 자동으로 입력 됩니다. (클릭)"/><br/>
	               </td>
	           </tr>
		       </tbody>
		   </table>
	   </div>
	   <s:if test="#session.user == null">
	   <div class="partial-info right">
		   <h1>03.주문자 정보</h1>
		   <s:if test='%{#session.user.id != "guest"}'>
		</s:if>
		   <table class="board-edit border-around order">
	           <tbody class="row-scope">
	           <tr>
	               <th><label for="pay_user_name">이름 </label></th>
	               <td><input type="text" class="pay_user_name" name="pay_user_name" style="width:151px;" required="required" title="이름을 입력하세요."/></td>
	           </tr>
	           <tr>
	               <th><label for="to_phone_mobi">휴대폰</label></th>
	               <td><a:phone id="phonebox_phone_mobi" name="pay_phone" type="phone_mobi" required="required"/></td>
	           </tr>
	           <tr>
	               <th><label for="pay_mail">이메일</label></th>
	               <td><a:email id="emailbox_email" name="pay_mail" required="required"/></td>
	           </tr>
	           </tbody>
	       </table>
       </div>
       </s:if>
       <s:else>
        <input type="hidden" name="pay_user_name" value="${user.name }"/>
        <input type="hidden" name="pay_phone" value="${user.phoneMobi }"/>
        <input type="hidden" name="pay_mail" value="${user.email }"/>
       </s:else>
	</div>
	<div>
	<input type="hidden" id="pay_type" name="pay_type"/>
	<input type="hidden" id="pay_type_name" name="pay_type_name"/>
	<input type="hidden" name="pay_bank_user"/>
	<input type="hidden" name="pay_bank_name"/>
	<input type="hidden" name="pay_bank_account"/>
	<input type="hidden" name="prodmodify" value=""/>
	</div>
	</form>
	<div>
	   <div class="payment" data-rule="tabContents">
	       <ul class="tab distribute div3">
			 <li><a href="#tab1" class="selected"><input type="hidden" class="pay_type" value="3"/>카드 결제</a></li>
			 <li><a href="#tab2"><input type="hidden" class="pay_type" value="2"/>실시간 계좌이체</a></li>
	         <li class="last"><a href="#tab3"><input type="hidden" class="pay_type" value="1"/><span>무통장 입금</span></a></li>	         
	       </ul>
	         <div class="content" id="tab1">
	         	<form class="payment" method="post" action="/payment/payment" target="pop" class="validator">
                 	<div class="__dataHere__"></div>
                 	<input type="hidden" class="paymethod" value="Card">					
					<button type="button" class="artn-button market purchase">구매하기</button>
					<a href="/product/grid" class="artn-button market">계속 쇼핑하기</a>		
				</form>  
	         </div>
	        
	         <div class="content" id="tab2">
	            <form class="payment" method="post" action="/payment/payment" target="pop" class="validator">
					<div class="__dataHere__"></div>
					<input type="hidden" class="paymethod" value="DirectBank">					
					<button type="button" class="artn-button market purchase">구매하기</button>
					<a href="/product/grid" class="artn-button market">계속 쇼핑하기</a>		
				</form>
	         </div>
	         <div class="content" id="tab3">	             
				 <p><strong>다음 단계에 입금하셔야할 계좌번호가 나옵니다.</strong></p>
	             <ul>
	             <li><s:select list="#{
                            '351-0656-3266-93': '농협 은행'
                            }" theme="simple"></s:select>
                 입금자명 : <input type="text" id="pay_bank_user"/>                 
                 </li>
	             </ul>
	            <div style="text-align: center;">
		         	<button type="submit" id="delivery_submit" class="artn-button market">구매하기</button>		         	
		         	<a href="/product/grid" class="artn-button market">계속 쇼핑하기</a>
	         	</div>           
             </div>
         </div>
	</div>	
</div>
</div>
</a:html>