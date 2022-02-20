<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>

<main id="main">
      <header class="section__header">
        <h1 class="section__title">BOOKING</h1>
      </header>
      <article class="accommo-reservation">
        <form id="frm" method="post" action="accommo/insert">
        <input type="hidden" name="roomNo" value="${accommo.roomNo }">
		<input type="hidden" name="no" value="${accommo.no }">
		<input type="hidden" name="taxIncludedPrice" value="">
		<input type="hidden" name="paidPrice" value="">
		<input type="hidden" name="extraPeople" value="">
          <div class="booking-summary">
            <div class="accommo-name">${accommo.accommoName }</div>
            <div class="accommo-calendar">
              <input type="date" name="checkInDate" class="form__date" value="<fmt:formatDate value="${checkIn }" pattern="yyyy-MM-dd"/>"/>
	   		  <input type="date" name="checkOutDate" class="form__date" value="<fmt:formatDate value="${checkOut }" pattern="yyyy-MM-dd"/>"/>
            </div>
            <div class="accommo-price" id="top-price"></div>
          </div>
          <div class="reservation-wrap">
            <div class="reservation__btn">
              <div class="payment__title">RESERVATIONS</div>
            </div>
            <div class="registration-box">
              <ul class="registration__list">
                <li class="registration__item">
                  <div class="registration__title">예약 스테이</div>
                  <div class="reservation__value">
                    ${accommo.accommoName } / ${accommo.roomName }
                  </div>
                </li>
                <li class="registration__item">
                  <div class="registration__title">예약일</div>
                  <div class="reservation__value">
                    <span id="span-checkIn"></span> ~
                    <span id="span-checkOut"></span
                    ><span id="span-night"></span>박
                  </div>
                </li>
                <li class="registration__item">
                  <div class="registration__title">이름</div>
                  <div class="reservation__value">${user.name }</div>
                </li>
                <li class="registration__item">
                  <div class="registration__title">휴대전화</div>
                  <div class="reservation__value">${user.tel }</div>
                </li>
                <li class="registration__item">
                  <div class="registration__title">이메일</div>
                  <div class="reservation__value">${user.email }</div>
                </li>
                <li class="registration__item">
                  <div class="registration__title">인원(최대 <span id="span-maximum-number">${accommo.maximumNumber }</span>명)</div>
                  <div class="reservation__value--people">
                    <div class="num-people-wrap">
                      <div class="num-people">
                        <label for="adult-number">성인</label>
                        <select
                          id="adult-number"
                          class="num-people__select"
                          aria-label=".num-people__select example"
                        >
                          <c:forEach begin="1" end="${accommo.maximumNumber }" var="number" step="1" varStatus="status">
							<option value="${status.index }" ${status.index eq accommo.standardNumber ? 'selected' : '' } >${status.index } 명</option>
						  </c:forEach>
                        </select>
                      </div>
                      <div class="num-people">
                        <label for="child-number">아동</label>
                        <select
                          id="child-number"
                          class="num-people__select"
                          aria-label=".num-people__select example"
                        >
                          <c:forEach begin="0" end="${accommo.maximumNumber-1 }" var="number" step="1" varStatus="status">
							<option value="${status.index }" ${status.index eq 0 ? 'selected' : '' } >${status.index } 명</option>
						  </c:forEach>
                        </select>
                      </div>
                      <div class="num-people">
                        <label for="infant-number">영아</label>
                        <select
                          id="infant-number"
                          class="num-people__select"
                          aria-label=".num-people__select example"
                        >
                          <c:forEach begin="0" end="${accommo.maximumNumber-1 }" var="number" step="1" varStatus="status">
							<option value="${status.index }" ${status.index eq 0 ? 'selected' : '' } >${status.index } 명</option>
						  </c:forEach>
                        </select>
                      </div>
                    </div>
                    <span class="member-text"
                      >아동: 24개월~12세<br />영아: 24개월 미만</span
                    >
                    <div id="maximum-error" style="display: none">
                      최대 숙박 인원수를 초과 하실수 없습니다.
                    </div>
                  </div>
                </li>
                <li class="registration__item">
                  <div class="registration__title">이용자 정보</div>
                    <div class="reservation__value--info">
	                  <div class="reservation-info-check">
	                    <input
	                      type="checkbox"
	                      value="realUser"
	                      id="flexCheckChecked-real-user"
	                      checked
	                    />
	                    <label for="flexCheckChecked-real-user">
	                      예약자 정보와 동일합니다.
	                    </label>
	                  </div>
	                  <div
	                    class="reservation-user-wrap"
	                    id="real-user-form"
	                    style="display: none"
	                  >
	                    <div class="reservation-user">
	                      <label for="roomUserName">이름</label
	                      ><input
	                        type="text"
	                        class="registration__value"
	                        id="roomUserName"
	                        name="roomUserName"
	                        placeholder="이용자 이름을 입력해 주세요"
	                      />
	                    </div>
	                    <div class="reservation-user">
	                      <label for="roomUserTel">휴대전화</label
	                      ><input
	                        type="tel"
	                        class="registration__value"
	                        id="roomUserTel"
	                        name="roomUserTel"
	                        placeholder="휴대전화번호를 입력해 주세요"
	                      />
	                    </div>
                    </div>
                  </div>
                </li>
                <li class="registration__item">
                  <div class="registration__title">예상 결제금액</div>
                  <div class="reservation__value--price">
                    <dl>
                      <dt>객실요금</dt>
                      <dd><span id="room-price"></span><span id="room-surcharge"></span></dd>
                    </dl>
                    <dl>
                      <dt>할인금액</dt>
                      <dd><span id="discount-amount"></span></dd>
                    </dl>
                    <dl>
                      <dt>포인트 사용(보유 point: <span id="user-point" data-point="${user.pnt }"><fmt:formatNumber value="${user.pnt }" /></span>)</dt>
                      <dd>
                        <input
                          name="usedPnt"
                          type="number"
                          value="0"
                          max="${user.pnt }"
                          min="0"
                        />
                        <div id="point-error" style="display: none">
                          보유 포인트를 초과 하실수 없습니다.
                        </div>
                      </dd>
                    </dl>

                    <dl>
                      <dt>합계</dt>
                      <dd id="reservation-total-price"><span id="bottom-price" data-total-price=""></span></dd>
                    </dl>
                  </div>
                </li>
                <li class="registration__item">
                  <div class="registration__title">결제방법 선택</div>
                  <div class="reservation-radio">
                    <input
                      type="radio"
                      name="payment"
                      value="카드"
                      id="flexRadioDefault1"
                      checked
                    />
                    <label for="flexRadioDefault1">신용카드 결제</label>
                  </div>
                  <div class="reservation-radio">
                    <input
                      type="radio"
                      name="payment"
                      value="카카오"
                      id="flexRadioDefault2"
                    />
                    <label for="flexRadioDefault2">
                      <img
                        class="kakao-pay"
                        alt="kakaopay"
                        src="/resources/images/reservation/payment_icon_yellow_small.png"
                      />
                    </label>
                  </div>
                </li>
              </ul>
              <p class="agree__title">이용자 약관 동의</p>
              <div class="agree__checkbox-registration">
                <div class="agree__all-registration">
                  <div class="all-wrap">
                    <input
                      type="checkbox"
                      id="check_all"
                      name="selectall"
                      onclick="selectAll(this)"
                    />
                    <label for="check_all">사용자 약관 전체 동의</label>
                  </div>
                </div>
                <details>
                  <summary class="registration__agree">
                    <div class="agree__box">
                      <input
                        type="checkbox"
                        class="check-necessary"
                        id="check_service"
                        name="agreecheck"
                        onclick="checkSelectAll()"
                      />
                      <label for="check_service">
                        서비스 이용 약관 동의 (필수)
                      </label>
                    </div>
                  </summary>
                  <div class="agree__text">
                    1. 개인정보를 제공받는 자 : ${accommo.accommoName }
                    <br />
                    2. 제공하는 개인정보 항목 : [필수] 스테이폴리오 아이디,
                    이름, 연락처, 이메일주소, 인원정보
                    <br />
                    3. 개인정보를 제공받는 자의 이용목적 : 사업자회원과
                    예약이용자의 원활한 거래 진행, 고객상담, 불만처리 등 민원
                    처리, 분쟁조정 해결을 위한 기록보존
                    <br />
                    4. 개인정보를 제공받는 자의 개인정보 보유 및 이용기간 :
                    개인정보 이용목적 달성 시 까지 보존합니다.
                    <br />
                    5. 동의 거부권 등에 대한 고지 : 정보주체는 개인정보 제공
                    동의를 거부할 권리가 있으나, 이 경우 상품 및 서비스 예약이
                    제한될 수 있습니다.
                  </div>
                </details>
                <details>
                  <summary class="registration__agree">
                    <div class="agree__box">
                      <input
                        type="checkbox"
                        class="check-necessary"
                        id="check_privacy"
                        name="agreecheck"
                        onclick="checkSelectAll()"
                      />
                      <label for="check_privacy">
                        개인정보 취급방침 동의 (필수)
                      </label>
                    </div>
                  </summary>
                  <div class="agree__text">
                    1. 개인정보를 제공받는 자 : ${accommo.accommoName }
                    <br />
                    2. 제공하는 개인정보 항목 : [필수] 스테이폴리오 아이디,이름,
                    연락처, 이메일주소, 인원정보
                    <br />
                    3. 개인정보를 제공받는 자의 이용목적 : 사업자회원과
                    예약이용자의 원활한 거래 진행, 고객상담, 불만처리 등 민원
                    처리, 분쟁조정 해결을 위한 기록보존
                    <br />
                    4. 개인정보를 제공받는 자의 개인정보 보유 및 이용기간 :
                    개인정보 이용목적 달성 시 까지 보존합니다.
                  </div>
                </details>
                <details>
                  <summary class="registration__agree">
                    <div class="agree__box">
                      <input
                        type="checkbox"
                        class="check-necessary"
                        id="check_refund"
                        name="agreecheck"
                        onclick="checkSelectAll()"
                      />
                      <label for="check_refund">
                        환불규정에 대한 동의(필수)
                      </label>
                    </div>
                  </summary>
                  <div class="agree__text">
                    <div class="refund-box">
                      <div class="refund-title">예약 안내</div>
                      <ul class="refund-content">
                        <li>
                          예약 신청 후 결제 방식에 따라 결제가 완료되면, 예약
                          완료 및 안내 문자가 송부됩니다.
                        </li>
                        <li>
                          해당일에 '예약 신청'이 중복될 경우 입금 순서가 아닌,
                          신청 순서로 예약 확정이 처리됩니다.
                        </li>
                        <li>
                          예약 신청이 불가한 고객은 연락 후 환불 처리해드립니다.
                        </li>
                        <li>
                         ${accommo.accommoName }의 정확한 주소는 예약 확정 후
                          안내 드립니다.
                        </li>
                        <li>
                          사전에 협의되지 않은 상업 목적의 사진/영상 촬영(광고,
                          쇼핑몰, SNS 마켓 등)은 불가합니다.
                        </li>
                      </ul>
                    </div>
                    <div class="refund-box">
                      <div class="refund-title">환불 규정</div>
                      <ul class="refund-content">
                        <li>
                          환불 시 아래의 기준일에 따른 환불 금액을 드립니다.
                          <table class="refund-table">
                            <colgroup>
                              <col style="width: 50%" />
                              <col style="width: 50%" />
                            </colgroup>
                            <tbody>
                              <tr>
                                <td>이용 14일전까지</td>
                                <td>총 결제금액의 90% 환불</td>
                              </tr>
                              <tr>
                                <td>이용 7일전까지</td>
                                <td>총 결제금액의 50% 환불</td>
                              </tr>
                              <tr>
                                <td>이용 5일전까지</td>
                                <td>총 결제금액의 30% 환불</td>
                              </tr>
                              <tr>
                                <td>이용 3일전 ~ 당일</td>
                                <td>변경 / 환불 불가</td>
                              </tr>
                            </tbody>
                          </table>
                        </li>
                        <li>
                          예약의 확정은 위 사항을 모두 숙지하였고 모든 사항에
                          동의함을 의미합니다.
                        </li>
                        <li>
                          자세한 문의사항은 ${accommo.accommoName }으로
                          연락주시기 바랍니다.
                        </li>
                      </ul>
                    </div>
                    <div class="refund-box">
                      <div class="refund-title">취소 안내</div>
                      <ul class="refund-content">
                        <li>
                          비회원이신 경우, 스테이폴리오 사이트 로그인 페이지
                          '비회원 예약조회'(예약번호/연락처 입력필수)를 통해
                          예약내역 확인 후 [예약취소] 버튼을 눌러 신청해주시기
                          바랍니다. https://www.stayfolio.com/nonmember
                        </li>
                        <li>
                          예약번호는 예약안내 문자를 통해 확인 가능합니다.
                          확인이 어려우신 경우 스테이폴리오 챗봇을 통해
                          예약번호를 문의해주시기 바랍니다.
                        </li>
                        <li>
                          회원이신 경우, 스테이폴리오 - ACCOUNT - 마이 페이지 -
                          예약 정보 - [취소 요청] 버튼을 눌러주시기 바랍니다.
                        </li>
                      </ul>
                    </div>
                  </div>
                </details>
                <details>
                  <summary class="registration__agree">
                    <div class="agree__box">
                      <input
                        type="checkbox"
                        id="check_marketing"
                        name="agreecheck"
                        onclick="checkSelectAll()"
                      />
                      <label for="check_marketing">
                        마케팅정보 수신 동의 (선택)
                      </label>
                    </div>
                  </summary>
                  <div class="agree__text">
                    이메일, SMS를 통해 스테이폴리오에서 제공되는 이벤트 소식,
                    스테이 소개 등 다양한 정보 안내를 받을 수 있습니다.
                    <br />
                    서비스의 중요 안내사항 및 스테이 예약/취소 관련 정보는 위
                    수신 여부와 관계없이 발송됩니다.
                  </div>
                </details>
              </div>
              <div class="btn__reservation">
                <button type="button" class="btn__next" id="payment">
                  결제하기
                </button>
              </div>
            </div>
          </div>
        </form>
      </article>
    </main>



