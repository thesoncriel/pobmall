<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - Custom Tags">
<div class="header">
    <h1>Custom Tag Library</h1>
    <div id="breadcrumbs" data-sub="*Custom Tags" data-target="left"></div>
</div>
<div class="section">

<div class="article">
	<h2>Common Attribute</h2>
	<p>아래는 커스텀 태그에 공통으로 적용되는 속성이다.</p>
	<table class="board-list">     
		<thead>
		<tr>
			<th>name</th>
			<th>type</th>
			<th>desc</th>
		</tr>
		</thead>
		<tbody class="row-scope">
		<tr>
			<td><strong>id</strong></td>
			<td>String</td>
			<td>결과 태그에 id 속성을 설정 한다.</td>
		</tr>
		<tr>
			<td><strong>name</strong></td>
			<td>String</td>
			<td>결과 태그가 입력 양식 종류일 경우 name 속성을 부여 한다.</td>
		</tr>
		<tr>
			<td><strong>value</strong></td>
			<td>String | Integer | Object | List</td>
			<td>커스텀 태그에 쓰일 값을 설정한다. 각 태그별로 받아들이는 데이터형이 다를 수 있다.</td>
		</tr>
		<tr>
			<td><strong>cssClass</strong></td>
			<td>String</td>
			<td>결과 태그에 class 속성을 부여 한다.</td>
		</tr>
		<tr>
			<td><strong>style</strong></td>
			<td>String</td>
			<td>결과 태그에 inline-style을 부여 한다.</td>
		</tr>
		</tbody>
	</table>
</div>

<div class="article">
	<h2>checkboxlist</h2>
	<p>특정 데이터를 비트연산을 통해 여러개의 체크 박스를 만들고자 할 때 쓰인다. </p>
	<table class="board-list">
		<thead>
		<tr>
			<th>name</th>
			<th>type</th>
			<th>req.</th>
			<th>desc</th>
		</tr>
		</thead>
		<tbody class="row-scope">
		<tr>
			<td><strong>name</strong></td>
			<td>String</td>
			<td>●</td>
			<td>체크박스들의 name 속성 값을 설정한다. 만들어진 모든 체크박스는 같은 name을 공유 한다.</td>
		</tr>
		<tr>
			<td><strong>value</strong></td>
			<td>Integer | <strong>0</strong></td>
			<td></td>
			<td>체크박스를 표현할 때 쓰일 데이터.</td>
		</tr>
		<tr>
			<td><strong>wrap</strong></td>
			<td>TagName | <strong>span</strong></td>
			<td></td>
			<td>체크박스 목록 전체를 감싸주는 태그를 설정한다.</td>
		</tr>
		<tr>
			<td><strong>subWrap</strong></td>
			<td>TagName | <strong>null</strong></td>
			<td></td>
			<td>각각의 체크박스를 감싸주는 태그를 설정한다.</td>
		</tr>
		<tr>
			<td><strong>listKey</strong></td>
			<td>String</td>
			<td>▲</td>
			<td>list 속성의 데이터형이 List&lt;Map>일 경우 <strong>필수</strong>. List 요소인 Map의 어떤 key에 해당되는 데이터를 사용할지를 설정한다.</td>
		</tr>
		<tr>
			<td><strong>type</strong></td>
			<td><strong>checkbox</strong> | radio</td>
			<td></td>
			<td>체크박스의 형태를 설정한다.</td>
		</tr>
		<tr>
			<td><strong>offset</strong></td>
			<td>Integer | <strong>0</strong></td>
			<td></td>
			<td>value의 정수 데이터 사용 시 몇번째 비트의 것 부터 사용할지를 설정한다. 첫번째 자리면 0, 두번째 자리면 1이다.</td>
		</tr>
		<tr>
			<td><strong>list</strong></td>
			<td>String | List&lt;Map></td>
			<td>●</td>
			<td>체크박스 옆의 label 내용을 목록의 형태로써 받는다. "목록1,목록2..."의 형태로 사용하거나 EL 구문으로 사용 한다.</td>
		</tr>
		</tbody>
	</table>
	
	<h3>예제1</h3>
	<h4>코드</h4>
	<pre>
&lt;a:checkboxlist name="checklist1" list="하나,둘,셋,넷,다섯,여섯" value="10"/>
	</pre>
	<h4>결과</h4>
	<a:checkboxlist name="checklist1" list="하나,둘,셋,넷,다섯,여섯" value="10"/>
	
	<h3>예제2</h3>
	<h4>코드</h4>
	<pre>
&lt;a:checkboxlist name="checklist2" list="하나,둘,셋,넷,다섯,여섯" value="12" wrap="div" subWrap="div"/>
	</pre>
	<h4>결과</h4>
	<a:checkboxlist name="checklist2" list="하나,둘,셋,넷,다섯,여섯" value="12" wrap="div" subWrap="div"/>
	
	<h3>예제3</h3>
	<h4>코드</h4>
	<pre>
&lt;a:checkboxlist name="checklist3" list="하나,둘,셋,넷,다섯,여섯" value="16" type="radio"/>
	</pre>
	<h4>결과</h4>
	<a:checkboxlist name="checklist3" list="하나,둘,셋,넷,다섯,여섯" value="16" type="radio"/>
