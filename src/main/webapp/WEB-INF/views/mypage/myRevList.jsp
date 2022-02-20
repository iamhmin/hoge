<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>
<head>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js"></script>
	<link rel="stylesheet" href="../../resources/css/admin_style.css" />
</head>
<style>
.text--discount a,
.text a{
 color: var(--color-black);}
.modal__title.nav {
margin: 0;
padding-left: 15px;
}
</style>


<div class="mypage__content">
	<ul class="content__menu">
		<li class="content__item"><a href="/mypage/myrevlist" class="active">STAY</a></li>
		<li class="content__item"><a href="/mypage/myrevlist">ACTIVITY</a></li>
	</ul>
	<c:if test="${empty myRevList }">
		<div class="mb-3 text-center alert alert-info">현재 예약하신 STAY가 없습니다.<br/> STAY를 예약하시고, HOGE와 함께 여행을 떠나세요!!! :)</div>
	</c:if>
	<div class="container">
		<c:forEach var="myRevInfo" items="${myRevList }">
			<div class="row my-5 justify-content-center">
				<div class="col-6 border-start border-top border-bottom bg-light">
					<div class="row">
						<div class="row ms-1 fs-2 fw-bold text--discount" style="padding: 0;">
							<a href="#">${myRevInfo.accommoName }</a>
						</div>
						<div class="row ms-1 text" style="padding: 0; margin: 0;">
							<a href="#">${myRevInfo.roomName }</a>
						</div>
						<div class="row ms-1 discount__text">
							${myRevInfo.accommoRegionDepth1 }/${myRevInfo.accommoRegionDepth2 }
						</div>					
						<div class="row ms-1 discount__text">CHECK IN ::
							<fmt:formatDate value="${myRevInfo.checkInDate }" type="both" pattern="yyyy-MM-dd '/ PM' HH:mm" />
						</div>					
						<div class="row ms-1 discount__text">CHECK OUT ::
							<fmt:formatDate value="${myRevInfo.checkOutDate }" type="both" pattern="yyyy-MM-dd '/ AM' HH:mm" />
						</div>					
						<div class="row ms-1 discount__text">PAY INFO ::
							<fmt:formatNumber value="${myRevInfo.roomTaxIncludedPrice }" type="currency" currencySymbol="￦" />
						</div>	
						<div class="row-2 d-flex">
							<c:if test="${myRevInfo.roomBookingStatus eq 1 }">
								<button id="" class="btn btn-dark me-2" onclick="creatingModal(${myRevInfo.roomBookingNo })">예약정보 및 취소</button>
							</c:if>
							<c:if test="${myRevInfo.roomBookingStatus eq 2 }">
								<button id="" type="button" class="btn btn-dark me-2">취소완료</button>
							</c:if>
							<c:if test="${myRevInfo.roomBookingStatus eq 0 and myRevInfo.reviewStatus eq 0}">
								<button id="insertReviewBtn" type="button" class="btn btn-dark me-2" data-bs-toggle="modal" data-bs-target="#modal-review-insert${myRevInfo.roomBookingNo }">리뷰작성</button>
							</c:if>
							<c:if test="${myRevInfo.roomBookingStatus eq 0 and myRevInfo.reviewStatus eq 1}">
								<button id="" type="button" class="btn btn-dark me-2" data-bs-toggle="modal" data-bs-target="#modal-review-select${myRevInfo.roomBookingNo }">리뷰조회</button>
							</c:if>
							<!-- 리뷰작성모달 Start -->
							<form id="form-insert-review${myRevInfo.roomBookingNo }" action="/mypage/myrevlist/insertreview" method="get">
								<div class="modal fade" id="modal-review-insert${myRevInfo.roomBookingNo }" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
								  <div class="modal-dialog">
								    <article class="modal-content">
								        <p class="modal__title nav">리뷰작성</p>
								      <div class="modal-body">
										<h3 style="margin-bottom: 10px;">${myRevInfo.accommoName }/${myRevInfo.roomName }</h3>
										<input id="reviewAccommoNo" type="hidden" name="accommoNo" value="${myRevInfo.accommoNo }"/>
										<input id="reviewRoomBookingNo" type="hidden" name="roomBookingNo" value="${myRevInfo.roomBookingNo }"/>
										<div class="make_star1">
											<div class="selectrating" data-rate="5">
												<span class="" id="">청결점수</span>
												<i class="fas fa-star"></i>
												<i class="fas fa-star"></i>
												<i class="fas fa-star"></i>
												<i class="fas fa-star"></i>
												<i class="fas fa-star"></i>
												<span class="starScore1" ></span>
												<input type="hidden" name="cleanlinessStar"/>
											</div>
										</div>
										<div class="make_star2">
											<div class="selectrating" data-rate="5">
												<span class="" id="">소통점수</span>
												<i class="fas fa-star"></i>
												<i class="fas fa-star"></i>
												<i class="fas fa-star"></i>
												<i class="fas fa-star"></i>
												<i class="fas fa-star"></i>
												<span class="starScore2"></span>
												<input type="hidden" name="communicationStar"/>
											</div>
										</div>
										<div class="make_star3">
											<div class="selectrating" data-rate="5">
												<span class="" id="">정확점수</span>
												<i class="fas fa-star"></i>
												<i class="fas fa-star"></i>
												<i class="fas fa-star"></i>
												<i class="fas fa-star"></i>
												<i class="fas fa-star"></i>
												<span class="starScore3"></span>
												<input type="hidden" name="accuracyStar"/>
											</div>
										</div>
										<div class="make_star4">
											<div class="selectrating" data-rate="5">
												<span class="" id="">위치점수</span>
												<i class="fas fa-star"></i>
												<i class="fas fa-star"></i>
												<i class="fas fa-star"></i>
												<i class="fas fa-star"></i>
												<i class="fas fa-star"></i>
												<span class="starScore4"></span>
												<input type="hidden" name="locationStar"/>
											</div>
										</div>
										<textarea class="answer__textarea" name="content" id="" style="margin-top: 10px;"></textarea>
								      </div>
								      <div class="modal-footer">
								        <button type="button" class="btn btn-dark" data-bs-dismiss="modal">닫기</button>
								        <button type="submit" class="reviewSave btn btn-dark">리뷰저장</button>
								      </div>
								    </article>
								  </div>
								</div>
							</form>
							<!-- 리뷰작성모달 End -->
							<!-- 리뷰조회모달 Start -->
							<form id="form-update-review${myRevInfo.roomBookingNo }" action="" method="get">
							<div class="modal fade" id="modal-review-select${myRevInfo.roomBookingNo }" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
							  <div class="modal-dialog">
							    <article class="modal-content">
							        <p class="modal__title nav">리뷰조회 및 수정</p>
							      <div class="modal-body">
							        <div style="margin-bottom: 10px;">
							      	<fmt:formatDate value="${myRevInfo.myReview.updatedDate }" type="both" pattern="yyyy-MM-dd HH:mm:ss" />
							      </div>
									<h3 style="margin-bottom: 10px;">${myRevInfo.accommoName }/${myRevInfo.roomName }</h3>
									<div class="make_star1">
										<div class="selectrating" data-rate="${myRevInfo.myReview.cleanlinessStar }">
											<span class="" id="">청결점수</span>
											<i class="fas fa-star"></i>
											<i class="fas fa-star"></i>
											<i class="fas fa-star"></i>
											<i class="fas fa-star"></i>
											<i class="fas fa-star"></i>
											<span class="starScore1"></span>
											<input type="hidden" name="cleanlinessStar"/>
										</div>
									</div>
									<div class="make_star2">
										<div class="selectrating" data-rate="${myRevInfo.myReview.communicationStar }">
											<span class="" id="">소통점수</span>
											<i class="fas fa-star"></i>
											<i class="fas fa-star"></i>
											<i class="fas fa-star"></i>
											<i class="fas fa-star"></i>
											<i class="fas fa-star"></i>
											<span class="starScore2"></span>
											<input type="hidden" name="communicationStar"/>
										</div>
									</div>
									<div class="make_star3">
										<div class="selectrating" data-rate="${myRevInfo.myReview.accuracyStar }">
											<span class="" id="">정확점수</span>
											<i class="fas fa-star"></i>
											<i class="fas fa-star"></i>
											<i class="fas fa-star"></i>
											<i class="fas fa-star"></i>
											<i class="fas fa-star"></i>
											<span class="starScore3"></span>
											<input type="hidden" name="accuracyStar"/>
										</div>
									</div>
									<div class="make_star4">
										<div class="selectrating" data-rate="${myRevInfo.myReview.locationStar }">
											<span class="" id="">위치점수</span>
											<i class="fas fa-star"></i>
											<i class="fas fa-star"></i>
											<i class="fas fa-star"></i>
											<i class="fas fa-star"></i>
											<i class="fas fa-star"></i>
											<span class="starScore4"></span>
											<input type="hidden" name="locationStar"/>
										</div>
									</div>
									<input type="hidden" name="no" value="${myRevInfo.myReview.no }"/>
									<textarea class="answer__textarea" name="content" style="margin-top: 10px;">${myRevInfo.myReview.content }</textarea>
								  </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-dark" data-bs-dismiss="modal">닫기</button>
							        <button id="reviewModifyBtn${myRevInfo.roomBookingNo }" type="button" class="reviewModify btn btn-dark">수정</button>
							        <button id="reviewDeleteBtn${myRevInfo.roomBookingNo }" type="button" class="reviewDelete btn btn-dark">삭제</button>
							      </div>
								 </article>
							   </div>
							 </div>
							 </form>
							 <!-- 리뷰조회모달 End-->
						</div>
					</div>
				</div>
				<!-- 이미지 -->
				<div class="col-4 me-0 border-top border-bottom border-end bg-light">
					<div id="carouselExampleIndicators${myRevInfo.accommoNo }" class="carousel slide" data-bs-ride="carousel">
						<div class="carousel-indicators">
							<c:forEach var="accommoImage" items="${myRevInfo.accommoImages }" varStatus="status">
								<button type="button" 
										data-bs-target="#carouselExampleIndicators${myRevInfo.accommoNo }"
										data-bs-slide-to="${status.index }" 
										class="<c:if test="${status.index eq 0 }">active</c:if>" 
										aria-current="true"
										aria-label="Slide ${status.count }">
								</button>
							</c:forEach>
						</div>
						<div class="carousel-inner">
							<c:forEach var="accommoImage" items="${myRevInfo.accommoImages }" varStatus="status">
								<div class="carousel-item<c:if test="${status.index eq 0 }"> active</c:if>">
									<img src="../../resources/images/accommodation/${accommoImage.image}" class="d-block w-100" alt="...">
								</div>
							</c:forEach>
						</div>
						<button class="carousel-control-prev" type="button"
							data-bs-target="#carouselExampleIndicators${myRevInfo.accommoNo }" data-bs-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Previous</span>
						</button>
						<button class="carousel-control-next" type="button"
							data-bs-target="#carouselExampleIndicators${myRevInfo.accommoNo }" data-bs-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Next</span>
						</button>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>

