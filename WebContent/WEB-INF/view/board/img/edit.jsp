<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : List" contents="${boardInfo.contentsCode }">
	<div class="header">
		<h1>${boardInfo.name }</h1>
		<div id="breadcrumbs" data-sub="${boardInfo.contentsCode }"></div>
	</div>
	<div class="section">
		<div class="article">				
			<form action="modify" method="post" enctype="multipart/form-data">
				<input type="hidden" name="contents_menu" value="${param.contents}"/>
				<fieldset>
					<table class="board-edit">
						<thead>
						
							<!-- <tr>									
								<th><label for="textbox_id">작성자</label></th>
								<s:if test="(showIsNull || hasLogin)">
									<td>
										<input type="hidden" id="textbox_name_user" name="user_name" value="${user.name }"/>
										<input type="hidden" id="textbox_id" maxlength="16" name="id_user" required="required" data-minlen="5" data-rule="id" data-url="/user/show?json=true" value="${user.id }" title="영문, 숫자로 16자 이내로 입력 하세요. (작성 후 포커스 이동 시 ID 사용 가능 여부 자동 확인함)" />
										${user.name}(${user.id})
									</td>
								</s:if>
								<s:else >
									<td><input type="text" id="textbox_id" value="${showData.id }" disabled="disabled"/><input type="hidden" name="id_user" value="${user.id }" /></td>
								</s:else>
							</tr> -->
								<tr>
									<th scope="row">아이디</th>
									<s:if test="(showIsNull || hasLogin)">
									<td>
										<input type="hidden" id="textbox_user_name" name="user_name" value="${user.name }"/>
										<input type="hidden" id="textbox_id_user" maxlength="16" name="id_user" required="required" data-minlen="5" data-rule="id" data-url="/user/show?json=true" value="${user.id }" title="영문, 숫자로 16자 이내로 입력 하세요. (작성 후 포커스 이동 시 ID 사용 가능 여부 자동 확인함)" />
										${user.name }(${user.id})
									</td>
									</s:if>
									<s:else >
									<td><!-- <input type="text" id="textbox_id" value="${showData.id }" disabled="disabled"/><input type="hidden" name="id_user" value="${user.id }" /> --></td></s:else>			
								</tr>
							<tr>
								<th scope="row" class="subject">제목</th>
								<td><input type="text" id="textbox_subject" name="subject" required="required" title="제목을 입력하세요" value="${showData.subject}"/><br/></td>									
							</tr>
						</thead>
						<tbody>
							
							<tr>								
								<td colspan="2"><textarea id="textbox_contents" editor="webnote" name="contents">${showData.contents}</textarea></td>
							</tr>
						
						</tbody>
					</table>
					<%--숨김 필드 모음--%>
					
					<s:if test="showIsNull">
					<input type="hidden" name="board_no" value="${params.board_no }"/>
					</s:if>
					
					<s:else>
						<input type="hidden" name="board_no" value="${showData.board_no }"/>
						<input type="hidden" name="id" value="${showData.id}"/>
						<s:if test="hasRe == false">
							<input type="hidden" name="depth" value="${showData.depth}"/>
							<input type="hidden" name="view_count" value="${showData.view_count}"/>
						</s:if>
					</s:else>
					
					<s:if test="hasRe">
						<input type="hidden" name="re" value="${param.re}"/>
						<input type="hidden" name="depth" value="${param.depth}"/>
					</s:if>
					
					<input type="hidden" name="view" value="${param.view}"/>
				
				</fieldset>
				
				<div class="footer board">
					<%-- <span class="artn-button board"><a:file name="file_img" value="${showData.file_img}" path="/upload/board/img/"/></span> --%>
					<div class="buttons">						
						<a href="list?board_no=${param.board_no }&view=${param.view}&amp;contents=${param.contents}" class="artn-button board">목록</a>
						<button type="submit" class="artn-button board"><s:if test="showIsNull || hasRe">작성</s:if><s:else>수정</s:else> 완료</button>						
					</div>
				</div>
			</form>
		
		</div>
	</div>	
</a:html>