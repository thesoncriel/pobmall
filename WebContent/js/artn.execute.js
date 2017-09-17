$(document).ready(function(){
	
    //FIXME: 상세검색 부분이 중복됨. 확인하고 수정 바람 - by jhson - 2013.07.12
    $("#search-detail").hide();
    $("a[href$='search-detail']").click(function(){
    	$("#search-detail").fadeToggle();
    	return false;
    });
    
    $("select[name='group_id']").change(function(){
        if( $("select[name='group_id']").val() === '0' ) {
            $("input[name='group_name']").attr("readonly", false);
            $("input[name='group_name']").val("");
        }
        else {
            // $("input[name='group_name']").val("value", $("select[name='group_id']").val());
            $("input[name='group_name']").attr("readonly", true);
            $("input[name='group_name']").val($("select[name='group_id']").children("option:selected").text());
        }
    });
    
    $(".paymentCancel").click(function(data){    	
    	window.open("/payment/cancel","cancel","width=700, height=450, top=200, left=500, scrollbars=no, location=no");
    	/*$(window.opener.document).find("#form_parent").submit();*/
    });
    
    // site_banner.jsp 에서 추출함. - 2013.11.19 by jhson
    $(".last .top").click(function(){
		$("html, body").animate({ scrollTop: 0 }, 600);
        return false;
	});
    
    /* porduct-show - 2013-11-20 yyj [시작] */
    (function(){
    	if( $("#list_product").length < 1 ) return;
    	Artn.List.inst["#list_product"].inputchange(function(e){
 	       var mParams = e.currentItem;
 	       var iPrice = parseInt( $("#price").val() );
 	       var iProductCnt = parseInt( mParams.find("*[name='product_count']").val() || 1);
 	       var iTotPrice = 0;
 	       var iOptPrice = 0;
 	       $("select[name^='opt_'] option:selected").each(function(){
 	 			iOptPrice += parseInt($(this).val().split(":")[1]);
 	       });
 	       iTotPrice = (iPrice + iOptPrice) * iProductCnt;
 	       var sText = $(".sum_price").contents().filter(function(){ return this.nodeType === 3; });
 	       $("input[name='price_opt']").val(iOptPrice);
 	       sText.get(0).nodeValue = iTotPrice.format(); 
 	});
  
 	/*$("select[name^='opt_']").change(function(){
 		var iValue = 0;
 		$("select[name^='opt_'] option:selected").each(function(){
 			if($(this).val() == ""){
 				iValue += 0;
 			}else{
 				iValue += parseInt($(this).val());  
 			}
 		});
 		$("input[name='price_opt']").val(iValue);
 	});*/
 	
 	$(".product-contents .tab li a").click(function(){
 		$("iframe").eq(0).attr("height", $($("iframe").eq(0).get(0).contentDocument).find("body").innerHeight()+10 );
 		$("iframe").eq(1).attr("height", $($("iframe").eq(1).get(0).contentDocument).find("body").innerHeight()+10 );
 		$("iframe").eq(0).load(function(){
 			$(this).attr("height", $($(this).get(0).contentDocument).find("body").innerHeight()+10 );
 		});
 		$("iframe").eq(1).load(function(){
 			$(this).attr("height", $($(this).get(0).contentDocument).find("body").innerHeight()+10 );
 		});
 		$($("iframe").get(0).contentDocument).find("body, a").click(function(){
 			$("iframe").attr("height", $($("iframe").get(0).contentDocument).find("body").innerHeight()+10 );
 		});  
 	});

    })();
    /* porduct-show - 2013-11-20 yyj [종료] */
    
    /* porduct-cart-list - 2013.11.20 by yyj [시작]*/
	(function(){
		if ( $(".text_sum_price").length < 1 ) return;
		$(".text_sum_price").each(function(){
	        var sText = $(this).contents().filter(function(){ return this.nodeType === 3; });
	        var iPrice = parseInt($(this).parent().parent().find("input[name='price']").val());
	        var iPriceOpt = parseInt($(this).parent().parent().find("input[name='price_opt']").val());
	        var iProductCnt = parseInt($(this).parent().parent().find("*[name='product_count']").val());	               
	        var iSumPrice = (iPrice+iPriceOpt)*iProductCnt;	        
	             
	        $(this).parent().children("input").val(iSumPrice);
		    sText.get(0).nodeValue = iSumPrice.format();	        
	        
	    });
		
		Artn.List.inst["#list_userCart"].itemremove(function(e){
			var sParams = "id_cart=" + ( ( (e.item.id_cart === null) || (e.item.id_cart === "") )? e.index : e.item.id_cart );

			$.post("delete",sParams,function(data){
				//inst.parent().parent().remove();
				alert("삭제 성공!");
	        });
			Artn.Method.totalPrice();
		});

		Artn.List.inst["#list_userCart"].inputchange(function(e){
		   var mParams = e.item;
	       var iPrice = parseInt( mParams.price );
	       var iPriceOpt = parseInt( mParams.price_opt );
	       var iProductCnt = parseInt( mParams.product_count || 1);
	       var iTotPrice = ( iPrice + iPriceOpt ) * iProductCnt;
	       if ((mParams.id_cart === undefined) || (mParams.id_cart === "")){
	           mParams.id_cart = e.index;
	       }
	       
	       e.currentItem.find(".sum_price").val(iTotPrice);
	       e.currentItem.find(".text_sum_price").text(iTotPrice.format());
	       Artn.Method.totalPrice();
	       mParams.product_count_modify = "true";
	       mParams.json = "true";
	       Artn.Ajax.userCartApply = mParams;
	       Artn.Util.timingEvent("selectTime", function(){
	    	   $.post("modify", Artn.Ajax.userCartApply, function(data){
	    		   
	    	   });
	       });
	       /* timeSet(mParams); */
		});
	    $("#my_info").click(function(){
	    	var sUrl = "/user/show?json=true";
	    	var sParams = "id="+$("#my_id").val();
	    	$.getJSON(sUrl, sParams, function(data){
	            for(var o in data){
	            	var saPhone = [];
	            	if( o == "phone_mobi" ){
	            		saPhone = data[o].split("-");
	            		var i = 0;
	            		for(i=0; i < saPhone.length; i++){
	            			//$("[name='to_"+o+"']").eq(i).val(saPhone[i]);
	            			$("*[name='to_phone_mobi']").eq(i).val(saPhone[i]);
	            		}
	            	}
	            	if( o == "phone_home" ){
	                    saPhone = data[o].split("-");
	                    var i = 0;
	                    for(i=0; i < saPhone.length; i++){
	                        //$("[name='to_"+o+"']").eq(i).val(saPhone[i]);
	                        $("*[name='to_phone_home']").eq(i).val(saPhone[i]);
	                    }
	                }
	               $("input[name='to_name']").val(data['name']);
	               $("input[name='to_zipcode']").val(data['zipcode_home']);
	               $("input[name='to_address']").val(data['address_home_new']);
	            }
	    	});
	    });
	    
	    $("#delivery_submit").click(function(){
	    	changeParam();
	    	var sParams = $("#cart-list").find("*[name='id_product']").serialize();
	        sParams += "&" + $("#cart-list").find("*[name='product_count']").serialize();
	    	$.post("/product/check",sParams,function(data){
	            var saResult = data.split("|");
	            if(saResult[0] === "0"){
	            	sMSG = saResult[1];
	                alert(sMSG);
	                return false;
	            }else{
	                $("#cart-list").submit();
	            }
	        });
	    	/* $("#cart-list").submit(); */
	    	
	    });
	    Artn.Method.totalPrice = function(){
	    	var iTotalPrice = 0;
	    	var iDeliveryPrice = parseInt($("#delivery_price").val());	    	
	        var iFreeCondition = parseInt($("#free_condition").val());
	        var iDeliveryStatus = parseInt($("#delivery_status").val());
	        
	    	$(".sum_price").each(function(){
	    		iTotalPrice += parseInt($(this).val());
	    	});
	    	
	    	var sText = $("#text_total_price").contents().filter(function(){ return this.nodeType === 3; });
	    	var sDeliveryPrice = $("#text_delivery_price").contents().filter(function(){return this.nodeType === 3; });
	    	var sProductPrice = $("#text_product_price").contents().filter(function(){return this.nodeType === 3; });

	    	if( (iTotalPrice < iFreeCondition && iTotalPrice > 0 && iDeliveryStatus !== 1)) {/*( (iTotalPrice >= iFreeCondition || iTotalPrice === 0 ) ){*/
	    		$("input[name='delivery_status']").val(2);
	    		if( iDeliveryStatus === 4 ){
	    			$("#total_price").val(iTotalPrice+iDeliveryPrice);		    		
			    	sText.get(0).nodeValue = (iTotalPrice+iDeliveryPrice).format();
			    	sProductPrice.get(0).nodeValue = iTotalPrice.format();
			    	sDeliveryPrice.get(0).nodeValue = (iDeliveryPrice).format();
	    		} else {	    			
		    		$("#total_price").val(iTotalPrice);	    			
				    sText.get(0).nodeValue = iTotalPrice.format();
				    sProductPrice.get(0).nodeValue = iTotalPrice.format();
				    sDeliveryPrice.get(0).nodeValue = 0;
	    		}	    		 
	    	} else {
	    		$("input[name='delivery_status']").val(1);
	    		$("#total_price").val(iTotalPrice);	    			
			    sText.get(0).nodeValue = iTotalPrice.format();
			    sProductPrice.get(0).nodeValue = iTotalPrice.format();
			    sDeliveryPrice.get(0).nodeValue = 0;			    
	    	}
	    	 
	    };       
	    
	    Artn.Method.totalPrice();
	    
	    // by jhson
	    $("form.payment").each(function(index){
	    	
	    	var jqForm = $(this);
	    	var jqButton = jqForm.find("button.purchase");
	    	
	    	jqButton.click({jqForm: jqForm}, function(e){
	    		$("input[name='paymethod']").val($(this).siblings(".paymethod").val());
	    		var browser = navigator.userAgent.toLowerCase();
	    		if(browser.indexOf("chrome") > 0){
	    			alert("결제는 익스(Explorer)만 가능합니다.");
	    			return;
	    		}
	    		if(Artn.Validation.check() === false) {
	        		alert("필수 항목을 입력해 주시기 바랍니다.");
	        		return;
	        	}	
	        	changeParam();
	    		var mParams = Artn.Util.serializeMap($("#cart-list"));
	    	    	
	    		var sHiddens = "";
	    		var sParams = $("#cart-list").find("*[name='id_product']").serialize();
	    	    sParams += "&" + $("#cart-list").find("*[name='product_count']").serialize();
	    	    var sHistoryParam = $("#cart-list").serialize();
	    	    $.post("/payment/historyModify?payment_ok=view",sHistoryParam,function(data){});
	    		$.post("/product/check",sParams,function(data){
	    	        var saResult = data.split("|");
	    	        if(saResult[0] === "0"){
	    	            sMSG = saResult[1];
	    	            alert(sMSG);
	    	            return false;
	    	        }else{
			    		for(var name in mParams){
			    			sHiddens += Artn.Util.createHidden( name, mParams[name] );
			    		}
		    		
			    		e.data.jqForm.find(".__dataHere__").empty();
			    		e.data.jqForm.find(".__dataHere__").append(sHiddens); 
			 
//			    		window.open(/*e.data.jqForm.attr("action")*/"", "pop", "width=600, height=650", "yes");
			    		var value = window.showModalDialog("/payment/payment", mParams, "width=600, height=650", "yes");
			    		if(value == null || value == undefined){
			    			$.post("/payment/historyModify?payment_ok=cancel",sHistoryParam,function(data){});
			    			return;
			    		}else{
			    			$.post("/payment/historyModify?payment_ok=success",sHistoryParam,function(data){});
			    			$("#transaction_num").val(value);
			    			$("#cart-list").submit();
			    		}
//			    		e.data.jqForm.submit();
	    	        }
	    		});
	    	});
	    });   
	})();
	/* porduct-cart-list - 2013.11.20 by yyj [종료]*/
	
	/* purchase-list - 2013.11.20 yyj [시작]*/
	(function(){
		if( $(".date_btn").length < 1 ) return;
		$("#search_frm *[name='status']").change(function(){
			/*
			var jqForm = $("#search_frm");
	        jqForm.attr("action", "/purchase/list?contents=" + $("input[name='contents']").val());
	        jqForm.get(0).target = "";*/
			$("#search_frm").submit();
	    });
	    
	    $(".date_btn").click(function(){
	    	var sHref = $(this).data("value");
	    	/*var jqForm = $("#search_frm");
	        jqForm.attr("action", "/purchase/list?contents=" + $("input[name='contents']").val());
	        jqForm.get(0).target = "";*/
	        $("#date").val(sHref);
	    	$("#search_frm").submit();
	    });
	    $("#search_frm .date_btn").each(function(){
	    	if( $("#search_frm").find("#date").val() === $(this).data("value")){
	    		$(this).addClass("selected");
	    	}	
	    });
	    
	    /*$(".search_btn").click(function(){
	    	var jqForm = $("#search_frm");
	        jqForm.attr("action", "/purchase/list");
	        jqForm.get(0).target = "";
	    });*/
	    
	    $(".update_btn").click(function(){
	    	var jqForm = $("#update_frm");
	        jqForm.attr("action", "/purchase/update?contents=" + $("input[name='contents']").val());
	        jqForm.get(0).target = "";
	        if( ($(this).data("src") != null) || ($(this).data("src") != undefined) ){
	        	$("#update_frm").attr("action",$(this).data("src"));
	        }
	    	$("input[name='id_purchase']").val($(this).siblings(".id_purchase").val());
	    	$("input[name='id_product']").val($(this).siblings(".id_product").val());
	    	$("input[name='id_user']").val($(this).siblings(".id_user").val());
	    	$("input[name='pay_user_name']").val($(this).siblings(".pay_user_name").val());
	    	$("input[name='pay_phone']").val($(this).siblings(".pay_phone").val());
	    	$("input[name='status']").val($(this).data("status"));
	    	if($(this).data("status") !== 3){
	    		$("#update_frm").submit();
	    	} 	
	    });
	    
	    $(".paymentCancel").click(function(){
	    	$("input[name='transaction_num']").val($(this).parent().parent().find(".transaction_num").val());
	    	$("input[name='id_payment']").val($(this).parent().parent().find(".id_payment").val());
	    	$("input[name='id_user']").val($(this).parent().parent().find(".id_user").val());
	    	$("input[name='id_purchase']").val($(this).parent().parent().find(".id_purchase").val());
	    	var jqForm = $("#update_frm");
	    	jqForm.attr("action", "/payment/cancel");
	    	jqForm.get(0).target = "cancel";
	    });
	    
	    $(".delivery").click(function(){
	    	$("#update_frm").find("input[name='delivery_num']").val($(".delivery_num").val());
	    	$("#update_frm").submit();
	    });

	    if( $("#list_purchase").length > 0 ){
	    	Artn.List.inst["#list_purchase"].selectclick(function(e){
		    	var iIdProduct = e.currentItem.find(".id_product").val();
		    	var sOptIndices = e.currentItem.find(".opt_indices").val();
		    	var iIdPurchase = e.currentItem.find(".id_purchase").val();
		    	var iIdPayment = e.currentItem.find(".id_payment").val();
		    	var sIdUser = e.currentItem.find(".id_user").val();
		    	var sParams = {
		    					"json" : true,
		    					"id" : iIdProduct
		    				};
		    	$("#dialog_exchange").find("input[name='id_product']").val(iIdProduct);
		    	$("#dialog_exchange").find("input[name='opt_indices']").val(sOptIndices);
		    	$("#dialog_exchange").find("input[name='id_purchase']").val(iIdPurchase);
		    	$("#dialog_exchange").find("input[name='id_payment']").val(iIdPayment);
		    	$("#dialog_exchange").find("input[name='id_user']").val(sIdUser);
		    	$.getJSON("/purchase/optlist",sParams,function(data){
		    		var iIdOptItemMemory = 0;
		    		var sSelect = "";
		    		var iCount = 0;
		    		var sTemp = Artn.Util.extractTemplate( $("#dialog_exchange") );
		    		for(var i = 0; i < data.length; i++){
		    			var iIdOptItem = parseInt(data[i].id_opt_item.toString());
		    			if( (iIdOptItemMemory != 0) && (iIdOptItemMemory != iIdOptItem) ){
		    				iCount = 1;
		    			}
		    			if( iCount == 1){
				    		sSelect += "</select><br/>";
						}
		    			if( (iIdOptItemMemory == 0) || (iIdOptItemMemory != iIdOptItem) ){
		    				sSelect += "<select name=\"opt_detail\">";
		    				sSelect += "<option value=\"선택안함:0:0\">-----선택-----</option>";
		    				iCount = 0;
		    			}
		    			sSelect += Artn.Util.replaceTemplate(sTemp, data[i]);
		    			if( i == data.length-1){
				    		sSelect += "</select>";
						}
				    	iIdOptItemMemory = iIdOptItem;
		    		}
		    		$("#exchange_select").html(sSelect);
		    		var saOptIndices = sOptIndices.split("/");
		    		for(var i = 0; i < saOptIndices.length; i++){
		    			$("#exchange_select").find("select").eq(i).find("option").eq(saOptIndices[i]).attr("selected","selected");
		    		}
		    	});
		    });
	    }
	    $(".close_dialog").click(function(){
	    	$("[id^=dialog]").dialog("close");
	    });
	})();
	/* purchase-list - 2013.11.20 yyj [종료]*/
	
	/* purchase-stats - 2013.11.20 yyj [시작]*/
	(function(){
		if( $("ul.stats li").length < 1 ) return;
		$("ul.stats li").each(function(){
			var sStatus = $(this).children("a").attr("href").split("status=")[1];
			var sParamStatus = $("#paramStatus").val();
			
			if(sStatus === sParamStatus){
				$(this).children("a").addClass("selected");
			}
		});
	})();
	/* purchase-stats - 2013.11.20 yyj [종료]*/
	
	/* user-find - 2013.11.20 yyj[시작] */
	(function(){
		if( $(".login").length < 1 ) return;
		$(".login").click(function(){
			var today = new Date();
			if($("#id_save").is(":checked") == true){
				today.setDate(today.getDate() + 365);
		        document.cookie = "id_save="+$("#textbox_id").val()+"; path=/; expires="
		                + today.toGMTString() + ";";
			}else{
				today.setDate(today.getDate() + (-1));
	            document.cookie = "id_save="+$("#textbox_id").val()+"; path=/; expires="
	                    + today.toGMTString() + ";";
			}
		});
		
		 function getId() {
			    // userid 쿠키에서 id 값을 가져온다.
		   var cook = document.cookie + ";";
	       var idx = cook.indexOf("id_save", 0);
	       var val = "";
	
	       if (idx != -1) {
	           cook = cook.substring(idx, cook.length);
	           begin = cook.indexOf("=", 0) + 1;
	           end = cook.indexOf(";", begin);
	           val = unescape(cook.substring(begin, end));
	       }
	
	       // 가져온 쿠키값이 있으면
	       if (val != "") {
	    	   $("#textbox_id").val(val);
	    	   $("#id_save").attr("checked",true);
	       }	        
		 }
		 
		 getId();
	})();
	/* user-find - 2013.11.20 yyj[종료] */
	
	/* user-join - 2013.11.20 yyj[시작] */
	(function(){
		if( $(".member_confirm, #reconfirm").length < 1 ) return;
		Artn["var"] = Artn["var"] || {};
		Artn["var"].timerId;
		$(".member_confirm, #reconfirm").click(function(){
	    	stopCount();
	    	$.post("/user/memberConfirm", {"phone_mobi" : $(".selectbox_phone").val()+$("#phone_mobi1").val()+$("#phone_mobi2").val()}, function(data){
	    		var timeLeft = 180; // 초 단위
	    	    var num = function(str)
	    	    {
	    	     if(str<10)
	    	      return '0'+str;
	    	     else
	    	      return str;
	    	    };
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
	    	    /* updateLeftTime(); */
	    	    /* time = setTimeout(updateLeftTime, 1000); */
	  
				return;
			});
	    });
		
	    $('#t_left_time').change(function(){
	    	alert(1111);
	    	if($('#t_left_time').text() === "00:00"){
		    	alert(22222);
		    }	
	    });
	    
	    $($("#step2")).click(function(){
	    	$("#joinForm").submit();
	    	// TODO: 핸드폰 인증 활성 필요
	    	/*if($("input[name='confirm_ok']").val() === "confirm_ok"){
	    		$("#joinForm").submit();
	    	}else{
	    		alert("본인인증을 받으십시오");
	    		return false;
	    	}*/
	    });
	    $(".close_dialog").click(function(){
	    	$("[id^=dialog]").dialog("close");
	    });
	    function stopCount() {
	    	clearTimeout(Artn["var"].timerId);    
	    }
	})();
	    /* user-join - 2013.11.20 yyj[시작] */
	
    	/* mypage-gnb - 2013.11.25 yyj[시작] */
		$(".mypage").click(function(){
			$(".mypage > ul").toggle(function(){});
		});
		$( ".top-gnb .category > a" ).click(function(){			
			$( ".category > ul" ).toggle(function(){});			
			$(this).children("span").toggleClass("circle-caret-1-n");
			$(this).children("span").toggleClass("circle-caret-1-s");			
			return false;
		});
	Artn.OutsideEvent.add(".mypage > ul");
	Artn.OutsideEvent.addExcept(".mypage");
	Artn.OutsideEvent.add(".category > ul", {}, function(){
		if ( $(".top-gnb .category ul").css("display") !== "none"){
			$( ".top-gnb .category > ul" ).toggle(function(){});
			$( ".top-gnb .category" ).children("a").children("span").toggleClass("circle-caret-1-n");
			$( ".top-gnb .category" ).children("a").children("span").toggleClass("circle-caret-1-s");
		}
	});
	Artn.OutsideEvent.addExcept(".top-gnb .category");
	/* mypage-gnb - 2013.11.25 yyj[종료] */
	
	/* product-grid : 표시되는 상품 개수별로 빈 칸(Cell)을 생성하는 코드 - 2013.11.27 by jhson [시작]*/
	(function(){
		$(".product-grid").each(function(index){
			var jqContainer = $(this);
			var jqForms = jqContainer.find("form");
			var iLenItem = jqForms.length;
			var iLenExtra = (iLenItem % 3);
			var sFormTag = "<form class=\"m-hdn\" style=\"visibility: hidden\"></form>";
			
			if (iLenExtra === 1){
				jqContainer.append(sFormTag + sFormTag);
			}
			if (iLenExtra === 2){
				jqContainer.append(sFormTag);
			}
		});
	})();
	/* product-grid : 표시되는 상품 개수별로 빈 칸(Cell)을 생성하는 코드 - 2013.11.27 by jhson [종료]*/
	
	/* payment-list -2013.11.27 yyj [시작]*/
	$(".payment-subject").click(function(){
		$(this).parent().parent().nextUntil(".payment-list").toggle();
		return false;
	});
	/* payment-list -2013.11.27 yyj [종료]*/
	
	/* 배송조회 클릭 팝업 - 2013.11.29 yyj[시작]*/
	$(".delivery_main").click(function(){
		window.open("/popup/delivery","delivery","width=300, height=190, top=200, left=500, scrollbars=no, location=no");
		
		return false;
	});
	/* 배송조회 클릭 팝업 - 2013.11.29 yyj[종료]*/
	
	
	/* 구매리스트 유료 무효 설정 - 20130.11.29 by thkim [시작]*/
	
	var iPaymentConditionVal = parseInt($("#search_frm #free_condition").val());	
	
	$(".board-list .payment-list").each(function(){
		var jqPaymentPrice =  $(this).children("td").children(".total-price");
		var iPaymentPriceVal = parseInt(jqPaymentPrice.val());		
		var jqPaymentStatus = $(this).children("td").children(".delivery-status");
		var iPaymentStatusVal = parseInt(jqPaymentStatus.val());
		
		var jqPrice = $(this).children("td").children(".price.amount");		
		
		if(iPaymentStatusVal === 4){			
			if(iPaymentPriceVal < iPaymentConditionVal){				
				$(this).children("td").children(".pay-free").text("유료");
				$(this).children("td").children(".pay-free").addClass("pay");
				if(iPaymentPriceVal > 0){
					jqPaymentPrice.val((parseInt(iPaymentPriceVal) + 3000).toString().format());
					jqPrice.text((parseInt(iPaymentPriceVal) + 3000).toString().format());
				}				
			} else{
				$(this).children("td").children(".pay-free").text("무료");
				$(this).children("td").children(".pay-free").addClass("free");
			}
		} else if(iPaymentStatusVal === 2){
			$(this).children("td").children(".pay-free").text("유료");
			$(this).children("td").children(".pay-free").addClass("pay");
		} else if(iPaymentStatusVal === 1){
			$(this).children("td").children(".pay-free").text("무료");
			$(this).children("td").children(".pay-free").addClass("free");
		}
	});	
	
	/* 구매리스트 유료 무효 설정 - 20130.11.29 by thkim [종료]*/
	
	/* 모바일용 GNB 생성 코드 - 2013.11.28 by jhson [시작] */
	Artn.Util.makeMobileGnb(".container.fixed-header", 
			[{
            	selector: ".account-menu",
            	isList: false,
            	cssClass: "block-justify",
            	innerIconSize: 32,
            	iconSize: 64
            },
            {
            	selector: ".top-decoration",
            	cssClass: "m-gnb-list",
            	iconSize: 64
            },
            {
            	selector: ".nav.gnb",
            	cssClass: "m-gnb-list",
            	iconSize: 64
            }
            ]);
	$(".m-gnb").hide();
	$(window).resize(function(){
		Artn.Util.doBlockJustify( ".block-justify:first-child", 0 );
	});
	
	$(".m-gnb-toggle").click(function(){
		if ( $(".block-justify:first-child").css("display") !== "none" ){
			Artn.Util.doBlockJustify( ".block-justify:first-child", 0 );
		}
		$(".m-gnb").slideToggle(function(){
			
		});
	});
   	/* 모바일용 GNB 생성 코드 - 2013.11.28 by jhson [종료] */
	
	/* 모바일용 product-show 의 fixed footer 부분 장바구니 담기 버튼 구현 - 2013.12.02 [시작] */
	if ( $(".product-show").length > 0 ){
		$("#button_SubmitToCartList").click(function(){
			$("#list_product").submit();
			
			return false;
		});
		$("#footer").css("margin-bottom", $(".footer-button").height());
	}
	
	/* 모바일용 product-show 의 fixed footer 부분 장바구니 담기 버튼 구현 - 2013.12.02 [종료] */
	
	/* payment-list -2013.12.05 yyj [시작]*/
	$(".print").click(function(){
		var title=$(".header > h1").text();
		if( $(".payment-list").length > 1 ){
			$(".payment-list").next().toggle();
		}
		goPrint(title);
		return false;
	});
	/* payment-list -2013.12.05 yyj [시작]*/
	
	/* product-show -2014.01.02 yyj [시작]*/
	$(".ownremove > option").each(function(){
		var sFiled;
		var sFiledA = [];
		sFiled = $(this).text();
		if(sFiled == "-----필수-----" || sFiled == "-----선택-----"){
			
		}else{
			sFiledA = sFiled.split(":");
			if(sFiledA[1] == "0원"){
				sFiledA[1] = "";
			}
			$(this).text(sFiledA[0]+sFiledA[1]);
		}
	});
	/* product-show -2014.01.02 yyj [종료]*/
	
	/*제이글로비스 카테고리 셀렉트 -2014-01-06 thkim [시작]*/
	var jqCategoryDiv = $(".product-section input[name='category_div']");
	var sCategoryDiv = "";
	
	if( jqCategoryDiv.length > 0 ){
		sCategoryDiv = jqCategoryDiv.val();		
		$(".product-section .category .category-"+sCategoryDiv).addClass("selected");
	}
	/*제이글로비스 카테고리 셀렉트 -2014-01-06 thkim [종료]*/
	
	/*제이글로비스 품절상품 -2014-01-27 thkim [시작]*/
	$(".article.product-show button[type='submit']").click(function(){
		if($(".article.product-show .sold-out").length > 0 ){
			alert("품절된 상품입니다.");
			return false;
		}
	});
	/*제이글로비스 품절상품 -2014-01-27 thkim [종료]*/
	
	/*제이글로비스 상품 판매전 팝업 등록 -2014-01-03 thkim [시작]*/	
	/*$("label[id^='label_close_checkbox'], input[id^='close_checkbox']").click(function(){
		console.log($(this).parent().data("index"));
		Artn.CommonUI.closeWin("dialog_popup" + $(this).parent().data("index"), 1);
	});	*/
	
	$("#size_controller").click(function(){
		$("html, body").animate({ scrollTop: 0 }, 600);
		$("#dialog_popup_example > div").html($(".webnote").html());
		$("#dialog_popup_example").dialog("open");
	});
	
	$("div[id^='dialog_popup_example']").on("dialogclose", function(){
		$(".board-edit input[name='width']").val(Math.round($(this).dialog( "option", "width" )));
		$(".board-edit input[name='height']").val(Math.round($(this).dialog( "option", "height" )));
		$(".board-edit input[name='location_x']").val(Math.round($(this).dialog( "option", "position" )[0]));
		$(".board-edit input[name='location_y']").val(Math.round($(this).dialog( "option", "position" )[1]));
		
	});
	
	/*제이글로비스 상품 판매전 팝업 등록 -2014-01-03 thkim [시작]*/	
	Artn.CommonUI.openWin();
	/*for( var i = 0; i < $("div[id^='dialog_popup']").length; i++ ){		
		openWin("dialog_popup" + i);
	}*/
	
	/*제이글로비스 상품 판매전 팝업 등록 -2014-01-03 thkim [종료]*/
});

