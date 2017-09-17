<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>

<a:html title=" - User Action Test : List" contents="${param.contents }">
	<div class="header">
	   <s:if test="params.board_no == 2">
           <h1>상품 평가</h1>
       </s:if>
       <s:if test="params.board_no == 3">
           <h1>환불 요청</h1>
       </s:if>
       <s:elseif test="params.board_no == 4">
           <h1>교환 요청</h1>
       </s:elseif>
        <div id="breadcrumbs" data-sub="${param.contents }"  data-target="auto"></div>
    </div>
	<div class="section">
		<div class="article">
			<form action="delete">
				<table class="board-list">
					<thead>
						<tr>
							<s:if test="auth.isAdmin"><th> </th></s:if>
							<th class="row-num">번호</th>
							<th>답변상태</th>
							<th>상품명</th>
							<s:if test="params.board_no == 2">
							<th>내용</th>
							<th>평가정보</th>
							</s:if>
							<s:else>
							<th>제목</th>
							</s:else>
							<th class="name">작성자</th>													
							<th class="date">등록일</th>
							<th class="view-cnt">조회수</th>						
						</tr>
					</thead>
					<tbody>					
						<s:if test="listIsNull">
							<tr><td colspan="8">게시물이 존재하지 않습니다.</td></tr>
						</s:if>
						<s:else><s:iterator value="listData">
						<tr>
							<s:if test="auth.isAdmin"><td><input type="checkbox" name="id" value="${id}"/></td></s:if>
							<td><s:property value="row_number"/></td>
							<td>
							     <s:if test="contents_reply == ''">
							         미답변
							     </s:if>
							     <s:elseif test="contents_reply != ''">
							         답변완료
							     </s:elseif>
							</td>
							<td><a href="/product/show?id=${id_product }"><s:property value="name"/>(${name_sub })</a></td>
							<s:if test="params.board_no == 2">
	                        <td><s:property value="contents"/></td>
	                        <td><span class="rating_show_bg"><span class="rating_show_fg" style="width:${rating }0%"></span></span></td>
	                        </s:if>
	                        <s:else>
		                        <td class="subject"><s:if test="%{depth > 0}"><span class="board-depth${depth }">${param.password}</span>
		                        <span class="artn-icon-16 comment"></span><span>답글:</span></s:if>
		                        <s:if test="auth.isAdmin == false">
		                            <%-- <a href="show?id=${id}&amp;board_no=${param.board_no}&amp;contents=${param.contents}" data-rule="confirmButton" data-dialog="#dialog"><s:property value="subject"/></a> --%>
		                            <a href="show?id=${id}&amp;board_no=${param.board_no}&amp;contents=${param.contents}"><s:property value="subject"/></a>
		                        </s:if>
		                        <s:else>
		                            <a href="show?id=${id}&amp;board_no=${param.board_no}&amp;contents=${param.contents}"><s:property value="subject"/></a>
		                        </s:else>
		                        <s:if test="util.today == date_upload_fmt"><span class="artn-icon-16 new">new</span></s:if></td>
	                        </s:else>
							<td><s:property value="user_name"/>(${id_user })</td>																									
							<td><s:property value="date_upload_fmt"/></td>
							<td><s:property value="view_count"/></td>					
						</tr>
						</s:iterator></s:else>
					</tbody>
				</table>
				<input type="hidden" name="board_no" value="${params.board_no}"/>
                <input type="hidden" name="myposts" value="${params.myposts }"/>
                <input type="hidden" name="contents" value="${params.contents }"/>
                <input type="hidden" name="myposts" value="${params.myposts }"/>
			<div class="footer board">
				<div class="buttons">
			        <%-- <a href="write?board_no=${param.board_no}&amp;contents=${param.contents}"  class="artn-button board">글쓰기</a> --%>
					<s:if test="auth.isAdmin"><input type="submit" value="삭제" class="artn-button board"></s:if>
				</div>
				<a:pagenav page="${param.page }" params="${params}" rowCount="${rowCount }" rowLimit="10" navCount="10" id="pagecontroller" cssClass="page-controller" font="symbol" />
			</div>				
			</form>
	
			<div>
				<jsp:include page="/WEB-INF/include/search/board.jsp" flush="false" />		
			</div>
		</div>
	</div>
</a:html>