<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>
<main id="main">
	<div class="login-wrap">
		<header class="section__header">
			<h1 class="section__title">LOGIN</h1>
			<p class="section__text">로그인</p>
		</header>
		<article id="login">
			<c:if test="${not empty error }">
				<div class="mb-3 alert alert-danger">${error }</div>
			</c:if>
			<form action="login" class="login-form" method="post">
				<div class="form__wrap">
					<div class="login__box">
						<input type="text" id="userId" name="id" placeholder="아이디" />
					</div>
					<div class="login__box">
						<input type="password" id="userPwd" name="pwd" placeholder="비밀번호" />
					</div>
				</div>
				<div class="login__btn">
					<button type="submit" class="btn__login">LOGIN</button>
				</div>
				<div class="login__etc">
					<a href="/register" class="sign-in">회원가입</a>
					<a href="/findid" class="forgot-pwd">아이디 찾기</a>
					<a href="/findpwd" class="forgot-pwd">패스워드 찾기</a>
				</div>
			</form>
			<div class="login__sns">
				<p class="sns__title">SNS 계정으로 로그인하기</p>
				<div class="sns__login">
					<a href="kakao/login" id="btn-kakao-login"> 
						<img src="../../resources/images/main/login_icon_kakao.png" alt="kakao-icon" class="sns__icon" />
					</a>
				</div>
			</div>
		</article>
	</div>
</main>
<!--  카카오 폼 -->
<form id="form-kakao-login" method="post" action="loginKakao">
	<input type="hidden" name="id" />
	<input type="hidden" name="name" />
	<input type="hidden" name="email" />
	<input type="hidden" name="gender" />
</form>
<script type="text/javascript">
$(function() {
	// 카카오 로그인 버튼을 클릭할 때 실행할 이벤트 핸들러 함수를 등록한다.
	$('#btn-kakao-login').click(function(event){
		// a태그는 클릭이벤트가 발생하면 페이지를 이동하는 기본동작이 수행되는데, 그 기본동작이 실행되지 않게 한다.
		event.preventDefault();
		// 카카오 로그인 실행시 오류메세지를 표시하는 경고창을 화면에 보이지 않게 한다.
		$("#alert-kakao-login").addClass("d-none");
		// 사용자키를 전달해서 카카오 로그인 서비스를 초기화한다.
		Kakao.init("82b4c2a96aab2017df298cdff9bd58ee");
		// 카카오 로그인 서비스 실행하기 및 사용자 정보 가져오기
		Kakao.Auth.login({
			success: function(auth) {
				Kakao.API.request({
					url: '/v2/user/me',
					success: function(response) {
						// 사용자 정보를 가져와서 폼에 추가한다.
						var account = response.kakao_account;
						
						$('#form-kakao-login input[name=id]').val(response.id);
						$('#form-kakao-login input[name=name]').val(account.profile.nickname);
						$('#form-kakao-login input[name=email]').val(account.email);
						//$('#form-kakao-login input[name=age]').val(account.age_range);
						$('#form-kakao-login input[name=gender]').val(account.gender);
						// 사용자 정보가 포함된 폼을 서버로 제출한다.
						document.querySelector("#form-kakao-login").submit()
					},
					fail: function(error) {
						// 경고창에 에러 메세지를 표시한다.
						$("#alert-kakao-login").removeClass("d-none").text("카카오 로그인 처리 중 오류가 발생하였습니다.");
					}
				});
			},
			fail: function(error) {
				// 경고창에 에러 메세지를 표시한다.
				$("#alert-kakao-login").removeClass("d-none").text("카카오 로그인 처리 중 오류가 발생하였습니다.");
			}
		});		
	})
})
</script>