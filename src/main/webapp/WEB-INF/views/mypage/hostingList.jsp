<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>
 
<main id="main">
  <header class="section__header">
    <h1 class="section__title">HOST PAGE</h1>
    <p class="section__text">호스트페이지</p>
  </header>
  <div class="host-change">
    <img src="../../resources/images/main/login_icon.png" alt="" class="host__icon" />
    <div class="host__registration">
      <a href="/host/applyForm?userNo=${LOGIN_USER.no}">호스트 등록</a>
    </div>
    <div class="host__line"></div>
    <div class="host__change">
      <a href="/mypage/myrevlist">마이페이지 전환</a>
    </div>
  </div>
  <article id="hosting-list">
    <ul class="hosting-list__list">
      <c:forEach var="accListDto" items="${accListDto }" >
        <li class="hosting-list__item">
            <a href="/host/main?hostNo=${accListDto.hostNo}&hostingType=${accListDto.hostingType }">
              <div class="hosting-list__img" style='background-image: url("/resources/images/hostMainImage/${accListDto.mainImage}")'>
                <span>${accListDto.accName }</span>
              </div>
              <div class="hosting-list__description">
                <div class="hosting-list__type">${accListDto.accType }</div>
                <div class="hosting-list__name">${accListDto.accName }</div>
                <div class="hosting-list__title">${accListDto.accIntroTitle }</div>
                <div class="hosting-list__btn">확인</div>
              </div>
            </a>
          </li>
       </c:forEach>
      <c:forEach var="actListDto" items="${actListDto }" >
        <li class="hosting-list__item">
            <a href="/host/main?hostNo=${actListDto.hostNo}&hostingType=${actListDto.hostingType }">
              <div class="hosting-list__img" style='background-image: url("/resources/images/hostMainImage/${actListDto.mainImage}")'>
                <span>${actListDto.actName }</span>
              </div>
              <div class="hosting-list__description">
                <div class="hosting-list__name">${actListDto.actName }</div>
                <div class="hosting-list__title">${actListDto.actIntroTitle }</div>
                <div class="hosting-list__btn">확인</div>
              </div>
            </a>
          </li>
       </c:forEach>
    </ul>
  </article>
</main>