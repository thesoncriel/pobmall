<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - Purchase Action Test : List" contents="${contentsCode }">
<div class="header">
    <h1>상품평</h1>
    <div id="breadcrumbs" data-sub="*상품평"></div>
</div>
<div class="section">
    <div class="article">
    <form action="/product/board/modify" method="post" enctype="multipart/form-data">
	    <table class="board-edit">
		    <thead>
		        <tr>
		            <th scope="row">작성자</th>
	                    <td>
	                        ${showData.pay_user_name }(${showData.id_user})
	                        <input type="hidden" id="textbox_user_name" name="user_name" value="${showData.pay_user_name }"/>
	                        <input type="hidden" id="textbox_id_user" name="id_user" value="${showData.id_user }" />
	                    </td>
		        </tr>
		        <tr>
		            <th>별점</th>
		            <td><div id="rating_show" date-name="rating" data-length="5" data-onevalue="2" data-mouse="yes" data-value="${rating_avg }"/></td>
		        </tr>
		    </thead>
		    <tbody>
		        <tr>
		            <th>한줄평</th>
		            <td colspan="3"><textarea id="textbox_contents" name="contents" style="height: 130px;"></textarea></td>
		        </tr>
		    </tbody>
		</table>
		<input type="hidden" name="subject" value=""/>
		<input type="hidden" name="board_no" value="2"/>
        <input type="hidden" name="id_product" value="${showData.id_product}"/>
        <input type="hidden" name="complete" value="true"/>
        <div class="footer board">
             <div class="buttons edit">
                 <button type="submit" class="artn-button board">작성 완료</button>
                 <a href="/main" class="artn-button board">목록</a>
             </div>
         </div>
    </form>
    </div>
</div>
</a:html>