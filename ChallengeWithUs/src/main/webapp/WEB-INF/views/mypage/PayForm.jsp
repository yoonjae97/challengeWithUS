<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/inc/viewsCss/pay.css" type="text/css"/>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">
<body>
<c:if test="${logStatus=='Y'}">
	<p>로그인중</p>
</c:if>

<div class="ChargeContainer">
  <div class="ChargeTitle">충전하기</div>
  <div class="Rectangle172"></div>
  
    
    <div class="Chargesaction">
      <label class="ChargeAmount"><input type="radio" name="cp_item" value="10000"><span>10000원</span></label>
      <div class="ChargeInfo">예치금은 1만원 단위로 충전 가능합니다</div>
    </div>
 
  <div class="ChargeButton">
    <button type="button" class="ButtonText" id="charge_kakao">충전</button>
  </div>
 </div>


               
                
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<script>
    $('#charge_kakao').click(function () {
        // getter

        var IMP = window.IMP;
        IMP.init('imp52436867');
        var money = $('input[name="cp_item"]:checked').val();
        
        IMP.request_pay({
            pg: 'kakaopay',
            merchant_uid: 'merchant_' + new Date().getTime(),

            name: '주문명 : 예치금 충전',
            amount: money,
            buyer_email: "test@naver.com",
            buyer_name: "test",
            buyer_tel: "010-1234-5678",
            buyer_addr: "서울",
            buyer_postcode: '123-456'
        }, function (rsp) {
            console.log(rsp);
            if (rsp.success) {
                var msg = '결제가 완료되었습니다.';
                $.ajax({
                    type: "POST", 
                    url: '${pageContext.request.contextPath}/myPage/PayRequest', //충전 금액값을 보낼 url 설정
                    data: {
                        "depositAmount" : money,
                    },
                    success:function(result) {
                    	console.log(result+"hi");
                    	if (result =="needlogin") {
                    		alert("로그인이 필요합니다.");
                    		window.location.href= "${pageContext.request.contextPath}/register/login";
                    	}
                    	else if (result == "success") {
                    		alert("결제 성공!");
                    		window.location.href= "${pageContext.request.contextPath}/myPage/myDeposit";
                        
                          }
        
                          else{
                        	// 작성 실패 시
                              alert("결제 실패");
                              window.location.href= "${pageContext.request.contextPath}/mypage";
                          }
                        },
                        error: function(e) {
                          console.log(e.responseText);
                        }             
                });
            } else {
                var msg = '결제에 실패하였습니다.';
                msg += '에러내용 : ' + rsp.error_msg;
            }
            alert(msg);
            
        });
    });
</script>
</body>
</html>
