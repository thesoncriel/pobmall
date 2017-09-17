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
</head>
<body>
<script>
	$(document).ready(function(){
		$(".product-board-list td.subject a").click(function(){
			$(this).parent().parent().next().toggle();
			return false;
		});
		$(".buttons button").click(function(){
	        parent.document.location.reload();
	    });
	});
</script>	
			<form action="delete">
			<%-- 상품문의 게시판 --%>
			<s:if test="params.board_no == 1">
				<table class="board-list">
					<thead>
						<tr>
							<s:if test="auth.isAdmin"><th> </th></s:if>
							<th class="row-num m-hdn">번호</th>
							<th class="name">답변상태</th>
							<th class="date m-hdn">문의유형</th>
							<th>제목</th>
							<th class="name">작성자</th>													
							<th class="date m-hdn">등록일</th>
							<th class="view-cnt">수정</th>												
						</tr>
					</thead>
					
					<tbody>					
						<s:if test="listIsNull">
							<tr><td colspan="8">게시물이 존재하지 않습니다.</td></tr>
						</s:if>
						<s:else><s:iterator value="listData" var="productBoardList">
						<tr class="product-board-list">
							<s:if test="auth.isAdmin"><td><input type="checkbox" name="id" value="${productBoardList.id}"/></td></s:if>
							<td class="m-hdn"><s:property value="row_number"/></td>
							<td>
								<s:if test="(status & 64) > 0">
								답변완료
								</s:if>
								<s:else></s:else>
							</td>
							<td class="m-hdn"><s:property value="category"/></td>
							<td class="subject"><a href="#"><s:property value="subject"/></a><s:if test="util.today == date_upload_fmt"><span class="artn-icon-16 new">new</span></s:if></td>
							<td><s:property value="user_name"/></td>																									
							<td class="m-hdn"><s:property value="date_upload_fmt"/></td>
							<td>
								<s:if test="#user.id == id_user">
									<a href="/product/board/edit?id=${productBoardList.id }&amp;id_product=${params.id_product }&amp;board_no=${param.board_no }" class="artn-button board" target="_blank">수정</a>
								</s:if>
								<s:if test="auth.isAdmin">
									<s:if test="!((status & 64) > 0)">
										<a href="/product/board/edit?id=${productBoardList.id }&amp;id_product=${params.id_product }&amp;board_no=${param.board_no }" class="artn-button board">답변</a>
									</s:if>
								</s:if>	
							</td>					
						</tr>
						<tr style="display: none;">
							<td class="m-hdn"></td>
							<td class="m-hdn"></td>
							<s:if test="auth.isAdmin"><td></td></s:if>
							<td class="subject" colspan="5" style="text-align: left;">
								<div>질문 : ${productBoardList.contents }</div>
								<s:if test="(status & 64) > 0">
								<hr style="border:0px;border-bottom: 1px solid #ccc;">
								<div style="padding-left: 30px;"><span class="artn-icon-16 comment"></span>답변 : ${productBoardList.contents_reply }</div>
								</s:if>
							</td>
						</tr>
						</s:iterator></s:else>
					</tbody>
				</table>
			</s:if>
			
			<s:if test="params.board_no == 2">
				<table class="board-list">
						<thead>
							<tr>
								<s:if test="auth.isAdmin"><th> </th></s:if>
								<th class="row-num m-hdn">번호</th>								
								<th>내용</th>
								<th>평점</th>
								<th class="name">작성자</th>													
								<th class="date m-hdn">등록일</th>
								<th class="view-cnt m-hdn">수정</th>												
							</tr>
						</thead>
						
						<tbody>					
							<s:if test="listIsNull">
								<tr><td colspan="7">게시물이 존재하지 않습니다.</td></tr>
							</s:if>
							<s:else>
								<s:iterator value="listData" var="productBoardList">
									<tr class="product-board-list">
										<s:if test="auth.isAdmin"><td><input type="checkbox" name="id" value="${productBoardList.id}"/></td></s:if>
										<td class="m-hdn"><s:property value="row_number"/></td>
										<td class="subject"><s:property value="contents"/><s:if test="util.today == date_upload_fmt"><span class="artn-icon-16 new">new</span></s:if></td>
										<td><span class="rating_show_bg"><span class="rating_show_fg" style="width:${productBoardList.rating }0%"></span></span></td>
										<td><s:property value="user_name"/></td>																									
										<td class="m-hdn"><s:property value="date_upload_fmt"/></td>
										<td class="m-hdn">
											<s:if test="#user.id == id_user || auth.isAdmin">
												<a href="/product/board/edit?id=${productBoardList.id }&id_product=${params.id_product }" class="artn-button board" target="_blank">수정</a>
											</s:if>									
										</td>					
									</tr>
								</s:iterator>
							</s:else>
						</tbody>
					</table>
				</s:if>
				
				
				
				
				<%-- <input type="hidden" name="board_no" value="${param.board_no}"/> --%>
				<input type="hidden" name="board_no" value="${param.board_no}"/>
				<input type="hidden" name="id_product" value="${params.id_product }"/>
								
			<div class="footer board">
				<div class="buttons">
				    <%-- <s:if test="hasLogin"> --%>
				    	<s:if test="params.board_no == 1">
				    		<a href="/product/board/write?board_no=${params.board_no }&id_product=${params.id_product }" class="artn-button board">글쓰기</a>
				    	</s:if>
				    <%-- </s:if> --%>
					<s:if test="auth.isAdmin"><input type="submit" value="삭제" class="artn-button board"></s:if>
				</div>
				<a:pagenav page="${param.page }" params="${params}" rowCount="${rowCount }" rowLimit="5" navCount="5" id="pagecontroller" cssClass="page-controller" font="symbol" />
			</div>				
			</form>	
</body>
</html>