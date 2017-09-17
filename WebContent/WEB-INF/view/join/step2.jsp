<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 회원가입" contents="sub901_2">
   <div class="header">
	<h1>회원 가입 - 회원정보 입력</h1>
  		<div id="breadcrumbs" data-sub="*회원가입,회원정보 입력"></div>
</div>
   <div class="section">
	<div class="article member-join step2">
		<div class="hgroup artn-bg-64 step3">
		    <h2>1. 약관동의</h2>  
		    <h2 class="selected">2. 회원정보 입력</h2>
		    <h2>3. 가입완료</h2>
		</div>
		<br/>
		<strong>* 은 필수 입니다.</strong>
		<form id="joinForm" action="join" method="post" enctype="multipart/form-data" class="validator">
			<fieldset>
			<table class="board-edit">
			<thead>
			
			<s:if test="userEdit(1)">
			<tr>
			<th><label for="file_img">사진</label></th>
			<td><a:img src="/upload/user/img/${showData.file_img }" alt="회원 사진" srcNone="/img/none.png" altNone="회원 사진 없음 - 회원 등록 후 적용 됩니다." width="100" height="100" /><br/>
			<a:file id="file_img" name="file_img" value="${showData.file_img }"/></td></tr></s:if>
			
			<s:if test="userEdit(2)"><tr>
			<th><label for="textbox_id">* 아이디</label></th>
			<td><input type="text" id="textbox_id" maxlength="16" name="id" required="required" data-minlen="5" data-rule="id" data-url="/user/checkid" value="${showData.id }" title="영문, 숫자로 16자 이내로 입력 하세요. (작성 후 포커스 이동 시 ID 사용 가능 여부 자동 확인함)" /></td></tr></s:if>
			
			<s:if test="userEdit(3)"><tr>
			<th><label for="textbox_name">* 이름</label></th>
			<td><input type="text" id="textbox_name" maxlength="16" name="name" data-minlen="2" required="required" value="${showData.name }" title="한글로 성함을 입력 하세요." data-rule="kor" /></td></tr></s:if>
			
			<s:if test="userEdit(4)"><tr>
			<th><label for="textbox_pw">* 비밀번호</label></th>
			<td><input type="password" id="textbox_pw" maxlength="16" name="pw" data-minlen="6" required="required" title="비밀번호를 입력 하세요. (최소 6글자)" /><br/>
				<input type="password" id="textbox_pwre" maxlength="16" name="pwre" required="required" title="위의 내용과 똑같이 입력 하세요." /></td></tr></s:if>
			
			<s:if test="userEdit(5)"><tr>
			<th><label for="textbox_nick">대화명</label></th>
			<td><input type="text" id="textbox_nick" maxlength="16" data-minlen="3" name="nick" required="required" value="${showData.nick }" title="게시물 작성 시 쓰일 이름을 입력 하세요." /></td></tr></s:if>
			
			<s:if test="userEdit(6)"><tr>
			<th><label for="email1">이메일</label></th>
			<td><a:email id="emailbox_email" name="email" value="${showData.email }" required="required"/></td></tr></s:if>
			
			<s:if test="userEdit(7)"><tr>
			<th><label for="phone_home1">전화번호</label></th>
			<td><a:phone id="phonebox_phone_home" name="phone_home" value="${showData.phone_home }"/></td></tr></s:if>
			
			<s:if test="userEdit(8)"><tr>
			<th><label for="phone_mobi1">* 휴대폰번호</label></th>
			<td><a:phone id="phonebox_phone_mobi" name="phone_mobi" value="${showData.phone_mobi }" type="phone_mobi" required="required"/>
			<!-- <a class="artn-button board member_confirm" data-rule="confirmButton" data-dialog="#dialog">본인인증</a>클릭시 입력하신번호로 인증번호가 도착합니다
			<input type="hidden" name="confirm_ok" value=""/> -->
			</td></tr></s:if>
			
			<s:if test="userEdit(9)"><tr>
			<th><label for="datepicker_date_birth">생년월일</label></th>
			<td><input type="text" id="datepicker_date_birth" name="date_birth" required="required" value="${showData.date_birth }" data-year="1950" title="생년월일을 입력 하세요. (클릭)" /></td></tr></s:if>
			
			<s:if test="userEdit(10)"><tr>
			<th><label for="genderm">성별</label></th>
			<td><s:radio id="gender" name="gender" list="#{'m':'남자','w':'여자'}" value="showData.gender" theme="simple" /></td></tr></s:if>
			
			<s:if test="userEdit(11)"><tr>
			<th><label for="selectbox_auth_user_id">사용자권한</label></th>
			<td><s:select id="selectbox_auth_user_id" name="auth_user_id" list="subData.auth_list" listKey="id" listValue="auth_user_kor" value="showData.auth_user_id" theme="simple"/> </td></tr></s:if>
			
			<s:if test="userEdit(12)"><tr>
				<th><label for="textbox_zipcode_home">우편번호</label></th>
					<td>
						<input type="text" id="textbox_zipcode_home" name="zipcode_home" maxlength="7" data-rule="zipcode" data-to="#textbox_address_home1" data-tonew="#textbox_address_home_new" value="${showData.zipcode_home }" title="거주하는 곳의 우편번호를 선택하세요. (클릭)"/>
						<strong>※상세주소를 같이 입력해 주세요.</strong>
					</td>
				</tr>
			</s:if>
			
			<s:if test="userEdit(13)"><tr>
			<th><label for="textbox_address_home2">주소</label></th>
			<td>
				도로명: <input type="text" id="textbox_address_home_new" name="address_home_new" value="${showData.address_home_new }" maxlength="100" title="새주소(도로명 주소)를 입력하세요. (클릭)" required="required"/><br/>
			</td>
			</tr>
			</s:if>
				
			<s:if test="userEdit(14)"><tr>
			<th><label>추가 정보</label></th>
			<td><a:checkboxlist name="opt" list="옵션1,옵션2,옵션3,옵션4,옵션5" value="${showData.opt }" /> </td></tr></s:if>
			
			<s:if test="userEdit(15)"><tr>
			<th><label>회원 상태</label></th>
			<td><a:checkboxlist name="status_user" list="신청중,가입됨,이름 비공개,자기소개 비공개" value="${showData.status_user }" /> ※ 아무것도 체크되어 있지 않다면 익명 사용자</td></tr></s:if>
			
			<s:if test="userEdit(16)"><tr>
			<th><label for="textbox_introduce">소개글</label></th>
			<td><textarea id="textbox_introduce" name="introduce">${showData.introduce }</textarea></td></tr></s:if>
			
			</thead>
			</table>
			<%--숨김 필드 모음--%>
			<input type="hidden" name="step" value="modify"/>
			
			</fieldset>
			<div class="footer">
                <div class="buttons">
                    <button type="submit" id="step2" class="artn-button board"><s:if test="showIsNull">작성</s:if><s:else>수정</s:else> 완료</button>
                </div>  
               </div>
		</form>
	</div>
</div>
<div id="dialog" title="확인" data-width="200" data-height="196" data-modal="true">
 		<form action="memberConfirm" method="post">
		<p>인증번호를 확인 합니다.</p>
		<input type="memberConfirm" name="memberConfirm" value=""/>
		<span id="t_left_time"></span>
		<button class="close_dialog">확인</button>
		<!-- <button type="submit">확인</button> --><button id="reconfirm" type="button">재발송</button>
		<div class="message alert"></div>
		</form>
</div>
</a:html>