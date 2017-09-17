<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - Product Action Test : Edit" contents="${contentsCode }">
<div class="header">
	<h1>상품 정보</h1>
	<div id="breadcrumbs" data-sub="*상품 정보"></div>
</div>
<div class="section">	
	<div class="article product-show">
		<h2>${showData.name }<s:if test="showData.product_count == 0"><span class="sold-out" style="color:red"> (일시 품절)</span></s:if></h2>		
		<div class="price-info">
			<div>
				<!-- <div class="preview" data-rule="tabContents"> -->
				<%-- 	<div class="preview_tab">
						<a href="#"><span class="artn-icon-32 carat-1-n m-hdn-hdn"></span><span class="artn-icon-32 circle-w m-show"></span></a>
						<ul class="tab">
							<li><a href="#tab1"><a:img src="/download?path=upload/thumnail/&fileName=${subData.imgList[0].file_img }" alt="상품 사진" srcNone="/img/none.png" altNone="상품 사진 없음 - 상품 등록 후 적용 됩니다." width="103" height="105"/></a></li>
							<li><a href="#tab2"><a:img src="/download?path=upload/thumnail/&fileName=${subData.imgList[1].file_img }" alt="상품 사진" srcNone="/img/none.png" altNone="상품 사진 없음 - 상품 등록 후 적용 됩니다." width="103" height="105"/></a></li>
							<li><a href="#tab3"><a:img src="/download?path=upload/thumnail/&fileName=${subData.imgList[2].file_img }" alt="상품 사진" srcNone="/img/none.png" altNone="상품 사진 없음 - 상품 등록 후 적용 됩니다." width="103" height="105"/></a></li>
						</ul>
						<a href="#"><span class="artn-icon-32 carat-1-s m-hdn-hdn"></span><span class="artn-icon-32 circle-e m-show"></span></a>
					</div>
					<div class="preview_contents">
						<div class="content" id="tab1"> 
							<a:img src="/download?path=upload/thumnail/&fileName=${subData.imgList[0].file_img }" alt="상품 사진" srcNone="/img/none.png" altNone="상품 사진 없음 - 상품 등록 후 적용 됩니다."/>
						</div>
						<div class="content" id="tab2"> 
							<a:img src="/download?path=upload/thumnail/&fileName=${subData.imgList[1].file_img }" alt="상품 사진" srcNone="/img/none.png" altNone="상품 사진 없음 - 상품 등록 후 적용 됩니다."/>
						</div>
						<div class="content" id="tab3"> 
							<a:img src="/download?path=upload/thumnail/&fileName=${subData.imgList[2].file_img }" alt="상품 사진" srcNone="/img/none.png" altNone="상품 사진 없음 - 상품 등록 후 적용 됩니다."/>
						</div>
						<div class="rating-wrap">
							구매 만족도 : <span class="rating_show_bg"><span class="rating_show_fg" style="width:${showData.rating_avg }0%"></span></span>
						</div>
					</div> --%>
				<!-- </div> -->					
					<div id="scroller_number_slideshow" class="number_slideshow scroller" data-type="slide" data-auto="on" data-imgWidth="" data-time="2000" data-speed="normal">
						<div class="preview_contents">					
							<ul class="scroll_view">
								<s:iterator value="subData.imgList">
									<s:if test="file_img != '' && file_img != null">
										<li class="content">
											<a href="#"><a:img src="/download?path=upload/thumnail/&fileName=${file_img }" alt="상품 사진" srcNone="/img/none.png" altNone="상품 사진 없음 - 상품 등록 후 적용 됩니다."/></a>
										</li>
									</s:if>
								</s:iterator>															
							</ul>
						</div>											
						<div class="preview_tab">
							<%-- <a href="#"><span class="artn-icon-32 carat-1-n m-hdn-hdn"></span><span class="artn-icon-32 circle-w m-show"></span></a> --%>							
							<ul class="number_slideshow_nav scroll_nav">
							<s:iterator value="subData.imgList">
								<s:if test="file_img != '' && file_img != null">
				                	<li><a href="#"><a:img src="/download?path=upload/thumnail/&fileName=${file_img }" alt="상품 사진" srcNone="/img/none.png" altNone="상품 사진 없음 - 상품 등록 후 적용 됩니다." width="50" height="50"/></a></li>
				                </s:if>
				            </s:iterator>				                
				            </ul>
				            <%-- <a href="#"><span class="artn-icon-32 carat-1-s m-hdn-hdn"></span><span class="artn-icon-32 circle-e m-show"></span></a> --%>
						</div>
						<div class="rating-wrap">
							구매 만족도 : <span class="rating_show_bg"><span class="rating_show_fg" style="width:${showData.rating_avg }0%"></span></span>
						</div>
					</div>
					
				<form action="cart/modify" id="list_product" class="validator break-enter" method="post" enctype="multipart/form-data">
					<table class="product-opt">
						<tbody class="row-scope">
							<tr>
								<th>판매가</th>
								<td><strong class="price price_ori">${showData.price }<sub>원</sub></strong></td>						
							</tr>
							<s:iterator value="subData.productOpt" var="item" status="s">
			                    <s:if test=" (#itemid == null) || (#itemid != #item.id_opt_item)">
				                    <s:set name="itemid" value="#item.id_opt_item"/>
			                        <tr>
	                                    <th><label><s:property value="#item.opt_name"/></label></th>
	                                    <td>
	                                    	<s:if test="#item.required == 0">
	                                    		<s:select name="opt_detail" list="subData.productOpt.{? (#this.id_opt_item == #item.id_opt_item) }" listKey='%{item_name + ":" +item_price + ":" + item_seq}' listValue='%{item_name + ":" +item_price + "원"}' theme="simple" headerKey="선택안함:0:0" headerValue="-----선택-----" cssClass="ownremove"></s:select>
	                                    	</s:if>
	                                    	<s:else>
	                                    		<s:select name="opt_detail" list="subData.productOpt.{? (#this.id_opt_item == #item.id_opt_item) }" listKey='%{item_name + ":" +item_price + ":" + item_seq}' listValue='%{item_name + ":" +item_price + "원"}' theme="simple" headerKey="선택안함:0:0" headerValue="-----필수-----" cssClass="ownremove"></s:select>
	                                    	</s:else>
	                                    </td>
	                                </tr>
			                    </s:if>
		                    </s:iterator>
							<tr>
								<th>구매수량</th>
								<td>
									<s:if test='%{#session.environment.osPlatform == "Desktop"}'>
					                    <span class="pc_view"><input type="text" class="product_count" id="spinner_product_count${s.index }" name="product_count" value="1" data-min="1" style="width: 25px;" readonly="readonly"><span> 개</span></span>
					                </s:if>
					                <s:else>
					                    <span class="mobi_view"><a:selectbox name="product_count" cssClass="select_count" min="1" max="100" value="${product_count }"/>개</span>                                 
					                </s:else>
									<span class="remain">판매수량: ${showData.sold_count }개<em>(남은수량: ${showData.product_count }개)</em></span>
								</td>
							</tr>
							<tr>
								<th>배송비</th>
								<td>
									<s:iterator value="subData.deliveryPrice">
										<s:if test="status == 1">
											무료											
										</s:if>
										<s:elseif test="status == 2">
											<span class="price">${delivery_price }</span>원(착불)<br/>
											(<span class="price">${free_condition }</span>원 이상 구매시 배송비 무료)											
										</s:elseif>
										<s:else>										
											<span class="price">${delivery_price }</span>원<br/>
											(<span class="price">${free_condition }</span>원 이상 구매시 배송비 무료)											
										</s:else>
									</s:iterator>
								</td>
							</tr>
						</tbody>
					</table>
					
					<div class="total-price">
						<span>총 상품 금액</span>
						<strong class="price sum_price">${showData.price }<sub>원</sub></strong>
					</div>
					<div class="buttons"><button class="artn-button" type="submit">장바구니에 담기</button></div>
					
					<%-- 숨김항목 --%>
					<input type="hidden" name="id_product" value="${showData.id }"/>
					<input type="hidden" name="opt" value=""/>
					<input type="hidden" name="file_img" value="${showData.file_img }"/>
					<input type="hidden" name="price_opt" value=""/>
					<input type="hidden" id="price" name="price" value="${showData.price }"/>
					<input type="hidden" name="subject" value="${showData.name }"/>
					<%-- 숨김항목 --%>					
				</form>
			</div>			
		</div>
		<div class="footer board mb">
			<div class="buttons">					
				<s:if test='%{auth.isGroupAdmin(id_group)}'>
					<a href="edit?id=${showData.id }" class="artn-button board">수정</a>
				</s:if>					
				<a href="grid?category=1&pob=true" class="artn-button board">목록</a>
			</div>
		</div>
		<div class="product-contents" data-rule="tabContents">	
				<ul class="tab distribute">
					<li><a href="#tab4">상품정보</a></li>
					<li><a href="#tab5">상품문의</a></li>
					<li><a href="#tab6">한줄상품평</a></li>
					<li class="last"><a href="#tab7">배송정책</a></li>
				</ul>
				<div class="content" id="tab4">
					<div class="desc">
						${showData.contents }
					</div>
				</div>
				<div class="content" id="tab5">
					<iframe src="/product/board/list?id_product=${params.id_product }&board_no=1" width="100%" height="600" scrolling="no" border="0"></iframe>
				</div>
				<div class="content" id="tab6">
					<iframe src="/product/board/list?id_product=${params.id_product }&board_no=2" width="100%" height="400" scrolling="no" border="0"></iframe>
				</div>
				<div class="content" id="tab6" style="text-align: center;">
					<img src="/img/sub/delivery.jpg" width="90%"/>
				</div>
		</div>
		
