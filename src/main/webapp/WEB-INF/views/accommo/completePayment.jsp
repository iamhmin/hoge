<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>

<main id="main">
  <header class="section__header">
    <h1 class="section__title">RESERVATIONS</h1>
    <p class="section__text">예약 확인</p>
  </header>
  <article class="accommo-completepayment">
    <p class="reservation-complete-text">
      감사합니다. 예약신청이 완료되었습니다.
    </p>
    <div class="reservation-box">
      <div class="accommo-info">
        <div class="accommo-info__description">
          <div class="accommo-info__text">
            <p class="accommo-name">${book.accommoName }</p>
            <p class="accommo-text">
              <fmt:formatDate value="${book.checkInDate }" pattern="yyyy-MM-dd"/>~<fmt:formatDate value="${book.checkOutDate }" pattern="yyyy-MM-dd"/>
            </p>
            <p class="accommo-text">인원 : ${room.standardNumber + book.extraPeople }명</p>
          </div>
          <div class="accommo-info__text">
            <p class="accommo-payment">￦<fmt:formatNumber value="${book.paidPrice }"/></p>
            <p class="accommo-text">결제 완료(<fmt:formatDate value="${book.bookingMadeDate }" pattern="yyyy-MM-dd"/>)</p>
          </div>
        </div>
        <div
          class="accommo-info__img"
          style="background-image: url('/resources/images/accommodation/${images[0].image}')"
      ></div>
      </div>
      <div class="accommo-user">
        <dl>
          <dt>예약 번호</dt>
          <dd>${book.no }</dd>
        </dl>
        <dl>
          <dt>이름</dt>
          <dd>${user.name }</dd>
        </dl>
        <dl>
          <dt>연락처</dt>
          <dd>${user.tel }</dd>
        </dl>
        <dl>
          <dt>이메일</dt>
          <dd>${user.email }</dd>
        </dl>
      </div>
      <div class="reservation-check__btn">
        <a href="/mypage/myrevlist">
        <button  type="button" class="btn__reservation-check">
          예약 상세 확인
        </button>
        </a>
        <a href="/mypage/myrevlist">
        <button type="button" class="btn__reservation-cancel">
          예약 취소
        </button>
        </a>
      </div>
    </div>
  </article>
</main>