//////////////////////////////////// project custom methods ////////////////////////////////////


/* porduct-cart-list - 2013.11.20 by yyj [시작]*/
function changeParam(){
	var jqPayType = $(".payment .tab").find(".selected");
    var iPayType = jqPayType.children("input").val();
    var sPayTypeName = jqPayType.text();
    var sPayId = jqPayType.attr("href");
    
    if( iPayType == 1){
        var sUserName = $("#pay_bank_user").val();
        var sBankName = $(sPayId).find("select :selected").text();
        var iBankVal = $(sPayId).find("select :selected").val();
        $("input[name='pay_bank_user']").val(sUserName);
        $("input[name='pay_bank_name']").val(sBankName);
        $("input[name='pay_bank_account']").val(iBankVal);
    }
    $("input[name='purchase_seq']").each(function(index){
        $(this).val(index+1);
    });
    $("input[name='pay_type']").val(iPayType);
    $("input[name='pay_type_name']").val(sPayTypeName);
}
/* porduct-cart-list - 2013.11.20 by yyj [종료]*/

/* */
var dtd_companys;
var dtd_select_obj; 
var company;
if(company == "" ) company = "우체국택배";

/* 택배 운송장 조회 - 2013-11-29 yyj [시작] */
function doorToDoorSearch()
{
	company = dtd_select_obj.options[dtd_select_obj.selectedIndex].value;
	var query_obj = document.getElementById('dtd_number_query');
	var query = query_obj.value;
	query = query.replace(' ', '');
	var url = "";
	
	/* 운송장 번호 값 확인 */
	if (company == "UPS") {
		var pattern1 = /^1z[0-9]{16}$/i;
		var pattern2 = /^M[0-9]{10}$/;
		if (query.search(pattern1) == -1 && query.search(pattern2) == -1) {
			alert(company+"의 운송장 번호 패턴에 맞지 않습니다.");
			query_obj.focus();
			return false;
		}
	} else if (company == "EMS") {
		var pattern = /^[a-zA-z]{2}[0-9]{9}[a-zA-z]{2}$/;
		if (query.search(pattern) == -1) {
			alert(company+"의 운송장 번호 패턴에 맞지 않습니다.");
			query_obj.focus();
			return false;
		}
	} else if (company == "SC 로지스" || company == "한진택배" || company == "현대택배") {
		if (!isNumeric(query)) {
			alert("운송장 번호는 숫자만 입력해주세요.");
			query_obj.focus();
			return false;
		} else if ( query.length != 10 && query.length != 12 ) {
			alert(company+"의 운송장 번호는 10자리 또는 12자리의 숫자로 입력해주세요.");
			query_obj.focus();
			return false;
		}
	} else {
		if (!isNumeric(query)) {
			alert("운송장 번호는 숫자만 입력해 주세요.");
			query_obj.focus();			
			return false;
		} else if (dtd_companys[company][0] > 0 && dtd_companys[company][0] != query.length) {
			alert(company+"의 운송장 번호는 "+dtd_companys[company][0]+"자리의 숫자로 입력해 주세요.");
			query_obj.focus();			
			return false;
		}
	}
	/* 링크만들기 */
	if (company == "대신택배") {
		url = dtd_companys[company][1];
		url+= "billno1="+query.substring(0,4);
		url+= "&billno2="+query.substring(4,7);
		url+= "&billno3="+query.substring(7,13);
	} else if (dtd_companys[company][1]) {
		url = dtd_companys[company][1]+query;
	}
	window.open(url,"_blank");
}

