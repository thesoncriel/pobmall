<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title="" contents="${contentsCode }">
    <div class="header">
        <h1>구매 정보 기록</h1>
        <div id="breadcrumbs" data-sub="${contentsCode }" data-target="auto"></div>
    </div>
	<div class="article">
        <form id="search_frm" action="historylist" method="post">
            <s:select name="status" list="#{
                            '': '전체 목록',
                            '1': '입금 대기',
                            '2': '입금 확인',
                            '3': '배송 중',
                            '4': '배송 완료',
                            '10': '구매 완료',
                            '-2': '구매 취소',
                            '-3': '환불 요청',
                            '-10': '환불 완료'
                            }" theme="simple">
			</s:select>
			<input type="hidden" name="contents" value="${param.contents }"/>
			<input type="hidden" id="date" name="date" value="${param.date }"/>
			<input type="button" class="artn-button board date_btn" data-value ="today" value="오늘"/>
			<input type="button" class="artn-button board date_btn" data-value ="1week" value="1주일"/>
			<input type="button" class="artn-button board date_btn" data-value ="1month" value="1개월"/>
			<input type="button" class="artn-button board date_btn" data-value ="3month" value="3개월"/>
			<input type="button" class="artn-button board date_btn" data-value ="6month" value="6개월"/>
			<input type="button" class="artn-button board date_btn" data-value ="1year" value="1년"/>
			<s:select name="search_div" headerKey="" headerValue="전체" list="#{'id_user':'구매자 ID',
			                                                                  'id_purchase':'주문번호',
			                                                                  'delivery_num':'운송장번호'
			                                                                  }" theme="simple"/>
			<input type="text" name="search_text"/>
			<input type="submit" class ="artn-button board serch_btn" value="검색"/>
            <table class="board-list">
                <thead>
	                <tr>
	                    <th>번호</th>
	                    <th>주문번호</th>
	                    <th>아이디</th>
	                    <th>구매상태</th>
	                    <th>구매가격</th>
	                    <th>변경날짜</th>
	                    <th>운송장번호</th>
                    </tr>
                </thead>
                <tbody>
                    <s:if test="listIsNull">
                    <tr>
                        <td colspan="7">구매 내역이 존재하지 않습니다.</td>
                    </tr>
                    </s:if>
                    <s:iterator value="listData">
                    <tr>
                        <td><s:property value="id"/></td>
                        <td><s:property value="id_purchase"/></td>
                        <td><s:property value="id_user"/></td>
                        <td><s:property value="status_kor"/></td>
                        <td><span class="price"><s:property value="sum_price"/></span><span>원</span></td>
                        <td><s:property value="date_upload_fmt"/></td>
                        <td><s:property value="delivery_num"/></td>
                    </tr>
                    </s:iterator>
                </tbody>
            </table>
        </form>
        <a:pagenav page="${param.page }" params="${params}" rowCount="${rowCount }" rowLimit="10" navCount="10" id="pagecontroller" cssClass="page-controller" font="symbol" />
	</div>
</a:html>