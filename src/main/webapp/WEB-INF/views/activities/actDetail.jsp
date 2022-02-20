<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>

<style>
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
</style>

<main>
	<article id="accommo-detail">
		<div class="width-wrap">
			<div class="accommo-detail__header">
				<div class="accommo-detail__title">${actMainDto.actName}</div>
            	<a class="accommo-back" href="javascript:history.back()"><img src="/resources/images/common/back.JPG">돌아가기</a>
            </div>
            

	<div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel">
	  <div class="carousel-indicators">
	  <c:forEach var="image" items="${actImages}" varStatus="status">
	  		<c:choose>
				<c:when test="${status.index == 0}">
	    			<button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="${status.index}" class="active" aria-current="true"></button>
	    		</c:when>
				<c:otherwise>
	    			<button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="${status.index}"></button>
	    		</c:otherwise>
			</c:choose>
		</c:forEach>
	  </div>
	  
		<div class="carousel-inner">
			<c:forEach var="image" items="${actImages}" varStatus="status">
				<c:choose>
					<c:when test="${status.index == 0}">
						<div class="carousel-item active">
					</c:when>
					<c:otherwise>
						<div class="carousel-item">
					</c:otherwise>
				</c:choose>
						<img src="/resources/images/activities/${image.image }" class="d-block w-100" alt="...">
						<div class="carousel-caption d-none d-md-block">
							<h2>"${actMainDto.actIntroTitle}"</h2>
							<h6>${actMainDto.dept1} / ${actMainDto.dept2}</h6>
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
	</div>
	  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
	    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	    <span class="visually-hidden">Previous</span>
	  </button>
	  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
	    <span class="carousel-control-next-icon" aria-hidden="true"></span>
	    <span class="visually-hidden">Next</span>
	  </button>
	</div>