</div>
<div class="article">
    <h2>dialog</h2>
    <p>다이얼로그 창을 생성하고 띄워준다.</p>
    <table class="board-list">
        <thead>
            <tr>
                <th>name</th>
	            <th>type</th>
	            <th>req.</th>
	            <th>desc</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><strong>width</strong></td>
                <td>Integer | 100</td>
	            <td>●</td>
	            <td>다이얼로그 창의 가로크기를 지정한다.</td>
            </tr>
            <tr>
                <td><strong>height</strong></td>
                <td>Integer | 100</td>
                <td>●</td>
                <td>다이얼로그 창의 세로크기를 지정한다.</td>
            </tr>
            <tr>
                <td><strong>popupOpt</strong></td>
                <td>Integer | 0</td>
                <td>●</td>
                <td>다이얼로그 옵션변경(bit연산)</td>
            </tr>
            <tr>
                <td><strong>index</strong></td>
                <td>Integer | 1</td>
                <td>●</td>
                <td>다이얼로그 우선순위 변경.</td>
            </tr>
            <tr>
                <td><strong>positionX</strong></td>
                <td>Integer | 100</td>
                <td>●</td>
                <td>다이얼로그창 x좌표.</td>
            </tr>
            <tr>
                <td><strong>positionY</strong></td>
                <td>Integer | 100</td>
                <td>●</td>
                <td>다이얼로그창 y좌표.</td>
            </tr>
            <tr>
                <td><strong>popupContent</strong></td>
                <td>String</td>
                <td>●</td>
                <td>다이얼로그 내용.</td>
            </tr>
        </tbody>
    </table>
    
    <h3>예제1</h3>
    <h4>코드</h4>
    <pre>
		&lt;a:dialog id="dialog_popup$" width="400" height="400" popupOpt="5" index="1" positionX="200" positionY="200" title="팝업"
		              popupContent="&lt;p>팝업 테스트&lt;img src="/download?path=/upload/board/up_file/&fileName=som-jms-i5p-i phone5-red.jpg" width="343" height="321" align="bottom" alt="som-jms-i5p-i phone5-red.jpg" title="" style="font-size: 13px; line-height: 20px;">&lt;/p>"/>  
    </pre>
</div>
<div class="article">
	<h2>email</h2>
	<p>email 형태의 데이터를 자동으로 분리하고 표현하는데 쓰인다.</p>
	<table class="board-list">
		<thead>
		<tr>
			<th>name</th>
			<th>type</th>
			<th>req.</th>
			<th>desc</th>
		</tr>
		</thead>
		<tbody class="row-scope">
		<tr>
			<td><strong>name</strong></td>
			<td>String</td>
			<td></td>
			<td>email 박스들의 name 속성 값을 설정한다. 만들어진 모든 입력 박스는 같은 name을 공유 한다.</td>
		</tr>
		<tr>
			<td><strong>value</strong></td>
			<td>String</td>
			<td></td>
			<td>email 박스를 표현할 때 쓰일 데이터.</td>
		</tr>
		<tr>
			<td><strong>required</strong></td>
			<td>required</td>
			<td></td>
			<td>본 항목이 필수일 경우 삽입한다.</td>
		</tr>
		<tr>
			<td><strong>wrap</strong></td>
			<td>TagName | <strong>span</strong></td>
			<td></td>
			<td>체크박스 목록 전체를 감싸주는 태그를 설정한다.</td>
		</tr>
		</tbody>
	</table>
	
	<h3>예제1</h3>
	<h4>코드</h4>
	<pre>
&lt;form class="validator">
&lt;a:email name="email1" value="theson@paran.com"/>
&lt;/form>	
	</pre>
	<h4>결과</h4>
	<form class="validator">
	<a:email name="email1" value="theson@paran.com"/>
	</form>	
	
	<h3>예제2</h3>
	<h4>코드</h4>
	<pre>
&lt;form class="validator">
&lt;a:email name="email2" required="required"/>&lt;br/>
&lt;button type="submit">확인&lt;/button>
&lt;/form>
	</pre>
	<h4>결과</h4>
	<form class="validator">
	<a:email name="email2" required="required"/><br/>
	<button type="submit">확인</button>
	</form>
</div>