<div class="modal fade" id="modal-cancelRev" tabindex="-1" aria-labelledby="예약취소" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<article class="modal-content">
				<p class="modal__title">예약 정보</p>
			<main class="modal-main">
				<p class="question__title" id="defaultTitle">기본정보</p>
				<table class="user-list-table">
					<colgroup>
						<col style="width: 20%" />
						<col style="width: 20%" />
						<col style="width: 20%" />
						<col style="width: 20%" />
						<col style="width: 20%" />
					</colgroup>
					<thead>
						<tr>
							<th>예약번호</th>
							<th>숙소이름</th>
							<th>방이름</th>
							<th>예약자</th>
							<th>추가인원</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td id="roomBookingNo"></td>
							<td id="accommoName"></td>
							<td id="roomName"></td>
							<td id="roomUserName"></td>
							<td id="extraPeople"></td>
						</tr>
					</tbody>
				</table>
				<div class="modal-question">
					<p class="question__title" id="detailTitle">결제정보</p>
					<table class="user-list-table">
						<colgroup>
							<col style="width: 20%" />
							<col style="width: 20%" />
							<col style="width: 20%" />
							<col style="width: 20%" />
							<col style="width: 20%" />
						</colgroup>
						<thead>
							<tr>
								<th>결제일</th>
								<th>결제타입</th>
								<th>결제액</th>
								<th>사용포인트</th>
								<th>실 결제금액</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td id="bookingMadeDate"></td>
								<td id="payment"></td>
								<td id="roomTaxIncludedPrice"></td>
								<td id="usedPnt"></td>
								<td id="paidPrice"></td>
							</tr>
						</tbody>
					</table>
					<table class="user-list-table">
						<colgroup>
							<col style="width: 50%" />
							<col style="width: 50%" />
						</colgroup>
						<thead>
							<tr>
								<th>예상 환불 포인트</th>
								<th>예상 환불 금액</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td id="refundUsedPnt"></td>
								<td id="refundpaidPrice"></td>
							</tr>
						</tbody>
					</table>
				</div>
				<form id="cancel-form" method="post" action="/mypage/myrevlist/cancelrev">
					<input type="hidden" name="roomBookingNo" value="" />
					<div class="modal-answer">
						<p class="answer__title">취소 사유</p>
						<textarea class="answer__textarea" name="cancelReason" id="cancelReasonContent"></textarea>
					</div>
					<div class="answer-btn">
						<button type="button" class="btn__answer" id="cancelRevBtn" data-bs-dismiss="modal">예약 취소</button>
					</div>
				</form>
			</main>
		</article>
	</div>