<div class="container">	
	<div class="row">
		<div class="col-8">
			<h3 class="accommo-detail__name" style="margin-top:50px;">${actMainDto.hostName}님이 호스팅하는 체험</h3>
			<hr style="margin-top:30px;" size="3px">
				<c:if test="${not empty promotionDiscountList}">
					<p style="margin-top:50px;"></p>
					<c:forEach var="promotionDiscountList" items="${promotionDiscountList }">
						<div class="col-4 detail-info__name" style="margin-left:10px;">
							<h6><할인 프로모션 진행중></h6>
							<p>${promotionDiscountList.introContent }</p>
							<p>평일:<strong><fmt:formatNumber value="${promotionDiscountList.weekdaysDiscountRate}" type="percent"/></strong>&emsp;
							주말:<strong><fmt:formatNumber value="${promotionDiscountList.peakSeasonDiscountRate}" type="percent"/></strong>&emsp;
							성수기:<strong><fmt:formatNumber value="${promotionDiscountList.peakSeasonDiscountRate}" type="percent"/></strong></p>
							<p>기간 : <fmt:formatDate value="${promotionDiscountList.startingDate}" pattern="yyyy.MM.dd"/> ~
							   <fmt:formatDate value="${promotionDiscountList.endingDate}" pattern="yyyy.MM.dd"/></p>
						</div>
						</c:forEach>
					<hr style="margin-top:45px;" size="3px">
				</c:if>
				<c:if test="${not empty promotionOfferList}">
					<p style="margin-top:50px;"></p>
					<c:forEach var="promotionOfferList" items="${promotionOfferList }">
						<div class="col-4 detail-info__name" style="margin-left:10px;">
							<h6><증정 프로모션 진행중></h6>
							<p>${promotionOfferList.introContent }</p>
							<p>증정품 : <strong>${promotionOfferList.content}</strong></p>
							<p>기간 : <fmt:formatDate value="${promotionOfferList.startingDate}" pattern="yyyy.MM.dd"/> ~
							   <fmt:formatDate value="${promotionOfferList.endingDate}" pattern="yyyy.MM.dd"/></p>
						</div>
					</c:forEach>
				</c:if>
			<div class="row">
				<div class="col-12 text-center">
					<h4 style="margin-top:40px;" class="detail-info__title">P R O G R A M</h4>
					<div class="detail-info__name">${actMainDto.actIntroTitle}</div>
          			<div class="after"></div>
					<p style="margin-top:20px;" class="detail-info__text">${actMainDto.actIntroContent}</p>
					<p class="detail-info__text" style="margin-top:45px;"><strong>해당 체험은 ${actMainDto.actAddress}에서 진행됩니다.</strong></p>
				</div>
			</div>
		</div>
		<div class="col-4">
			<div class="card" style="margin-top:80px;">
				<div class="card-body">
					<h5 class="detail-info__title" id="box1" style="margin-top:10px; margin-right:10px;">체험요금 ₩<fmt:formatNumber value="${actMainDto.actPricePerPerson }" pattern="##,###"/>/인</h5>
					<p class="detail-info__text" style="margin-top:50px;">체험 선택하기</p>
					<hr style="margin-bottom:30px; margin-top:10px;" size="3px">
					<c:choose>
						<c:when test="${empty timeTableList}">
							<div class="col-12">
								<h4>선택가능한 타임이 없습니다.</h4>
							</div>
						</c:when>
						<c:otherwise>
							<c:forEach var="timeTableList" items="${timeTableList }" varStatus="status">
								<div class="row">
									<div class="col-4">
										<label class="form-label"><fmt:formatDate value="${timeTableList.time}" pattern="yyyy월 M월 d일 (E)"/></label>
										<h5><fmt:formatDate value="${timeTableList.time}" pattern="kk시mm분"/> -</h5>
										<label class="form-label">예약인원 ${timeTableList.soFarBookedNumberOfPeople}</label>
										<label class="form-label">총인원 ${actMainDto.actMaximumNumber}</label>
									</div>
									<div class="col-4">
									
									<!-- 빼기로 했는데 UI가 너무 휑해서 일단 넣어놓을게요 -->
										<label class="form-label">인원 선택</label>
										<select class="form-control text-center" name="type">
											<c:forEach var="i" begin="0" end="${actMainDto.actMaximumNumber - timeTableList.soFarBookedNumberOfPeople}">
												<option id="a" value="${i}"><c:out value="${i}"/>명</option>
											</c:forEach>
										</select>
										
									</div>
									<div class="col-4">
										<label class="form-label">₩<fmt:formatNumber value="${actMainDto.actPricePerPerson}" pattern="##,###"/>/인</label>
										<c:choose>
											<c:when test="${actMainDto.actMaximumNumber eq timeTableList.soFarBookedNumberOfPeople}">
												<a>
													<img src="/resources/images/common/soldout.jpg">
												</a>
											</c:when>
											<c:otherwise>
												<a href="/reserve/activity?no=${param.actNo }&activityTimeNo=${timeTableList.no }">
													<img src="/resources/images/common/booking3.JPG">
												</a>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
								<hr style="margin-bottom:30px; margin-top:10px;" size="3px">
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 리뷰 -->
<div class="container">
	<div class="row">
		<div class="col-12">
			<hr style="margin-top:100px; margin-bottom:50px;" size="3px">
		</div>
		<div class="col-12">
			<div class="detail-review__title">
              <i class="fa-solid fa-star"></i> ${getActDetailStar.average } / 후기 ${getActDetailReviewsTotal.total }개
            </div>
		</div>
	</div>
</div>
<p style="margin-top:70px;">
<div class="container">
	<div class="row">
		<c:forEach var="getActDetailReviews6" items="${getActDetailReviews6 }">
			<div class="col-6">
				<div class="row">
					<div class="col-1">
						<div class="review__user-img" style="background-image: url('/resources/images/userprofiles/${getActDetailReviews6.userImage }')"></div>
					</div>
					<div class="col-11">
						<p class="review__user-name" style="margin-top:30px; margin-left:40px;">${getActDetailReviews6.userName }</p>
						<p class="review__date" style="margin-left:40px;"><fmt:formatDate value="${getActDetailReviews6.createdDate}" pattern="yyyy.MM.dd"/></p>
					</div>
					<div class="col-11">
						<p class="review__text" style="margin-top:10px; margin-bottom:50px; margin-left:5px;">${getActDetailReviews6.content }</p>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
