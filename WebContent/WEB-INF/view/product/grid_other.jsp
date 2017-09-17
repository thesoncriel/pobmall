<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - Product Action Test : List" contents="${contentsCode }">
<div class="header">
	<h1>상품 목록</h1>
	<div id="breadcrumbs" data-sub="*상품 목록"></div>
</div>
<div class="article">
<!-- <h1>상품 목록</h1> -->
<div class="product-section">
		<img src="/img/jglovis/main/pob-ac.jpg" width="100%">
</div>
		<div class="product-grid">
			<s:if test="listIsNull">
				<div class="not-exists">상품이 존재하지 않습니다.</div>
			</s:if>
			<s:else><s:iterator value="listData" var="all" status="s">
	

		<form action="cart/modify" method="post">
		<!-- <form action="#" method="post"> -->
		<input type="hidden" name="id_product" value="${all.id }"/>
		<input type="hidden" name="subject" value="${all.name }"/>
		<%-- <input type="hidden" name="contents" value="${all.contents }"/> --%>
		<input type="hidden" name="price" value="${all.price }"/>
		<input type="hidden" name="price_opt" value="${all.price_opt }"/>
		<input type="hidden" name="price_before" value="${all.price_before }"/>
		<input type="hidden" name="price_event" value="${all.price_event }"/>	
		<input type="hidden" name="file_img" value="${all.file_img }"/>	
		<input type="hidden" name="" value="${all.id_opt_group }"/>
			<div class="preview">
				<div data-rule="tabContents">
				    <ul class="tab m-hdn-hdn">
				    <s:iterator value="subData.imgList.{? (#this.id_product == #all.id)}" var="sub" status="v">
					    <li>
					    <a href="#tab${s.index + 1 }${v.index + 1}">
	                    	<a:img cssClass="file_img" src="/download?path=/upload/thumnail/&fileName=${sub.file_img }" alt="상품 사진" srcNone="/img/none.png" altNone="상품 사진 없음 - 상품 등록 후 적용 됩니다." width="35" height="35" />
	                    </a>
	                    </li>
				    </s:iterator>
					</ul>
					<s:iterator value="subData.imgList.{? (#this.id_product == #all.id)}" var="sub" status="v">						
                    	<a href="show?id=${id }"><img src="/download?path=/upload/thumnail/&fileName=${sub.file_img }" alt="${all.name }" class="content" id="tab${s.index }${v.index }"/></a>              	
                    </s:iterator>
				</div>
				
					<%-- <b>COLOR</b>
						<div>
							<a href="#"></a><a href="#"></a>
						</div> --%>
					<%-- <a:img src="/download?path=upload/product/img/&fileName=${showData.file_img }" alt="상품 사진" srcNone="/img/none.png" altNone="상품 사진 없음 - 상품 등록 후 적용 됩니다." width="320" height="240"/> --%>
								
			</div>
			<div class="desc">
				<%-- <div>상품번호 : <s:property value="id"/><br/> 상품명 : <s:property value="name"/></div>
				<div>상품설명<s:property value="contents" escapeHtml="false"/></div> --%>
				<h3><s:property value="name"/></h3>
				<h4>( <s:property value="name_sub"/> )</h4>
				<div class="more-view m-hdn-hdn"><a href="show?id=${id }">더보기 ▶</a></div>								
			</div>
			<div class="footer">
				<%-- <div>
					<div>가격 : <s:property value="price"/></div> 
					<div>할인 전 가격 : <s:property value="price_before"/></div>
					<div>이벤트 가격 : <s:property value="price_event"/></div>
				</div> --%>
				<%-- <div>
					<s:iterator value='%{subData["productOpt" + #s.index]}' var="sub">
					<div><a:selectopt name="opt_detail" value="${sub.items_price }" text="${sub.items_name }" textdiv=","/></div>
					<input name="seq__${sub.seq }" value="${sub.seq }" type="text"/>		
					</s:iterator>		
					<div><button type="submit" class="artn-button board">카트</button></div>	
				</div> --%>
					<strong class="price"><s:property value="price"/> 원</strong>
					<!-- <button type="submit" class="artn-button board m-hdn-hdn">구매하기</button> -->
					<a href="show?id=${id }" type="submit" class="artn-button board m-hdn-hdn">구매하기</a>					
				</div>
		</form>
	 
	 
	</s:iterator></s:else>
	</div>
	<div class="footer board">
		<div class="buttons">
			<s:if test='%{auth.isGroupAdmin(id_group)}'>
			<a class="artn-button board" href="write?contents=${contentsCode }&id_group=${id_group }">상품 등록</a>
			</s:if>
		</div>
		<a:pagenav page="${param.page }" params="${params}" rowCount="${rowCount }" rowLimit="10" navCount="10" id="pagecontroller" cssClass="page-controller" font="symbol" />
	</div>	
</div>
<input type="hidden" class="id_group" value="${param.id_group }"/>
</a:html>