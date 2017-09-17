<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 로그인" contents="sub900">
<script>
$(document).ready(function(){
	var jqMsg = $("input[name='msg']");
	if(jqMsg.val().length > 0){
		alert(jqMsg.val());
	}
})
</script>
<div class="header">
	<h1>로그인</h1>
    <div id="breadcrumbs" data-sub="*로그인"></div>
</div>
<div class="contents">  
	<input type="hidden" name="msg" value="${params.msg }"/>
	    <!-- <h2 class="logo">MediFit - 개인 맞춤형 운동처방 시스템</h2> -->
	<div style="text-align: center;">
		<form action="/user/login" method="post" class="artn-login">
		<div class="body">
			<div class="inner">
				<ul>
				    <li><input type="text" name="id" data-rule="id" maxlength="16" id="textbox_id" placeholder="아이디를 입력하세요" value="${loginId }" /></li>
				    <li><input type="password" name="pw" maxlength="16" id="textbox_pw" placeholder="비밀번호를 입력하세요"/></li>
				</ul>
		     	<button type="submit" class="artn-button login">로그인</button>
			</div>
			
			<div class="footer">
				
				<div class="inner">
					
					<div class="options">
						<span><input type="checkbox" id="id_save" name="id_save"><label for="id_save">아이디 저장</label></span>&nbsp;&nbsp;&nbsp;  
					    <span><a href="/user/find" target="_blank">아이디</a>/<a href="/user/find" target="_blank">비밀번호 찾기</a></span>
				    </div>
					<hr/>
					<s:if test="error.login != ''"><div class="error"><span class="artn-icon-32 alert"></span>${error.login }</div></s:if>
					<%--<table>
					<tr>
						<td><span class="artn-icon-32 alert"></span></td>
						<td>아싸라삐용 ^^)/</td>
					</tr>
					</table> --%>
					<a id="" href="/join" class="artn-button board">회원 가입하기</a>
				</div>                         
			</div>
		</div>
		<div style="height: 5px; display: inline-block;"></div>
	</form>	
		<s:if test="params.cart == 'true'">	
			<form action="/product/cart/login" method="post" class="artn-login cartbody">
				<div class="body">
					<div class="inner cart-inner">
						<input type="hidden" name="guest_name" value="guest"/>
				        <div class="cart-guest">비회원으로 구매하시겠습니까?</div>
				        <button type="submit" class="artn-button login">비회원 구매</button>
					</div>
				</div>
			</form>
		</s:if>
	</div>	
	
	<s:if test='%{params.myposts == "true"}'>
		<form action="/product/board/myposts" method="post" class="artn-login guest-body validator">
				<div class="body">
					<div class="inner guest-list">
						<div class="guest-pay">비회원 로그인</div>
						<hr/>
						<div>
							<label>이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름 : </label><input type="text" name="pay_user_name" required="required"/>
						</div>
						<div>
							<label>전화번호 : </label><a:phone name="pay_phone" type="phone_mobi" required="required"/>
						</div>
							<div class="footer">
				                <div class="buttons">
				                    <button type="submit" class="artn-button board">확인</button>
				                </div>  
			                </div>
							</div>
				</div>
		</form>
	</s:if>
	
	<s:if test='%{params.Guest == "Guest"}'>
        <form action="list" method="post" class="artn-login guest-body validator">
                <div class="body">
                    <div class="inner guest-list">
                        <input type="hidden" name="contents" value="sub6_1"/>
                        <input type="hidden" name="Guest" value="${params.Guest }"/>
                        <div class="guest-pay">비회원 구매리스트</div>
                        <hr/>
                        <div>
                            <label>이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름 : </label><input type="text" name="pay_user_name" required="required"/>
                        </div>
                        <div>
                            <label>전화번호 : </label><a:phone name="pay_phone" type="phone_mobi" required="required"/>
                        </div>
                            <div class="footer">
                                <div class="buttons">
                                    <button type="submit" class="artn-button board">확인</button>
                                </div>  
                            </div>
                            </div>
                </div>
        </form>
    </s:if>
</div>

</a:html>