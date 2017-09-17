<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : List">
<div class="header">
    <h1>비밀번호 확인</h1>
    <div id="breadcrumbs" data-sub="*비밀번호 확인"></div>
</div>
<div class="contents">
	<div style="text-align: center;">
        <form action="edit" method="post" class="validator user-password">
	        <input type="hidden" name="contents" value="${param.contents }"/>
	        <div class="body">
	            <div class="inner">
	                <div class="user-update">회원정보 수정</div>
	                <p>외부로부터 회원님의 정보를 안전하게 보호하기 <br/>위해
	                패스워드를 한번 더 확인합니다.</p>
	                <hr/>
	                <div class="footer">
		                <div>회원아이디</div> ${user.id }<br/>
	                    <div><label for="userpassword">패스워드</label></div> <input type="password" id="userpassword" name="pw"/>
	                    <s:actionerror/>
	                    <input type="hidden" name="id" value="${param.id }" />
	                    <input type="hidden" name="pw_checked" value="true" />
	                    <button type="submit" class="artn-button">확인</button>              
	                </div>
	            </div>
	        </div>
	    </form> 
	</div>
</div>

</a:html>