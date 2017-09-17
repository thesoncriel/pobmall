<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : List" contents="${param.contents }">
	<div class="header">
	    <s:if test="showData.board_no == 3">
		    <h1>환불 문의</h1>
	        <div id="breadcrumbs" data-sub="${param.contents }"></div>
	    </s:if>
		<s:elseif test="showData.board_no == 4">
            <h1>교환 문의</h1>
            <div id="breadcrumbs" data-sub="${param.contents }"></div>
        </s:elseif>
	</div>
	<div class="section">
		<div class="article">		
			
			<form action="modify" method="post" enctype="multipart/form-data" class="validator">
				<fieldset>
					<table class="board-edit">
						<thead>
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
								
								<td><input type="hidden" id="textbox_user_name" name="user_name" value="${showData.pay_user_name }"/>
								    <input type="hidden" id="textbox_user_name" name="guest_phone" value="${showData.pay_phone }"/>
								    ${showData.pay_user_name }(Guest)
								</td>			
							</tr>
                            <tr>
                                <th scope="row">이메일</th>
                                <td><a:email id="emailbox_email" name="guest_mail" required="required"/></td>         
                            </tr>
						</s:if>
						<s:if test="auth.isAdmin == false">
				            <tr>        
                                <th scope="row" class="category">사유</th>
                                <td>            
                                    <select name="category"> 
                                        <option value="구매자변심">구매자 변심</option>
                                        <option value="상품하자">상품하자</option>
                                    </select>
                                    <s:if test="params.board_no == 3">
                                    <strong>※환불 받을 계좌 및 예금주를 작성해주세요.</strong>
                                    </s:if>      
                                </td>
                            </tr>
				        </s:if>
							<tr>
							<th scope="row" class="subject">제목</th>
							<td><input type="text" id="textbox_subject" name="subject" required="required" title="제목을 입력하세요" value="${showData.subject}"/></td></tr>
						</thead>
						<tbody>
							<tr>
							<td colspan="2"><textarea id="textbox_contents" editor="webnote" name="contents">${showData.contents}</textarea></td></tr>
						</tbody>
					</table>
					<%--숨김 필드 모음--%>
					
					<s:if test="showIsNull">
					<input type="hidden" name="board_no" value="${showData.board_no }"/>
					<input type="hidden" name="id_product" value="${showData.id_product }"/>
					<input type="hidden" name="id_purchase" value="${showData.id_purchase }"/>
					<input type="hidden" name="purchase_status" value="${showData.status }"/>
					<input type="hidden" name="myposts" value="${showData.myposts }"/>
					</s:if>
					<s:else>
					<input type="hidden" name="board_no" value="${showData.board_no }"/>
					<input type="hidden" name="id" value="${showData.id}"/>
					<input type="hidden" name="id_product" value="${showData.id_product }"/>
					<input type="hidden" name="purchase_status" value="${showData.status }"/>
					<input type="hidden" name="myposts" value="${showData.myposts }"/>
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
				<div class="footer board">
					<div class="buttons edit">
					    <s:if test=" ( (params.board_no != 3) && (params.board_no != 4) ) || (auth.isAdmin)">
						<a href="list?board_no=${param.board_no }&amp;contents=${param.contents}&amp;myposts=${param.myposts }" class="artn-button board">목록</a>
						</s:if>
						<button type="submit" class="artn-button board"><s:if test="showIsNull || hasRe">작성</s:if><s:else>수정</s:else>완료</button>
					</div>
				</div>
			</form>
		
		</div>
	</div>	
</a:html>