<div class="article">
	<h2>file</h2>
	<p>file을 업로드 하는데 쓰인다. Ajax를 통한 이미지 업로드도 지원 한다.</p>
	<table class="board-list">
		<thead>
		<tr>
			<th>name</th>
			<th>type</th>
			<th>req.</th>
			<th>desc</th>
		</tr>
		</thead>
		<tbody class="row-scope">
		<tr>
			<td><strong>name</strong></td>
			<td>String</td>
			<td>●</td>
			<td>file 입력란의 name 속성 값을 설정한다.</td>
		</tr>
		<tr>
			<td><strong>value</strong></td>
			<td>String</td>
			<td></td>
			<td>이미 업로드 된 파일명. 실제 업로드된 파일명을 기재한다.</td>
		</tr>
		<tr>
			<td><strong>oriValue</strong></td>
			<td>String</td>
			<td></td>
			<td>이미 업로드 된 파일명. 사용자가 다운받을 때 쓰이는 파일명을 기재한다.</td>
		</tr>
		<tr>
			<td><strong>path</strong></td>
			<td>String</td>
			<td>▲</td>
			<td>파일을 Ajax로 업로드 할 경로를 설정 한다. <strong>Ajax 사용 시 필수.</strong> 업로드 후 되받아오는 실 경로는 path/name/filename 와 같은 형식이다.</td>
		</tr>
		<tr>
			<td><strong>thumbWidth</strong></td>
			<td>Integer</td>
			<td></td>
			<td>Ajax 이미지 업로드 시 만들게될 썸네일의 너비값을 설정 한다.</td>
		</tr>
		<tr>
			<td><strong>thumbHeight</strong></td>
			<td>Integer</td>
			<td></td>
			<td>Ajax 이미지 업로드 시 만들게될 썸네일의 높이값을 설정 한다.</td>
		</tr>
		<tr>
			<td><strong>action</strong></td>
			<td>URI</td>
			<td></td>
			<td>Ajax 이미지 업로드 시 사용할 컨트롤러의 경로를 설정 한다. 미설정 시 js에서 기본 경로로 사용 한다.</td>
		</tr>
		<tr>
			<td><strong>toImg</strong></td>
			<td>class name</td>
			<td></td>
			<td>Ajax 이미지 업로드 후 그 이미지를 표현할 이미지 태그의 클래스명. 현재 파일 태그가 위치한 곳과 가장 가까운 이미지 태그를 찾는다.</td>
		</tr>
		<tr>
			<td><strong>downloader</strong></td>
			<td>URI | <strong>'/download?path='</strong></td>
			<td></td>
			<td>Ajax 이미지 업로드 후 Ajax로 이미지 경로를 다시 받아올 때 쓰이는 다운로드 컨트롤러의 경로를 설정 한다.</td>
		</tr>
		</tbody>
	</table>
	
	<h3>예제1</h3>
	<h4>코드</h4>
	<pre>
&lt;form class="validator">
&lt;a:file id="file1" name="file1" path="/upload/"/>
&lt;button type="submit">확인&lt;/button>
&lt;/form>
	</pre>
	<h4>결과</h4>
	<form class="validator">
	<a:file id="file1" name="file1" path="/upload/"/>
	<button type="submit">확인</button>
	</form>
	
	
	<h3>예제2</h3>
	<h4>코드</h4>
	<pre>
&lt;form class="validator">
&lt;img src="" class="file2" width="300"/>&lt;br/>
&lt;a:file id="ajaxupload_file2" name="file2" path="/upload/"/>
&lt;button type="submit">확인&lt;/button>
&lt;/form>	
	</pre>
	<h4>결과</h4>
	<form class="validator">
	<img src="" class="file2" width="300"/><br/>
	<a:file id="ajaxupload_file2" name="file2" path="/upload/"/>
	<button type="submit">확인</button>
	</form>	
</div>

<div class="article">
	<h2>html</h2>
	<p>프로젝트에 공통으로 쓰이는 기본 문서구조를 사용한다. html, head, body 및 각종 contents wrapper 등이 포함 된다.</p>
	<table class="board-list">
		<thead>
		<tr>
			<th>name</th>
			<th>type</th>
			<th>req.</th>
			<th>desc</th>
		</tr>
		</thead>
		<tbody class="row-scope">
		<tr>
			<td><strong>title</strong></td>
			<td>String</td>
			<td>●</td>
			<td>웹브라우저 상단에 표현될 문서 제목을 설정 한다. &lt;head> 태그 내의 &lt;title> 태그 내용에 적용 된다.</td>
		</tr>
		</tbody>
	</table>
	
	<h3>예제1</h3>
	<h4>코드</h4>
	<pre>
&lt;a:html title=" - Custom Tags">
&lt;div class="header">
    &lt;h1>Welcome To Arotechno !!&lt;/h1>
    &lt;div id="breadcrumbs" data-sub="*Test" data-target="left">&lt;/div>
&lt;/div>
&lt;div class="section">
&lt;div class="article">
&lt;!-- any contents... -->
&lt;/div>
&lt;/div>
&lt;/a:html>
	</pre>
</div>

<div class="article">
	<h2>img</h2>
	<p>데이터(이미지 파일명)의 존재 유무를 판단하여 자동으로 대체 이미지를 보여준다.</p>
	<table class="board-list">
		<thead>
		<tr>
			<th>name</th>
			<th>type</th>
			<th>req.</th>
			<th>desc</th>
		</tr>
		</thead>
		<tbody class="row-scope">
		<tr>
			<td><strong>alt</strong></td>
			<td>String</td>
			<td></td>
			<td>img 태그의 alt 속성과 대응 된다.</td>
		</tr>
		<tr>
			<td><strong>altNone</strong></td>
			<td>String</td>
			<td></td>
			<td>img 태그의 alt 속성과 대응 된다. 데이터가 없을 경우 표현된다.</td>
		</tr>
		<tr>
			<td><strong>src</strong></td>
			<td>URI</td>
			<td></td>
			<td>img 태그의 src 속성과 대응 된다.</td>
		</tr>
		<tr>
			<td><strong>srcNone</strong></td>
			<td>URI</td>
			<td></td>
			<td>img 태그의 src 속성과 대응 된다. 데이터가 없을 경우 표현된다.</td>
		</tr>
		<tr>
			<td><strong>title</strong></td>
			<td>String</td>
			<td></td>
			<td>img 태그의 title 속성과 대응 된다.</td>
		</tr>
		<tr>
			<td><strong>width</strong></td>
			<td>Integer</td>
			<td></td>
			<td>img 태그의 width 속성과 대응 된다.</td>
		</tr>
		<tr>
			<td><strong>height</strong></td>
			<td>Integer</td>
			<td></td>
			<td>img 태그의 height 속성과 대응 된다.</td>
		</tr>
		</tbody>
	</table>
	
	<h3>예제1</h3>
	<h4>코드</h4>
	<pre>