function isNumeric(s) {
	var count = 0;
	for (i = 0; i < s.length; i++) {

		if(s.charAt(i)<'0' || s.charAt(i)>'9') {
			count++;
		}
	}
	if(count > 0) {
		return 0;
	} else {
		return 1;
	}
}

function SetDeleveryContents(idx) {
	dtd_companys = new Array();
	dtd_companys["우체국택배"] = new Array(13, "http://service.epost.go.kr/trace.RetrieveRegiPrclDeliv.postal?sid1=","1234567890123 (13자리)","1588-1300","http://parcel.epost.go.kr");
	dtd_companys["대한통운"] = new Array(10, "http://www.doortodoor.co.kr/servlets/cmnChnnel?tc=dtd.cmn.command.c03condiCrg01Cmd&invc_no=","1234567890 (10자리)", "1588-1255", "http://www.doortodoor.co.kr");
	dtd_companys["한진택배"] = new Array(12, "http://www.hanjin.co.kr/Delivery_html/inquiry/result_waybill.jsp?wbl_num=", "1234567890 (10,12자리)", "1588-0011", "http://hanex.hanjin.co.kr");
	dtd_companys["로젠택배"] = new Array(11, "http://d2d.ilogen.com/d2d/delivery/invoice_tracesearch_quick.jsp?slipno=", "12345678901 (11자리)","1588-9988", "http://www.ilogen.com");
	dtd_companys["현대택배"] = new Array(12, "http://www.hlc.co.kr/hydex/jsp/tracking/trackingViewCus.jsp?InvNo=", "1234567890 (10,12자리)", "1588-2121", "http://www.hlc.co.kr");
	dtd_companys["KG옐로우캡택배"] = new Array(11, "http://www.yellowcap.co.kr/custom/inquiry_result.asp?invoice_no=", "12345678901 (11자리)", "1588-0123", "http://www.yellowcap.co.kr");
	dtd_companys["KGB택배"] = new Array(10, "http://www.kgbls.co.kr/sub5/trace.asp?f_slipno=", "1234567890 (10자리)", "1577-4577", "http://www.kgbls.co.kr");
	dtd_companys["EMS"] = new Array(13, "http://service.epost.go.kr/trace.RetrieveEmsTrace.postal?ems_gubun=E&POST_CODE=", "EE123456789KR (13자리)", "1588-1300", "http://service.epost.go.kr");
	dtd_companys["DHL"] = new Array(0, "http://www.dhl.co.kr/publish/kr/ko/eshipping/track.high.html?pageToInclude=RESULTS&type=fasttrack&AWB=", "1234567890 (10자리)", "1588-0001", "http://www.dhl.co.kr");
	dtd_companys["한덱스"] = new Array(10, "http://ptop.e-handex.co.kr:8080/jsp/tr/detailSheet.jsp?iSheetNo=", "1234567890 (10자리)", "1588-9040", "http://www.e-handex.co.kr");
	dtd_companys["FedEx"] = new Array(12, "http://www.fedex.com/Tracking?ascend_header=1&clienttype=dotcomreg&cntry_code=kr&language=korean&tracknumbers=", "123456789012 (12자리)", "080-023-8000", "http://www.fedex.com/kr");
	dtd_companys["동부익스프레스"] = new Array(12, "http://www.dongbuexpress.co.kr/Html/Delivery/DeliveryCheck.jsp?search_item_no=", "123456789012 (12자리)", "1588-8848", "http://www.dongbuexpress.co.kr");
	dtd_companys["CJ GLS"] = new Array(12, "http://www.cjgls.co.kr/kor/service/service02_01.asp?slipno=", "123456789012 (12자리)", "1588-5353", "http://www.cjgls.co.kr");
	dtd_companys["SC 로지스"] = new Array(12, "https://www.sc-logis.co.kr/cus_search_result.html?awbino=", "1234567890 (10,12자리)", "1588-0555", "http://www.sc-logis.co.kr");
	dtd_companys["UPS"] = new Array(25, "http://www.ups.com/WebTracking/track?loc=ko_KR&InquiryNumber1=", "M1234567890 (최대 25자리)", "1588-6886", "http://www.ups.com/content/kr/ko/index.jsx" );
	dtd_companys["하나로택배"] = new Array(10, "http://www.hanarologis.com/branch/chase/listbody.html?a_gb=center&a_cd=4&a_item=0&fr_slipno=", "1234567890 (최대 10자리)", "1577-2828", "http://www.hanarologis.com");
	dtd_companys["대신택배"] = new Array(13, "http://home.daesinlogistics.co.kr/daesin/jsp/d_freight_chase/d_general_process2.jsp?", "1234567891234 (13자리)", "043-222-4582", "http://apps.ds3211.co.kr");
	
	dtd_select_obj = document.getElementById("dtd_select");
	company = dtd_select_obj.options[idx].value;
	document.getElementById("Dcs01").innerHTML	= dtd_companys[company][2];
	document.getElementById("Dcs02").innerHTML	= company;
	document.getElementById("Dcs03").innerHTML	= dtd_companys[company][3];
	document.getElementById("Dcs04").href		= dtd_companys[company][4];
	document.getElementById("Dcs04").target		= "_blank";
	
}

