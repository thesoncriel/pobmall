<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : List" contents="sub1000">
	<div class="header">
		<h1>사이트 관리자</h1>
		<div id="breadcrumbs" data-sub="*관리자 메뉴"></div>
	</div>
	<div class="section">
		<div class="article">			
			<table>
				<tr>
					<th>현재 접속자</th>
					<td>${loginManager.userCount }
				</tr>
			</table>
		</div>
	</div>
</a:html>