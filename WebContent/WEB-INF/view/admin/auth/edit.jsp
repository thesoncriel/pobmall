<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : List" contents="${param.contents }">
<div class="header">
	<h1>권한 수정</h1>
</div>
<div class="section">
<div class="article">
<form action="modify" method="post" enctype="multipart/form-data" class="validator">
<fieldset>
<table class="board-edit style2">
<tbody class="row-scope">
<tr>
<th>권한명칭</th>
<td><input type="text" name="auth_user_kor" value="${showData.auth_user_kor }"/>
	<input type="hidden" name="id" value="${showData.id }"/><input type="hidden" name="id_group" value="${showData.id_group }"/></td></tr>
<tr>
<th>권한코드 (비트 연산)</th>
<td><a:checkboxlist name="auth_user" list="01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28(사용자 정보 수정),29,30(관리자),31(최고관리자)" value="${showData.auth_user }" subWrap="div"/></td></tr>
<tr>
<th>메뉴 권한</th>
<td><a:checkboxlist name="restrict_menu" list="01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,20,21" value="${showData.restrict_menu }" subWrap="div"/></td></tr>
<tr>
<th>사용자 정보 수정 권한</th>
<td><a:checkboxlist name="restrict_user_edit" list="사용자 사진,아이디,이름,비밀번호,대화명,이메일,전화번호,휴대폰번호,생년월일,성별,회원 등급,우편번호,주소,추가 정보,회원 상태,소개글" value="${showData.restrict_user_edit }" subWrap="div"/></td></tr>
</tbody>
</table>
</fieldset>
<div class="footer board">
	<div class="buttons">
		<button type="submit" class="artn-button board">수정 완료</button>
		<a href="list" class="artn-button board">목록</a>
	</div>
</div>
</form>

</div>
</div>
</a:html>