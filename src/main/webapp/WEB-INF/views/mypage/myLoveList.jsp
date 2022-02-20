<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>
<head>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js"></script>
	<link rel="stylesheet" href="../../resources/css/admin_style.css" />
</head>
<div class="mypage__content">
	<ul class="content__menu">
		<li class="content__item"><a href="/mypage/myrevlist" class="active">STAY</a></li>
		<li class="content__item"><a href="/mypage/myrevlist">ACTIVITY</a></li>
	</ul>
	<c:if test="${empty myLoveList }">
		<div class="mb-3 text-center alert alert-info">현재 관심있는 STAY가 없습니다.<br/> STAY를 둘러보시고, HOGE와 함께 여행을 떠나세요!!! :)</div>
	</c:if>
	<div class="container">
		<c:forEach var="myLoveInfo" items="${myLoveList }">
			<div class="row my-5 justify-content-center">
				<div class="col-6 border-start border-top border-bottom bg-light">
					<div class="row">
						<div class="row ms-1 fs-2 fw-bold discount__text">
							<a href="#">${myLoveInfo.name }</a>
						</div>
						<div class="row ms-1 mb-3 discount__text">
							<a href="#">${myLoveInfo.type }</a>
						</div>
						<div class="row ms-1 discount__text">
							CITY :: ${myLoveInfo.regionDepth1 }
						</div>					
						<div class="row ms-1 discount__text">
							<fmt:formatDate value="" type="both" pattern="yyyy-MM-dd '/ PM' HH:mm" />
						</div>					
						<div class="row ms-1 discount__text">PEOPLE ::
							기준 ${myLoveInfo.minNumber }명(최대 ${myLoveInfo.maxNumber }명)
						</div>					
						<div class="row ms-1 discount__text">PAY INFO ::
							<fmt:formatNumber value="${myLoveInfo.minWeekdaysPrice }" type="currency" currencySymbol="￦" />
							~
							<fmt:formatNumber value="${myLoveInfo.maxPeakSeasonPrice }" type="currency" currencySymbol="￦" />
						</div>
						<div class="row ms-1">STAR :: ${myLoveInfo.cleanlinessStar }
							
						</div>	
					</div>
				</div>
				<!-- 이미지 -->
				<div class="col-4 me-0 border-top border-bottom border-end bg-light">
					<div id="carouselExampleIndicators${myLoveInfo.no }" class="carousel slide" data-bs-ride="carousel">
						<div class="carousel-indicators">
							<c:forEach var="accommoImage" items="${myLoveInfo.accommoImages }" varStatus="status">
								<button type="button" 
										data-bs-target="#carouselExampleIndicators${myLoveInfo.no }"
										data-bs-slide-to="${status.index }" 
										class="<c:if test="${status.index eq 0 }">active</c:if>" 
										aria-current="true"
										aria-label="Slide ${status.count }">
								</button>
							</c:forEach>
						</div>
						<div class="carousel-inner">
							<c:forEach var="accommoImage" items="${myLoveInfo.accommoImages }" varStatus="status">
								<div class="carousel-item<c:if test="${status.index eq 0 }"> active</c:if>">
									<img src="../../resources/images/accommodation/${accommoImage.image}" class="d-block w-100" alt="...">
								</div>
							</c:forEach>
						</div>
						<button class="carousel-control-prev" type="button"
							data-bs-target="#carouselExampleIndicators${myLoveInfo.no }" data-bs-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Previous</span>
						</button>
						<button class="carousel-control-next" type="button"
							data-bs-target="#carouselExampleIndicators${myLoveInfo.no }" data-bs-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Next</span>
						</button>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>