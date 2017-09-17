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
		<table class="board-edit user style2">
		<thead>
		<s:if test="userEdit(1)"><tr>
		<th>사진</th>
		<td><a:img cssClass="file_img3" src="/download?path=/upload/user/thumnail/&fileName=${showData.file_img }" alt="회원 사진" srcNone="/img/none.png" altNone="회원 사진 없음 - 사진 등록 후 적용 됩니다." width="100" height="150" />
		</td></tr></s:if>
		
		<s:if test="userEdit(2)"><tr>
		<th>아이디</th>
		<td>${showData.id }</td></tr></s:if>
		
		<s:if test="userEdit(3)"><tr>
		<th>이름</th>
		<td>${showData.name }</td></tr></s:if>
		
		<s:if test="userEdit(5)"><tr>
		<th>대화명</th>
		<td>${showData.nick }</td></tr></s:if>
		
		<s:if test="userEdit(6)"><tr>
		<th>이메일</th>
		<td>${showData.email }</td></tr></s:if>
		
		<s:if test="userEdit(7)"><tr>
		<th>전화번호</th>
		<td>${showData.phone_home }</td></tr></s:if>
		
		<s:if test="userEdit(8)"><tr>
		<th>휴대폰번호</th>
		<td>${showData.phone_mobi }</td></tr></s:if>
		
		<s:if test="userEdit(9)"><tr>
		<th>생년월일</th>
		<td>${showData.date_birth }</td></tr></s:if>
		
		<s:if test="userEdit(10)"><tr>
		<th>성별</th>
		<td>${showData.gender_kor }</td></tr></s:if>
		
		<s:if test="userEdit(11)"><tr>
		<th>사용자권한</th>
		<td>${showData.auth_user_kor }</td></tr></s:if>
		
		<s:if test="userEdit(12)"><tr>
		<th>우편번호</th>
		<td>${showData.zipcode_home }</td></tr></s:if>
		
		<s:if test="userEdit(13)"><tr>
		<th>주소</th>
		<td>
		지번주소: ${showData.address_home1 }<br/>
		새주소: ${showData.address_home_new }<br/>
		상세: ${showData.address_home2 }</td></tr></s:if>
		
		<s:if test="userEdit(14)"><tr>
		<th>추가 정보</th>
		<td><a:valuelist list="옵션1,옵션2,옵션3,옵션4,옵션5" value="${showData.opt }"/></td></tr></s:if>
		
		<s:if test="userEdit(16)"><tr>
		<th>소개글</th>
		<td>${showData.introduce }</td></tr></s:if>
		
		</thead>
		</table>
	       <div class="footer board">
               <div class="buttons">
					<a href="leave?id=${showData.id }" class="artn-button board">회원탈퇴</a> 
					<a href="edit.action?id=${showData.id }&contents=${contentsCode }" class="artn-button board">수정</a>              
					<s:if test='%{(#parameters.from == null) && (auth.isAdmin) }'>
					<a href="list?contents=adm1000_1" class="artn-button board">목록</a>
					</s:if>
					<s:else>
					<a href="${header['referer'] }" class="artn-button board">목록</a>
					</s:else>
               </div>	
           </div>
	   </div>
	</div>
</a:html>