<script type="text/javascript">
$(function() {
	window.onload = function () {
		updateForm();
	}
	// 날짜 변경시 실행
	$(":input[name=checkInDate], :input[name=checkOutDate]").change(function() {
		updateForm();
	});
	
	// 인원수 제한 기능
	setTimeout("window.self.focus();", 1000 );
	var adult, child, infant;
		
	$("#adult-number").focus(function(){
		adult = parseInt($(this).val());
	}).change(function(){
		setNumber("adult", adult);
		updateForm();
	});
	$("#child-number").focus(function(){
		child = parseInt($(this).val());
	}).change(function(){
		setNumber("child", child);
		updateForm();
	});
	$("#infant-number").focus(function(){
		infant = parseInt($(this).val());
	}).change(function(){
		setNumber("infant", infant);
		updateForm();
	});
	
	// 이용자 정보 다를 경우
	$("#flexCheckChecked-real-user").change(function() {
		if ($("input:checkbox[id='flexCheckChecked-real-user']").is(":checked") == true){
			$("#real-user-form").hide();
		} else {
			$("#real-user-form").show();
		}
	});
	
    //yyyy-mm-dd 포맷 날짜 생성
	function dateFormat() {
	    var d = new Date();
	    return d.getFullYear() + "-" + ((d.getMonth() + 1) > 9 ? (d.getMonth() + 1).toString() : "0" + (d.getMonth() + 1)) + "-" + (d.getDate() > 9 ? d.getDate().toString() : "0" + d.getDate().toString());
	}
    
    function updateForm() {
    	// price를 위한 date
    	var checkIn = $(":input[name=checkInDate]").val().replace(/-/g, '');
		var checkOut = $(":input[name=checkOutDate]").val().replace(/-/g, '');
		var number = parseInt($("#adult-number option:selected").val()) + parseInt($("#child-number option:selected").val()) + parseInt($("#infant-number option:selected").val())
		var roomNo = $(":input[name=roomNo]").val();
		var point = $("input[name=usedPnt]").val();
		
		$.getJSON("/getAccommoPrice",
				{checkIn: checkIn, checkOut: checkOut, roomNo: roomNo, number: number, point: point},
				function(priceDto) {
			$("#top-price, #bottom-price").text("￦"+priceDto.totalPrice.toLocaleString());
			$("#bottom-price").attr("data-total-price", priceDto.totalPrice);
			$("#room-price").text("￦" + priceDto.roomPrice.toLocaleString());
			$("input[name=taxIncludedPrice]").val(priceDto.totalPrice+priceDto.usePoint);
			$("input[name=paidPrice]").val(priceDto.totalPrice);
			$("input[name=extraPeople]").val(priceDto.extraPeople);
			console.log(priceDto.surcharge);
			if (priceDto.surcharge > 0) {
				$("#room-surcharge").text("(+ ￦" + priceDto.surcharge.toLocaleString() + ")");
			} else {
				$("#room-surcharge").empty();
			}
			if (priceDto.discountAmount > 0) {
				$("#discount-amount").text("-￦" + priceDto.discountAmount.toLocaleString() + "");
			} else {
				$("#discount-amount").empty();
			}
			
		})
		// 예약일을 상단 날짜에서 가져오기
		$("#span-checkIn").text($(":input[name=checkInDate]").val());
		$("#span-checkOut").text($(":input[name=checkOutDate]").val());
		const date1 = new Date(Date.parse($(":input[name=checkInDate]").val()));
		const date2 = new Date(Date.parse($(":input[name=checkOutDate]").val()));
		const night = (date2.getTime() - date1.getTime()) / 1000 / 60 / 60 / 24; 
		$("#span-night").text(night);
    }
    
    // 인원수 select 실행 취소
    function setNumber(idAge, age) {
		var number = parseInt($("#adult-number option:selected").val()) + parseInt($("#child-number option:selected").val()) + parseInt($("#infant-number option:selected").val());
		if (number > $("#span-maximum-number").text()) {
			$("#maximum-error").show();
			/*  focus를 가진 상태에서 여러번 값을 바꿀 때를 방지 */
			$('#'+idAge+'-number').trigger("blur");
			$('#'+idAge+'-number').val(age).prop("selected", true);
		} else {
			$("#maximum-error").hide();
		}
	}
    
   
    
    // 결제하기
	$("#payment").click(function(event) {
		event.preventDefault();
		var frm = $("#frm");
		if ($("input:checkbox[id='flexCheckChecked-real-user']").is(":checked") == false &&
			($("input[name=roomUserName]").val() == '' || $("input[name=roomUserTel]").val() == '')) {
				$("#real-user-error").show();
		} else {
			$("#real-user-error").hide();
			if ($("input[class=check-necessary]:checked").length!=3) {
				alert("필수 동의사항을 모두 확인해 주세요.");
			} else {
				if($('input[name="payment"]:checked').val() == "카드") {
					frm.submit();
				} else {
					frm.attr("action", "/reserve/accommo/kakaoPay");
					frm.submit();
				}
			}
		}
	});
    
    // 포인트 사용
    $("input[name=usedPnt]").change(function() {
    	var point = parseInt($("#user-point").attr("data-point"));
    	if (point < parseInt($(this).val())){
    		$("#point-error").show();
			$(this).val(point);
			updateForm();
		} else {
			$("#point-error").hide();
			updateForm();
		}
    });
});
	
</script>