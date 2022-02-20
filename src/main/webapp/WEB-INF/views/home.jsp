<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="common/tags.jsp" %>
<main>
	<!-- 
   - ul 이 슬라이드 전체, li가 보여지는 슬라이드 화면 1개 라고 보시면 됩니다. 
   - 페이지 네이션은 부트스트랩 자체 기능으로 조절 가능.
   - 이미지는 div에 background-image로 불러올 예정이기에 
   background-color를 임시로 넣어두고 사이즈 맞춰놨습니다.
 -->
	<!-- 숙소 -->
	<section id="stay">
		<!-- 최신순 -->
		<article id="stay-new">
		<div id="carouselNewStayControls" class="carousel slide" data-bs-ride="carousel">
			<ul class="stay-new__list carousel-inner">
			    <c:forEach var="newSixAccommoDto" items="${newSixAccommoDtos }">
			    <li id="stay-new__item" class="stay-new__item carousel-item">
				    <a href="/accommo/detail?accNo=${newSixAccommoDto.accNo }&check_in=&check_out=&days=">
					    <img style="background-image: url('../resources/images/hostMainImage/${newSixAccommoDto.mainImage}')" alt="" class="stay-new__image" />
					    <div class="stay-new__info">
							<p class="title">${newSixAccommoDto.accName }</p>
							<p class="info__description">
								${newSixAccommoDto.accIntroTitle }
							</p>
							<p class="event">NEW LAUNCHING</p>
							<span class="read-more">read more</span>
						</div>
					</a>
			    </li>
			    </c:forEach>
			 </ul>    
			 <button class="carousel-control-prev" type="button" data-bs-target="#carouselNewStayControls" data-bs-slide="prev">
			   <span class="carousel-control-prev-icon" aria-hidden="true"></span>
			   <span class="visually-hidden">Previous</span>
			 </button>
			 <button class="carousel-control-next" type="button" data-bs-target="#carouselNewStayControls" data-bs-slide="next">
			   <span class="carousel-control-next-icon" aria-hidden="true"></span>
			   <span class="visually-hidden">Next</span>
			 </button>
		</div>
		</article>
		
		<!-- 전체 숙소 -->
		<article id="stay-total">
			<h1 class="article-title">STAY</h1>
			
						<ul class="stay-total__list owl-carousel owl-theme">
							<c:forEach var="accommoDto" items="${accommoDtos }" varStatus="status">
							<li class="stay-total__item-wrap">
								
								<a href="/accommo/detail?accNo=${accommoDto.accommoNo }&check_in=&check_out=&days=">
									<div class="stay-total__item">
										<img style="background-image: url('../resources/images/hostMainImage/${accommoDto.mainImage }')" alt="" class="stay-total__image" />
											<button class="btn__like">
												<i class="far fa-heart"></i>
											</button>
											<div class="stay-total__info">
												<h2 class="info__title">${accommoDto.accommoName }</h2>
												<p class="info__text">
													${accommoDto.accommoRegionDepth1 } / ${accommoDto.accommoRegionDepth2 } &#183; 
														￦<fmt:formatNumber value="${accommoDto.minPrice }" type="currency" currencySymbol="￦" pattern="##,###"/> 
														~ 
														￦<fmt:formatNumber value="${accommoDto.maxPrice }" type="currency" currencySymbol="￦" pattern="##,###"/>
												</p>
												<span class="read-more">read more</span>
											</div>
										</div>
									</a>
								</li>
							</c:forEach>
						</ul>
			
		</article>
	</section>
	<!-- 프로모션 -->
	<section id="promotion">
		<!-- 프로모션 이미지 배너 -->
		<div class="promotion-banner">
			<a href="">
				<div class="promotion__image">HOGE X PROMOTION</div>
			</a>
		</div>

		<!-- 할인 -->
	<article id="discount">
	  <div class="discount-wrap">
		<div id="carouselDiscountAccControls" class="carousel slide" data-bs-ride="carousel">
			<ul class="discount__list carousel-inner">
			    <c:forEach var="homePromotionDiscountDto" items="${homePromotionDiscountDtos }">
			    <li id="discount__item" class="discount__item carousel-item">
					<h1 class="article-title discount">DISCOUNT</h1>
				    <a href="/accommo/detail?accNo=${homePromotionDiscountDto.accommoNo }&check_in=&check_out=&days=">
					  <div class="discount__item-box">
					    <div class="discount__info">
							<div class="info-top">
								<p class="text--discount">
									${homePromotionDiscountDto.introContent }
								</p>
								<p class="event--discount">
									평일 숙박 
									<fmt:formatNumber value="${homePromotionDiscountDto.weekdaysDiscountRate }" type="percent"/>
									할인!!!
								</p>
							</div>
							<div class="info-bottom">
								<h2 class="info__title">${homePromotionDiscountDto.accommoName }</h2>
								<p class="discount__text">
									${homePromotionDiscountDto.accommoRegionDepth1 } / 
									${homePromotionDiscountDto.accommoRegionDepth2 } · 
									${homePromotionDiscountDto.accommoType }
								</p>
								<p class="discount__text">
									최소 ${homePromotionDiscountDto.minNumber }명 / 
									최대 ${homePromotionDiscountDto.maxNumber }명 
								</p>
								<p class="discount__text">
									￦<fmt:formatNumber value="${homePromotionDiscountDto.minPrice * (1-homePromotionDiscountDto.weekdaysDiscountRate)}" type="currency" currencySymbol="￦" pattern="##,###"/>
									 ~ 
									￦<fmt:formatNumber value="${homePromotionDiscountDto.maxPrice * (1-homePromotionDiscountDto.peakSeasonDiscountRate)}" type="currency" currencySymbol="￦" pattern="##,###"/>
								</p>
							</div>
						</div>
						<div class="discount__image">
							<img src="../resources/images/hostMainImage/${homePromotionDiscountDto.mainImage }"/>
						</div>
					  </div>
						<div class="promotion-date">
							<p>${homePromotionDiscountDto.deadlineDate } DAYS</p>
							<p>LEFT!</p>
						</div>
					</a>
			    </li>
			    </c:forEach>
			 </ul>    
			 <button class="carousel-control-prev" type="button" data-bs-target="#carouselDiscountAccControls" data-bs-slide="prev">
			   <span class="carousel-control-prev-icon" aria-hidden="true"></span>
			   <span class="visually-hidden">Previous</span>
			 </button>
			 <button class="carousel-control-next" type="button" data-bs-target="#carouselDiscountAccControls" data-bs-slide="next">
			   <span class="carousel-control-next-icon" aria-hidden="true"></span>
			   <span class="visually-hidden">Next</span>
			 </button>
		</div>
		</div>
		</article>
		
		<!-- 증정 -->
		<article id="event">
			<h1 class="article-title">EVENT</h1>
			<!-- 증정 3개 묶어서 1개 슬라이드 화면 -->
			<div class="container-fluid my-5">
				<c:if test="${empty homePromotionOfferDtos }">
					<div class="mb-3 text-center alert alert-info">제공 가능한 프로모션이 존재하지 않습니다.</div>
				</c:if>
				<ul class="event__list owl-carousel owl-theme">
					<c:forEach var="homePromotionOfferDto" items="${homePromotionOfferDtos }" varStatus="status">
					<li class="event__item-wrap">
						
						<a href="/accommo/detail?accNo=${homePromotionOfferDto.accommoNo }&check_in=&check_out=&days=">
							<div class="event__item">
							  <img style="background-image: url('../resources/images/hostMainImage/${homePromotionOfferDto.mainImage }')" alt="" class="event__image" />
								<button class="btn__like">
									<i class="far fa-heart"></i>
								</button>
								<div class="promotion-date">
									<p>${homePromotionOfferDto.deadlineDate } DAYS</p>
									<p>LEFT!</p>
								</div>
								<div class="event__info">
									<h2 class="info__title">${homePromotionOfferDto.accommoName }</h2>
									<p class="info__text">
										${homePromotionOfferDto.accommoRegionDepth1 } /
										${homePromotionOfferDto.accommoRegionDepth2 } 
									</p>
									<p class="event-info__description">
										${homePromotionOfferDto.introContent }
									</p>
									<span class="read-more">자세히 보기</span>
								</div>
							</div>
						</a>
					</li>
					</c:forEach>
				</ul>
			</div>
		</article>
	</section>

	<!-- 체험 -->
	<section id="activity">
		<!-- 최신순 -->
		<article id="activity-new">
		<div id="carouselNewActivityControls" class="carousel slide" data-bs-ride="carousel">
			<ul class="activity-new__list carousel-inner">
			<c:forEach var="newSixAcivityDto" items="${newSixAcivityDtos }">
			    <li id="activity-new__item" class="activity-new__item carousel-item">
				    <a href="/activity/detail?actNo=${newSixAcivityDto.actNo }">
				    	<div class="activity-new__image">
				    		<img src="../resources/images/hostMainImage/${newSixAcivityDto.mainImage }"/>
				    	</div>
				    	<div class="activity-new__info">
		                  <div class="act-new__left">
		                    <p class="act-event">NEW LAUNCHING </p>
		                    <span class="read-more act">read more</span>
		                  </div>
		                  <div class="act-new__right">
		                    <p class="text">
		                      ${newSixAcivityDto.actIntroTitle }
		                    </p>
		                    <p class="title">${newSixAcivityDto.actName }</p>
		                  </div>
		                </div>
					</a>
			    </li>
			 </c:forEach>   
			 </ul>    
			 <button class="carousel-control-prev" type="button" data-bs-target="#carouselNewActivityControls" data-bs-slide="prev">
			   <span class="carousel-control-prev-icon" aria-hidden="true"></span>
			   <span class="visually-hidden">Previous</span>
			 </button>
			 <button class="carousel-control-next" type="button" data-bs-target="#carouselNewActivityControls" data-bs-slide="next">
			   <span class="carousel-control-next-icon" aria-hidden="true"></span>
			   <span class="visually-hidden">Next</span>
			 </button>
		</div>
		</article>

		<!-- 전체 체험 -->
		<article id="activity-total">
			<h1 class="article-title">EVENT</h1>
			<!-- 증정 3개 묶어서 1개 슬라이드 화면 -->
				<ul class="activity-total__list owl-carousel owl-theme">
					<c:forEach var="activityPromotion" items="${activityPromotionDto }" varStatus="status">
						<li class="activity-total__item-wrap">
							<button class="btn__act-like">
								<i class="far fa-heart"></i>
							</button> 
							<a href="/activity/detail?actNo=${activityPromotion.activityNo }">
								<img style="background-image: url('../resources/images/hostMainImage/${activityPromotion.mainImage }')"
									 alt="" class="activity-total__image" />
								<div class="promotion-date">
									<p>${activityPromotion.deadlineDate } DAYS<p>
									<p>LEFT!</p>
								</div>
								<div class="activity-total__info">
									<h2 class="info__title act">
										${activityPromotion.activityName }
									</h2>
									<p class="info__text">
									${activityPromotion.depth1 }
									/
									${activityPromotion.depth2 }</p>
									<span class="read-more">read more</span>
								</div>
							</a>
						</li>
					</c:forEach>
				</ul>
		</article>
	</section>
</main>
<script>
	$(function() {
		// 캐러셀 엑티브
		$("#stay-new__item").attr("class","stay-new__item carousel-item active");
		$("#discount__item").attr("class","discount__item carousel-item active");
		$("#activity-new__item").attr("class","activity-new__item carousel-item active");
		
		// 페이지내비게이션의 링크를 클릭했을 때 실행될 이벤트핸들러 함수를 등록한다.
		$(".pagination a").click(function(event) {
			event.preventDefault();
			// 클릭한 페이지내비게이션의 페이지번호 조회하기
			var pageNo = $(this).attr("data-page");
		})
	});
	
	// carouser 반응형, 루프, 네비 조정 
	var owl = $('.owl-carousel');
	owl.owlCarousel({
	    loop:true,
	    nav:false,
	    margin:30,
	    responsive:{
	        0:{
	            items:1
	        },
	        600:{
	            items:2
	        },
	        960:{
	            items:3
	        },
	        1200:{
	            items:3
	        }
	    }
	});
	
	owl.on('mousewheel', '.owl-stage', function (e) {
	    if (e.deltaY<0) {
	        owl.trigger('next.owl');
	    } else {
	        owl.trigger('prev.owl');
	    }
	    e.preventDefault();
	});
	
</script>