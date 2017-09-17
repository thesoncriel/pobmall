<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : List" contents="${contentsCode }">
	<div class="header">
		<h1>게시판 관리</h1>
		<div id="breadcrumbs" data-sub="${contentsCode }" data-target="auto"></div>
	</div>
	<div class="section">
		<div class="article">			
			<form action="modify" method="post">
			<input type="hidden" value="${contentsCode }" name="contents"/>							
				<table class="board-manager">
					<thead>					
						<tr>
							<th	class="no">번호</th>
							<th>이름</th>
							<th class="view">형태</th>
							<th class="contents-code">코드</th>
							<th class="auth-list">권한: 목록</th>
							<th class="auth-show">권한: 보기</th>
							<th class="auth-modify">권한: 수정</th>
							<th class="auth-delete">권한: 삭제</th>
							<th class="row-limit last">페이징</th>
						</tr>
						<tr>
							
						</tr>
					</thead>
					<tbody>
						<s:iterator value="boardManager.list">
						<tr>
							<td class="no">${boardNo }<input type="hidden" name="boardNo" value="${boardNo }"/></td>
							<td><input name="name" type="text" value="${name }"/></td>
							<td><s:select name="view" list="#{'normal':'일반 게시판', 'file':'자료 게시판', 'img':'사진 게시판' ,'notice':'공지사항', 'guest':'익명' }" theme="simple" value="view"></s:select></td>  
							<td><input name="contentsCode" type="text" value="${contentsCode }"/></td>
							<td><s:select id="selectbox_authList" name="authList" value="authList" list="subData.userAuthList" listKey="auth_user" listValue="auth_user_kor" theme="simple" /></td>
							<td><s:select id="selectbox_authShow" name="authShow" value="authShow" list="subData.userAuthList" listKey="auth_user" listValue="auth_user_kor" theme="simple" /></td>
							<td><s:select id="selectbox_authModify" name="authModify" value="authModify" list="subData.userAuthList" listKey="auth_user" listValue="auth_user_kor" theme="simple" /></td>
							<td><s:select id="selectbox_authDelete" name="authDelete" value="authDelete" list="subData.userAuthList" listKey="auth_user" listValue="auth_user_kor" theme="simple" /></td> 
							<td><a:selectbox name="rowLimit" id="selectbox_rowLimit" min="10" max="30" step="5" value="${rowLimit }"/></td>
						</tr>
						</s:iterator>
					</tbody>	
				</table>
				
				<div class="footer board">
					<div class="buttons">
						<button type="button" id="button_boardManager_addRow" class="artn-button board">추가</button>
						<button type="submit" id="button_boardManager_modify" class="artn-button board">수정</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</a:html>