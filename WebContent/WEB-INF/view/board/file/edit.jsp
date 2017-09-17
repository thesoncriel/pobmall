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
									<td colspan="2"><textarea id="textbox_contents" style="height:300px; width:99%" editor="webnote" name="contents">${showData.contents}</textarea></td>
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
						<table id="fileAttachCtrl">
							<thead>
								<tr>
									<td colspan="2">
									<%-- <span id="label_fileSize"><span class="current"></span> / <span class="max"></span>MBytes</span>--%>
									<span>파일 업로더</span> 
									<div class="file-attach-controller">
										<button type="button" class="select-all">전체선택</button>
										<button type="button" class="select-none">선택해제</button>
										<button type="button" class="del-file">선택삭제</button>
										<span class="file-attach-buttons"></span>
									</div>
									<%--<button type="button" class="add-file">업로드추가</button> --%>
									</td></tr>
							</thead>
							<tbody>
								<tr>
									<th>올려질 파일</th>
									<td>
										<ul id="list_attachFilesClient"></ul>
									</td>
								</tr>
								<tr>
									<th>업로드 된 파일</th>
									<td>
										<ul id="list_attachFilesServer">
										<s:iterator value="subData.fileList">
											<li>${ori_name } [<a href="/download?path=upload/board/name/&fileName=${file_name }&oriName=${ori_name }">다운</a>] [<a href="/board/attachDelete.action?id=${id }&seq=${seq }" class="delete-attach">삭제</a>]</li>
										</s:iterator>
										</ul>
									</td>
								</tr>
							</tbody>
							<tfoot>
								<tr><td colspan="2">※ 파일용량 제한은 100MB 입니다.</td></tr>
							</tfoot>
							
						</table>
						<%--
						<span class="artn-button board"><a:file name="file_name" value="${showData.file_name1}" path="/upload/board/name/" id="file_board1"/></span><input type="hidden" name="seq" value="${showData.seq1}">
						<span class="artn-button board"><a:file name="file_name" value="${showData.file_name2}" path="/upload/board/name/" id="file_board2"/></span><input type="hidden" name="seq" value="${showData.seq2}">
						<span class="artn-button board"><a:file name="file_name" value="${showData.file_name3}" path="/upload/board/name/" id="file_board3"/></span><input type="hidden" name="seq" value="${showData.seq3}">
						 --%>
						<div class="buttons">
							<button class="artn-button board" type="submit"><s:if test="showIsNull || hasRe">작성</s:if><s:else>수정</s:else> 완료</button>
					<a href="list?board_no=${param.board_no }&view=${param.view}&amp;contents=${param.contents}" class="artn-button board">목록</a>
						</div>
					</div>
					
				</form>
			</div>
		</div>	
</a:html>