<p style="margin-top:30px;">
<div class="container">
	<div class="row justify-content-md-center">
		<div class="detail-review__btn">
            <button id="btn" class="btn__review">후기 ${getActDetailReviewsTotal.total }개 모두 보기</button>
          </div>
	</div>
</div>

<!-- 리뷰 모달 -->
<div class="modal fade" id="modal-review" tabindex="-1" aria-labelledby="전체 리뷰" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-scrollable modal-lg">
		
          <article class="modal-content detail-review__modal">
            <div class="modal-title-wrap">
              <div class="modal-review__title">
                <i class="fa-solid fa-star"></i> ${getActDetailStar.average }
              </div>
              <div class="moda-review__count">후기 ${getActDetailReviewsTotal.total }개</div>
            </div>
            <div class="modal-review-wrap">
              <section class="review-left">
              </section>
              <section class="review-right">
                <c:forEach var="getActDetailReviews" items="${getActDetailReviews }">
	                <div class="modal-content-box">
	                  <div class="review__info">
	                    <div
	                      class="review__user-img"
	                      style="background-image: url('/resources/images/userprofiles/${getActDetailReviews.userImage }')"
	                    ></div>
	                    <div class="user-wrap">
	                      <div class="review__user-name">${getActDetailReviews.userName }</div>
	                      <div class="review__date"><fmt:formatDate value="${getActDetailReviews.createdDate}" pattern="yyyy.MM.dd"/></div>
	                    </div>
	                  </div>
	                  <div class="review__text">
	                    ${getActDetailReviews.content }
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
		<div class="col-2">
		    <p class="faq-title" style="margin-bottom:15px;">F A Q</p>
		    <p style="margin-bottom:15px;"><a href="" class="" id="11">호스트 소개</a></p>
		    <p style="margin-bottom:15px;"><a href="" class="" id="22">예약 및 결제</a></p>
		    <p style="margin-bottom:15px;"><a href="" class="" id="33">이용 안내</a></p>
		    <p style="margin-bottom:15px;"><a href="" class="" id="44">제공 항목</a></p>
		    <p style="margin-bottom:15px;"><a href="" class="" id="66">호스트에게 문의</a></p>
	    </div>
	    
		<div class="col-10" id="1">
			<h5 class="faq-sub-title" style="margin-bottom:30px;">FAQ를 통하여 예약에 관련된 더 자세한 내용들을 찾아보세요.</h5>
			<h3 class="faq-content-title" style="margin-bottom:20px;">호스트 소개</h3>
			<div class="row">
				<div class="col-12">
					<c:forEach var="actInfoType1" items="${actInfoType1}">
						<div class="row">
							<div class="col-2">
								<h5 class="content-title">${actInfoType1.infoTitle1}</h5>
							</div>
							<div class="col-10">
								<p class="content-title" style="margin-bottom:30px;">${actInfoType1.infoContent1}</p>
							</div>
						</div>
					</c:forEach>
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
					<p>• 계좌이체 결제시 현금영수증 발행이 가능합니다. 예약시 신청해주세요.</p>
					<p style="margin-bottom:40px;">• 예약 취소는 MyPage - 예약정보 - [예약 취소 요청] 버튼을 눌러주시기 바랍니다.</p>
				</div>
			</div>
			<div class="row faq-p">
				<div class="col-2">
					<h5 class="content-title">환불 규정</h5>
				</div>
				<div class="col-8">
					<p class="font-p" style="margin-bottom: 10px;">• 환불 시 아래의 기준일에 따른 환불 금액을 드립니다.</p>
					<table class="table refund" id="box2">
						<thead>
							<tr>
								<th></th>
								<th>이용 10일전까지</th>
								<th></th>
								<th>총 결제금액의 100% 환불</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th></th>
								<td><strong>이용 9일전까지</strong><td>
								<td><strong>총 결제금액의 90% 환불</strong><td>
							</tr>
						</tbody>
						<tbody>
							<tr>
								<th></th>
								<td><strong>이용 8일전까지</strong><td>
								<td><strong>총 결제금액의 80% 환불</strong><td>
							</tr>
						</tbody>
						<tbody>
							<tr>
								<th></th>
								<td><strong>이용 7일전까지</strong><td>
								<td><strong>총 결제금액의 70% 환불</strong><td>
							</tr>
						</tbody>
						<tbody>
							<tr>
								<th></th>
								<td><strong>이용 6일전까지</strong><td>
								<td><strong>총 결제금액의 60% 환불</strong><td>
							</tr>
						</tbody>
						<tbody>
							<tr>
								<th></th>
								<td><strong>이용 5일전까지</strong><td>
								<td><strong>총 결제금액의 50% 환불</strong><td>
							</tr>
						</tbody>
						<tbody>
							<tr>
								<th></th>
								<td><strong>이용 4일전까지</strong><td>
								<td><strong>총 결제금액의 40% 환불</strong><td>
							</tr>
						</tbody>
						<tbody>
							<tr>
								<th></th>
								<td><strong>이용 3일전까지</strong><td>
								<td><strong>변경/환불 불가</strong><td>
							</tr>
						</tbody>
					</table>
					<p class="font-p">• 예약의 확정은 위 사항을 모두 숙지하였고 모든 사항에 동의함을 의미합니다.</p>
					<p class="font-p" style="margin-bottom:40px;">• 자세한 문의사항은 ${actMainDto.actName}(${actMainDto.tel})로 연락주시기 바랍니다.</p>
				</div>
			</div>
			<div class="row faq-p">
				<div class="col-2">
					<h5 class="content-title">취소 안내</h5>
				</div>
				<div class="col-10 font-p">
					<p>• 예약번호는 예약안내 문자를 통해 확인 가능합니다. 확인이 어려우신 경우 호게 챗봇을 통해 예약번호를 문의해주시기 바랍니다.</p>
					<p style="margin-bottom:40px;">• 취소를 원하시는 경우, 호게 - ACCOUNT - 마이 페이지 - 예약 정보 - [취소 요청] 버튼을 눌러주시기 바랍니다.</p>
				</div>
			</div>
		</div>
		
		<div class="col-10 faq-p" id="3">
			<h5 class="faq-sub-title" style="margin-bottom:30px;">FAQ를 통하여 예약에 관련된 더 자세한 내용들을 찾아보세요.</h5>
			<h3 class="faq-content-title" style="margin-bottom:20px;">이용 안내(알아두어야 할 사항)</h3>
			<c:forEach var="actInfoType2" items="${actInfoType2}">
				<div class="row">
					<div class="col-2">
						<h5 class="content-title">${actInfoType2.infoTitle2}</h5>
					</div>
					<div class="col-10 font-p">
						<p style="margin-bottom:30px;">${actInfoType2.infoContent2}</p>
					</div>
				</div>
			</c:forEach>
		</div>
		
		<div class="col-10 faq-p" id="4">
			<h5 class="faq-sub-title" style="margin-bottom:30px;">FAQ를 통하여 예약에 관련된 더 자세한 내용들을 찾아보세요.</h5>
			<h3 class="faq-content-title" style="margin-bottom:20px;">제공 항목</h3>
			<c:forEach var="actInfoType3" items="${actInfoType3}">
				<div class="row">
					<div class="col-2">
						<h5 class="content-title">${actInfoType3.infoTitle3}</h5>
					</div>
					<div class="col-10">
						<p class="font-p" style="margin-bottom:30px;">${actInfoType3.infoContent3}</p>
					</div>
				</div>
			</c:forEach>
		</div>
		
	</div>
</div>
</div>
</article>
</main>
<script type="text/javascript">
	

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

	var reviewModal = new bootstrap.Modal(document.getElementById('modal-review'), {
		keyboard: false
	});
	
	$('#btn').on('click', function(){
		$('#modal-review').modal('show');
	});



</script>
</html>