있을 때: &lt;a:img src="/img/check.gif" srcNone="/img/none.png" alt="있음" altNone="없음" width="100" height="100"/>&lt;br/>
없을 때: &lt;a:img src="" srcNone="/img/none.png" alt="있음" altNone="없음" width="100" height="100"/>
	</pre>
	<h4>결과</h4>
	있을 때: <a:img src="/img/check.gif" srcNone="/img/none.png" alt="있음" altNone="없음" width="100" height="100"/><br/>
	없을 때: <a:img src="" srcNone="/img/none.png" alt="있음" altNone="없음" width="100" height="100"/>
</div>

<div class="article">
	<h2>pagenav</h2>
	<p>페이지 네비게이터 (혹은 페이지컨트롤러)를 생성한다.</p>
	<table class="board-list">
		<thead>
		<tr>
			<th>name</th>
			<th>type</th>
			<th>req.</th>
			<th>desc</th>
		</tr>
		</thead>
		<tbody class="row-scope">
		<tr>
			<td><strong>uri</strong></td>
			<td>URI | <strong>Current</strong></td>
			<td></td>
			<td>네비게이터에서 쓰일 URI - 하이퍼링크로 넘어갈 주소 - 를 설정 한다. 예) /board/list.action</td>
		</tr>
		<tr>
			<td><strong>type</strong></td>
			<td><strong>inline</strong> | table</td>
			<td></td>
			<td>네비게이터의 최종 렌더링 형태를 설정한다. inline일 경우 span과 div를, table일 경우 table태그를 사용한다.</td>
		</tr>
		<tr>
			<td><strong>page</strong></td>
			<td>Integer | <strong>0</strong></td>
			<td></td>
			<td>현재 선택된 페이지에 대한 설정을 한다. 적용 시 보여지는 네비게이터의 페이지 숫자에 selected class가 추가된다.</td>
		</tr>
		<tr>
			<td><strong>rowLimit</strong></td>
			<td>Integer | <strong>10</strong></td>
			<td></td>
			<td>현재 게시물 리스트가 최대 몇행까지를 표현하는지 설정한다.</td>
		</tr>
		<tr>
			<td><strong>rowCount</strong></td>
			<td>Integer</td>
			<td>●</td>
			<td>현재 게시물 리스트가 페이징을 제외할 시 최대 몇행까지 존재하는지를 설정한다.</td>
		</tr>
		<tr>
			<td><strong>navCount</strong></td>
			<td>Integer | <strong>10</strong></td>
			<td></td>
			<td>네비게이터에서 보여질 최대 페이지수를 설정한다.</td>
		</tr>
		<tr>
			<td><strong>font</strong></td>
			<td><strong>'eng'</strong> | 'kor' | 'symbol' | String</td>
			<td></td>
			<td>'처음, 이전, 다음, 맨끝'과 같은 링크 글자를 어떻게 표현할지를 설정한다.</td>
		</tr>
		<tr>
			<td><strong>params</strong></td>
			<td>List&lt;Map> | String</td>
			<td></td>
			<td>네비게이터에 GET 방식으로 적용될 파라메터값을 설정한다.</td>
		</tr>
		</tbody>
	</table>
	
	<h3>예제1 - 기본</h3>
	<h4>코드</h4>
	<pre>
&lt;a:pagenav cssClass="page-controller" rowCount="125"/>
	</pre>
	<h4>결과</h4>
	<a:pagenav cssClass="page-controller" rowCount="125"/>
	
	<h3>예제2 - 페이지 및 최대 행 수 설정</h3>
	<h4>코드</h4>
	<pre>
&lt;a:pagenav cssClass="page-controller" rowCount="125" page="3" rowLimit="20"/>
	</pre>
	<h4>결과</h4>
	<a:pagenav cssClass="page-controller" rowCount="125" page="3" rowLimit="20"/>
	
	<h3>예제3 - 네비게이션 개수 설정</h3>
	<h4>코드</h4>
	<pre>
&lt;a:pagenav cssClass="page-controller" rowCount="125" page="4" navCount="5"/>
	</pre>
	<h4>결과</h4>
	<a:pagenav cssClass="page-controller" rowCount="125" page="4" navCount="5"/>
	
	<h3>예제4 - 테이블 타입으로 변경</h3>
	<h4>코드</h4>
	<pre>
&lt;a:pagenav cssClass="page-controller" rowCount="95" type="table"/>
	</pre>
	<h4>결과</h4>
	<a:pagenav cssClass="page-controller" rowCount="95" type="table"/>
	
	<h3>예제5 - URI 및 파라메터 설정</h3>
	<h4>코드</h4>
	<pre>
&lt;a:pagenav cssClass="page-controller" rowCount="95" uri="/artn/list" params="name=하하&subject=학교가자"/>
	</pre>
	<h4>결과</h4>
	<a:pagenav cssClass="page-controller" rowCount="95" uri="/artn/list" params="name=하하&subject=학교가자"/>
	
	<h3>예제6 - 폰트 설정</h3>
	<h4>코드</h4>
	<pre>
