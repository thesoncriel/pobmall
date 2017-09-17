<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<%response.sendRedirect("/product/grid?category=1&pob=true"); %>
<a:html title=" - 메인 페이지" contents="main">
<div class="header">
	<h1>상품 목록</h1>		 
	<div id="breadcrumbs" data-sub="*상품 목록"></div>
</div>
<div class="article">
<!-- <h1>상품 목록</h1> -->
<div class="product-grid">
	<h2>Premium</h2>	
	<s:if test="listIsNull">
		<div class="not-exists">상품이 존재하지 않습니다.</div>
	</s:if>
	<s:else><s:iterator value="listData.{? (#this.category == 1)}" var="all" status="s">
	<form action="product/cart/modify" method="post">
	<input type="hidden" name="id_product" value="${all.id }"/>
	<input type="hidden" name="subject" value="${all.name }"/>
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
					<a href="/product/show?id=${id }">
				<s:iterator value="subData.imgList.{? (#this.id_product == #all.id)}" var="sub" status="v">						
                    <img src="/download?path=/upload/thumnail/&fileName=${sub.file_img }" alt="${all.name }" class="content" id="tab${s.index }${v.index }"/>                    	
				</s:iterator>
					</a>
		</div>
	</div>
	<div class="desc">
		<h3><s:property value="name"/></h3>
		<h4>( <s:property value="name_sub"/> )</h4>
		<div class="more-view m-hdn-hdn"><a href="product/show?id=${id }">더보기 ▶</a></div>								
	</div>
	<div class="footer">
		<strong class="price"><s:property value="price"/> 원</strong>
		<!-- <button type="submit" class="artn-button board m-hdn-hdn">구매하기</button> -->
		<a href="product/show?id=${id }" type="submit" class="artn-button board m-hdn-hdn">구매하기</a>					
	</div>
	</form>	 
	</s:iterator></s:else>
</div>
<div class="product-grid">
	<h2>Special</h2>
	<s:if test="listIsNull">
		<div class="not-exists">상품이 존재하지 않습니다.</div>
	</s:if>
	<s:else><s:iterator value="listData.{? (#this.category == 2)}" var="all" status="s">
	<form action="product/cart/modify" method="post">
	<input type="hidden" name="id_product" value="${all.id }"/>
	<input type="hidden" name="subject" value="${all.name }"/>
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
				<a href="/product/show?id=${id }">
				<s:iterator value="subData.imgList.{? (#this.id_product == #all.id)}" var="sub" status="v">						
                   	<img src="/download?path=/upload/thumnail/&fileName=${sub.file_img }" alt="${all.name }" class="content" id="tab${s.index }${v.index }"/>                 	
				</s:iterator>
				</a>
		</div>
	</div>
	<div class="desc">
		<h3><s:property value="name"/></h3>
		<h4>( <s:property value="name_sub"/> )</h4>
		<div class="more-view m-hdn-hdn"><a href="product/show?id=${id }">더보기 ▶</a></div>								
	</div>
	<div class="footer">
		<strong class="price"><s:property value="price"/> 원</strong>
		<!-- <button type="submit" class="artn-button board m-hdn-hdn">구매하기</button> -->					
		<a href="product/show?id=${id }" class="artn-button board m-hdn-hdn">구매하기</a>
	</div>
	</form>
	</s:iterator></s:else>
</div>
<div class="footer board">
	<div class="buttons">
		<s:if test='%{auth.isGroupAdmin(id_group)}'>
		<a class="artn-button board" href="/product/write?contents=${contentsCode }">상품 등록</a>
		</s:if>
	</div>
</div>
<div class="search_div">
    <form action="/product/grid" method="post" class="product-search">
        <input type="text" name="search_text"/>
        <input type="submit" class="artn-button board search_btn" value="검색"/>
    </form>
</div>
</div>
<input type="hidden" class="id_group" value="${param.id_group }"/>
</a:html>