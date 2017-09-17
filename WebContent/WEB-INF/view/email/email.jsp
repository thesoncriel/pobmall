<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : List" contents="${contentsCode }">
<script>
	$(document).ready(function(){
		Artn.AsyncForm.inst["#asyncform_email"].success(function(){
			$("#dialog_emailResult").dialog("open");
		});
	});
</script>
<div class="header">
    <h1>Contact Us</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }"></div>
</div>
<div class="section">
                        <div class="article sub5_6">
                        <form id="asyncform_email" action="write" method="post" enctype="multipart/form-data" class="validator" data-message-type="none">
                        	<%--<input type="hidden" name="email_to" value="theson@paran.com"/> --%>
                        	<input type="hidden" name="contectus" value="true"/>
                            <table class="board-edit">
	                            <thead>
	                            	<tr>
	                            		<th><label>보내는분</label></th>
	                            		<td>
	                            			<select name="email_to">
	                            				<option value="jhson@artn.kr">기술지원 1팀</option>
	                            				<option value="yjyun@artn.kr">기술지원 2팀</option>
	                            				<option value="hssong@artn.kr">상품배송 1팀</option>
	                            				<option value="thkim@artn.kr">상품배송 2팀</option>	                            				
	                            			</select>
	                            		</td>
	                            	</tr>
	                                <tr>
	                                    <th><label>회사명</label></th>
	                                    <td><input type="text" name="company" required="required"/></td>  
	                                </tr>
	                                <tr>
	                                    <th><label>담당자명</label></th>
	                                    <td><input type="text" name="name" required="required"/></td>  
	                                </tr>
	                                <tr>
	                                    <th><label>연락처</label></th>
	                                    <td><a:phone name="phone" required="required"/></td>
	                                </tr>
	                                
	                                <tr>
	                                    <th><label>이메일 주소</label></th>
	                                    <td><a:email required="required" name="email"/></td>  
	                                </tr>
	                                
	                                <tr>
	                                    <th><label>사이트 주소</label></th>
	                                    <td><input type="text" name="site" data-minlen="3"/></td>
	                                </tr>
	                                
	                                <tr>
	                                    <th><label>문의 분류</label></th>
	                                    <td>
	                                        <select name="category">
	                                            <option value="상품 문의" selected="selected">상품 문의</option>
	                                            <option value="교환 문의">교환 문의</option>
	                                            <option value="배송 문의">배송 문의</option>
	                                            <option value="반품/취소/환불">반품/취소/환불</option>
	                                            <option value="기타">기타</option>
	                                        </select>
	                                    </td>
	                                </tr>
	                                
	                                <tr>
	                                    <th><label>문의 제목</label></th>
	                                    <td><input type="text" name="contentName" required="required"/></td>  
	                                </tr>
	                                
	                                <tr>
	                                    <th><label>문의 내용</label></th>
	                                    <td colspan="2"><textarea name="content"> </textarea></td>
	                                </tr>
	                                <tr>
	                                    <th><label>파일 첨부</label></th>
	                                    <td colspan="2"><input type="file" name="file_email"/></td>
	                                </tr>
	                            </thead>                   
                            </table>
                                
                                <div class="footer board">
                                	<div class="buttons">
                                		<input type="submit" value="작성 완료" class="artn-button board"/>
                            		</div>
                                </div>
						</form>
                        </div>
                        <div id="dialog_emailResult" data-width="500" data-height="300" style="text-align: center;">
                        	<p style="background-image: url(/img/jglovis/constact-us2.gif); background-position:50%, 50%; text-indent: -65000px; height: 200px;">이메일 전송완료</p>
                        	<a href="/main" class="artn-button board">확인</a>
                        </div>
                        
                        
</div>
</a:html>