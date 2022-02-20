<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>
<main id="main">
  <div class="login-wrap">
    <header class="section__header">
      <h1 class="section__title">FIND ID</h1>
      <p class="section__text">아이디 찾기</p>
    </header>
    <article id="login">
      <c:if test="${not empty error }">
		<div class="mb-3 alert alert-danger">${error }</div>
	  </c:if>
      <form action="/findid" class="login-form" method="post">
        <c:if test="${empty userId }">
        <div class="form__wrap">
          <p class="find__text">
            가입 당시 입력하셨던 이메일 주소를 알려 주세요.
          </p>
          <div class="join__box">
            <input
              type="email"
              id="userEmail"
              name="userEmail"
              placeholder="이메일을 입력해 주세요"
              required
            />
          </div>
          <div class="login__btn">
            <button type="submit" class="btn__login" id="btn_findId">
              GO FIND
            </button>
          </div>
        </div>
        </c:if>
        
        <c:if test="${not empty userId }">
        <div class="form__wrap">
		  <p class="find__text">
               회원님의 아이디는 <c:out value="${userId }" /> 입니다.
          </p>
          <div class="join__box">
            <input
              type="email"
              id="userEmail"
              name="userEmail"
              placeholder="이메일을 입력해 주세요"
              disabled
            />
          </div>
          <div class="login__btn">
            <a href="/login">
              <button type="button" class="btn__login" id="btn_findId">
                LOGIN
              </button>
            </a>
          </div>
		</div>
		</c:if>
      </form>
    </article>
  </div>
</main>