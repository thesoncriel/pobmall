<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/include/title_css_script.htmlpart"/>
<script>
    $(document).ready(function(){
        $(".buttons button, .buttons a").click(function(){
            parent.document.location.reload();
        });
    });
</script>
</head>
<body>
			<form action="modify" method="post" enctype="multipart/form-data">
				<fieldset>
				<s:if test="params.board_no == 1">
					<table class="board-edit">
						<thead>
							<tr>
								<th scope="row">작성자</th>
								<s:if test="(showIsNull || hasLogin)">
								    <s:if test="hasLogin == false">                               
                                        <td>
                                            <input type="text" id="textbox_user_name" name="user_name" value=""/>
                                            <input type="hidden" id="textbox_id_user" name="id_user" value="Guest" />
                                        </td>
                                    </s:if>
									<s:elseif test="params.aaa == 'aaa'">								
										<td>
											${showData.user_name }(${showData.id_user})
											<input type="hidden" id="textbox_user_name" name="user_name" value="${showData.user_name }"/>
											<input type="hidden" id="textbox_id_user" name="id_user" value="${showData.id_user }" />
										</td>
									</s:elseif>
									<s:else>
										<td>
										${user.name }(${user.id})
										<input type="hidden" id="textbox_user_name" name="user_name" value="${user.name }"/>
										<input type="hidden" id="textbox_id_user" name="id_user" value="${user.id }" />
									</td>
									</s:else>
								</s:if>
								<s:else >
								<td><!-- <input type="text" id="textbox_id" value="${showData.id }" disabled="disabled"/><input type="hidden" name="id_user" value="${user.id }" /></td> --></s:else>
							</tr>
							<tr>
								<th scope="row" class="subject">제목</th>
								<td>
									<input type="text" id="textbox_subject" name="subject" required="required" title="제목을 입력하세요" value="${showData.subject}"/>
								</td>
							</tr>
							<tr>
								<th>문의 유형</th>
								<td>
									<select name="category">
										<option value="">전체</option>
										<option value="상품(성능/사이즈)">상품(성능/사이즈)</option>
										<option value="교환">교환</option>
										<option value="배송">배송</option>
										<option value="반품/취소/환불">반품/취소/환불</option>
										<option value="기타">기타</option>
									</select>
								</td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td></td>
								<td><textarea id="textbox_contents" name="contents" style="height: 130px;">${showData.contents}</textarea></td>
							</tr>
							<s:if test="auth.isAdmin">
							<tr>
								<td colspan="6"><h3>답변 쓰기</h3></td>
							</tr>
								<tr>
									<td></td>
									<td><textarea id="textbox_contents_reply" name="contents_reply" style="height: 130px;">${showData.contents_reply}</textarea></td>
								</tr>
							</s:if>
						</tbody>
					</table>
				</s:if>
				
				<!-- 한줄평 -->
				<s:if test="params.board_no == 2">
					<table class="board-edit">
						<thead>
							<tr>
								<th scope="row">작성자</th>
								<s:if test="(showIsNull || hasLogin)">
									<s:if test="params.aaa == 'aaa'">								
										<td>
											${showData.user_name }(${showData.id_user})
											<input type="hidden" id="textbox_user_name" name="user_name" value="${showData.user_name }"/>
											<input type="hidden" id="textbox_id_user" name="id_user" value="${showData.id_user }" />
										</td>
									</s:if>
									<s:else>
										<td>
										${user.name }(${user.id})
										<input type="hidden" id="textbox_user_name" name="user_name" value="${user.name }"/>
										<input type="hidden" id="textbox_id_user" name="id_user" value="${user.id }" />
									</td>
									</s:else>
								</s:if>								
							</tr>
							<tr>
								<th>별점</th>
								<td><div id="rating_show" date-name="rating" data-length="5" data-onevalue="2" data-mouse="yes" data-value="${rating_avg }"/></td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>한줄평</th>
								<td colspan="3"><textarea id="textbox_contents" name="contents" style="height: 130px;">${showData.contents}</textarea></td>
							</tr>
						</tbody>
					</table>
					<input type="hidden" name="subject" value=""/>
				</s:if>	
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
					<input type="hidden" name="id_product" value="${params.id_product}"/>					
			
				</fieldset>
				<!--<a:file name="file_img" value="${showData.file_img }" path="/upload/board/img/"/>-->
				<div class="footer board">
					<div class="buttons edit">
						<a href="list?board_no=${param.board_no }&amp;id_product=${param.id_product}" class="artn-button board">목록</a>
						<button type="submit" class="artn-button board"><s:if test="showIsNull || hasRe">작성</s:if><s:else>수정</s:else>완료</button>
					</div>
				</div>
			</form>
	</body>
</html>
		
