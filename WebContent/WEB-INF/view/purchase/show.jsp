<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - Purchase Action Test : Edit" contents="${contentsCode }">
<div class="header">
	<h1>구매 정보</h1>
	<div id="breadcrumbs" data-sub="${contentsCode }" data-target="auto"></div>
</div>
<div class="article">
<form action="modify" method="post">
<fieldset>
        <table class="board-list">
           <thead>
            <tr>
                <th>상품</th>
                <th>옵션</th>
                <th class="m-hdn">상품 가격</th>
                <th>옵션 가격</th>
                <th><span class="m-hdn">상품 </span>개수</th>
                <th>전체 가격</th>
                <th class="m-hdn">운송장 번호</th>
                <th class="last">기타</th>
            </tr>
            </thead>
            <tbody id="list_userCart">
            <tr>
                <td><a:img src="/download?path=upload/thumnail/&fileName=${showData.file_img }" alt="상품 사진" srcNone="/img/none.png" altNone="상품 사진 없음 - 상품 등록 후 적용 됩니다." width="50" height="40" /><br/><s:property value="subject"/></td>    
                <td><s:property value="showData.opt_detail"/></td>
                <td class="m-hdn"><span class="price"><s:property value="showData.price"/></span><span>원</span></td>
                <td><span class="price"><s:property value="showData.price_opt"/></span><span>원</span></td>
                <td><s:property value="showData.product_count"/><span>개</span></td>
                <td><span class="sum_price price"><s:property value="showData.sum_price"/></span><span>원</span></td>
                <td class="m-hdn"><s:property value="showData.delivery_num"/></td>
                <td><a href="#" id="prod_history" class="artn-button board">주문상태<br/>상세보기</a></td>
            </tr>
            </tbody>
        </table>
        
        <div id="article">
<div class="article cart-list">
    <div class="purtial-info left">
        <h1>배송지 정보</h1>
        <s:if test='%{(showData.status == 1) || (showData.status == 2) }'>
    <a href="/payment/edit?id=${showData.id_payment}" class="artn-button board">배송지 정보 변경</a>
    </s:if>
       <table class="board-show delivery">
           <tbody class="row-scope">
           <tr>
               <th><label for="to_name">이름</label></th>
               <td>${showData.to_name }</td>
           </tr>
           <tr>
               <th><label for="to_phone_mobi">휴대폰</label></th>
               <td>${showData.to_phone_mobi }</td>
           </tr>
           <tr>
               <th><label for="to_phone_home">일반전화</label></th>
               <td>${showData.to_phone_home }</td>
           </tr>
           <tr>
               <th><label for="to_zipcode">우편번호</label></th>
               <td>${showData.to_zipcode }</td>
           </tr>
           <tr>
               <th><label for="to_address">주소</label></th>
               <td>${showData.to_address }</td>
           </tr>
           </tbody>
       </table>
    </div>
    <div class="purtial-info right">
       <h1>주문자 정보</h1>
       <table class="board-show order">
           <tbody class="row-scope">
           <tr>
               <th><label for="pay_user_name">이름 </label></th>
               <td>${showData.pay_user_name }</td>
           </tr>
           <tr>
               <th><label for="pay_phone">전화번호</label></th>
               <td>${showData.pay_phone }</td>
           </tr>
           <tr>
               <th><label for="pay_mail">이메일</label></th>
               <td>${showData.pay_mail }</td>
           </tr>
           </tbody>
       </table>
       <h1>결제 정보</h1>
       <table class="board-show payment-show">
           <tbody class="row-scope">
           <tr>
               <th><label for="pay_type_name">결제방법</label></th>
               <td>${showData.pay_type_name }</td>
           </tr>
           <s:if test="showData.pay_type == 1">
           <tr>
               <th><label for="pay_bank_name">결제은행</label></th>
               <td>${showData.pay_bank_name }</td>
           </tr>
           <tr>
               <th><label for="pay_bank_account">결제계좌번호</label></th>
               <td>${showData.pay_bank_account }</td>
           </tr>
           <tr>
               <th><label for="pay_bank_user">입금자</label></th>
               <td>${showData.pay_bank_user }</td>
           </tr>
           </s:if>
           </tbody>
       </table>
    </div>
</div>
    </div>
    <div>
    </div>
</fieldset>
<a href="/payment/list?contents=${params.contents }" class="artn-button board">목록</a>   
</form>
</div>

<div id="dialog_product_history" title="주문 상태 내역" data-width="250" data-height="250" data-openBy="#prod_history">

<table>
    <tr>
        <th>일자</th>
        <th>진행내역</th>
        <th></th>
    </tr>
    <s:iterator value="subData.purchaseHistory" var="sub">
    <tr>
        <td>${sub.date_upload }</td>
        <td>${sub.status_kor }</td>
        <td></td>
    </tr>
    </s:iterator>
</table>
    <div class="footer board">
        <div class="buttons">
            <button class="artn-button board" type="button" data-close="close">확인</button>
        </div>
    </div>      

</div>
</a:html>