한글: &lt;a:pagenav cssClass="page-controller" rowCount="100" font="kor"/>
심볼: &lt;a:pagenav cssClass="page-controller" rowCount="100" font="symbol"/>
사용자정의: &lt;a:pagenav cssClass="page-controller" rowCount="100" font="처음,후진,전진,목적"/>
	</pre>
	<h4>결과</h4>
	한글: <a:pagenav cssClass="page-controller" rowCount="100" font="kor"/>
	심볼: <a:pagenav cssClass="page-controller" rowCount="100" font="symbol"/>
	사용자정의: <a:pagenav cssClass="page-controller" rowCount="100" font="처음,후진,전진,목적"/>
</div>

<div class="article">
	<h2>phone</h2>
	<p>전화번호 형태의 데이터를 selectbox와 textbox 두개로 나누어서 보여준다.</p>
	<table class="board-list">
		<thead>
		<tr>
			<th>name</th>
			<th>type</th>
			<th>req.</th>
			<th>desc</th>
		</tr>
		</thead>
		<tbody class="row-scope">
		<tr>
			<td><strong>wrap</strong></td>
			<td>TagName | <strong>'span'</strong></td>
			<td></td>
			<td>컨트롤을 감싸줄 태그를 설정한다.</td>
		</tr>
		<tr>
			<td><strong>type</strong></td>
			<td><strong>phone</strong> | phone_mobi</td>
			<td></td>
			<td>phone일 경우 select에 모바일앞번호 외 지역번호까지 출력한다. phone_mobi는 모바일 번호만 출력한다.</td>
		</tr>
		<tr>
			<td><strong>name</strong></td>
			<td>String</td>
			<td></td>
			<td>구성되는 select, text 에서 쓰일 name 속성을 설정 한다. 모두 동일한 값으로 설정 된다.</td>
		</tr>
		<tr>
			<td><strong>value</strong></td>
			<td>String</td>
			<td></td>
			<td>전화번호 형태의 데이터를 설정한다. 설정 시 하이픈(-)을 기준으로 쪼개어 각 자리에 위치 시킨다.</td>
		</tr>
		<tr>
			<td><strong>required</strong></td>
			<td>required</td>
			<td></td>
			<td>본 항목이 필수요소일 경우 적용한다. js에서 컨트롤 하며 사용시 form.validator 가 필요하다.</td>
		</tr>
		</tbody>
	</table>
	
	<h3>예제1</h3>
	<h4>코드</h4>
	<pre>
&lt;a:phone name="phone" value="010-7557-6100"/>
	</pre>
	<h4>결과</h4>
	<a:phone name="phone" value="010-7557-6100"/>
</div>

<div class="article">
	<h2>selectbox</h2>
	<p>지정한 범위의 개수, 횟수를 표현하여 사용하거나 정수데이터의 쉬프트연산을 응용, 혹은 10진수가 나열된 문자열 형태의 데이터를 특정 자릿수대로 쪼개어 selectbox로 표현하고자 할 때 쓰인다.</p>
	<table class="board-list">
		<thead>
		<tr>
			<th>name</th>
			<th>type</th>
			<th>req.</th>
			<th>desc</th>
		</tr>
		</thead>
		<tbody class="row-scope">
		<tr>
			<td><strong>name</strong></td>
			<td>String</td>
			<td></td>
			<td>select의 name 속성에 대응 된다.</td>
		</tr>
		<tr>
			<td><strong>value</strong></td>
			<td>Integer | String</td>
			<td></td>
			<td>select에 적용할 값을 설정한다. 정수, 혹은 10진수만으로 이루어진 문자열만을 사용.</td>
		</tr>
		<tr>
			<td><strong>type</strong></td>
			<td><strong>numeric</strong> | split | shift</td>
			<td></td>
			<td>데이터가 사용될 방법을 설정한다.
				<ul>
					<li>numeric: 일반적인 방법으로 정수 데이터를 사용한다.</li>
					<li>split: 10진수 문자열을 특정 자릿수만큼 잘라서 사용한다.</li>
					<li>shift: 정수를 쉬프트 연산을 이용하여 사용한다.</li>
				</ul> 
			</td>
		</tr>
		<tr>
			<td><strong>min</strong></td>
			<td>Integer | <strong>0</strong></td>
			<td></td>
			<td>select에서 표현될 option의 최소값을 설정한다.</td>
		</tr>
		<tr>
			<td><strong>max</strong></td>
			<td>Integer | <strong>10</strong></td>
			<td></td>
			<td>select에서 표현될 option의 최대값을 설정한다.</td>
		</tr>
		<tr>
			<td><strong>step</strong></td>
			<td>Integer | <strong>1</strong></td>
			<td></td>
			<td>min과 max를 이용하여 option을 출력할 때 각 값사이의 범위를 설정한다.</td>
		</tr>
		<tr>
			<td><strong>unit</strong></td>
			<td>String</td>
			<td></td>
			<td>option 출력 시 뒤에 '단위'를 출력하고자 할 때 쓰인다. option의 value에는 영향을 미치지 않는다.</td>
		</tr>
		<tr>
			<td><strong>zero</strong></td>
			<td>String</td>
			<td></td>
			<td>option 출력 시 0값에 대하여 임의의 출력값을 원할 때 쓰인다. option의 value에는 영향을 미치지 않는다.</td>
		</tr>
		<tr>
			<td><strong>digit</strong></td>
			<td>Integer | <strong>1</strong></td>
			<td></td>
			<td><strong>쉬프트연산, 10진수 문자열 이용 시</strong> 몇자리씩 끊어서 쓸지를 설정한다.</td>
		</tr>
		<tr>
			<td><strong>index</strong></td>
			<td>Integer | <strong>0</strong></td>
			<td></td>
			<td><strong>쉬프트연산, 혹은 10진수 문자열 이용 시</strong> 몇번째 자리에서 데이터를 받아올지를 지정한다. 사용시 digit 속성값만큼 자릿수를 넘긴다.</td>
		</tr>
		</tbody>
	</table>
	
	<h3>예제1 - 통상적인 방법 (type='numeric')</h3>
	<h4>코드</h4>
	<pre>
