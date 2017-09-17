<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 병원 정보" contents="${contentsCode }">
<div class="header">
    <h1>병원 정보</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="auto"></div>
</div>
<div class="section">
<div class="article">
<h2><em>${showData.name}</em></h2>
                    <table class="board-show group style2">
                        <tbody>
                            <tr>
                                <th>설립일</th>
                                <td>${showData.date_estab} 설립</td>
                            </tr>
                            <tr>
                                <th>우편번호</th>
                                <td>${showData.zipcode_group}</td>
                            </tr>
                            <tr>
                                <th>주소</th>
                                <td>${showData.address_group1}<br/>
                                    ${showData.address_group2}</td>
                            </tr>
                            <tr>
                                <th>TEL</th>
                                <td>${showData.phone_group}</td>
                            </tr>
                            <tr>
                                <th>FAX</th>
                                <td>${showData.phone_fax}</td>
                            </tr>
                            <tr>
                                <th>업종</th>
                                <td><a:valuelist list="서비스,판매점,의료기관,가입시 승인 필요" value="${showData.group_type }"/></td>
                            </tr>
                            <tr>
                                <th>URL</th>
                                <td>${showData.homepage}</td>
                            </tr>
                        </tbody> 
                    </table>
                <a:img src="/upload/group/img/${showData.file_img}" alt="이미지" srcNone="/img/none.png" altNone="이미지 없음 - 이미지 등록 후 적용 됩니다." />
                <iframe class="effect frame" src="${showData.map_url}" width="660" height="435" scrolling="no" frameborder="0"></iframe>

<div class="footer board">
	<div class="buttons">
		<s:if test='%{auth.isGroupAdmin(id)}'><a href="edit?id=${showData.id }&contents=${contentsCode }" class="artn-button board">수정</a></s:if>
		<s:elseif test='%{(hasLogin == true) && (auth.isGroupUser(id) == false)}'><a href="/groupuser/write?id_group=${showData.id }" class="artn-button board">가입</a></s:elseif>
		<s:if test='%{auth.isAdmin}'><a href="delete?id=${showData.id }" class="artn-button board">삭제</a></s:if><a href="list?contents=${contentsCode }" class="artn-button board">목록</a>
	</div>
</div>
                
<!--<s:if test='%{auth.isGroupAdmin(id)}'><a href="edit?id=${showData.id }">수정</a></s:if>
<s:elseif test='%{auth.isGroupUser(id) == false}'><a href="/groupuser/write?id_group=${showData.id }">가입</a></s:elseif>
 <s:if test='%{auth.isAdmin}'><a href="delete?id=${showData.id }">삭제</a></s:if> <a href="list">목록</a>-->
 

</div>
</div>

</a:html>