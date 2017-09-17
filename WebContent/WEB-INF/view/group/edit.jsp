<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 병원 관리" contents="${contentsCode }">
<div class="header">
    <h1>병원 <s:if test="showIsNull">등록</s:if><s:else>수정</s:else></h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="auto"></div>
</div>
<div class="section">
<div class="article">
<form action="modify" method="post" enctype="multipart/form-data" class="validator">
<fieldset>
<table class="board-edit style2">
<thead>

<tr>
<th><label for="file_img">사진</label></th>
<td><a:img src="/upload/group/img/${showData.file_img }" alt="그룹 사진" srcNone="/img/none.png" altNone="그룹 사진 없음 - 그룹 등록 후 적용 됩니다." width="100" height="100" /><br/>
<a:file id="file_img" name="file_img" value="${showData.file_img }"/></td></tr>

<tr>
<th><label for="file_img">배너</label></th>
<td><a:img src="/upload/group/banner/${showData.file_banner }" alt="그룹 배너" srcNone="/img/none.png" altNone="그룹 배너 없음 - 그룹 등록 후 적용 됩니다." width="100" height="100" /><br/>
<a:file id="file_banner" name="file_banner" value="${showData.file_banner }" path="/upload/group/"/></td></tr>

<tr>
<th><label for="textbox_name">그룹 이름</label></th>
<td><input type="text" id="textbox_name" maxlength="16" name="name" data-minlen="2" required="required" value="${showData.name }" title="그룹 이름을 입력 하세요." /></td></tr>

<s:if test="auth.isAdmin">
<tr>
<th><label for="user_name">관리자명</label></th>
<td><input type="text" id="autocomplete_user_name" data-url="/user/list?json=true" data-format="{name} ({date_birth}) :: {id}" data-field="#name,date_birth,@id:id_user" data-type="map" data-minlen="1" name="user_name" value="${showData.user_name }"/>
<input type="hidden" name="id_user" value="${showData.id_user}"/></td>
</tr>
</s:if>
<tr>
<th><label>그룹 형태</label></th>
<td><a:checkboxlist name="group_type" list="서비스,판매점,의료기관,펜션,카페,가입시 승인 필요" value="${showData.group_type }" /> </td></tr>

<tr>
<th><label for="phone_group1">연락처</label></th>
<td><a:phone id="phonebox_phone_group" name="phone_group" value="${showData.phone_group }"/></td></tr>

<tr>
<th><label for="phone_fax1">팩스번호</label></th>
<td><a:phone id="phonebox_phone_fax" name="phone_fax" value="${showData.phone_fax }"/></td></tr>

<tr>
<th><label for="textbox_homepage">홈페이지</label></th>
<td><input type="text" id="textbox_homepage" name="homepage" value="${showData.homepage }" title="홈페이지 주소를 입력 하세요." /></td></tr>

<tr>
<th><label for="datepicker_date_estab">설립일</label></th>
<td><input type="text" id="datepicker_date_estab" name="date_estab" value="${showData.date_estab }" data-year="1950" title="회사 설립일 입력 하세요. (클릭)" /></td></tr>

<tr>
<th><label for="textbox_map_coord">지도 좌표값</label></th>
<td><input type="text" id="textbox_map_coord" class="map-coord" name="map_coord" value="${showData.map_coord }" title="그룹 위치를 지도에 표시하기 위한 좌표값을 넣어주세요." />
<input type="button" name="map_button" value="좌표찾기" data-rule="coordinate" data-to="#textbox_map_coord"/>
</td></tr>

<tr>
<th><label for="textbox_zipcode_group">우편번호</label></th>
<td><input type="text" id="textbox_zipcode_group" class="zipcode" name="zipcode_group" maxlength="7" data-rule="zipcode" data-to="#textbox_address_group1" data-tonew="#textbox_address_group_new" value="${showData.zipcode_group }" title="그룹이 위치하는 곳의 우편번호를 선택하세요. (클릭)"/></td></tr>

<tr>
<th><label for="textbox_address_group2">주소</label></th>
<td>지&nbsp;&nbsp;&nbsp;번: <input type="text" id="textbox_address_group1" class="address" name="address_group1" value="${showData.address_group1 }" maxlength="100" title="우편번호 선택 시 자동으로 입력 됩니다. (클릭)"/><br/>
	도로명: <input type="text" id="textbox_address_group_new" class="address" name="address_group_new" value="${showData.address_group_new }" maxlength="100" title="새주소(도로명 주소)를 입력하세요. (클릭)"/><br/>
	상&nbsp;&nbsp;&nbsp;세: <input type="text" id="textbox_address_group2" class="address" name="address_group2" value="${showData.address_group2 }" maxlength="100" title="상세 주소를 입력 하세요."/></td></tr>
	
<tr>
<th><label for="textbox_introduce">소개글</label></th>
<td><textarea id="textbox_introduce" editor="webnote" name="introduce">${showData.introduce }</textarea></td></tr>

</thead>
</table>
<%--숨김 필드 모음--%>
<s:if test="showIsNull == false">
<input type="hidden" name="id" value="${showData.id }"/>
<input type="hidden" name="date_create" value="${showData.date_create }"/>
</s:if>

</fieldset>


<div class="footer board">
	<div class="buttons">
			<button type="submit" class="artn-button board"><s:if test="showIsNull">작성</s:if><s:else>수정</s:else> 완료</button>
	</div>
</div>
</form>
</div>
</div>

</a:html>