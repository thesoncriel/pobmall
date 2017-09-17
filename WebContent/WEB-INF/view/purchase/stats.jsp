<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title="처방전 통계" contents="${contentsCode }">
<div class="header">
    <h1>통계</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
<input type="hidden" id="paramStatus" value="${param.status }"/>
<form action="stats?contents=adm1000_5_3" method="post">
	<div class="search_div">
		<%-- <s:select name="search_div" list="#{
		                            '': '전체 목록',
		                            'id_product': '상품번호',
		                            'id_user': '아이디'
		                            }" theme="simple">
		</s:select> --%>
		<label for="date_sales_start">기간 별 검색</label> 
		<input type="hidden" name="id" value="${id }">
		<input type="text" id="datepicker_date_sales_start" name="date_sales_start" required="required" value="${showData.date_sales_start }" data-year="2013" title="상품 개시 시작일을 입력하세요." />-<input type="text" id="datepicker_date_sales_end" name="date_sales_end" required="required" value="${showData.date_sales_end }" data-year="2013" title="상품 개시 종료일을 입력하세요." />
		<select name="status">
			<option value="1">입금중</option>
			<option value="2">배송준비중</option>
			<option value="3">배송중</option>
			<option value="4">배송완료</option>
			<option value="10">판매완료</option>
			<option value="-2">구매취소</option>
			<option value="-3">환불요청</option>
			<option value="-10">환불완료</option>
		</select>
		<button class="artn-button board">검색</button>
	</div>
</form>	
<%-- <s:select name="opt_detail" list="listData.{? (#this.status == status) }" 
listKey='%{status}' listValue='%{status}' theme="simple" headerKey="" headerValue="-----선택-----"></s:select> --%>
	<div class="article">
		<div class="purchase-stats">
			<div>
			<s:if test="subIsNull.purchaseStatsUser">
			</s:if><s:else>
			<h2>유저별</h2>
				<div id="chart_line_user" data-type="line" data-from="#table_user_stats" style="margin-top:20px; margin-left:70px; width:700px; width:700px;"></div>
				<table id="table_user_stats" class="data">
						<thead>
						<tr>
							<th>상품번호</th>
							<th>금액</th>							
						</tr>
						</thead>
						<tbody>
					 <s:iterator value="subData.purchaseStatsUser" var="user">
						<tr>
							<td>${user.date_upload_fm }</td>
							<td>${user.total_price }</td>
						</tr>
					</s:iterator> 
						</tbody>
					</table>
				</s:else>
			</div>
			<div class="stats-item">
				<h2>배송별</h2>
				<ul class="tab stats distribute div7">
	         		<li><a href="/purchase/stats?contents=adm1000_5_3&status=10"><span>판매완료</span></a></li>
	         		<li><a href="/purchase/stats?contents=adm1000_5_3&status=1"><span>입금중</span></a></li>
	         		<li><a href="/purchase/stats?contents=adm1000_5_3&status=2"><span>배송준비중</span></a></li>
	         		<li><a href="/purchase/stats?contents=adm1000_5_3&status=3"><span>배송중</span></a></li>
	         		<li><a href="/purchase/stats?contents=adm1000_5_3&status=4"><span>배송완료</span></a></li>
	         		<li><a href="/purchase/stats?contents=adm1000_5_3&status=-3"><span>환불요청</span></a></li>
	         		<li><a href="/purchase/stats?contents=adm1000_5_3&status=-10"><span>환불완료</span></a></li>	         		
	       		</ul>
				<div>
					<div id="chart_bar" data-type="bar" data-from="#table_stats"></div>
					<div id="chart_pie" data-type="pie" data-from="#table_stats"></div>
					<div id="chart_line" data-type="line" data-from="#table_stats"></div>
				</div>
					<table id="table_stats" class="data">
						<thead>
						<tr>
							<th>날짜</th>
							<th>금액</th>							
						</tr>
						</thead>
						<tbody>
					 <s:iterator value="listData.{? (#this.status == status)}" var="all">
						<tr>
							<td>${all.date_upload_fm }</td>
							<td>${all.total_price }</td>
						</tr>
					</s:iterator> 
						</tbody>
					</table>
			</div>
			<div class="stats-item">
			<s:if test="subIsNull.purchasestatsbrowser">
				<div>
					<span>데이타 없음</span>
				</div>
			</s:if><s:else>
			<h2>브라우저별</h2>
				<div>
					<div id="chart_pie_browser" data-type="pie" data-from="#table_browser_stats"></div>
				</div>
				<table id="table_browser_stats" class="data" style="margin-top: 20px;">
						<thead>
						<tr>
							<th>상품번호</th>
							<th>금액</th>							
						</tr>
						</thead>
						<tbody>
					 <s:iterator value="subData.purchasestatsbrowser" var="browser">
						<tr>
							<td>${browser.browser_version }</td>
							<td>${browser.cnt }</td>
						</tr>
					</s:iterator> 
						</tbody>
					</table>
				</s:else>
			</div>
		</div>
	</div>	
