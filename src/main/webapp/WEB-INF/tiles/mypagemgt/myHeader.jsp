<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../views/common/tags.jsp" %>
<header class="section__header">
	<h1 class="section__title">MY PAGE</h1>
	<p class="section__text">마이페이지</p>
</header>

<div class="mypage__info">
	<p class="info__title"><c:out value="${LOGIN_USER.name}"/>님 반가워요!</p>
	<p class="info__count">호게와 함께 ${cnt }번의 여행을 했어요.</p>
	<p class="info__point"><fmt:formatNumber value="${LOGIN_USER.pnt}"/> point</p>
	
</div>

<div class="host">
   <img src="../../resources/images/main/login_icon.png" alt="host-icon" class="host__icon" />
   <div class="host__registration">
     <a href="/host/applyForm?userNo=${LOGIN_USER.no}">호스트 등록</a>
   </div>
   <div class="host__line"></div>
   <div class="host__change">
     <a href="/mypage/hostingList">호스트 전환</a>
   </div>
</div>

