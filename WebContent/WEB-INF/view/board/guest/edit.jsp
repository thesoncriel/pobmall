<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : List" contents="${param.contents }">
	<div class="header">
		<h1>${param.name }</h1>
		<div id="breadcrumbs" data-sub="${param.contents }"></div>
	</div>
	<div class="section">
		<div class="article">		
			
			<form action="modify" method="post" enctype="multipart/form-data" class="validator">
				<fieldset>
					<table class="board-edit">
						<thead>
						<%-- <s:if test="showIsNull"> --%>
						<s:if test=" hasLogin">
							<th scope="row">작성자</th>
							<td>
								<input type="hidden" id="textbox_user_name" name="user_name" value="${user.name }"/>
								<input type="hidden" id="textbox_id_user" name="id_user" value="${user.id }" />
								${user.name }(${user.id})
							</td>
						</s:if>
						
						<s:if test="hasLogin == false">
							<tr>
								<th scope="row">작성자</th>
								<%-- <s:if test="(showIsNull || hasLogin)">
								<td>${user.name }(${user.id})</td></s:if> --%>
								<%-- <s:else > --%>
								<td><input type="text" id="textbox_name" value="${showData.user_name }" name="user_name" required="required" /></td><%-- </s:else> --%>			
							</tr>
						</s:if>
						
				<%-- 		<s:else>
							<tr>
								<th scope="row">작성자</th>
								<s:if test="(showIsNull || hasLogin)">
								<td>${user.name }(${user.id})</td></s:if>
								<s:else >
								<td><input type="text" id="textbox_name" value="${showData.name }" name="user_name"/></td></s:else>			
							</tr>
						</s:else>
				 --%>		<%-- </s:if> --%>
				        <s:if test=" (auth.isAdmin == false) && ( (params.board_no == 4) || (params.board_no == 5) )">
				            <tr>        
                                <th scope="row" class="category">사유</th>
                                <td>            
                                    <select name="category"> 
                                        <option value="구매자변심">구매자 변심</option>
                                        <option value="상품하자">상품하자</option>
                                    </select>
                                    <s:if test="params.board_no == 4">
                                    <strong>※환불 받을 계좌 및 예금주를 작성해주세요.</strong>
                                    </s:if>      
                                </td>
                            </tr>
				        </s:if>
							<tr>
							<th scope="row" class="subject">제목</th>
							<td><input type="text" id="textbox_subject" name="subject" required="required" title="제목을 입력하세요" value="${showData.subject}"/></td></tr>
						<s:if test="hasLogin == false">
							<tr>
							<th scope="row" class="subject"><label for="textbox_password">비밀번호</label></th>
							<td><input type="password" id="textbox_password" name="password" required="required" title="비밀번호를 입력하세요" data-mixengnum="true" /></td></tr>
						</s:if>
						<s:else>
							<input type="hidden" name="password" value="${showData.password }"/>
						</s:else>	
						</thead>
						<tbody>
							<tr>
							<td colspan="2"><textarea id="textbox_contents" editor="webnote" name="contents">${showData.contents}</textarea></td></tr>
						</tbody>
					</table>
					<%--숨김 필드 모음--%>
					
					<s:if test="showIsNull">
					<input type="hidden" name="board_no" value="${params.board_no }"/>
					</s:if>
					<s:else>
					<input type="hidden" name="board_no" value="${showData.board_no }"/>
					<input type="hidden" name="id" value="${showData.id}"/>
					<s:if test="!hasRe">
					<input type="hidden" name="depth" value="${showData.depth}"/>
					</s:if>
					</s:else>
					<input type="hidden" name="contents_menu" value="${param.contents}"/>					
					<s:if test="hasRe">
						<input type="hidden" name="re" value="${param.re}"/>
						<input type="hidden" name="depth" value="${param.depth}"/>
					</s:if>
			
				</fieldset>
				<!--<a:file name="file_img" value="${showData.file_img }" path="/upload/board/img/"/>-->
				<div class="footer board">
					<div class="buttons edit">
					    <s:if test=" ( (params.board_no != 4) && (params.board_no != 5) ) || (auth.isAdmin)">
						<a href="list?board_no=${param.board_no }&amp;contents=${param.contents}" class="artn-button board">목록</a>
						</s:if>
						<button type="submit" class="artn-button board"><s:if test="showIsNull || hasRe">작성</s:if><s:else>수정</s:else>완료</button>
					</div>
				</div>
			</form>
		
		</div>
	</div>	
</a:html>