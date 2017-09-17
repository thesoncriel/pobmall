<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 사용자 정보" contents="${contentsCode }">
<div class="header">
    <h1>사용자 정보</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="auto"></div>
</div>
<div class="section">
<div class="article">


<table class="board-edit groupuser style2">
<thead>

<tr>
<th>ID</th>
<td>${showData.id_user }</td></tr>

<tr>
<th>성명</th>
<td>${showData.user_name }</td></tr>

<tr>
<th>병원명</th>
<td>${showData.group_name }</td></tr>

<tr>
<th>병원권한</th>
<td>${showData.auth_group_kor }</td></tr>

<tr>
<th>가입일자</th>
<td>${showData.date_join }</td></tr>

</thead>
</table>

<div class="footer board">
  	<div class="buttons">
		<s:if test='%{auth.isGroupAdmin(id) }'>
		<a href="edit?id=${showData.id }" class="artn-button board">수정</a>
		</s:if>
		 <s:if test='%{auth.isGroupAdmin || (showData.id_user == #session.user.id)}'>
		<a href="/groupuser/delete?id=${showData.id }" class="artn-button board">그룹 탈퇴</a>
		</s:if>
		<s:if test="auth.isAdmin"><a href="list" class="artn-button board">목록</a></s:if>
	</div>
</div>
                                
                                
</div>
</div>
</a:html>