function checkValidDoor(query) {
	/* 운송장 번호 값 확인 */
	if (company == "UPS") {
		var pattern1 = /^1z[0-9]{16}$/i;
		var pattern2 = /^M[0-9]{10}$/;
		if (query.search(pattern1) == -1 && query.search(pattern2) == -1) {
			lert(company+"의 운송장 번호 패턴에 맞지 않습니다.");
			document.door_to_door_frm.dtd_number_query.focus();
			return false;
		}
	} else if (company == "EMS") {
		var pattern = /^[a-zA-z]{2}[0-9]{9}[a-zA-z]{2}$/;
		if (query.search(pattern) == -1) {
			alert(company+"의 운송장 번호 패턴에 맞지 않습니다.");
			document.door_to_door_frm.dtd_number_query.focus();
			return false;
		}
	} else if (company == "SC 로지스" || company == "한진택배" || company == "현대택배") {
		if (!isNumeric(query)) {
			alert("운송장 번호는 숫자만 입력해주세요.");
			document.door_to_door_frm.dtd_number_query.focus();
			return false;
		} else if ( query.length != 10 && query.length != 12 ) {
			alert(company+"의 운송장 번호는 10자리 또는 12자리의 숫자로 입력해주세요.");
			document.door_to_door_frm.dtd_number_query.focus();
			return false;
		}
	} else {
		if (!isNumeric(query)) {
			alert("운송장 번호는 숫자만 입력해 주세요.");
			document.door_to_door_frm.dtd_number_query.focus();			
			return false;
		} else if (dtd_companys[company][0] > 0 && dtd_companys[company][0] != query.length) {
			alert(company+"의 운송장 번호는 "+dtd_companys[company][0]+"자리의 숫자로 입력해 주세요.");
			document.door_to_door_frm.dtd_number_query.focus();			
			return false;
		} 
	}

}
/* 택배 운송장 조회 - 2013-11-29 yyj [종료] */

