<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html contents="${contentsCode }">
<div class="header">
    <s:if test="contentsCode == 'sub100'"><h1>회원 관리</h1></s:if>
    <s:else><h1>그룹 사용자 관리</h1></s:else>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="auto"></div>
    
</div>    
    <div class="section">
        <div class="article">
            <table class="board-list">
                <thead>
                    <tr>
                        <th class="row-num">번호</th>
                        <th class="name">성명</th>
                        <th>소속그룹</th>
                        <th>그룹 전화번호</th>
                        <th>직급</th>
                        <th class="last">상세정보</th>
                    </tr>
                </thead>
                <tbody>
                	<s:if test="listIsNull">
					    	<tr><td colspan="7">그룹사용자가 없습니다</td></tr>
					</s:if>
					<s:else>
                    <s:iterator value="listData">
                        <tr>
                            <td><s:property value="row_number"/></td>
							<td><s:property value="user_name"/></td>
							<td><a href="/groupuser/list?id_group=${id_group}&contents=${contentsCode }"><s:property value="group_name"/></a></td>
							<td><s:property value="phone_group"/> </td>
							<td><s:property value="auth_group_kor"/></td>
							<td><a href="show?id=${id }&contents=${contentsCode }">정보 보기</a></td>
                        </tr>
                    </s:iterator>
                    </s:else>
                </tbody>
            </table>

            <div class="footer board">
                <s:if test='%{auth.isAdmin}'>
                <div class="buttons">
					<a href="write" class="artn-button board">추가</a>
				</div>
				</s:if>
				<a:pagenav page="${param.page }" params="${params}" rowCount="${rowCount }" rowLimit="10" navCount="10" id="pagecontroller" cssClass="page-controller" font="symbol" />
            </div>
            <div>
            <s:include value="/WEB-INF/include/search/groupUser.jsp"></s:include>
            </div>
        </div>
    </div>
</a:html>
