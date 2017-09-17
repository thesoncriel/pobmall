<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 사용자 목록" contents="${contentsCode }">
<script type="text/javascript">
Artn["var"] = Artn["var"] || {};
Artn["var"].timerId;
$(document).ready(function(){
	$("#id_find").click(function(){
		var jqTag = $(".left");
		var sParams = {
                "json" : true,
                "name" : jqTag.find(".name").val(),
                "phone_mobi" : jqTag.find(".selectbox_phone").val()+"-"+jqTag.find("#phone_mobi11").val()+"-"+jqTag.find("#phone_mobi12").val(),
                "find" : true
        }
        $.getJSON("/user/findid",sParams,function(data){        	
            $("#find_text").html(data.message);            
            $("#dialog_id").dialog("open");
        });
	});
    $("#passwd_find, #reconfirm").click(function(){
        stopCount();
        $(".message.alert").text("");
        var jqTag = $(".right");
        var sPhone = jqTag.find(".selectbox_phone").val()+"-"+jqTag.find("#phone_mobi21").val()+"-"+jqTag.find("#phone_mobi22").val()
        var sEmail = jqTag.find("#email1").val() + "@" + jqTag.find("#email2").val();
        var sParams = {
                "json" : true,
                "id" : jqTag.find(".id").val(),
                "name" : jqTag.find(".name").val(),
                "phone_mobi" : sPhone,
                "email" : sEmail,
                "find" : true
        }
        $.getJSON("/user/findpassword",sParams,function(data){
            if(data.code == "0"){
            	if($(this).attr("id") != "reconfirm"){
            		$("#dialog_emailResult").dialog("open");	
            	}
                /* $.post("/user/memberConfirm", {"phone_mobi" : sPhone}, function(data){
                    var timeLeft = 180; // 초 단위
                    var num = function(str)
                    {
                     if(str<10)
                      return '0'+str;
                     else
                      return str;
                    }
                    updateLeftTime();
                    function updateLeftTime() {
                     
                     timeLeft = (timeLeft <= 0) ? 0 : -- timeLeft;
                     
                     var hours = num(Math.floor(timeLeft / 3600));
                     var minutes = num(Math.floor((timeLeft - 3600 * hours) / 60));
                     var seconds = num(timeLeft % 60);
                      
                     $('#t_left_time').html(minutes+':'+seconds);
                         if(minutes === "00" && seconds === "00" ){
                            $.post("/user/memberConfirm", {"confirmTimeOut":"confirmTimeOut"}, function(data){
                                return;
                            });                 
                            stopCount();
                        } 
                        else{
                            Artn["var"].timerId = setTimeout(updateLeftTime, 1000);
                        }
                    }           
          
                    return;
                }); */
            }else if(data.code == "1"){
                alert(data.message);
            }
        });
    });
    $('#t_left_time').change(function(){
        alert(1111);
        if($('#t_left_time').text() === "00:00"){
            alert(22222);
        }   
    });
    $(".close_dialog").click(function(){
    	$("[id^=dialog]").dialog("close");
    });
    $("#passwd_open").click(function(){
    	$.post("/user/memberConfirm",{"memberConfirm":$("[name='memberConfirm']").val()},function(data){
    		var sConfirm = data.split("|");
    		$("#dialog_passwd").find(".id").val($(".right").find(".id").val());
            $("#dialog_time").dialog("close");
            $("#dialog_passwd").dialog("open");
    		/* if(sConfirm[0] == "2"){
    			$("#dialog_passwd").find(".id").val($(".right").find(".id").val());
    			$("#dialog_time").dialog("close");
                $("#dialog_passwd").dialog("open");	
    		}else{
    			$(".message.alert").text(sConfirm[1]);
    		} */
    		
    	});
    });
    function stopCount() {
        clearTimeout(Artn["var"].timerId);    
    }
});

</script>
<div class="header">
    <h1>아이디/비밀번호 찾기</h1>
    <div id="breadcrumbs" data-sub="*아이디/비밀번호 찾기"></div>
