<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<form id="asyncsearch_productOptItem" action="/product/optitem/list" method="post" data-to="#sortablelist_productOptItem">
	<fieldset>
		<input type="hidden" name="json" value="true"/>
		<input type="hidden" name="id_opt_item" value=""/>
	</fieldset>
</form>

<div id="dialog_productOptItem" data-width="500" data-height="600">
	<h2>옵션 목록 편집</h2>
	<h3>※ 끌어서 순서 변경 가능</h3>
	
	<form id="asyncform_productOptItem" action="/product/optitem/modify" method="post" data-response-type="json" data-message-type="message">
	<p class="message"></p>
	<fieldset>
		<input type="hidden" name="id_opt_item"/>
		<table class="board-list">
			<thead>
				<tr>
					<th>순서</th>
					<th>옵션값</th>
					<th>옵션가격</th>
					<th>재고량</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody id="sortablelist_productOptItem" data-seq-name="item_seq">
				<!-- 
				@{if defined('item_seq')}
				<tr>
					<td class="item_seq">{item_seq}</td>
					<td>
						<input type="hidden" name="item_seq" value="{item_seq}"/>
						<input type="text" name="item_name" value="{item_name}"/></td>
					<td><input type="text" name="item_price" value="{item_price}" style="width: 50px"/></td>
					<td><input type="text" name="item_count" value="{item_count}" style="width: 50px"/></td>
					<td><button type="button" class="artn-button board delete">삭제</button></td></tr>
				@{else}
				<tr>
					<td class="item_seq">0</td>
					<td>
						<input type="hidden" name="item_seq" value="0"/>
						<input type="text" name="item_name" value=""/></td>
					<td><input type="text" name="item_price" value="" style="width: 50px"/></td>
					<td><input type="text" name="item_count" value="" style="width: 50px"/></td>
					<td><button type="button" class="artn-button board delete">삭제</button></td></tr>
				@{/if}
				 -->
			</tbody>
		</table>
		<button class="artn-button board" type="button" id="button_productOptItem_add">옵션 목록 추가</button>
		<button class="artn-button board" type="submit">작성 완료</button>
	</fieldset>
	</form>
</div>

<script type="text/javascript">
	$(document).ready(function(){
		///옵션 목록에서 옵션 설정 버튼을 눌렀을 때 수행됨
		Artn.List.inst["#sortablelist_productOpt"].editclick(function(e){
			var asyncSearch = Artn.AsyncSearch.inst["#asyncsearch_productOptItem"];
			
			if ( (e.item.id_opt_item !== undefined) && (e.item.id_opt_item !== "") ){
				asyncSearch.set("id_opt_item", e.item.id_opt_item);
				asyncSearch.submit();
			}
			else{
				Artn.List.inst["#sortablelist_productOptItem"].clear();
				Artn.List.inst["#sortablelist_productOptItem"].add();
			}
		});
		///옵션 설정 버튼 누르고 해당 옵션에 대한 아이템 리스트를 뽑아오는 것이 성공 했을 때 수행됨
		Artn.AsyncSearch.inst["#asyncsearch_productOptItem"].success(function(e){
			var sIdOptItem = "0";
			
			if (e.item[0]){
				sIdOptItem = e.item[0].id_opt_item;
			}
			
			Artn.AsyncForm.inst["#asyncform_productOptItem"].set("id_opt_item", sIdOptItem);
		});
		///옵션 아이템 수정 요청이 성공 했을 때 수행됨
		Artn.AsyncForm.inst["#asyncform_productOptItem"].success(function(e){
			console.log(e.item);
			e.sender.set("id_opt_item", e.item.id_opt_item);
			$("#dialog_productOptItem").dialog("close");
		});
		
		<%--/*Artn.AsyncForm.inst["#asyncform_optGroup"].success(function(e){
			e.sender.set("id_opt_item", e.item.id_opt_item);
		});*/--%>
		$("#button_productOpt_add").click(function(){
			Artn.List.inst["#sortablelist_productOpt"].add();
			return false;
		});
		$("#button_productOptItem_add").click(function(){
			Artn.List.inst["#sortablelist_productOptItem"].add();
			return false;
		});
	});
</script>