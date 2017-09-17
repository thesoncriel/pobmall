<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - Group Action Test : Edit" contents="${contentsCode }">
<div class="header">
<s:if test="showIsNull">
	<h1>팝업 등록</h1>
	<div id="breadcrumbs" data-sub="*팝업 등록"></div>
</s:if>
<s:else>
	<h1>팝업 수정</h1>
	<div id="breadcrumbs" data-sub="*팝업 수정"></div>
</s:else>
</div>
<div class="article popup">
<form action="modify" method="post" enctype="multipart/form-data" class="validator">
<fieldset>


<%-- 팝업 정보 [시작] /////////////////////////////////////////////////////////////////////////////// --%>
<table class="board-edit">
<tbody class="row-scope">
<tr>
	<th><label for="id_user">아이디</label></th>
	<td>
		<s:if test="showIsNull">
			${user.name }(${user.id })
			<input type="hidden" name="id_user" value="${user.id }"/>
			<input type="hidden" name="user_name" value="${user.name }"/>
			<input type="hidden" name="id_updater" value="${user.id }"/>
			<input type="hidden" name="updater_name" value="${user.name }"/>
		</s:if>
		<s:else>
			<input type="hidden" name="id_user" value="${showData.id_user }"/>
			<input type="hidden" name="user_name" value="${showData.user_name }"/>
			<input type="hidden" name="id_updater" value="${user.id }"/>
			<input type="hidden" name="updater_name" value="${user.name }"/>
			${showData.user_name }(${showData.id_user })
		</s:else>
	</td>
	 
</tr>
<tr>
	<th><label for="file_popup_zone">팝업존 이미지</label></th>
	<td>
		<a:img cssClass="file_popup_zone" src="/download?path=/upload/popup/popup_zone/&fileName=${showData.file_popup_zone }" alt="팝업 이미지" srcNone="/img/none.png" altNone="팝업 이미지 없음" /><br/>
		<a:file id="ajaxupload_file_popup_zone" name="file_popup_zone" path="/upload/popup/" value="${showData.file_popup_zone }" thumbWidth="200" thumbHeight="150" />
    </td>
</tr>
<tr>
<th><label for="title">제목</label></th>
<td><input type="text" name="title" value="${showData.title }" required="required" title="제목을 입력하세요."/></td></tr>

<tr>
	<th><label for="popup_seq">순서</label></th>
	<td><a:selectbox name="popup_seq" value="${showData.popup_seq }" min="0" max="10" /></td>
</tr>

<tr>
	<th><label for="goto_url">팝업존 이동 경로</label></th>
	<td><input type="text" name="goto_url" value="${showData.goto_url }"/></td>
</tr>

<tr>
	<th><label for=date_start>게시 일시</label></th>
	<td>
	    <input type="text" id="datepicker_date_start" name="date_start" value="${showData.date_start_fmt }"/> ~ <input type="text" id="datepicker_date_end" name="date_end" value="${showData.date_end_fmt }"/>
	</td>
</tr>

<tr>
	<th><label>가로 사이즈</label></th>
	<td><input type="text" name="width" value="${showData.width }"/><button type="button" id="size_controller">버튼</button></td>
</tr>
<tr>
	<th><label>세로 사이즈</label></th>
	<td><input type="text" name="height" value="${showData.height }"/></td>
</tr>
<tr>
	<th><label>가로 위치</label></th>
	<td><input type="text" name="location_x" value="${showData.location_x }"/></td>
</tr>
<tr>
	<th><label>세로 위치</label></th>
	<td><input type="text" name="location_y" value="${showData.location_y }"/></td>
</tr>

<tr>
	<th><label>옵션</label></th>
	<td>
		<a:checkboxlist name="popup_opt" value="${showData.popup_opt }" list="팝업 사용여부, 새창 사용여부, 제목줄 표시여부(새창이 아닐때만 적용), 모달 사용여부, 팝업존 게시여부" wrap="ul" subWrap="li" />
	</td>
</tr>

<tr>
	<th><label>외부팝업</label></th>
	<td>
		<a:checkboxlist name="popup_opt" value="${showData.popup_opt }" offset="8" list="사용" />
		<input type="text" name="outer_popup_url" value="${showData.outer_popup_url }"/>
	</td>
</tr>
<tr>
	<th><label>그만보기 설정</label><br/>
		
	</th>
	<td>
		<span class="checkboxlist"><input type="radio" name="popup_opt" id="popup_opt0" value="0"/><label for="popup_opt0">사용안함</label></span>
		<a:checkboxlist name="popup_opt" value="${showData.popup_opt }" offset="12" list="오늘 하루동안, 세션 기간동안" type="radio" />
	</td>
</tr>
<tr>
	<th><label for="popup_content">팝업 내부 컨텐츠</label></th>
	<td><textarea editor="webnote" name="popup_content">${showData.popup_content }</textarea></td>
</tr>

</tbody>
</table>
<%-- 팝업 정보 [종료] /////////////////////////////////////////////////////////////////////////////// --%>
<div id="dialog_popup_example" data-width="${showData.width }" data-height="${showData.height }" title="${showData.title }" data-position-x="${showData.location_x }" data-position-y="${showData.location_y }">
	<div></div>	
	<input id="example" name="checkbox" type="checkbox"/>
    <label id="label_example" for="example">
       	<span>열지않기 옵션 위치</span>
    </label>
</div>
<%--숨김 필드 모음--%>
<input type="hidden" name="contents" value="${contentsCode }"/>
<s:if test="showIsNull == false">
<input type="hidden" name="id" value="${showData.id }"/>
<input type="hidden" name="id_group" value="${showData.id_group }"/>
<input type="hidden" name="date_upload" value="${showData.date_upload }"/>
</s:if>
<s:else>
<input type="hidden" name="id_group" value="${param.id_group }"/>
</s:else>

</fieldset>
<button type="submit" class="artn-button board"><s:if test="showIsNull">작성</s:if><s:else>수정</s:else> 완료</button>
<a href="list?id_group=${showData.id_group }&contents=${contentsCode }" class="artn-button board">목록</a>
</form>

</div>
</a:html>