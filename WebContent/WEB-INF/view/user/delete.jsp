<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : List" contents="${contentsCode }">
<div class="header">
	<h1>사용자 <s:if test="showIsNull">등록</s:if><s:else>수정</s:else></h1>
	    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="auto"></div>
	</div>

<div class="section">
<div class="article">
	<div class="user-leave">
		<h2>아래 회원탈퇴 버튼을 눌러야 회원탈퇴 처리 됩니다.<br/>
		    회원탈퇴 후 재가입 시 기존에 사용하신 아이디는 사용 불가능합니다.<br/>
		    그동안 이용해 주셔서 감사합니다.</h2>
		<p>회원탈퇴 사유를 알려주시면 보다 나은 서비스를 위해 소중한 정보로 활용하겠습니다.</p>
		<form action="delete" method="post">		
			<input name="id" type="hidden" value="${params.id }"/>
			<table class="board-edit style3">
				<tbody class="row-scope">
					<tr>
						<th>탈퇴사유</th>
						<td>
							<dl>
								<dd><input type="radio" name="delete_comment" checked="checked" value="제품 품질 불만족"/>제품 품질 불만족</dd>
								<dd><input type="radio" name="delete_comment" value="쇼핑몰 서비스 불만족"/>쇼핑몰 서비스 불만족</dd>
								<dd><input type="radio" name="delete_comment" value="원하는 상품이 없습니다."/>원하는 상품이 없습니다.</dd>
								<dd><input type="radio" name="delete_comment" value="단순 변심"/>단순 변심</dd>
								<dd><input type="radio" name="delete_comment" value="접속 불량"/>접속 불량</dd>
								<dd><input type="radio" name="delete_comment" value="기타"/>기타</dd>							
							</dl>
						</td>
					</tr>
					<tr>
						<th>기타 사유</th>
						<td><textarea name="delete_comment_sub"></textarea> </td>
					</tr>
				</tbody>			
			</table>
			<button class="artn-button board">회원탈퇴</button>
		</form>
	</div>
</div>
</div>
</a:html>