</div>
<script type="text/javascript">
	function parsePieChartData(strSelector){
		var jqTrList = $(strSelector).find("tbody tr");
		var iRowLen = jqTrList.length;
		var iCellLen = jqTrList.eq(0).find("td").length;
		var jqTdList = null;
		var aData = [iRowLen];
		var iCell = 0;
		
		
		for(var iRow = 0; iRow < iRowLen; iRow++){
			aData[ iRow ] = [iCellLen];
			jqTdList = jqTrList.eq( iRow ).find("td");
			
			iCell = 0;
			aData[ iRow ][ iCell ] = jqTdList.eq( iCell ).text();
			for(iCell = 1; iCell < iCellLen; iCell++ ){
				aData[ iRow ][ iCell ] = parseFloat( jqTdList.eq( iCell ).text() );
			}
		}
		return aData;
	}
	
	function createPieChart(jqElem){
		var data = null;
	    var pie = null;

	    data = parsePieChartData( jqElem.data("from") );
		
		pie = $.jqplot( jqElem.attr("id"), [data], {
	        gridPadding: {top:0, bottom:38, left:0, right:0},
	        seriesDefaults:{
	            renderer: $.jqplot.PieRenderer, 
	            trendline:{ show: false }, 
	            rendererOptions: { padding: 8, showDataLabels: true }
	        },
	        legend:{
	            show:true, 
	            placement: "outside", 
	            rendererOptions: {
	                numberRows: 2
	            }, 
	            location: "s",
	            xoffset: 2,	            
	            marginTop: "10px"
	        }       
	    });
	}
	
	function createBarChart(jqElem){
		var data = null;
	    var bar = null;
	    
	    data = parsePieChartData( jqElem.data("from") );
	    console.log(parsePieChartData( jqElem.data("from") ));
	    
		bar = $.jqplot( jqElem.attr("id"), [data], {
			title: 'Concern vs. Occurrance',
	        gridPadding: {top:0, bottom:38, left:0, right:0},
	        series:[{renderer:$.jqplot.BarRenderer}],
	        axesDefaults: {
	            tickRenderer: $.jqplot.CanvasAxisTickRenderer ,
	            tickOptions: {	              
	              fontSize: '10pt'
	            }
	        },
	        axes: {
	          xaxis: {
	        	tickOptions:{angle: -30},  
	            renderer: $.jqplot.CategoryAxisRenderer
	          },
	        	yaxis:{
	              tickOptions:{
	                formatString:"%'d원"
	                }
	            }
	        }
	    });
	}
	
	function createLineChart(jqElem){
		var data = null;
	    var Line = null;
	    
	    data = parsePieChartData( jqElem.data("from") );    
	    
		Line = $.jqplot( jqElem.attr("id"), [data], {
			title: 'Concern vs. Occurrance',
	        gridPadding: {top:0, bottom:38, left:0, right:0},
	        axes:{
	            xaxis:{
	              renderer:$.jqplot.DateAxisRenderer,
	              tickOptions:{
	                formatString:'%Y-%m-%d'
	              } 
	            },
	            yaxis:{
	              tickOptions:{
	                formatString:"%'d원"
	                }
	            }
	          },
	          highlighter: {
	            show: true,
	            sizeAdjust: 7.5
	          },
	          cursor: {
	            show: false
	          }
	    });
	}

	$(document).ready(function(){
		$("div[id^='chart']").each(function(index){
			var jqChart = $(this);
	
			if (jqChart.data("type") === "pie"){
				createPieChart( jqChart );
			} else if(jqChart.data("type") === "bar"){
				createBarChart( jqChart );
			} else if(jqChart.data("type") === "line"){
				createLineChart( jqChart );
			} 		
		});
		Artn.Util.numberFormatToTable($("#table_stats tr td:nth-child(2)"));
		Artn.Util.numberFormatToTable($("#table_user_stats tr td:nth-child(2)"));
	});
	</script>

</a:html>