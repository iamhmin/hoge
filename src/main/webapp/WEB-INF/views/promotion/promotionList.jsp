<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>

<link rel="stylesheet" type="text/css" href="../../../../resources/css/promotionList.css" />

<main id="main">
  <article id="main-promotion">
    <section class="pomotion-stay">
      <header class="section__header">
        <h1 class="section__title">STAY</h1>
      </header>
      <article class="promo-stay__discount">
        <div class="article-title--promo">DISCOUNT</div>
        
        <c:forEach var="accDiscountPromotions" items="${accDiscountPromotions }" >
			<li class="promotion-list__item">
				<a href="/accommo/detail?accNo=${accDiscountPromotions.accommoNo }">
				<div class="promotion-list__img" style='background-image: url("/resources/images/hostMainImage/${accDiscountPromotions.mainImage}")'>
					<div class="promotion-main__left">${accDiscountPromotions.deadlineDate }DAYS LEFT</div>
					<div class="promo-title">${accDiscountPromotions.accommoName }</div>
					<div class="promotion-main__depth">${accDiscountPromotions.accommoRegionDepth1 }/${accDiscountPromotions.accommoRegionDepth2 }</div>
				</div>
				<div class="promotion-list__description">
					<div class="promotion-list__name">< ${accDiscountPromotions.accommoName } ></div>
					<div class="promotion-list__title">${accDiscountPromotions.introContent }</div>
					<div class="promotion-list__rate">
						평일:<fmt:formatNumber value="${accDiscountPromotions.weekdaysDiscountRate}" type="percent"/>&emsp;
						주말:<fmt:formatNumber value="${accDiscountPromotions.peakSeasonDiscountRate}" type="percent"/>&emsp;
						성수기:<fmt:formatNumber value="${accDiscountPromotions.peakSeasonDiscountRate}" type="percent"/>
					</div>
					<div class="promotion-list__date">
						<fmt:formatDate value="${accDiscountPromotions.startingDate}" pattern="yyyy.MM.dd"/> ~
							  <fmt:formatDate value="${accDiscountPromotions.endingDate}" pattern="yyyy.MM.dd"/>
					</div>
				</div>
				</a>
			</li>
		</c:forEach>
        
      </article>
      <article class="promo-stay__event">
        <div class="article-title--promo">EVENT</div>
        
        <c:forEach var="accOfferPromotions" items="${accOfferPromotions }" >
			<li class="promotion-list__item">
				<a href="/accommo/detail?accNo=${accOfferPromotions.accommoNo }">
				<div class="promotion-list__img" style='background-image: url("/resources/images/hostMainImage/${accOfferPromotions.mainImage}")'>
					<div class="promotion-main__left">${accOfferPromotions.deadlineDate }DAYS LEFT</div>
					<div class="promo-title">${accOfferPromotions.accommoName }</div>
					<div class="promotion-main__depth">${accOfferPromotions.accommoRegionDepth1 }/${accOfferPromotions.accommoRegionDepth2 }</div>
				</div>
				<div class="promotion-list__description">
					<div class="promotion-list__name">< ${accOfferPromotions.accommoName } ></div>
					<div class="promotion-list__title">${accOfferPromotions.introContent }</div>
					<div class="promotion-list__rate">${accOfferPromotions.offerContent }</div>
					<div class="promotion-list__date">
						<fmt:formatDate value="${accOfferPromotions.startingDate}" pattern="yyyy.MM.dd"/> ~
							  <fmt:formatDate value="${accOfferPromotions.endingDate}" pattern="yyyy.MM.dd"/>
					</div>
				</div>
				</a>
			</li>
		</c:forEach>
        
      </article>
    </section>
    <section class="promotion-activity">
      <header class="section__header">
        <h1 class="section__title">ACTIVITY</h1>
      </header>
      <article class="promo-activity__discount">
        <div class="article-title--promo">DISCOUNT</div>
       
        <c:forEach var="actDiscountPromotions" items="${actDiscountPromotions }" >
			<li class="promotion-list__item">
				<a href="/activity/detail?actNo=${actDiscountPromotions.actNo }">
				<div class="promotion-list__img" style='background-image: url("/resources/images/hostMainImage/${actDiscountPromotions.mainImage}")'>
					<div class="promotion-main__left">${actDiscountPromotions.deadlineDate }DAYS LEFT</div>
					<div class="promo-title">${actDiscountPromotions.actName }</div>
					<div class="promotion-main__depth">${actDiscountPromotions.accommoRegionDepth1 }/${actDiscountPromotions.accommoRegionDepth2 }</div>
				</div>
				<div class="promotion-list__description">
					<div class="promotion-list__name">< ${actDiscountPromotions.actName } ></div>
					<div class="promotion-list__title">${actDiscountPromotions.introContent }</div>
					<div class="promotion-list__rate">
						평일:<fmt:formatNumber value="${actDiscountPromotions.weekdaysDiscountRate}" type="percent"/>&emsp;
						주말:<fmt:formatNumber value="${actDiscountPromotions.peakSeasonDiscountRate}" type="percent"/>&emsp;
						성수기:<fmt:formatNumber value="${actDiscountPromotions.peakSeasonDiscountRate}" type="percent"/>
					</div>
					<div class="promotion-list__date">
						<fmt:formatDate value="${actDiscountPromotions.startingDate}" pattern="yyyy.MM.dd"/> ~
							  <fmt:formatDate value="${actDiscountPromotions.endingDate}" pattern="yyyy.MM.dd"/>
					</div>
				</div>
				</a>
			</li>
		</c:forEach>
       
      </article>
      <article class="promo-activity__event">
        <div class="article-title--promo">EVENT</div>

		<c:forEach var="actOfferPromotions" items="${actOfferPromotions }" >
			<li class="promotion-list__item">
				<a href="/activity/detail?actNo=${actOfferPromotions.actNo }">
				<div class="promotion-list__img" style='background-image: url("/resources/images/hostMainImage/${actOfferPromotions.mainImage}")'>
					<div class="promotion-main__left">${actOfferPromotions.deadlineDate }DAYS LEFT</div>
					<div class="promo-title">${actOfferPromotions.actName }</div>
					<div class="promotion-main__depth">${actOfferPromotions.accommoRegionDepth1 }/${actOfferPromotions.accommoRegionDepth2 }</div>
				</div>
				<div class="promotion-list__description">
					<div class="promotion-list__name">< ${actOfferPromotions.actName } ></div>
					<div class="promotion-list__title">${actOfferPromotions.introContent }</div>
					<div class="promotion-list__rate">${actOfferPromotions.offerContent }</div>
					<div class="promotion-list__date">
						<fmt:formatDate value="${actOfferPromotions.startingDate}" pattern="yyyy.MM.dd"/> ~
							  <fmt:formatDate value="${actOfferPromotions.endingDate}" pattern="yyyy.MM.dd"/>
					</div>
				</div>
				</a>
			</li>
		</c:forEach>

      </article>
    </section>
  </article>
</main>