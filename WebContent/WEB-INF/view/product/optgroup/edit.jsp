<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - Group Action Test : Edit" contents="${contentsCode }">
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
		
		Artn.AsyncForm.inst["#asyncform_optGroup"].success(function(e){
			e.sender.set("id_opt_item", e.item.id_opt_item);
		});
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
<div class="header">
	<h1>옵션 그룹</h1>
	<div id="breadcrumbs" data-sub="${contentsCode }" data-target="auto"></div>
</div>
<div class="article">
<h1>옵션 그룹 설정</h1>
<form id="asyncform_optGroup" action="/product/optgroup/modify" method="post" data-response-type="json">
<fieldset>
<input type="hidden" name="json" value="true"/>
<s:if test="listIsNull == false">
	<input type="hidden" name="id_opt_group" value="${showData.id_opt_group }"/>
</s:if>
<table class="board-edit">
	<tbody class="row-scope">
		<tr>
			<th>옵션그룹명</th>
			<td>
				<input type="text" name="name" value="${showData.name }"/>
				<input type="hidden" name="id_group" value="0"/>
			</td>
		</tr>
	</tbody>
</table>
</fieldset>

<fieldset>
<table class="board-list">
    <thead>
		<tr>
			<th>순서</th>
			<th>옵션명</th>
			<th>필수여부</th>
			<th>옵션설정</th>
		</tr>
	</thead>
	<tbody id="sortablelist_productOpt" data-seq-name="opt_seq">
		<s:if test="listIsNull">
		<tr>
			<td><input type="text" name="opt_seq" value="1" readonly="readonly"/></td>
			<td><input type="text" name="opt_name" value=""/><input type="hidden" name="id_opt_item" value="0"/><input type="hidden" name="opt_type" value="0"/></td>
			<td><s:select name="required" list="#{'0':'아니오','1':'예' }" value="required" theme="simple"/></td>
			<td><button type="button" class="artn-button board edit" data-rule="dialogButton" data-dialog="#dialog_productOptItem">옵션목록</button>
				<button type="button" class="artn-button board delete">삭제</button>
			</td>
		</tr>
		</s:if>
		<s:else>
		<s:iterator value="listData">
		<tr>
			<td><input type="text" name="opt_seq" value="${opt_seq }" readonly="readonly"/></td>
			<td><input type="text" name="opt_name" value="${opt_name }"/><input type="hidden" name="id_opt_item" value="${id_opt_item }"/><input type="hidden" name="opt_type" value="0"/></td>
			<td><s:select name="required" list="#{'0':'아니오','1':'예' }" value="required" theme="simple"/></td>
			<td><button type="button" class="artn-button board edit" data-rule="dialogButton" data-dialog="#dialog_productOptItem">옵션목록</button>
				<button type="button" class="artn-button board delete">삭제</button>
			</td>
		</tr>
		</s:iterator>
		</s:else>
		<!-- 
		<tr>
			<td><input type="text" name="opt_seq" value="{opt_seq}" readonly="readonly"/></td>
			<td><input type="text" name="opt_name" value="{opt_name}"/><input type="hidden" name="id_opt_item" value="0"/><input type="hidden" name="opt_type" value="0"/></td>
			<td><s:select name="required" list="#{'0':'아니오','1':'예' }" theme="simple"/></td>
			<td><button type="button" class="artn-button board edit" data-rule="dialogButton" data-dialog="#dialog_productOptItem">옵션목록</button>
				<button type="button" class="artn-button board delete">삭제</button>
			</td></tr>
		 -->
	</tbody>
</table>
</fieldset>
<div class="footer board">
	<div class="buttons">
		<a id="button_productOpt_add" class="artn-button board" href="#">옵션추가</a>
		<button class="artn-button board" type="submit">수정완료</button>
		<a class="artn-button board" href="#" data-rule="gotoback">취소</a>
	</div>
</div>
</form>

</div>


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
				<tr>
					<td class="item_seq">{item_seq}</td>
					<td>
						<input type="hidden" name="item_seq" value="{item_seq}"/>
						<input type="text" name="item_name" value="{item_name}"/></td>
					<td><input type="text" name="item_price" value="{item_price}" style="width: 50px"/></td>
					<td><input type="text" name="item_count" value="{item_count}" style="width: 50px"/></td>
					<td><button type="button" class="artn-button board delete">삭제</button></td></tr>
				 -->
			</tbody>
		</table>
		<button class="artn-button board" type="button" id="button_productOptItem_add">옵션 목록 추가</button>
		<button class="artn-button board" type="submit">작성 완료</button>
	</fieldset>
	</form>
</div>

</a:html>