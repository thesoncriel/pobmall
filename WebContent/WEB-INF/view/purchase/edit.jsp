<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - Group Action Test : Edit" contents="${contentsCode }">
<div class="header">
	<h1>배송지/주문자 정보</h1>
	<div id="breadcrumbs" data-sub="${contentsCode }" data-target="auto"></div>
</div>
<div class="article">
<form action="modify" method="post" enctype="multipart/form-data" class="validator">
<div class="article cart-list">
    <div class="purtial-info left">
        <h1>배송지 정보</h1>
       <table class="board-edit delivery">
           <tbody class="row-scope">
           <tr>
               <th><label for="to_name">이름</label></th>
               <td><input type="text" name="to_name" value="${showData.to_name }"/></td>
           </tr>
           <tr>
               <th><label for="to_phone_mobi">휴대폰</label></th>
               <td><a:phone id="phonebox_phone_mobi" name="to_phone_mobi" type="phone_mobi" value="${showData.to_phone_mobi }" required="required" /></td>
           </tr>
           <tr>
               <th><label for="to_phone_home">일반전화</label></th>
               <td><a:phone id="phonebox_phone_home" name="to_phone_home" type="phone" value="${showData.to_phone_home }" required="required" /></td>
           </tr>
           <tr>
               <th><label for="to_zipcode">우편번호</label></th>
               <td><input type="text" id="textbox_zipcode_home" class="zipcode_home" name="to_zipcode" maxlength="7" data-rule="zipcode" data-tonew="#textbox_address_home_new" value="${showData.to_zipcode }" title="거주하는 곳의 우편번호를 선택하세요. (클릭)"/></td>
           </tr>
           <tr>
               <th><label for="to_address">주소</label></th>
               <td><input type="text" id="textbox_address_home_new" class="address_home_new" name="to_address" maxlength="100" title="우편번호 선택 시 자동으로 입력 됩니다. (클릭)" value="${showData.to_address }"/>
               </td>
           </tr>
           </tbody>
       </table>
    </div>
    <div class="purtial-info right">
       <h1>주문자 정보</h1>
       <table class="board-edit order">
           <tbody class="row-scope">
           <tr>
               <th><label for="pay_user_name">이름 </label></th>
               <td><input type="text" class="pay_user_name" name="pay_user_name" value="${showData.pay_user_name }"/></td>
           </tr>
           <tr>
               <th><label for="pay_phone">전화번호</label></th>
               <td><a:phone id="phonebox_phone_home" name="pay_phone" type="phone" value="${showData.pay_phone }" required="required"/></td>
           </tr>
           <tr>
               <th><label for="pay_email">이메일</label></th>
               <td><a:email id="emailbox_email" name="pay_mail" value="${showData.pay_mail }"/></td>
           </tr>
           </tbody>
       </table>
   </div>
</div>
       <input type="hidden" name="id" value="${id }"/>
       <input type="hidden" name="payment_update"/>
<button type="submit" class="artn-button board"><s:if test="showIsNull">작성</s:if><s:else>수정</s:else> 완료</button>
</form>
</div>
</a:html>