</div>
<script>
$(function() {
	/* 작성된 리뷰 별점셋팅 스타트 */
	<c:forEach var="myRevInfo" items="${myRevList }">
	<c:forEach var="cnt" begin="1" end="4">
	
	// 작성된 리뷰 별 셋팅하기
	var rating = $("#modal-review-select${myRevInfo.roomBookingNo} .selectrating");
	rating.each(function(){
		var defaultScore = $(this).attr('data-rate');
		for(var i = 0; i<defaultScore; i++){
			$(this).find('.fa-star').eq(i).css({color:'#dc143c'});
		}
		
		// 작성된 리뷰 색칠 후 각 스코어와 input에 값 셋팅
		$("#modal-review-select${myRevInfo.roomBookingNo} .starScore1").text(${myRevInfo.myReview.cleanlinessStar } + "점");
		$("#modal-review-select${myRevInfo.roomBookingNo} .starScore2").text(${myRevInfo.myReview.communicationStar } + "점");
		$("#modal-review-select${myRevInfo.roomBookingNo} .starScore3").text(${myRevInfo.myReview.accuracyStar } + "점");
		$("#modal-review-select${myRevInfo.roomBookingNo} .starScore4").text(${myRevInfo.myReview.locationStar } + "점");
		$("#modal-review-select${myRevInfo.roomBookingNo} .make_star1 input[type=hidden]").val(${myRevInfo.myReview.cleanlinessStar });
		$("#modal-review-select${myRevInfo.roomBookingNo} .make_star2 input[type=hidden]").val(${myRevInfo.myReview.communicationStar });
		$("#modal-review-select${myRevInfo.roomBookingNo} .make_star3 input[type=hidden]").val(${myRevInfo.myReview.accuracyStar });
		$("#modal-review-select${myRevInfo.roomBookingNo} .make_star4 input[type=hidden]").val(${myRevInfo.myReview.locationStar });
	});
	// 작성된 리뷰 별 클릭 수정
	$("#modal-review-select${myRevInfo.roomBookingNo} .make_star${cnt} svg").click(function() {
		var targetNum = $(this).index() +1;
		$("#modal-review-select${myRevInfo.roomBookingNo} .make_star${cnt} svg").css({color:"black"});
		$("#modal-review-select${myRevInfo.roomBookingNo} .make_star${cnt} svg:nth-child(-n+" + targetNum +")").css({color:"#dc143c"});
		$("#modal-review-select${myRevInfo.roomBookingNo} .starScore${cnt}").text(targetNum-1 + "점");
		$("#modal-review-select${myRevInfo.roomBookingNo} .make_star${cnt} input[type=hidden]").val(targetNum-1);
	});
	</c:forEach>
	</c:forEach>
	/* 작성된 리뷰 별점셋팅 엔드 */
	
	/* 작성할 리뷰 기초셋팅 스타트 */
	<c:forEach var="myRevInfo" items="${myRevList }">
	<c:forEach var="cnt" begin="1" end="4">
	
	// 작성할 리뷰 별 기초셋팅하기
	var rating = $("#modal-review-insert${myRevInfo.roomBookingNo} .selectrating");
	rating.each(function(){
		var defaultScore = $(this).attr('data-rate');
		for(var i = 0; i<defaultScore; i++){
			$(this).find('.fa-star').eq(i).css({color:'#dc143c'});
			$("#modal-review-insert${myRevInfo.roomBookingNo} .starScore${cnt}").text(defaultScore + "점");
			$("#modal-review-insert${myRevInfo.roomBookingNo} .make_star${cnt} input[type=hidden]").val(defaultScore);
		}	
	});
	
	// 작성할 리뷰 별 클릭 수정
	$("#modal-review-insert${myRevInfo.roomBookingNo} .make_star${cnt} svg").click(function() {
		var targetNum = $(this).index() +1;
		$("#modal-review-insert${myRevInfo.roomBookingNo} .make_star${cnt} svg").css({color:"black"});
		$("#modal-review-insert${myRevInfo.roomBookingNo} .make_star${cnt} svg:nth-child(-n+" + targetNum +")").css({color:"#dc143c"});
		$("#modal-review-insert${myRevInfo.roomBookingNo} .starScore${cnt}").text(targetNum-1 + "점");
		$("#modal-review-insert${myRevInfo.roomBookingNo} .make_star${cnt} input[type=hidden]").val(targetNum-1);
	});
	</c:forEach>
	</c:forEach>
	/* 작성할 리뷰 기초셋팅 엔드 */
	
	/* 폼 서브밋 */
	<c:forEach var="myRevInfo" items="${myRevList }">
		$("#reviewDeleteBtn${myRevInfo.roomBookingNo }").click(function() {
			$("#form-update-review${myRevInfo.roomBookingNo }").attr("action","/mypage/myrevlist/deletereview");
			$("#form-update-review${myRevInfo.roomBookingNo }").submit();
		});
		
		$("#reviewModifyBtn${myRevInfo.roomBookingNo }").click(function() {
			$("#form-update-review${myRevInfo.roomBookingNo }").attr("action","/mypage/myrevlist/updatereview");
			$("#form-update-review${myRevInfo.roomBookingNo }").submit();
		});
	</c:forEach>

	/* 리뷰 수정 보류
	<c:forEach var="myRevInfo" items="${myRevList }">
	
	$("#reviewModifyBtn${myRevInfo.roomBookingNo }").click(function() {
		var $cleanlinessStar = $("#modal-review-select${myRevInfo.roomBookingNo} .make_star1 input[type=hidden]").val();
		var $communicationStar = $("#modal-review-select${myRevInfo.roomBookingNo} .make_star2 input[type=hidden]").val();
		var $accuracyStar = $("#modal-review-select${myRevInfo.roomBookingNo} .make_star3 input[type=hidden]").val();
		var $locationStar = $("#modal-review-select${myRevInfo.roomBookingNo} .make_star4 input[type=hidden]").val();
		var $content = $("#modal-review-select${myRevInfo.roomBookingNo} textarea").val();
		var $no = $("#modal-review-select${myRevInfo.roomBookingNo} input[name=no]").val();	
		console.log($cleanlinessStar);
		console.log($communicationStar);
		console.log($accuracyStar);
		console.log($locationStar);
		console.log($content);
		console.log($no);
		console.log(${myRevInfo.accommoNo});
		
		$.ajax({
			type: 'get',
		    url:  '/mypage/myrevlist/updatereview',
		    data: {cleanlinessStar:${myRevInfo.accommoNo}, 
		    	   communicationStar:$communicationStar, 
		    	   accuracyStar:$accuracyStar, 
		    	   locationStar:$locationStar,
		    	   content:$content
		    	   no:$no},
		    success: function(data) {
		    	console.log(data);
		    }
		});
		
	});
	
	</c:forEach>*/
});