</div>
<div class="article">
    <div class="user-find">
	    <div class="left">
	    <form class="left_frm">
	        <table class="board-edit delivery">
	               <thead>
	                   <tr>
	                       <th>
	                           <span>아이디 찾기</span>
	                       </th>
	                   </tr>
	               </thead>
	                <tbody class="row-scope">
	                    <tr>
	                       <td>
	                          <ul>
	                            <li>
	                                <label>이름</label><input type="text" class="name" name="name" required="required"/>
	                            </li>
	                            <li>
	                                <label>핸드폰</label><a:phone id="phonebox_phone_mobi1" name="phone_mobi1" value="${showData.phone_mobi }" type="phone_mobi" required="required"/>
	                            </li>
	                            <li>
	                                <input type="button" id="id_find" class="artn-button find" value="아이디 확인하기"/>
	                            </li>
	                         </ul>
	                       </td>
	                    </tr>
	                </tbody>
	            </table>
	        </form>
	    </div>
	    <div class="right">
	        <form class="right_frm">
	        	<input type="hidden" id="email1" maxlength="24" name="email" value="master">
	        	<input type="hidden" id="email2" maxlength="24" name="email" value="artn.kr">
	           <table class="board-edit delivery">
	               <thead>
	                   <tr>
	                       <th>
	                           <span>비밀번호 찾기</span>
	                       </th>
	                   </tr>
	               </thead>
	                <tbody class="row-scope">
	                    <tr>
	                       <td>
	                          <ul>
	                            <li>
	                                <label>아이디</label><input type="text" class="id" name="id" required="required"/>
	                            </li>
	                            <li>
	                                <label>이름</label><input type="text" class="name" name="name" required="required"/>
	                            </li>
	                            <li>
	                                <label>핸드폰</label><a:phone id="phonebox_phone_mobi2" name="phone_mobi2" value="${showData.phone_mobi }" type="phone_mobi" required="required"/><input type="button" id="passwd_find" class="artn-button find" value="메일로 전송"/>
	                            </li>
	                        </ul>
	                       </td>
	                    </tr>
	                </tbody>
	            </table>
	        </form>
	    </div>
	    <div id="dialog_time" title="확인" data-width="200" data-height="196" data-modal="true">
	        <p>인증번호를 확인 합니다.</p>
		    <input type="text" name="memberConfirm"/>
		    <span id="t_left_time"></span>
		    <button id="passwd_open" type="button">확인</button><button id="reconfirm" type="button">재발송</button>
		    <div class="message alert"></div>
		</div>
		<div id="dialog_id" title="아이디 확인" data-width="450" data-height="200" data-modal="true">
		    <div id="find_text"></div>
		    <input type="button" class="artn-button board close_dialog" value="닫기"/>
		</div>
		<%-- <div id="dialog_passwd" title="비밀번호 변경" data-width="290" data-height="157" data-modal="true">
		    <form action="/user/pwupdate" method="post" class="validator">
		        <div>
		            <span>변경 비밀번호 :</span><input type="password" id="textbox_pw" maxlength="16" name="pw" data-minlen="6" required="required" title="비밀번호를 입력 하세요. (최소 6글자)" /><br/>
		            <span>비밀번호 확인 :</span><input type="password" id="textbox_pwre" maxlength="16" name="pwre" required="required" title="위의 내용과 똑같이 입력 하세요." />
		        </div>
		        <input type="hidden" class="id" name="id">
		        <input type="submit" class="artn-button board" value="변경완료"/>
		        <input type="button" class="artn-button board close_dialog" value="닫기"/>
		    </form>
		</div> --%>
		<div id="dialog_emailResult" data-width="500" data-height="300" style="text-align: center;">
           	<p style="background-image: url(/img/jglovis/constact-us2.gif); background-position:50%, 50%; text-indent: -65000px; height: 200px;">이메일 전송완료</p>
           	<a href="/" class="artn-button board">확인</a>
        </div>
	</div>
</div>

</a:html>