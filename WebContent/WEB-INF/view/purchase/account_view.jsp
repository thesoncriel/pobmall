<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - Purchase Action Test : Create" contents="${contentsCode }">
<style type="text/css">
.account-view
{
    width: 412px;
    margin: 0 auto;
    margin-top: 30px;
    margin-bottom: 50px;
    text-align: center;
}
.brTag
{
    display: none;
}
@media all and (max-width: 412px){
	.account-view
	{
	   width: auto;
	}
	.brTag
	{
	   display: block;
	}
}
</style>
<div class="header">
    <h1>입금 계좌</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="auto"></div>
</div>
<div class="article">
    <div class="account-view">
    	<h2>주문이 완료 되었습니다!</h2>
    	<p>아래의 입금 계좌로 입금하여 주시면<br class="brTag"/> 결제 확인 절차 후 상품이 배송됩니다.</p>
    	<p>감사합니다.</p>
        <table class="board-show border-around style3">
            <tbody class="row-scope">
                <tr>
                <th>예금주</th>
                <td>(주)제이글로비스</td>
                </tr>
                <tr>
                    <th>입금은행</th>
                    <td>${showData.pay_bank_name }</td>
                </tr>
                <tr>
                    <th>입금계좌</th>
                    <td>${showData.pay_bank_account }</td>
                </tr>
            </tbody>
        </table>
        <a href="/payment/list" class="artn-button board">주문 목록</a> 
    </div>
</div>
</a:html>