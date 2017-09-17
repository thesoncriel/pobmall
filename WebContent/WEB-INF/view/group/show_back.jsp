<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : List" contents="${contentsCode }">
<div class="header">
	<h1>그룹 정보</h1>
	    <div id="breadcrumbs" data-sub="*365plus,그룹 정보"></div>
	</div>
<div class="section">
<div class="article">


<table class="board-edit"> 
<thead>
<tr>
<th>사진</th>
<td><a:img src="/upload/group/img/${showData.file_img }" alt="그룹 사진" srcNone="/img/none.png" altNone="그룹 사진 없음 - 회원 등록 후 적용 됩니다." width="100" height="100" />
</td></tr>
<tr>
<th>배너</th>
<td><a:img src="/upload/group/banner/${showData.file_banner }" alt="그룹 배너" srcNone="/img/none.png" altNone="그룹 배너 없음 - 그룹 등록 후 적용 됩니다." width="100" height="35" />
</td></tr>

<tr>
<th>이름</th>
<td>${showData.name }</td></tr>

<tr>
<th>그룹 형태</th>
<td><a:valuelist list="서비스,판매점,의료기관,가입시 승인 필요" value="${showData.group_type }"/></td></tr>

<tr>
<th>연락처</th>
<td>${showData.phone_group }</td></tr>

<tr>
<th>팩스번호</th>
<td>${showData.phone_fax }</td></tr>

<tr>
<th>홈페이지</th>
<td>${showData.homepage }</td></tr>

<tr>
<th>설립일</th>
<td>${showData.date_estab }</td></tr>

<tr>
<th>위치 (지도)</th>
<td><iframe src="${showData.map_url}" width="660" height="435" scrolling="no" ></iframe></td></tr>

<tr>
<th>그룹 생성 일시</th>
<td>${showData.date_create }</td></tr>

<tr>
<th>주소</th>
<td>
우편번호: ${showData.zipcode_group}<br/>
지번주소: ${showData.address_group1 }<br/>
새주소: ${showData.address_group_new }<br/>
상세: ${showData.address_group2 }</td></tr>

<tr>
<th>소개글</th>
<td>${showData.introduce }</td></tr>

</thead>
</table>
<s:if test='%{auth.isGroupAdmin(id)}'><a href="edit?id=${showData.id }">수정</a></s:if>
<s:elseif test='%{auth.isGroupUser == false}'><a href="/groupuser/write?id_group=${showData.id }">가입</a></s:elseif>
 <s:if test='%{auth.isAdmin}'><a href="delete?id=${showData.id }">삭제</a></s:if> <a href="list">목록</a>
</div>
</div>

</a:html>