<!-- 호이호이 -->		
<%-- <script>
	$(document).ready(function(){
		$(".yyj td.subject a").click(function(){
			$(this).parent().parent().next().toggle();
			return false;
		});
	});
</script>	
	<h2>상품 문의</h2>
			<form action="delete">
				<table class="board-list">
				<thead>
					<tr>
						<s:if test="auth.isAdmin"><th> </th></s:if>
						<th class="row-num">번호</th>
						<th class="name">답변상태</th>
						<th class="date">문의유형</th>
						<th>제목</th>
						<th class="name">작성자</th>													
						<th class="date">등록일</th>
						<th class="view-cnt">수정</th>												
					</tr>
				</thead>
				<tbody>					
					<s:if test="subIsNull.productBoard">
						<tr><td colspan="7">게시물이 존재하지 않습니다.</td></tr>
					</s:if>
					<s:else><s:iterator value="subData.productBoard" var="yyj">
					<tr class="yyj">
						<s:if test="auth.isAdmin"><td><input type="checkbox" name="id" value="${yyj.id}"/></td></s:if>
						<td><s:property value="row_number"/></td>
						<td>
							<s:if test="contents_reply != null && contents_reply != ''">
							답변OK
							</s:if><s:else>미답상태</s:else>
						</td>
						<td><s:property value="category"/></td>
						<td class="subject"><a href="#"><s:property value="subject"/></a><s:if test="util.today == date_upload_fmt"><span class="artn-icon-16 new">new</span></s:if></td>
						<td><s:property value="user_name"/></td>																									
						<td><s:property value="date_upload_fm"/></td>
						<td>
							<s:if test="#user.id == id_user">
								<a href="/product/board/edit?id=${yyj.id }&id_product=${params.id_product }" class="artn-button board" target="_blank">수정</a>
							</s:if>
							<s:if test="auth.isAdmin && contents_reply == ''">
								<a href="/product/board/edit?id=${yyj.id }&id_product=${params.id_product }" class="artn-button board">답변</a>
							</s:if>
						</td>					
					</tr>
					<tr style="display: none;">
						<td></td>
						<td></td>
						<td class="subject" colspan="7" style="text-align: left;">
							<div>질문 : ${yyj.contents }</div>
							<hr style="border:0px;border-bottom: 1px solid #ccc;">
							<div style="padding-left: 30px;"><span class="artn-icon-16 comment"></span>답변 : ${yyj.contents_reply }</div>
						</td>
					</tr>
					</s:iterator></s:else>
				</tbody>
				</table>
				<input type="hidden" name="board_no" value="${param.board_no}"/>
				<input type="hidden" name="contents" value="${param.contents}"/>				
			<div class="footer board">
				<div class="buttons">
				    <a href="/product/board/write?board_no=1&id_product=${param.id }" class="artn-button board" target="_blank">글쓰기</a>
					<s:if test="auth.isAdmin"><input type="submit" value="삭제" class="artn-button board"></s:if>
				</div>
				<a:pagenav page="${param.page }" params="${params}" rowCount="${subRowCount.productBoard }" rowLimit="10" navCount="10" id="pagecontroller" cssClass="page-controller" font="symbol" />
			</div>				
			</form>		 --%>
<!-- 호이호이 -->		
		
		
		
		
		
		<div class="footer board">
			<div class="buttons">					
				<s:if test='%{auth.isGroupAdmin(id_group)}'>
					<a href="edit?id=${showData.id }" class="artn-button board">수정</a>
				</s:if>					
				<a href="grid?category=1&pob=true" class="artn-button board">목록</a>
			</div>
		</div>
		

	</div>
</div>
<div class="footer-button m-show">
	<a href="/product/grid?category=1&pob=true" class="m-action-icon"><span class="artn-icon-32 grid">목록</span></a>
	<a href="#" id="button_SubmitToCartList">장바구니에 담기</a>
	<a href="#" class="m-action-icon m-button-gradient top" style="text-align: center;"><strong>TOP</strong></a>
</div>
</a:html>