<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : Information" contents="${contentsCode }">
<div class="header">
    <h1>내가 쓴 글</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="auto"></div>     
</div>
<div class="article">
    <div class="mini-board myposts">
        <s:property value="miniBoard('3,4,2', 5)"/>
        <div class="top">
          <div class="left">
            <div class="sub_title">
                <span>환불 문의</span>
                <a href="list?board_no=3&amp;myposts=true">더보기></a>
            </div>
              <ul>
              <s:iterator value="subData.mini0">
              <li>
              <a href="show?id=${id}&amp;board_no=${board_no }&amp;myposts=true" class="mini-sub" style="text-overflow:ellipsis;">
	              <s:if test="contents_reply == ''">미답변-</s:if>
	              <s:elseif test="contents_reply != ''">답변완료-</s:elseif>
	              ${subject}</a>
	          <s:if test="util.today == date_upload_fmt"><span class="artn-icon-16 new">new</span></s:if><span class='date'>${date_upload_fmt}</span></li>
              </s:iterator>
              </ul>
          </div> 
          <div class="right">
            <div class="sub_title">
                <span>교환 문의</span>
                <a href="list?board_no=4&amp;myposts=true">더보기></a>
            </div>
              <ul>
                <s:iterator value="subData.mini1">
                <li>
                <a href="show?id=${id}&amp;board_no=${board_no }&amp;myposts=true" class="mini-sub" style="text-overflow:ellipsis;">
                    <s:if test="contents_reply == ''">미답변-</s:if>
                    <s:elseif test="contents_reply != ''">답변완료-</s:elseif>
                    ${subject}</a>
                <s:if test="util.today == date_upload_fmt"><span class="artn-icon-16 new">new</span></s:if><span class='date'>${date_upload_fmt}</span></li>
                </s:iterator>
              </ul>
                
          </div>
        </div>
        <div class="bottom">
            <div class="sub_title">
                <span>상품 평가</span>
                <a href="list?board_no=2&amp;myposts=true">더보기></a>
            </div>
            <table class="board-list">
                <thead>
                    <tr>
                        <th class="row-num">번호</th>
                        <th>상품명</th>
                        <th>내용</th>
                        <th>상품평가</th>
                        <th class="name">작성자</th>                                                   
                        <th class="date">등록일</th>
                    </tr>
                </thead>
                <tbody>
	            <s:iterator value="subData.mini2" status="s">
	            <tr>
	                <td><s:property value="row_number"/></td>
	                <td><a href="/product/show?id=${id_product }&amp;myposts=true"><s:property value="name"/>(${name_sub })</a></td>
	                <td class="subject"><s:property value="contents"/><s:if test="util.today == date_upload_fmt"><span class="artn-icon-16 new">new</span></s:if></td>
	                <td><span class="rating_show_bg"><span class="rating_show_fg" style="width:${rating }0%"></span></span></td>
	                <td><s:property value="user_name"/></td>                                                                                                    
	                <td><s:property value="date_upload_fmt"/></td>
	            </tr>
	            </s:iterator>
	            </tbody>
            </table>
        </div>
     </div>
</div>
</a:html>