기본: &lt;a:selectbox max="20" value="18"/>&lt;br/>
min, max, step 설정: &lt;a:selectbox min="10" max="20" step="3" value="16"/>&lt;br/>
unit 설정: &lt;a:selectbox value="8" unit="회"/>&lt;br/>
zero 설정: &lt;a:selectbox max="20" unit="개" zero="선택안함"/>&lt;br/>
	</pre>
	<h4>결과</h4>
	기본: <a:selectbox max="20" value="18"/><br/>
	min, max, step 설정: <a:selectbox min="10" max="20" step="3" value="16"/><br/>
	unit 설정: <a:selectbox value="8" unit="회"/><br/>
	zero 설정: <a:selectbox max="20" unit="개" zero="선택안함"/><br/>
	
	<h3>예제2 - 10진수 쪼개기 (10진수는 쪼갤 시 좌측을 기준으로 쪼갠다.)</h3>
	<h4>코드</h4>
	<pre>
기본: &lt;a:selectbox type="split" value="309081179650"/>&lt;br/>
offset 설정: &lt;a:selectbox type="split" value="309081179650" offset="2"/>&lt;br/>
digit 설정: &lt;a:selectbox type="split" value="309081179650" digit="3" max="999"/>&lt;br/>
offset, digit 설정: &lt;a:selectbox type="split" value="309081179650" digit="3" max="999" offset="3"/>&lt;br/>
	</pre>
	<h4>결과</h4>
	기본: <a:selectbox type="split" value="309081179650"/> value="<strong style="color:red">3</strong>09081179650"<br/>
	offset 설정: <a:selectbox type="split" value="309081179650" offset="2"/> value="30<strong style="color:red">9</strong>081179650"<br/>
	digit 설정: <a:selectbox type="split" value="309081179650" digit="3" max="999"/> value="<strong style="color:red">309</strong>081179650"<br/>
	offset, digit 설정: <a:selectbox type="split" value="309081179650" digit="3" max="999" offset="3"/> value="309081179<strong style="color:red">650</strong>"<br/>
	
	<h3>예제3 - 쉬프트 연산 (2진수로 배열했을 때 우측을 기준으로 쉬프트 연산 한다.)</h3>
	<h4>코드</h4>
	<pre>
기본: &lt;a:selectbox type="shift" value="123"/>&lt;br/>
offset 설정: &lt;a:selectbox type="shift" value="123" offset="2"/>&lt;br/>
digit 설정: &lt;a:selectbox type="shift" value="123" digit="3"/>&lt;br/>
offset, digit 설정: &lt;a:selectbox type="shift" value="123" offset="1" digit="3"/>&lt;br/>
	</pre>
	<h4>결과</h4>
	※  123 = 0111,1011(2)<br/>
	기본: <a:selectbox type="shift" value="123"/> value= 0111,101<strong style="color:red">1</strong>(2)<br/>
	offset 설정: <a:selectbox type="shift" value="123" offset="2"/> value= 0111,1<strong style="color:red">0</strong>11(2)<br/>
	digit 설정: <a:selectbox type="shift" value="123" digit="3"/> value= 0111,1<strong style="color:red">011</strong>(2) = 3(10)<br/>
	offset, digit 설정: <a:selectbox type="shift" value="123" offset="1" digit="3"/> value= 01<strong style="color:red">11,1</strong>011(2) = 7(10)<br/>
</div>

