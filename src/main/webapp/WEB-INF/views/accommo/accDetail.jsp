<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>

<style>
	.target { display: inline-block; width: 1000px; }
	A:link {text-decoration:none; color:#000000;}
	A:visited {text-decoration:none; color:#000000;}
	A:active {text-decoration:none; color:#000000;}
	A:hover {text-decoration:none; color:#000000;}
	#box1 {text-align: right;}
	#box2 {text-align: center;}
	.box3 {
    width: 60px;
    border-radius: 70%;
    overflow: hidden;
	}
	#footer {
	margin: 0;}
</style>


 <main>
      <article id="accommo-detail">
        <div class="width-wrap">
          <div class="accommo-detail__header">
           <button class="btn__date-search" type="button" id="chat-connect">나의 채팅목록에 추가</button>
            <a class="accommo-back" href="javascript:history.back()"><img src="/resources/images/common/back.JPG">돌아가기</a>
          </div>

    <div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel">
		<div class="carousel-inner">
			<c:forEach var="image" items="${accImages}" varStatus="status">
				<c:choose>
					<c:when test="${status.index == 0}">
						<div class="carousel-item active">
					</c:when>
					<c:otherwise>
						<div class="carousel-item">
					</c:otherwise>
				</c:choose>
						<img src="/resources/images/accommodation/${image.image }" class="d-block w-100" alt="..." style="height: 650px;">
						<div class="carousel-caption d-none d-md-block">
							<h2>"${accMainDto.accIntroTitle}"   <${accMainDto.accName}></h2>
							<h6>${accMainDto.dept1} / ${accMainDto.dept2}</h6>
							<c:choose>
								<c:when test="${not empty promotionDiscountList}">
									<h6><프로모션 진행중></h6>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${not empty promotionOfferList}">
											<h6><프로모션 진행중></h6>
										</c:when>
										<c:otherwise>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
			</c:forEach>
		</div>
         
          <div class="accommo-summary">
            <div class="accommo-detail__name">${accMainDto.accName}</div>
            <div class="accommo-detail__form">
              <c:choose>
				<c:when test="${param.days eq ''}">
					날짜를 선택해주세요.
				</c:when>
				<c:when test="${param.days == null}">
					날짜를 선택해주세요.
				</c:when>
				<c:otherwise>
					${param.check_in } ~ ${param.check_out } [${param.days }박]
				</c:otherwise>
			</c:choose>	
            </div>
            <form method="post" action="search" method="post">
              <input type="hidden" name="accNo" value="${accMainDto.accNo }" />
              <input
                class="date-search-form"
                id="checkInBox1"
                type="text"
                name="check_in"
              />
              ~
              <input
                class="date-search-form"
                id="checkOutBox1"
                type="text"
                name="check_out"
              />
              <button class="btn__date-search" type="submit">검색</button>
            </form>
          </div>
        </div>
       </div> 
        <section class="accommo-detail__room">
          <div class="background-img"></div>
          <div class="slide-wrap">
            <div class="slide__info">
              <div class="slide__title">ROOMS</div>
              <div class="hr"></div>
              <div class="promo-info-wrap">
                
                <c:choose>
					<c:when test="${empty promotionDiscountList}">
					</c:when>
					<c:otherwise>
						<c:forEach var="promotionDiscountList" items="${promotionDiscountList }">
		                  <div class="promo-info">할인 프로모션</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
              
                <c:choose>
					<c:when test="${empty promotionOfferList}">
					</c:when>
					<c:otherwise>
						<c:forEach var="promotionOfferList" items="${promotionOfferList }">
		                  <div class="promo-info">증정 프로모션</div>
						</c:forEach>
					</c:otherwise>
			    </c:choose>
              </div>
            </div>
            <div class="slide__content owl-carousel owl-theme">
              <c:forEach var="roomSearchList" items="${roomSearchList}">
                <c:forEach var="image" items="${roomSearchList.roomImages}" varStatus="status">
				  <c:if test="${status.index == 0}">
		              <div class="slide__item" style="background-image: url('/resources/images/room/${image.image }')">
		                <a class="searchDate" href="/accommo/roomDetail?accNo=${param.accNo }&check_in=${param.check_in }&check_out=${param.check_out }&roomNo=${roomSearchList.no }&days=${param.days }">
		                  <div class="room__text">
		                    <div class="room__text-box">
		                      <div class="room__name">${roomSearchList.name}</div>
		                      <div class="room__price">&#8361;<fmt:formatNumber value="${roomSearchList.weekdaysPrice }" pattern="##,###"/> ~</div>
		                    </div>
		                    <div class="room__text-box">
		                      <div class="room__num-people">${roomSearchList.standardNumber }명(최대 ${roomSearchList.maximumNumber }명)</div>
		                      <div class="room__book">book</div>
		                    </div>
		                  </div>
		                </a>
		              </div>
	              </c:if>
				</c:forEach>
              </c:forEach>
            </div>
            <i class="fa-solid fa-circle-chevron-left"></i>
            <i class="fa-solid fa-circle-chevron-right"></i>
          </div>
        </section>
        <section class="accommo-detail__info">
          <div class="detail-info__title">${accMainDto.accIntroTitle}</div>
          <div class="detail-info__name">${accMainDto.accName}</div>
          <div class="after"></div>
          <p class="detail-info__text">
            ${accMainDto.accIntroContent}
          </p>
          <div class="detail-info__address">
            ${accMainDto.accName}의 주소는 [ ${accMainDto.accAddress}
            ]입니다.
          </div>
        </section>
        <section class="accommo-detail__review">
          <div class="review-title-box">
            <div class="detail-review__title">
              <i class="fa-solid fa-star"></i> ${getAccDetailStar.totalAverage } / 후기 ${getAccDetailReviewsTotal.total }개
            </div>
            <ul class="detail-review__star">
              <li class="star__item">
                <div class="star-title">청결도</div>
                <div class="star-count">${getAccDetailStar.cleanlinessStar }</div>
              </li>
              <li class="star__item">
                <div class="star-title">의사소통</div>
                <div class="star-count">${getAccDetailStar.communicationStar }</div>
              </li>
              <li class="star__item">
                <div class="star-title">정확도</div>
                <div class="star-count">${getAccDetailStar.accuracyStar }</div>
              </li>
              <li class="star__item">
                <div class="star-title">위치</div>
                <div class="star-count">${getAccDetailStar.locationStar }</div>
              </li>
            </ul>
          </div>
          <div class="detail-review__content">
            <c:forEach var="getAccDetailReviews6" items="${getAccDetailReviews6 }">
	            <div class="review-content-box">
	              <div class="review__info">
	                <div
	                  class="review__user-img"
	                  style="background-image: url('/resources/images/userprofiles/${getAccDetailReviews6.userImage }')"
	                ></div>
	                <div class="user-wrap">
	                  <div class="review__user-name">${getAccDetailReviews6.userName }</div>
	                  <div class="review__date"><fmt:formatDate value="${getAccDetailReviews6.createdDate}" pattern="yyyy.MM.dd"/></div>
	                </div>
	              </div>
	              <div class="review__text">
	               ${getAccDetailReviews6.content }
	              </div>
	            </div>
            </c:forEach>
          </div>
          <div class="detail-review__btn">
            <button id="btn" class="btn__review">후기 ${getAccDetailReviewsTotal.total }개 모두 보기</button>
          </div>
        </section>
        
   
   <!-- 모달 -->
    <div class="modal fade" id="modal-review" tabindex="-1" aria-labelledby="전체 리뷰" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-scrollable modal-lg">
		
          <article class="modal-content detail-review__modal">
            <div class="modal-title-wrap">
              <div class="modal-review__title">
                <i class="fa-solid fa-star"></i> ${getAccDetailStar.totalAverage }
              </div>
              <div class="moda-review__count">후기 ${getAccDetailReviewsTotal.total }개</div>
            </div>
            <div class="modal-review-wrap">
              <section class="review-left">
                <ul class="modal-review__star">
                  <li class="modal-star__item">
                    <div class="star-title">청결도</div>
                    <div class="star-count">${getAccDetailStar.cleanlinessStar }</div>
                  </li>
                  <li class="modal-star__item">
                    <div class="star-title">의사소통</div>
                    <div class="star-count">${getAccDetailStar.communicationStar }</div>
                  </li>
                  <li class="modal-star__item">
                    <div class="star-title">정확도</div>
                    <div class="star-count">${getAccDetailStar.accuracyStar }</div>
                  </li>
                  <li class="modal-star__item">
                    <div class="star-title">위치</div>
                    <div class="star-count">${getAccDetailStar.locationStar }</div>
                  </li>
                </ul>
              </section>
              <section class="review-right">
                <c:forEach var="getAccDetailReviews" items="${getAccDetailReviews }">
	                <div class="modal-content-box">
	                  <div class="review__info">
	                    <div
	                      class="review__user-img"
	                      style="background-image: url('/resources/images/userprofiles/${getAccDetailReviews.userImage }')"
	                    ></div>
	                    <div class="user-wrap">
	                      <div class="review__user-name">${getAccDetailReviews.userName }</div>
	                      <div class="review__date"><fmt:formatDate value="${getAccDetailReviews.createdDate}" pattern="yyyy.MM.dd"/></div>
	                    </div>
	                  </div>
	                  <div class="review__text">
	                    ${getAccDetailReviews.content }
	                  </div>
	                </div>
                 </c:forEach>
              </section>
            </div>
          </article>
		
	  </div>
	</div>
        
     <div class="faq">
  <div class="container faq-content" >
	<div class="row">
		<div class="col-2 ">
		    <p class="faq-title" style="margin-bottom:15px;">F A Q</p>
		    <p style="margin-bottom:15px;"><a href="" class="" id="11">인원 및 금액</a></p>
		    <p style="margin-bottom:15px;"><a href="" class="" id="22">예약 및 결제</a></p>
		    <p style="margin-bottom:15px;"><a href="" class="" id="33">이용 안내</a></p>
		    <p style="margin-bottom:15px;"><a href="" class="" id="44">부대시설 안내</a></p>
		    <p style="margin-bottom:15px;"><a href="" class="" id="55">기타 안내</a></p>
	    </div>
	    
		<div class="col-10" id="1">
			<h5 class="faq-sub-title" style="margin-bottom:30px;">FAQ를 통하여 예약에 관련된 더 자세한 내용들을 찾아보세요.</h5>
			<h3 class="faq-content-title" style="margin-bottom:20px;">인원 및 금액</h3>
			<div class="row faq-p">
				<div class="col-2">
					<h5 class="content-title">인원 기준</h5>
				</div>
				<div class="col-8">
					<table class="table" id="box2">
						<thead>
							<tr>
								<th>객실이름</th>
								<th></th>
								<th>기준인원</th>
								<th></th>
								<th>최대인원</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="roomListDto" items="${roomListDto}">
								<tr>
									<td>${roomListDto.name}<td>
									<td>${roomListDto.standardNumber}<td>
									<td>${roomListDto.maximumNumber}<td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<c:forEach var="roomListDto" items="${roomListDto}">
						<c:if test="${roomListDto.pricePerPerson ne 0}">
							<p class="font-p">• ${roomListDto.name } 객실 : 기준 인원 외의 인원은 1박당 <fmt:formatNumber value="${roomListDto.pricePerPerson }" pattern="##,###"/>원의 추가 비용이 적용됩니다.</p>
						</c:if>
					</c:forEach>
					<p class="font-p" style="margin-bottom:40px;">• 최대인원을 초과하는 인원 및 방문객의 입실은 불가합니다.</p>
				</div>
			</div>
			<div class="row faq-p">
				<div class="col-2">
					<h5 class="content-title">요금 기준</h5>
				</div>
				<div class="col-8">
					<table class="table" id="box2">
						<thead>
							<tr>
								<th>객실이름</th>
								<th></th>
								<th>주중(일-목)</th>
								<th></th>
								<th>주말(금-토)</th>
								<th></th>
								<th>성수기</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="roomListDto" items="${roomListDto}">
								<tr>
									<td>${roomListDto.name}<td>
									<td>${roomListDto.weekdaysPrice}<td>
									<td>${roomListDto.weekendPrice}<td>
									<td>${roomListDto.peakSeasonPrice}<td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<p class="font-p">• 성수기 : 7. 15 - 8. 14/ 12월 특정 일자(12. 24, 12. 31)</p>
					<p class="font-p">• 공휴일 전날은 주말요금이 적용됩니다.</p>
					<p class="font-p" style="margin-bottom:40px;">• 예약 변경 및 기타 문의사항은 ${accMainDto.accName}(${accMainDto.tel})로 연락 주시기 바랍니다.</p>
				</div>
			</div>
		</div>
		
		<div class="col-10" id="2">
			<h5 class="faq-sub-title" style="margin-bottom:30px;">FAQ를 통하여 예약에 관련된 더 자세한 내용들을 찾아보세요.</h5>
			<h3 class="faq-content-title" style="margin-bottom:20px;">예약 및 결제</h3>
			<div class="row">
				<div class="col-2">
					<h5 class="content-title">예약 안내</h5>
				</div>
				<div class="col-8 font-p">
					<p>• 예약신청 후 결제방식에 따라 결제가 완료되면, 예약이 확정됩니다.</p>
					<p>• 신청 후 12시간 이내에 입금되지 않을 경우, 예약이 취소됩니다.</p>
					<p>• 한 날짜에 예약신청이 중복될 경우, 입금 순서가 아닌 신청 순서로 예약이 확정됩니다.</p>
					<p>• 계좌이체 결제시 현금영수증 발행이 가능합니다. 예약시 신청해주세요.</p>
					<p>• 예약 취소는 MyPage - 스테이 예약정보 - [예약 취소 요청] 버튼을 눌러주시기 바랍니다.</p>
					<p>• 이곳은 촬영 스튜디오가 아닌 숙박 공간입니다. 사전에 협의되지 않은 상업 사진 및 영상 촬영은 불가합니다.(광고용 사진, 제품사진, 쇼핑몰, SNS마켓 포함)</p>
					<p style="margin-bottom:40px;">• 상업적 용도의 촬영은 별도 대관료를 책정하여 운영하고 있습니다.</p>
				</div>
			</div>
			<div class="row faq-p">
				<div class="col-2">
					<h5 class="content-title">환불 규정</h5>
				</div>
				<div class="col-8">
					<p class="font-p" style="margin-bottom: 10px;">• 환불 시 아래의 기준일에 따른 환불 금액을 드립니다.</p>
					<table class="table refund" id="box2">
						<tbody>
							<tr>
								<td><strong>이용 10일전까지</strong></td>
								<td><strong>총 결제금액의 100% 환불</strong></td>
							</tr>
							<tr>
								<td>이용 9일전까지</td>
								<td>총 결제금액의 90% 환불</td>
							</tr>
							<tr>
								<td>이용 8일전까지</td>
								<td>총 결제금액의 80% 환불</td>
							</tr>
							<tr>
								<td>이용 7일전까지</td>
								<td>총 결제금액의 70% 환불</td>
							</tr>
							<tr>
								<td>이용 6일전까지</td>
								<td>총 결제금액의 60% 환불</td>
							</tr>
							<tr>
								<td>이용 5일전까지</td>
								<td>총 결제금액의 50% 환불</td>
							</tr>
							<tr>
								<td>이용 4일전까지</td>
								<td>총 결제금액의 40% 환불</td>
							</tr>
							<tr>
								<td>이용 3일전까지</td>
								<td>변경/환불 불가</td>
							</tr>
						</tbody>
					</table>
					<p class="font-p">• 예약의 확정은 위 사항을 모두 숙지하였고 모든 사항에 동의함을 의미합니다.</p>
					<p class="font-p" style="margin-bottom:40px;">• 자세한 문의사항은 ${accMainDto.accName}(${accMainDto.tel})로 연락주시기 바랍니다.</p>
				</div>
			</div>
			<div class="row faq-p">
				<div class="col-2">
					<h5 class="content-title">취소 안내</h5>
				</div>
				<div class="col-8 font-p">
					<p>• 예약번호는 예약안내 문자를 통해 확인 가능합니다. 확인이 어려우신 경우 호게 챗봇을 통해 예약번호를 문의해주시기 바랍니다.</p>
					<p style="margin-bottom:40px;">• 취소를 원하시는 경우, 호게 - ACCOUNT - 마이 페이지 - 예약 정보 - [취소 요청] 버튼을 눌러주시기 바랍니다.</p>
				</div>
			</div>
			<div class="row">
				<div class="col-2">
					<h5 class="content-title">숙박권 양도</h5>
				</div>
				<div class="col-8 font-p">
					<p>• 숙박권의 재판매를 비롯하여 양도, 양수, 교환을 금지합니다.</p>
					<p style="margin-bottom:40px;">• 예약자의 부득이한 사유로 인해 본인 이용이 어려울 경우 가족에 한해 가족관계임을 증명할 수 있는 서류(가족관계증명서 등)와 실제 이용하시는 분의 신분증을 해당 스테이에 제시 후 이용이 가능합니다.</p>
				</div>
			</div>
		</div>
		
		<div class="col-10 faq-p" id="3">
			<h5 class="faq-sub-title" style="margin-bottom:30px;">FAQ를 통하여 예약에 관련된 더 자세한 내용들을 찾아보세요.</h5>
			<h3 class="faq-content-title" style="margin-bottom:20px;">이용 안내</h3>
			<div class="row">
				<div class="col-2">
					<h5 class="content-title">예약 전<br>확인사항</h5>
				</div>
				<div class="col-8 font-p">
					<p>• 체크인은 ${accMainDto.accCheckInTime}, 체크아웃은 ${accMainDto.accCheckOutime}입니다.</p>
					<p>• 객실 정리를 위해 체크아웃 시간을 지켜주시길 부탁드립니다.</p>
					<p>• 예약하신 당일 오전에 체크인 안내 문자를 보내드립니다.</p>
					<p>• 숙박 인원 외의 방문자 입실은 불가하며, 이에 따른 책임은 게스트에게 있으니 꼭 참고 부탁드립니다.</p>
					<p>• 숙소 내 모든 구역에서는 전자 담배를 포함하여 절대 금연입니다. 위반 시 즉각 퇴실 조치와 추가 청소비를 청구합니다.</p>
					<p>• 시설 및 비품의 파손, 반출, 분실 시 변상비가 청구됩니다.</p>
					<p>• 사전에 협의가 이뤄지지 않은 상업 사진 및 영상 촬영(광고용, 제품 사진, 쇼핑몰, SNS 마켓 포함), 드론 촬영은 불가합니다.</p>
					<p style="margin-bottom:40px;">• 예약 변경 및 기타 문의 사항은 ${accMainDto.accName}(${accMainDto.tel})로 연락해 주시기 바랍니다.</p>
				</div>
			</div>
		</div>
		
		<div class="col-10 faq-p" id="4">
			<h5 class="faq-sub-title" style="margin-bottom:30px;">FAQ를 통하여 예약에 관련된 더 자세한 내용들을 찾아보세요.</h5>
			<h3 class="faq-content-title" style="margin-bottom:20px;">부대시설 안내</h3>
			<c:forEach var="roomInfoType1" items="${roomInfoType1}">
				<div class="row">
					<div class="col-2">
						<h5 class="content-title">${roomInfoType1.infoTitle1}</h5>
					</div>
					<div class="col-10">
						<pre class="font-p"><p style="margin-bottom:30px;">${roomInfoType1.infoContent1}</p></pre>
					</div>
				</div>
			</c:forEach>
		</div>
		
		<div class="col-10 faq-p" id="5">
			<h5 class="faq-sub-title" style="margin-bottom:30px;">FAQ를 통하여 예약에 관련된 더 자세한 내용들을 찾아보세요.</h5>
			<h3 class="faq-content-title" style="margin-bottom:20px;">기타 안내</h3>
			<c:forEach var="roomInfoType2" items="${roomInfoType2}">
				<div class="row">
					<div class="col-2">
						<h5 class="content-title">${roomInfoType2.infoTitle2}</h5>
					</div>
					<div class="col-10">
					<pre class="font-p"><p style="margin-bottom:30px;">${roomInfoType2.infoContent2}</p></pre>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
  </div>
</div>   
        
        
        
      </article>
    </main>




<script>

	// owl-carousel
	
	var owl = $(".owl-carousel");
	owl.owlCarousel({
	  loop: true,
	  nav: true,
	  margin: 50,
	  navText: [$(".fa-circle-chevron-left"), $(".fa-circle-chevron-right")],
	  responsive: {
	    0: {
	      items: 1,
	    },
	    600: {
	      items: 1,
	    },
	    1200: {
	      items: 2,
	    },
	  },
	});





datePickerSet($("#checkInBox1"), $("#checkOutBox1"));

function datePickerSet(sDate, eDate) {
	
    var sDay = sDate.val();
    var eDay = eDate.val();

    // 체크인 달력 생성
    if (!isValidStr(eDay)) {
        sDate.datepicker({
            maxDate: new Date(eDay)
        });
    }
    
    sDate.datepicker({
        language: 'ko',
        minDate: new Date(),
        autoClose: true,
        onSelect: function () {
            datePickerSet(sDate, eDate);
        }
    });

    // 체크아웃 달력 생성
    if (!isValidStr(sDay)) {
        eDate.datepicker({
            minDate: new Date(sDay)
        });
    } 
    
    eDate.datepicker({
        language: 'ko',
        autoClose: true,
        onSelect: function () {
            datePickerSet(sDate, eDate);
        }
    });

	//날짜 생성 여부
	function isValidStr(str) {
	    if (str == null || str == undefined || str == "")
	        return true;
	    else
	        return false;
	}
}

	$(function() {
		$("#2").hide();
		$("#3").hide();
		$("#4").hide();
		$("#5").hide();
	})
	
	
	$('#11').click(function(e){
		e.preventDefault(); // 이벤트 막아버림(새로고침, submit 등등)
		$("#1").show();
		$("#2").hide();
		$("#3").hide();
		$("#4").hide();
		$("#5").hide();
	})
	
	$('#22').click(function(e){
		e.preventDefault();
		$("#2").show();
		$("#1").hide();
		$("#3").hide();
		$("#4").hide();
		$("#5").hide();
	})
	
	$('#33').click(function(e){
		e.preventDefault();
		$("#3").show();
		$("#1").hide();
		$("#2").hide();
		$("#4").hide();
		$("#5").hide();
	})
	
	$('#44').click(function(e){
		e.preventDefault();
		$("#4").show();
		$("#1").hide();
		$("#2").hide();
		$("#3").hide();
		$("#5").hide();
	})
	
	$('#55').click(function(e){
		e.preventDefault();
		$("#5").show();
		$("#1").hide();
		$("#2").hide();
		$("#3").hide();
		$("#4").hide();
	})
	
	$('#66').click(function(e){
		e.preventDefault();
	})
	
	$('.searchDate').click(function(e){
		if (${param.check_in == ''}) {
			alert('날짜를 선택하세요.');
			e.preventDefault();
		} else if (${param.check_in == null}) {
			alert('날짜를 선택하세요.');
			e.preventDefault();
		}
	})
	
	
	
	var reviewModal = new bootstrap.Modal(document.getElementById('modal-review'), {
		keyboard: false
	});
	
	$('#btn').on('click', function(){
		$('#modal-review').modal('show');
	});



$("#chat-connect").click(function(){
	  
	$.ajax({
	        url: '/accommo/chat-connect.do'
	        , type: 'post'
	        , dataType: 'text'
	        , data: {
	        	hostNo: ${accMainDto.hostNo}
	        }
	    });
	//alert('채팅목록에 추가되었습니다');
	 $(this).html('채팅목록에 추가됨');
	
});



</script>