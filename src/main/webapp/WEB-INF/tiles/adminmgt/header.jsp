<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../views/common/tags.jsp" %>
 <header id="header">
  <div class="header-wrap">
    <div class="header__logo">
      <a href="#"
        ><img src="../../resources/images/main/logo.png" alt="logo" class="logo"
      /></a>
    </div>
    <div class="search-admin">ADMIN</div>
    <nav id="nav">
      <ul class="nav__menu">
      <!-- 이승준
        		admin계정이 없어 우선 hong을 관리자라 생각하고 LoginController에 기능을 구현하였습니다.
        		hong으로 로그인하시고 확인 후 수정하시면됩니다.
        -->
        <li class="nav__item"><a href="/logout">LOGOUT</a></li>
        <li class="nav__item">
        
          <div class="admin-nav__dropdown">
           <button class="btn__dropdown">
             <div class="dropdown__img"></div>
           </button>
           <ul class="admin-dropdown__menu">
             <li class="dropdown__item"><a href="/mypage/myrevlist">마이페이지</a></li>
	         <li class="dropdown__item"><a href="/mypage/hostingList">호스팅리스트</a></li>
           </ul>
          </div>
          
        </li>
      </ul>
    </nav>
  </div>
  <div class="sub-nav">
    <ul class="sub-nav__tab">
      <li class="sub-nav__item-main">
        <i class="fas fa-cog"></i><a href="/admin/main">MAIN</a>
      </li>
      <li class="sub-nav__item" data-tabNum="0">
        <a href="" class="tab__btn">회원관리</a>
      </li>
      <li class="sub-nav__item" data-tabNum="1">
        <a href="" class="tab__btn">숙소관리</a>
      </li>
      <li class="sub-nav__item" data-tabNum="2">
        <a href="" class="tab__btn">체험관리</a>
      </li>
      <li class="sub-nav__item" data-tabNum="3">
        <a href="" class="tab__btn">프로모션관리</a>
      </li>
      <li class="sub-nav__item" data-tabNum="4">
        <a href="" class="tab__btn">매출관리</a>
      </li>
    </ul>
    <!--  -->
    <ul class="sub-nav__content">
      <li class="tab__content">
        <ul class="tab__menu">
          <li class="tab__item">
            <a href="/admin/user-list" class="">회원리스트</a>
          </li>
          <li class="tab__item"><a href="/admin/host-qna">호스트문의</a></li>
          <li class="tab__item"><a href="/admin/user-qna">회원문의</a></li>
          <li class="tab__item"><a href="/admin/review">리뷰관리</a></li>
        </ul>
      </li>
      <li class="tab__content">
        <ul class="tab__menu">
          <li class="tab__item"><a href="/admin/accommo-list">숙소리스트</a></li>
          <li class="tab__item"><a href="/admin/accommo-waiting-list">숙소승인 대기</a></li>
          <li class="tab__item"><a href="/admin/accommo-ended-list">숙소승인 반려/종료</a></li>
        </ul>
      </li>
      <li class="tab__content">
        <ul class="tab__menu">
          <li class="tab__item"><a href="/admin/activity-list">체험리스트</a></li>
          <li class="tab__item"><a href="/admin/activity-waiting-list">체험승인 대기</a></li>
          <li class="tab__item"><a href="/admin/activity-ended-list">체험승인 반려/종료</a></li>
        </ul>
      </li>
      <li class="tab__content">
        <ul class="tab__menu">
          <li class="tab__item"><a href="/admin/promotion-list">프로모션 리스트</a></li>
          <li class="tab__item"><a href="/admin/promotion-waiting-list">승인대기</a></li>
          <li class="tab__item">
            <a href="/admin/promotion-denied-list">승인반려</a>
          </li>
          <li class="tab__item">
            <a href="/admin/promotion-ended-list">프로모션 종료</a>
          </li>
        </ul>
      </li>
      <li class="tab__content">
        <ul class="tab__menu">
          <li class="tab__item"><a href="/admin/withdrawal-waiting">송금 신청내역</a></li>
          <li class="tab__item"><a href="/admin/sales">매출내역</a></li>
        </ul>
      </li>
    </ul>
  </div>
  
<script type="text/javascript">
$(".sub-nav__item a").click(function() {
	$(".sub-nav__item-main a").removeClass('active');
}) 

function activeMenu(tabName, contentName) {
	$('.tab__menu a').removeClass('active');
	$(".tab__menu a:contains("+contentName+")").addClass('active');
	$(".sub-nav__item a:contains("+tabName+")")[0].click();
	
}
function activeMenuTab(tabName) {
	$(".sub-nav__item-main a").removeClass('active');
	$(".sub-nav__item a:contains("+tabName+")")[0].click();
	
}

function mainActive() {
	$(".sub-nav__item-main a").addClass('active');
	
}

</script>
  
</header>