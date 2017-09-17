<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : Information" contents="sub100">
<div class="article">
<h1>접속자 정보</h1>

<dl>
<dt>ID</dt><dd>${user.id }</dd>
<dt>이름</dt><dd>${user.name }</dd>
<s:if test="userEdit(5)"><dt>대화명</dt><dd>${user.nick }</dd></s:if>
<s:if test="userEdit(6)"><dt>이메일</dt><dd>${user.email }</dd></s:if>
<s:if test="userEdit(7)"><dt>집전화</dt><dd>${user.phoneHome }</dd></s:if>
<s:if test="userEdit(8)"><dt>휴대폰</dt><dd>${user.phoneMobi }</dd></s:if>
<s:if test="userEdit(9)"><dt>생년월일</dt><dd>${user.dateBirth }</dd></s:if>
<dt>가입일자</dt><dd>${user.dateJoin }</dd>
<dt>접속IP</dt><dd>${user.ip }</dd>
<dt>관리자여부</dt><dd><s:property value="auth.isAuthByName('Admin')"/></dd>
</dl>
<a href="edit?id=${user.id }">개인정보 수정</a>
</div>
</a:html>