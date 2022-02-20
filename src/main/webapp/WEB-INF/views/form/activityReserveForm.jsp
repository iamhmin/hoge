<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>
<!DOCTYPE html>
<html lang="ko">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<div class="container ">
	<div class="row mb-3">
		<div class="col">
			<h3>BOOKING</h3>
		</div>
	</div>
	<form id="frm" method="post" action="activity/insert" >
		<input type="hidden" name="activityNo" value="${activity.no }">
		<input type="hidden" name="taxIncludedPrice" value="">
		<input type="hidden" name="paidPrice" value="">
		<input type="hidden" name="numberOfPeople" value="">
		<input type="hidden" name="userNo" value="${user.no }">
		<div class="row mb-3">
			<div class="col">
				<div class="d-flex justify-content-between">
					<div>
						<h5 id="activity-name" data-price-per="${activity.pricePerPerson }">${activity.name }</h5>
					</div>
   					<div>
	   					<select class="form-select form-select-lg mb-3" aria-label=".form-select-lg example" id="select-activity-time" name="activityTimeNo">
							<c:forEach var="activityTime" items="${activityTimes }" varStatus="status">
								<option value="${activityTime.no }" data-booked-number="${activityTime.soFarBookedNumberOfPeople }" ${activityTime.no eq activityTimeNo ? 'selected' : '' } >
									<fmt:formatDate value="${activityTime.time}" pattern="yyyy-MM-dd HH:ss"/>
								</option>
							</c:forEach>
						</select>
   					</div>
   					<div>
   						<span id="top-price"></span>
   					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<h3>RESERVATIONS</h3>
			</div>
		</div>
		<div class="row mb-3 border">
			<div class="col text-center">
				<table class="table">
					<tr>
						<th>예약 체험</th>
						<td>${activity.name }</td>
					</tr>
					<tr>
						<th>예약일</th>
						<td>
							<span id="span-activity-time"></span>
						</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>
							${user.name }
						</td>
					</tr>
					<tr>
						<th>휴대전화</th>
						<td>
							${user.tel }
						</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>
							${user.email }
						</td>
					</tr>
					<tr>
						<th>인원 (최대 <span id="span-maximum-number" data-maximum="${activity.maximumNumber }"></span>명)</th>
						<td>
							<div class="d-flex justify-content-between">
								<div class="d-flex justify-content-start">
									<div class="d-flex justify-content-start">
										<span style="width: 50px; padding-right: 2px">성인</span>
										<select id="adult-number" class="form-select form-select-sm" aria-label=".form-select-sm example">
											<c:forEach begin="1" end="${activity.maximumNumber }" var="number" step="1" varStatus="status">
												<option value="${status.index }" ${status.index eq 1 ? 'selected' : '' } >${status.index } 명</option>
											</c:forEach>
										</select>
									</div>
									<div class="d-flex justify-content-start">
										<span style="width: 50px; padding-right: 2px">아동</span>
										<select id="child-number" class="form-select form-select-sm" aria-label=".form-select-sm example">
											<c:forEach begin="0" end="${activity.maximumNumber-1 }" var="number" step="1" varStatus="status">
												<option value="${status.index }" ${status.index eq 0 ? 'selected' : '' } >${status.index } 명</option>
											</c:forEach>
										</select>
									</div>
									<div class="d-flex justify-content-start">
										<span style="width: 50px; padding-right: 2px">영아</span>
										<select id="infant-number" class="form-select form-select-sm" aria-label=".form-select-sm example">
											<c:forEach begin="0" end="${activity.maximumNumber-1 }" var="number" step="1" varStatus="status">
												<option value="${status.index }" ${status.index eq 0 ? 'selected' : '' } >${status.index } 명</option>
											</c:forEach>
										</select>
									</div>
								</div>
								<div>
									<span>아동: 24개월~12세<br/>영아: 24개월 미만</span>
								</div>
							</div>
							<div id="maximum-error" style="display: none">
								<h5>최대 체험 인원수를 초과 하실수 없습니다.</h5>
							</div>
						</td>
					</tr>
					<tr>
						<th>예상 결제금액</th>
						<td>
							<table class="table" id="total-price">
								<tr id="activity-price-surcharge">
									<th>체험 요금</th>
									<td><span id="activity-price"></span><span id="activity-price"></span></td>
								</tr>
								<tr>
									<th>포인트 사용(보유 point: <span id="user-point" data-point="${user.pnt }"><fmt:formatNumber value="${user.pnt }" /></span>)</th>
									<td>
										<input name="usedPnt" type="number" value="0" max="${user.pnt }" min="0">
										<div id="point-error" style="display: none">
											<h5>보유 포인트를 초과 하실수 없습니다.</h5>
										</div>
									</td>
								</tr>
							</table>
							<span id="bottom-price" data-total-price=""></span>
						</td>
					</tr>
					<tr>
						<th>결제방법 선택</th>
						<td>
							<div class="d-flex justify-content-start">
								<div class="form-check">
									<input class="form-check-input" type="radio" name="payment" value="카드" id="flexRadioDefault1" checked>
									<label class="form-check-label" for="flexRadioDefault1">신용카드 결제</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="payment" value="카카오" id="flexRadioDefault2">
									<img alt="kakaopay" src="/resources/images/reservation/payment_icon_yellow_small.png">
								</div>
							</div>
						</td>
					</tr>
				</table>
			</div>
			<!-- 이용자 약관 동의 -->
			<div>
				<h6>이용자 약관 동의</h6>
				<div>
					<div class="form-check">
						<input class="form-check-input" type="checkbox" id="terms-all" id="flexCheckDefault">
						<label class="form-check-label" for="flexCheckDefault">사용자 약관 전체 동의</label>
					</div>
					<div class="d-flex flex-column bd-highlight mb-3">
						<div class="d-flex justify-content-between">
							<div>
								<input class="form-check-input-necessary" type="checkbox" id="terms">
								<label class="form-check-label" for="flexCheckDefault">게스트 권리 포기서에 대한 동의 (필수)</label>
							</div>
							<div>
								<button class="btn-terms" style="width: 500px;" data-content=1>약관 모두 보기</button>
							</div>
						</div>
						<div id="terms-content-1" style="display: none">
							체험에 참여하기에 앞서 호스트는 회원님에게 본 게스트 권리 포기서에 동의할 것을 요구합니다. 본 권리 포기서는 회원님이 체험을 처음으로 예약하는 날짜 또는 참여하는 날짜 중 먼저 도래하는 시점에 회원님과 호스트 사이에 효력이 발생합니다. 본 권리 포기서에 정의되지 않은 모든 용어는 에어비앤비 이용 약관 및/또는 체험 호스트를 위한 추가 약관에 명시된 의미를 갖습니다.
						</div>
					</div>
					<div class="d-flex flex-column bd-highlight mb-3">
						<div class="d-flex justify-content-between">
							<div>
								<input class="form-check-input-necessary" type="checkbox" id="terms">
								<label class="form-check-label" for="flexCheckDefault">환불 정책에 대한 동의 (필수)</label>
							</div>
							<div>
								<button class="btn-terms" style="width: 500px;" data-content=2>약관 모두 보기</button>
							</div>
						</div>
						<div id="terms-content-2" style="display: none">
							<h2>체험 게스트 환불 정책</h2>
							<p>체험 게스트 환불 정책은 게스트 환불에 대한 에어비앤비의 정책 및 본 정책과 관련된 호스트의 의무에 적용됩니다. 본 정책은 에어비앤비 이용 약관 및 에어비앤비 체험 호스트를 위한 추가 약관과 함께 적용되며, 에어비앤비 플랫폼을 통해 체험을 예약하고 여행 문제를 겪는 게스트에게 적용됩니다.
							첫 글자가 대문자로 된 모든 용어는 본 체험 게스트 환불 정책에서 별도로 정의하지 않는 한, 에어비앤비 약관 또는 결제 약관에 정의된 의미를 가집니다.
							체험 호스트 또는 게스트로 에어비앤비 플랫폼을 이용하면, 본 체험 게스트 환불 정책을 읽고 이해했으며 이에 동의한다는 것입니다.</p>
							<h2>조건에 부합하는 여행 문제 및 환불 정책	</h2>
							<p>다음 경우는 '여행 문제'에 해당하여 체험 게스트 환불 정책에 따라 환불받을 수 있습니다.</p>
							<ul>
								<li>호스트가 예약된 체험을 이행하지 않거나 명시된 시작 시간보다 15분 이상 늦게 도착하여 게스트가 체험을 포기하는 경우</li>
								<li>게스트가 예약한 후 호스트가 체험 내용을 현저하게 변경하는 경우</li>
								<li>합리적으로 판단했을 때 게스트의 체험 참여에 부정적인 영향을 줄 것으로 예상되는 안전이나 건강상의 위험 요소가 체험에 포함된 경우</li>
								<li>온라인으로 진행되는 체험에서 음향 및 영상 문제 등의 기술적인 문제로 게스트가 체험에 참여할 수 없거나 호스트가 체험을 진행할 수 없는 경우</li>
							</ul>
							<p>게스트가 여행 문제를 겪은 것으로 에어비앤비가 판단할 경우, 에어비앤비는 본 정책에 부합해 재량에 따라 게스트에게 환불을 제공할 것이며, 환불액 최대 한도는 게스트가 지불한 체험 요금 총액입니다. 환불 금액은 여행 문제의 성격에 따라 달라집니다.</p>
							<h2>퀄리티 최소 기준, 호스트의 책임 및 게스트 환급</h2>
							<p>호스트는 에어비앤비 플랫폼에 등록하는 체험이 에어비앤비의 체험 플랫폼 기준에 부합하고 게스트에게 여행 문제를 일으키지 않도록 할 책임이 있습니다. 체험 진행 전과 도중에 호스트는 본인이 직접 또는 제삼자를 통해 게스트의 문제를 해결하도록 최선의 노력을 기울여야 합니다.
							(i) 에어비앤비가 호스트의 체험과 관련해 게스트가 여행 문제를 겪었다고 판단하고, (ii) 에어비앤비가 게스트에게 (총 요금을 초과하지 않는 범위 내에서) 환급을 제공할 경우, 호스트는 에어비앤비가 요청한 날로부터 30일 이내에 해당 금액을 에어비앤비에 환급할 것에 동의합니다. 호스트는 에어비앤비에 지불해야 할 금액을 수령 대금에서 차감하거나 결제 약관에 따라 허용된 기타 방법으로 Airbnb Payments가 수금하도록 승인합니다..
							호스트는 본 체험 게스트 환불 정책에 따른 게스트의 권리가 체험 환불 정책에 우선함을 이해합니다. 여행 문제에 이의를 제기하려는 경우, 호스트는 에어비앤비에 서면으로 통지하거나 전화로 연락해 여행 문제와 관련된 이의 제기에 대한 정보(사진 등의 증빙 자료 포함)를 제공할 수 있습니다. 단, 이의를 제기하기 전에 게스트와 여행 문제를 해결하기 위해 합당한 최선의 모든 노력을 기울여야 합니다.</p>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row mb-3">
			<div class="col">
				<button id="payment" type="submit" class="btn btn-dark">결제하기</button>
			</div>
		</div>
	</form>
