<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : List" contents="${contentsCode }">
	<div class="header">
		<h1>게시판 관리</h1>
		<div id="breadcrumbs" data-sub="${contentsCode }" data-target="auto"></div>
	</div>
	<div class="section">
		<div class="article">			
			<form action="modify" method="post">
			<input type="hidden" value="${contentsCode }" name="contents"/>							
				<div>
					<div>
						<div>배송비 관리</div>
						<s:if test="listIsNull">
							<div>					
							<a:checkboxlist name="status" value="${status }" list="무료,착불,구매시 지불" type="radio" wrap="div" subWrap="div"/>
							<p>구매시 지불/착불 시 
								총 결제금액이 <input type="text" name="free_condition" value="${free_condition }"/>원 미만일 경우,
								<input type="text" name="delivery_price" value="${delivery_price }"/>원 부과
							</p>																			
						</div>
						</s:if>
						<s:iterator value="listData">
						<input type="text" name="id_delivery" value="${id_delivery }"/>
						<div>					
							<a:checkboxlist name="status" value="${status }" list="무료,착불,구매시 지불" type="radio" wrap="div" subWrap="div"/>
							<p>구매시 지불/착불 시 
								총 결제금액이 <input type="text" name="free_condition" value="${free_condition }"/>원 미만일 경우,
								<input type="text" name="delivery_price" value="${delivery_price }"/>원 부과
							</p>
							<%-- <dl>
								<dd><input type="radio" name="status" value="1"/></dd>
								<dd>
									<input type="radio" name="status" value="2">
									<input type="text" name="delivery_price" value="${delivery_price }"/>
								</dd>							
								<dd>
									<input type="radio" name="status" value="3">
									<input type="text" name="delivery_price" value="${delivery_price }"/>
								</dd>
							</dl>	 --%>													
						</div>
						</s:iterator>
					</div>
				</div>				
				<div class="footer board">
					<div class="buttons">						
						<button type="submit" class="artn-button board">수정</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</a:html>