<div class="article">
    <h2>surveyradio</h2>
    <p>예/아니오 라디오박스를 생성한다(bit연산).</p>
    <table class="board-list">
        <thead>
            <tr>
                <th>name</th>
                <th>type</th>
                <th>req.</th>
                <th>desc</th>
            </tr>
        </thead>
        <tbody class="row-scope">
            <tr>
                <td>value</td>
                <td>Integer | 0</td>
                <td></td>
                <td>라디오박스를 표현할 때 쓰일 데이터.</td>
            </tr>
            <tr>
                <td>offset</td>
                <td>Integer | 0</td>
                <td></td>
                <td>value의 정수 데이터 사용 시 몇번째 비트의 것 부터 사용할지를 설정한다. 첫번째 자리면 0, 두번째 자리면 1이다. radio박스를 그룹화한다.</td>
            </tr>
            <tr>
                <td>wrap</td>
                <td>TagName | span</td>
                <td></td>
                <td>라디오박스 목록 전체를 감싸주는 태그를 설정한다.</td>
            </tr>
            <tr>
                <td>subWrap</td>
                <td>TagName | null</td>
                <td></td>
                <td>각각의 라디오박스를 감싸주는 태그를 설정한다.</td>
            </tr>
            <tr>
                <td>required</td>
                <td>String</td>
                <td></td>
                <td>라디오박스의 필수여부 체크.</td>
            </tr>
            <tr>
                <td>unchecked</td>
                <td>boolean</td>
                <td></td>
                <td>라디오박스의 기본값 체크여부. 미입력시 false(체크함) 기본: 아니오</td>
            </tr>
            <tr>
                <td>labelShow</td>
                <td>boolean</td>
                <td></td>
                <td>라디오버튼의 레이블 표시 여부</td>
            </tr>
            <tr>
                <td>disabled</td>
                <td>String</td>
                <td></td>
                <td>라디오박스의 사용여부.</td>
            </tr>
        </tbody>
    </table>
    <h3>예제1</h3>
    <h4>코드</h4>
    <pre>
&lt;a:surveyradio name="check" value="" offset="0" subWrap="span" wrap="none" unchecked="false" labelShow="false"/>
    </pre>
    <h4>결과</h4>
    <a:surveyradio name="check" value="" offset="0" subWrap="span" wrap="none" unchecked="false" labelShow="false"/>
    
    <h3>예제2</h3>
    <h4>코드</h4>
    <pre>
&lt;a:surveyradio name="check" value="" offset="1" subWrap="span" wrap="div" unchecked="false" labelShow="false"/>
&lt;a:surveyradio name="check" value="" offset="2" subWrap="span" wrap="div" unchecked="true" labelShow="false"/>
    </pre>
    <h4>결과</h4>
    <a:surveyradio name="check" value="" offset="1" subWrap="span" wrap="div" unchecked="false" labelShow="false"/>
    <a:surveyradio name="check" value="" offset="2" subWrap="span" wrap="div" unchecked="true" labelShow="false"/>
    
    <h3>예제3</h3>
    <h4>코드</h4>
    <pre>
&lt;a:surveyradio name="check" value="" offset="3" subWrap="span" wrap="div" unchecked="false" labelShow="true"/>
&lt;a:surveyradio name="check" value="" offset="4" subWrap="span" wrap="div" unchecked="" labelShow="true"/>
    </pre>
    <h4>결과</h4>
    <a:surveyradio name="check" value="" offset="3" subWrap="span" wrap="div" unchecked="false" labelShow="true"/>
    <a:surveyradio name="check" value="" offset="4" subWrap="span" wrap="div" unchecked="" labelShow="true"/>
</div>

<div class="article">
    <h2>surveyvalue</h2>
    <p>예/아니오 라디오박스에서 선택한값을 표시 해준다.</p>
    <table class="board-list">
        <thead>
            <tr>
                <th>name</th>
                <th>type</th>
                <th>req.</th>
                <th>desc</th>
            </tr>
        </thead>
        <tbody class="row-scope">
            <tr>
                <td>value</td>
                <td>Integer | 0</td>
                <td></td>
                <td>라디오박스에서 선택한 데이터.</td>
            </tr>
            <tr>
                <td>offset</td>
                <td>Integer | 0</td>
                <td></td>
                <td>value의 정수 데이터 사용 시 몇번째 비트의 것 부터 사용할지를 설정한다. 첫번째 자리면 0, 두번째 자리면 1이다.</td>
            </tr>
            <tr>
                <td>wrap</td>
                <td>TagName | span</td>
                <td></td>
                <td>값을 감싸주는 태그를 설정한다.</td>
            </tr>
        </tbody>
    </table>
    <h3>예제1</h3>
    <h4>코드</h4>
    <pre>
&lt;a:surveyvalue value="0" wrap="span" />
&lt;a:surveyvalue value="1" wrap="span" />
    </pre>
    <h4>결과</h4>
    <a:surveyvalue value="0" wrap="span" />
    <a:surveyvalue value="1" wrap="span" />
</div>

