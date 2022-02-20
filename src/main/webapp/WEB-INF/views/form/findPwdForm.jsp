<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>
<main id="main">
  <div class="login-wrap">
    <header class="section__header">
      <h1 class="section__title">FIND PASSWORD</h1>
      <p class="section__text">패스워드 찾기</p>
    </header>
    <article id="login">
      <c:if test="${not empty error }">
		<div class="mb-3 alert alert-danger">${error }</div>
	  </c:if>
      <form action="/findpwd" class="login-form" method="post">
        <div class="form__wrap">
          <p class="find__text">
            입력된 정보로 임시 비밀번호가 전송됩니다.
          </p>
          <div class="join__box">
            <input
              type="text"
              id="userId"
              name="userId"
              placeholder="아이디를 입력해주세요"
              required
            />
          </div>
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
      </form>
    </article>
  </div>
</main>
<script>
	$("#btn_findId").click(function() {
		alert("이메일이 성공적으로 보내졌습니다.");
	});
</script>