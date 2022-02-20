<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../views/common/tags.jsp" %>
<header id="host-header">
	<div class="host-header-wrap">
		<div class="header__title">
			<h1 class="host-title">
			<a href="/host/main?hostNo=${param.hostNo}&hostingType=${param.hostingType }">${accMainDto.accName }</a>
			<a href="/host/main?hostNo=${param.hostNo}&hostingType=${param.hostingType }">${actMainDto.actName }</a> <!-- 이거 없으면 호스트-체험메인에서 상단에 체험이름이 안나와요;;; -->
			</h1>
			<h1 class="host-text">${accMainDto.accType }</h1>
		</div>
		<nav id="host-nav">
			<ul class="host-nav__menu">
			<c:choose>
				<c:when test="${(param.hostingType) == 1 }">
					<li class="host-nav__item"><a href="/host/mainRoom?hostNo=${param.hostNo }&hostingType=${param.hostingType }" class="">객실관리</a></li>
				</c:when>
			<c:otherwise>

					<li class="host-nav__item"><a href="/activity/mainTime?hostNo=${param.hostNo }&hostingType=${param.hostingType }" class="">체험관리</a></li>
			</c:otherwise>
			</c:choose>

				<li class="host-nav__item"><a href="/host/mainPromotion?hostNo=${param.hostNo }&hostingType=${param.hostingType }">프로모션</a></li>
				<li class="host-nav__item"><a href="/host/review?page=1&hostNo=${param.hostNo }&hostingType=${param.hostingType }">리뷰관리</a></li>
				<li class="host-nav__item"><a href="/host/booking-calendar?hostNo=${param.hostNo }&hostingType=${param.hostingType }">예약캘린더</a></li>
				<li class="host-nav__item"><a href="/host/sales?hostNo=${param.hostNo }&hostingType=${param.hostingType }">매출관리</a></li>

				<li class="host-nav__item"><a href="/host/chat?hostNo=${param.hostNo }&hostingType=${param.hostingType }">게스트문의</a></li>
				<li class="host-nav__item"><a href="/host/qna?page=1&hostNo=${param.hostNo }&hostingType=${param.hostingType }">관리자문의</a></li>

			</ul>
			<div class="host-nav__dropdown">
	            <button class="btn__dropdown">
	              <div class="dropdown__img"></div>
	            </button>
	            <ul class="host-dropdown__menu">
	              <li class="dropdown__item"><a href="/mypage/myrevlist">마이페이지</a></li>
	              <li class="dropdown__item"><a href="/mypage/hostingList">호스팅리스트</a></li>
	            </ul>
            </div>

		</nav>
	</div>
</header>
<script type="text/javascript">
function activeMenu(tabName) {
	$('.host-nav__item a').removeClass('active');
	$(".host-nav__item a:contains("+tabName+")").addClass('active');
	
}
</script>