<div class="article">
    <h2>valuebox</h2>
    <p>지정한 숫자의 값을 표현한다.</p>
    <table class="board-list">
    
        <thead>
            <tr>
                <th>name</th>
                <th>type</th>
                <th>req.</th>
                <th>desc</th>
            </tr>
        </thead>
        <tbody class="row-scope">
            <tr>
                <td>type</td>
                <td>String</td>
                <td></td>
                <td>데이터가 사용될 방법을 설정한다.<br/>
					numeric: 일반적인 방법으로 정수 데이터를 사용한다.<br/>
					split: 10진수 문자열을 특정 자릿수만큼 잘라서 사용한다.<br/>
					shift: 정수를 쉬프트 연산을 이용하여 사용한다.</td>
            </tr>
            <tr>
                <td>value</td>
                <td>String</td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td>unit</td>
                <td>String</td>
                <td></td>
                <td>단위 표시</td>
            </tr>
            <tr>
                <td>zero</td>
                <td>String</td>
                <td></td>
                <td>기본값 표시</td>
            </tr>
            <tr>
                <td>digit</td>
                <td>Integer</td>
                <td></td>
                <td>쉬프트연산, 10진수 문자열 이용 시 몇자리씩 끊어서 쓸지를 설정한다.</td>
            </tr>
            <tr>
                <td>index</td>
                <td>Integer</td>
                <td></td>
                <td>쉬프트연산, 혹은 10진수 문자열 이용 시 몇번째 자리에서 데이터를 받아올지를 지정한다. 사용시 digit 속성값만큼 자릿수를 넘긴다.</td>
            </tr>
        </tbody>
    </table>
    <h3>예제1</h3>
    <h4>코드</h4>
    <pre>
        Numeric (Default) : &lt;a:valuebox value="3"/>
        Split : &lt;a:valuebox value="013693543" type="split" digit="3" index="2"/>
        Shift : &lt;a:valuebox value="013693543" type="shift" digit="3" index="0"/>
    </pre>
    <h4>결과</h4>
    Numeric (Default) : <a:valuebox value="3"/><br/>
    Split : <a:valuebox value="013693543" type="split" digit="3" index="2"/> value = "013693<strong style="color: red;">543</strong>"<br/>
    Shift : <a:valuebox value="013693543" type="shift" digit="3" index="0"/> 2진수 value = "01100<strong style="color: red;">111</strong>"  
    <h3>예제1</h3>
    <h4>코드</h4>
    <pre>
        0 일때: &lt;a:valuebox value="0" zero="하나도 없음" unit="개"/>
        1 일때: &lt;a:valuebox value="1" zero="하나도 없음" unit="개"/>
        2 일때: &lt;a:valuebox value="2" zero="하나도 없음" unit="개"/>
    </pre>
    <h4>결과</h4>
    0 일때: <a:valuebox value="0" zero="하나도 없음" unit="개"/><br/>
	1 일때: <a:valuebox value="1" zero="하나도 없음" unit="개"/><br/>
	2 일때: <a:valuebox value="2" zero="하나도 없음" unit="개"/>
</div>
<div class="article">
    <h2>valuelist</h2>
    <p>check박스에서 선택한 내용 표시</p>
    <table class="board-list">
        <thead>
            <tr>
                <th>name</th>
                <th>type</th>
                <th>req.</th>
                <th>desc</th>
            </tr>
        </thead>
        <tbody class="row-scope">
            <tr>
                <td>value</td>
                <td>Intger</td>
                <td></td>
                <td>값을 표현때 쓰이는 데이터</td>
            </tr>
            <tr>
                <td>zero</td>
                <td>String</td>
                <td></td>
                <td>value가 0이거나 값이 없을경우 표시할 내용</td>
            </tr>
            <tr>
                <td>cssCheckedClass</td>
                <td>String</td>
                <td></td>
                <td>icon을 사용할 경우 check해줄 css 클래스</td>
            </tr>
            <tr>
                <td>cssUncheckedClass</td>
                <td>String</td>
                <td></td>
                <td>icon을 사용할 경우 uncheck해줄 css 클래스</td>
            </tr>
            <tr>
                <td>wrap</td>
                <td>String</td>
                <td></td>
                <td>컨트롤을 감싸줄 태그를 설정한다.</td>
            </tr>
            <tr>
                <td>icon</td>
                <td>Boolean</td>
                <td></td>
                <td>아이콘 표시 여부를 결정한다.</td>
            </tr>
            <tr>
                <td>list</td>
                <td>List&lt;Map></td>
                <td></td>
                <td>목록의 형태로써 받는다. "목록1,목록2..."의 형태로 사용하거나 EL 구문으로 사용 한다.</td>
            </tr>
            <tr>
                <td>offset</td>
                <td>Integer</td>
                <td></td>
                <td>value의 정수 데이터 사용 시 몇번째 비트의 것 부터 사용할지를 설정한다. 첫번째 자리면 0, 두번째 자리면 1이다.</td>
            </tr>
            <tr>
                <td>listKey</td>
                <td>String</td>
                <td>▲</td>
                <td>list 속성의 데이터형이 List&lt;Map>일 경우 필수. List 요소인 Map의 어떤 key에 해당되는 데이터를 사용할지를 설정한다.</td>
            </tr>
        </tbody>
    </table>
    <h3>예제1</h3>
    <h4>코드</h4>
    <pre>
        &lt;a:valuelist list="one,two,three,four,five,six,seven" value="100"/>
    </pre>
    <h4>결과</h4>
    <a:valuelist list="one,two,three,four,five,six,seven" value="100"/>
    
    <h3>예제2</h3>
    <h4>코드</h4>
    <pre>
        &lt;a:valuelist list="one,two,three,four,five,six,seven" zero="값이 없습니다." value="100"/>
        &lt;a:valuelist list="one,two,three,four,five,six,seven" zero="값이 없습니다." value=""/>
    </pre>
    <h4>결과</h4>
    <a:valuelist list="one,two,three,four,five,six,seven" zero="값이 없습니다." value="100"/><br/>
    <a:valuelist list="one,two,three,four,five,six,seven" zero="값이 없습니다." value=""/>
    
    <h3>예제3</h3>
    <h4>코드</h4>
    <pre>
        &lt;a:valuelist list="one,two,three,four,five,six,seven" value="100" icon="true"/>
    </pre>
    <h4>결과</h4>
    <a:valuelist list="one,two,three,four,five,six,seven" value="100" icon="true"/>
</div>
</div>
</a:html>