/* 프린트 - 2013-12-05 yyj [시작] */
function goPrint(title){
    var sw=screen.width;
    var sh=screen.height;
    var w=800;//팝업창 가로길이
    var h=600;//세로길이
    var xpos=(sw-w)/2; //화면에 띄울 위치
    var ypos=(sh-h)/2; //중앙에 띄웁니다.

    var pHeader="<html><head><link rel='stylesheet' type='text/css' href='/Exp_admin/css/print.css'><title>"+title+"</title></head><body>";
    var pgetContent=document.getElementById("printarea").innerHTML + "<br>";
    //innerHTML을 이용하여 Div로 묶어준 부분을 가져옵니다.
    var pFooter="</body></html>";
    pContent=pHeader + pgetContent + pFooter;  
     
    pWin=window.open("","print","width=" + w +",height="+ h +",top=" + ypos + ",left="+ xpos +",status=yes,scrollbars=yes"); //동적인 새창을 띄웁니다.
    pWin.document.open(); //팝업창 오픈
    pWin.document.write(pContent); //새롭게 만든 html소스를 씁니다.
    pWin.document.close(); //클로즈
    pWin.print(); //윈도우 인쇄 창 띄우고
    pWin.close(); //인쇄가 되던가 취소가 되면 팝업창을 닫습니다.
}
/* 프린트 - 2013-11-29 yyj [종료] */

