<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - Product Action Test : List" contents="${contentsCode }">
<div class="header">
	<h1>상품 목록</h1>
	<div id="breadcrumbs" data-sub="*상품 목록"></div>
</div>
<div id="dialog_main" data-width="430" data-height="325">
	<img src="/img/jglovis/popup.jpg"/>
	<form class="today" id="checkForm" name="checkForm">
        <label onclick="closeWin();">
            <input id="chkbox" name="chkbox" type="checkbox">
            <span>오늘 하루 열지 않음</span>
        </label>
    </form>
</div>
<div class="article">
<!-- <h1>상품 목록</h1> -->
<div class="product-section">
	<input type="hidden" name="category_div" value="${param.category }"/>
	<s:if test="params.category == 257">	
		<img src="/img/jglovis/main/main-img-galaxy.jpg" width="100%">
	</s:if>
	<s:elseif test="params.category == 513">	
		<img src="/img/jglovis/main/main-img-iphone.jpg" width="100%">
	</s:elseif>
	<s:elseif test="params.category == 1025">
		<img src="/img/jglovis/main/main-img-lg.jpg" width="100%">
	</s:elseif>
	<s:else>
		<img src="/img/jglovis/main/main-img-all.jpg" width="100%">
	</s:else>
	<div class="category">
		<div>			
			<ul>
				<li class="title">카테고리</li>
				<li><a href="grid?category=1&pob=true" class="category-1">전체</a></li>				
				<li><a href="grid?category=257&pob=true" class="category-257">갤럭시</a></li>
				<li><a href="grid?category=1025&pob=true" class="category-1025">LG</a></li>
				<li><a href="grid?category=513&pob=true" class="category-513">아이폰</a></li>								
			</ul>
		</div>		
	</div>
</div>
<div class="product-grid">
		<h2><span class="artn-icon-16 bullet1"></span>&nbsp;Premium</h2>
		<s:if test="subIsNull.productPremiumList">
			<div class="not-exists">상품이 존재하지 않습니다.</div>
		</s:if>
		<s:else><s:iterator value="subData.productPremiumList" var="all" status="s">		
	

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
				    <%-- <ul class="tab m-hdn-hdn">
				    <s:iterator value="subData.imgList.{? (#this.id_product == #all.id)}" var="sub" status="v">
					    <li>
					    <a href="#tab${s.index + 1 }${v.index + 1}">
	                    	<a:img cssClass="file_img" src="/download?path=/upload/thumnail/&fileName=${sub.file_img }" alt="상품 사진" srcNone="/img/none.png" altNone="상품 사진 없음 - 상품 등록 후 적용 됩니다." width="35" height="35" />
	                    </a>
	                    </li>
				    </s:iterator>
					</ul> --%>
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
				<h3><s:property value="name"/><s:if test="product_count == 0"><span style="color:red">(임시 품절)</span></s:if></h3>
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
	
	<div class="product-grid">
		<h2><span class="artn-icon-16 bullet1"></span>&nbsp;Special</h2>
		<s:if test="subIsNull.productSpecialList">
			<div class="not-exists">상품이 존재하지 않습니다.</div>
		</s:if>
		<s:else><s:iterator value="subData.productSpecialList" var="all" status="s">
	
		
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
				    <%-- <ul class="tab m-hdn-hdn">
				    <s:iterator value="subData.imgList.{? (#this.id_product == #all.id)}" var="sub" status="v">
					    <li>
					    <a href="#tab${s.index + 1 }${v.index + 1}">
	                    	<a:img cssClass="file_img" src="/download?path=/upload/thumnail/&fileName=${sub.file_img }" alt="상품 사진" srcNone="/img/none.png" altNone="상품 사진 없음 - 상품 등록 후 적용 됩니다." width="35" height="35" />
	                    </a>
	                    </li>
				    </s:iterator>
					</ul> --%>
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
				<h3><s:property value="name"/><s:if test="product_count == 0"><span style="color:red">(임시 품절)</span></s:if></h3>
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
		<a:pagenav page="${param.page }" params="${params}" rowCount="${pobRowCount }" rowLimit="6" navCount="10" id="pagecontroller" cssClass="page-controller" font="symbol" />
	</div>	
</div>
<input type="hidden" class="id_group" value="${param.id_group }"/>
<%-- ${session.nonOpen } --%>
	
	<s:iterator value="subData.popupOpenList">
	<s:property value="session.nonOpen[popup_seq] == false"/><br/>
		<s:if test="session.nonOpen[popup_seq] == false">
			<a:dialog id="dialog_popup${popup_seq }" width="${width }" index="${popup_seq }" height="${height }" popupContent="${popup_content }" popupOpt="${popup_opt }" positionX="${location_x }" positionY="${location_y }" title="${title }"/>
		</s:if>		
	</s:iterator>
</a:html>