</div>
<script type="text/javascript">
$(function() {
	var bookedNumber = $("#select-activity-time option:selected").attr("data-booked-number");
	var maximum = $("#span-maximum-number").attr("data-maximum");
	var availNumber = maximum - bookedNumber;
	$("#span-maximum-number").text(availNumber);
	$("#span-activity-time").text($("#select-activity-time option:selected").text());
	
	setTimeout("window.self.focus();", 1000 );
	var adult, child, infant;
	var number
	$("#select-activity-time").change(function() {
		bookedNumber = $("#select-activity-time option:selected").attr("data-booked-number");
		$("#span-activity-time").text($("#select-activity-time option:selected").text());
		maximum = $("#span-maximum-number").attr("data-maximum");
		availNumber = maximum - bookedNumber;
		$("#span-maximum-number").text(availNumber);
		
		number = parseInt($("#adult-number option:selected").val()) + parseInt($("#child-number option:selected").val()) + parseInt($("#infant-number option:selected").val());
		
		if (number > availNumber) {
			$("#maximum-error").show();
			/*  focus를 가진 상태에서 여러번 값을 바꿀 때를 방지 */
			$('#adult-number').val(1).prop("selected", true);
			$('#child-number').val(0).prop("selected", true);
			$('#infant-number').val(0).prop("selected", true);
		} 
		updateForm();
	});
	
	// 인원수 제한 기능
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
	
	// 인원수 select 실행 취소
    function setNumber(idAge, age) {
		number = parseInt($("#adult-number option:selected").val()) + parseInt($("#child-number option:selected").val()) + parseInt($("#infant-number option:selected").val());
		if (number > availNumber) {
			$("#maximum-error").show();
			/*  focus를 가진 상태에서 여러번 값을 바꿀 때를 방지 */
			$('#'+idAge+'-number').trigger("blur");
			$('#'+idAge+'-number').val(age).prop("selected", true);
		} else {
			$("#maximum-error").hide();
		}
	}
	
	function updateForm() {
		var pricePer = $("#activity-name").attr("data-price-per");
		var number = parseInt($("#adult-number option:selected").val()) + parseInt($("#child-number option:selected").val()) + parseInt($("#infant-number option:selected").val())
		$("input[name=numberOfPeople]").val(number);
		var point = $("input[name=usedPnt]").val();
		
		$.getJSON("/getActivityPrice",
				{pricePer: pricePer, number: number, point: point},
				function(activityPriceDto) {
			$("#top-price, #bottom-price").text("￦"+activityPriceDto.totalPrice.toLocaleString());
			$("#bottom-price").attr("data-total-price", activityPriceDto.totalPrice);
			$("#activity-price").text("￦" + activityPriceDto.price.toLocaleString());
			
			$("input[name=taxIncludedPrice]").val(activityPriceDto.price);
			$("input[name=paidPrice]").val(activityPriceDto.totalPrice);
		})
    }
	
	window.onload = function () {
		updateForm();
	}
	
	
 // 전체 동의
    $("#terms-all").click(function() {
		if($("#terms-all").is(":checked")) $("input[id=terms]").prop("checked", true);
		else $("input[id=terms]").prop("checked", false);
	});
	
    // 전체 동의 해제
	$("input[id=terms]").click(function() {
		var total = $("input[id=terms]").length;
		var checked = $("input[id=terms]:checked").length;
		
		if(total != checked) $("#terms-all").prop("checked", false);
		else $("#terms-all").prop("checked", true); 
	});
	
	// 약관 표시
	$(".btn-terms").click(function(event) {
		event.preventDefault();
		var contentNo = $(this).attr("data-content");
		if ($("#terms-content-" + contentNo).is(':visible')){
			$("#terms-content-" + contentNo).hide();
		} else {
			$("#terms-content-" + contentNo).show();
		}
	});
	
	// 결제하기
	$("#payment").click(function(event) {
		event.preventDefault();
		var frm = $("#frm");
		if ($("input:checkbox[id='flexCheckChecked-real-user']").is(":checked") == false &&
			($("input[name=roomUserName]").val() == '' || $("input[name=roomUserTel]").val() == '')) {
				$("#real-user-error").show();
		} else {
			$("#real-user-error").hide();
			if ($("input[class=form-check-input-necessary]:checked").length!=2) {
				alert("동의사항을 모두 확인해 주세요.");
			} else {
				if($('input[name="payment"]:checked').val() == "카드") {
					frm.submit();
				} else {
					frm.attr("action", "/reserve/activity/kakaoPay");
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
</body>
</html>