function creatingModal(roomBookingNo) {
	
	let answeringModal = new bootstrap.Modal(document.getElementById('modal-cancelRev'), {
		keyboard: false
	
	});
	
	$.getJSON('/mypage/myrevlist/cancelrev', {roomBookingNo:roomBookingNo}, function(myRevInfoByBookingNo) {
			$("#bookingMadeDate").text(myRevInfoByBookingNo.bookingMadeDate);
			$('#roomBookingNo').text(myRevInfoByBookingNo.roomBookingNo);
			$('#accommoName').text(myRevInfoByBookingNo.accommoName);
			$('#roomName').text(myRevInfoByBookingNo.roomName);
			$('#roomUserName').text(myRevInfoByBookingNo.roomUserName);
			$('#extraPeople').text(myRevInfoByBookingNo.extraPeople);
			$('#payment').text(myRevInfoByBookingNo.payment);
			$('#paidPrice').text(myRevInfoByBookingNo.paidPrice);
			$('#usedPnt').text(myRevInfoByBookingNo.usedPnt);
			$('#roomTaxIncludedPrice').text(myRevInfoByBookingNo.roomTaxIncludedPrice);
			$('#refundUsedPnt').text(myRevInfoByBookingNo.usedPnt);
			$('#refundpaidPrice').text(myRevInfoByBookingNo.paidPrice);
			$('input[name=roomBookingNo]').attr('value', myRevInfoByBookingNo.roomBookingNo);
	});
	
	answeringModal.show();
}
$("#cancelRevBtn").click(function() {
	
	var roomBookingNo = $(":input[name=roomBookingNo]").val();
	var cancelReason = $(":input[name=cancelReason]").val();
	
	console.log(roomBookingNo);
	console.log(cancelReason);
	
	$("#cancel-form").trigger("submit");
	
});
</script>