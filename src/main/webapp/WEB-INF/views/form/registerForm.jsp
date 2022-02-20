<!-- 이승준: 부트스트랩을 이용한 데모뷰, 디자인 적용 시 삭제 될 것-->
<!-- 이승준: ID값 적용된 변수=> userId,check_id, userPwd,userPwdConfirm,check_pwd,check_pwdConfirm -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>
<head>
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  	<script type="text/javascript">
		$(function(){
			// 아이디 정규표현식: 아이디는 영문으로 시작하여, 소문자와 숫자를 사용해 6~12자리만 가능
			var idRegex = /^[a-z][a-z0-9]{5,12}$/;
			
			// 비밀번호 정규표현식: 8 ~ 16자 영문, 숫자, 특수문자를 최소 한가지씩 조합
			var pwdRegex = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/; 
			
			// 비밀번호 유효성 체크(신버전)
			$("#userPwd").on("keyup",function() {
				var $pwd = $(this).val();
				if (!(pwdRegex.test($pwd))) {
					$("#check_pwd").html("8 ~ 16자 영문, 숫자, 특수문자를 최소 한가지씩 조합하여 8~16자리까지만 가능합니다!!  :(").css("color", "red");
					// $("#registerBtn").attr("disabled", true);
				} else {
					$("#check_pwd").html("사용가능한 비밀번호 입니다!!  :)").css("color", "green");
				}
			});
			
			// 비밀번호 일치 확인(신버전)
			$("#userPwd, #userPwdConfirm").on("keyup", function () {
				var $pwd = $("#userPwd").val();
				var $pwdConfirm = $("#userPwdConfirm").val();
				
				if ($pwd != $pwdConfirm) {
			 		$("#check_pwdConfirm").html("불일치!! :(").css("color", "red");
			 	} else if ($pwd == "") {
			 		$("#check_pwdConfirm").html("");
			 	} else {
					$("#check_pwdConfirm").html("일치!! :)").css("color", "green");
			 	}
			});

		<%-- 비밀번호 유효성 체크(구버전)
			$("#userPwd").on("keyup",function() {
				var pwd = $("#userPwd").val();
				console.log(pwd);
				if (!(pwdRegex.test(pwd))) {
					$("#check_pwd").text("8 ~ 16자 영문, 숫자, 특수문자를 최소 한가지씩 조합하여 8~16자리까지만 가능합니다!!  :(");
					$("#check_pwd").css("color", "red");
					$("#registerBtn").attr("disabled", true);
				} else {
					$("#check_pwd").text("사용가능한 비밀번호 입니다!!  :(");
					$("#check_pwd").css("color", "blue");
				}
			});
		--%>
			
		<%-- 비밀번호 일치 확인(구버전)
			 
			$("#userPwdConfirm").blur(function() {
				var pwd = $("#userPwd").val(); 
				var pwdConfirm = $(this).val();
				var satusValue = "";
				if (pwd != pwdConfirm) {
					$("#check_pwdConfirm").text("비밀번호가 일치하지 않습니다!!  :(");
					$("#check_pwdConfirm").css("color", "red");
					$("#registerBtn").attr("disabled", true);
				} else {
					$("#check_pwdConfirm").text("비밀번호가 일치합니다!!  :)");
					$("#check_pwdConfirm").css("color", "blue");
				}
			});
		--%>
			// 아이디 유효성 체크
			$("#userId").on("keyup", function() {
				var id = $(this).val();
				
				$.ajax({
					url : "/register/checkId",
					type : "post",
					data : {userId : id},
					success : function(result) {
						// 확인용: console.log("1=중복 // 0=정상 : "+ reuslt);							
						
						if (result == 1) {
							// 1 : 중복
							$("#check_id").text("사용중인 아이디입니다!!  :(");
							$("#check_id").css("color", "red");
							// $("#registerBtn").attr("disabled", true);
						} else {
							
							// 0 : 정상, 형식검사 시작
							if (idRegex.test(id)) {
								$("#check_id").text("사용가능한 아이디 입니다!!  :)");
								$("#check_id").css("color", "green");
							} else if (id == "") {
								$("#check_id").text("아이디를 입력해주세요!!  :(");
								$("#check_id").css("color", "red");
								// $("#registerBtn").attr("disabled", true);
							} else if (!(idRegex.test(id))) {
								$("#check_id").text("아이디는 영문으로 시작하여, 소문자와 숫자를 사용해 6~12자리까지만 가능합니다!! :(");
								$("#check_id").css("color", "red");
								// $("#registerBtn").attr("disabled", true);
							}
						}
								
					}, error : function() {
							console.log("실패");
						}
				});
			});
		});
	</script>
</head>
<main id="main">
  <div class="login-wrap">
    <header class="section__header">
      <h1 class="section__title">JOIN</h1>
      <p class="section__text">회원가입</p>
    </header>
    <article id="join">
      <form action="register" class="sign-in-form" method="post">
        <div class="form__wrap">
          <div class="join__box">
            <label for="userId">아이디</label>
            <input
              type="text"
              id="userId"
              name="id"
              placeholder="아이디를 입력해 주세요"
              autocomplete="off"
            />
            <div class="warning" id="check_id"></div>
          </div>
          <div class="join__box">
            <label for="userPwd">비밀번호</label>
            <input
              type="password"
              id="userPwd"
              name="pwd"
              placeholder="비밀번호를 입력해 주세요"
            />
            <div class="warning" id="check_pwd"></div>
          </div>
          <div class="join__box">
            <label for="userPwdConfirm">비밀번호 확인</label>
            <input
              type="password"
              id="userPwdConfirm"
              name="userPwdConfirm"
              placeholder="비밀번호를 확인해 주세요"
            />
            <div class="warning" id="check_pwdConfirm"></div>
          </div>
          <div class="join__box">
            <label for="userName">이름</label>
            <input
              type="text"
              id="userName"
              name="name"
              placeholder="이름을 입력해 주세요"
              autocomplete="off"
            />
          </div>
          <div class="join__box">
            <label for="userTel">휴대전화</label>
            <input
              type="tel"
              id="userTel"
              name="tel"
              placeholder="휴대전화번호를 입력해 주세요"
              autocomplete="off"
            />
          </div>
          <div class="join__box">
            <label for="userEmail">이메일</label>
            <input
              type="email"
              id="userEmail"
              name="email"
              placeholder="이메일을 입력해 주세요"
              autocomplete="off"
            />
          </div>
          <div class="join__check">
            <p class="check__title">성별</p>
            <div class="radio-box">
              <input type="radio" 
                id="genderF" 
                name="gender" 
                value="female" 
                checked 
              />
              <label for="genderF">여자</label>
              <input 
                type="radio" 
                id="genderM" 
                name="gender" 
                value="male" 
              />
              <label for="genderM">남자</label>
            </div>
          </div>
        </div>
        <div class="agree-checkbox">
          <div class="agree__all">
            <div class="all-wrap">
              <input
                type="checkbox"
                id="check_all"
                name="selectall"
                onclick="selectAll(this)"
              />
              <label for="check_all">사용자 약관 전체 동의</label>
            </div>
          </div>
          <details>
            <summary>
              <div class="agree__box">
                <input
                  type="checkbox"
                  id="check_service"
                  name="agreecheck"
                  onclick="checkSelectAll()"
                />
                <label for="check_service">
                  서비스 이용 약관 동의 (필수)
                </label>
              </div>
            </summary>
            <div class="agree__text">
              개인정보 수집 및 이용 동의
              <br />
              1. 수집항목: [필수] 이름, 연락처, 이메일주소, 인원정보
              <br />
              2. 수집 및 이용목적: 사업자회원과 예약이용자의 원활한 거래
              진행, 고객상담, 불만처리 등 민원 처리, 분쟁조정 해결을 위한
              기록보존, 스테이폴리오 멤버십 및 프로모션, 이벤트 안내
              <br />
              3. 보관기간: 회원탈퇴 등 개인정보 이용목적 달성 시까지 보관.
              단, 상법 및 ‘전자상거래 등에서의 소비자 보호에 관한 법률’ 등
              관련 법령에 의하여 일정 기간 보관이 필요한 경우에는 해당 기간
              동안 보관함
              <br />
              4. 동의 거부권 등에 대한 고지: 정보주체는 개인정보의 수집 및
              이용 동의를 거부할 권리가 있으나, 이 경우 상품 및 서비스
              예약이 제한될 수 있습니다. 개인정보 제3자 제공 동의
              <br />
              <br />
              1. 개인정보를 제공받는 자: 스테이 호스트
              <br />
              2. 제공하는 개인정보 항목: [필수] 스테이폴리오 아이디, 이름,
              연락처, 이메일주소, 인원정보
              <br />
              3. 개인정보를 제공받는 자의 이용목적: 사업자회원과
              예약이용자의 원활한 거래 진행, 고객상담, 불만처리 등 민원
              처리, 분쟁조정 해결을 위한 기록보존
              <br />
              4. 개인정보를 제공받는 자의 개인정보 보유 및 이용기간:
              개인정보 이용목적 달성 시 까지 보존합니다.
              <br />
              5. 동의 거부권 등에 대한 고지: 정보주체는 개인정보 제공 동의를
              거부할 권리가 있으나, 이 경우 상품 및 서비스 예약이 제한될 수
              있습니다.
            </div>
          </details>
          <details>
            <summary>
              <div class="agree__box">
                <input
                  type="checkbox"
                  id="check_privacy"
                  name="agreecheck"
                  onclick="checkSelectAll()"
                />
                <label for="check_privacy">
                  개인정보 취급방침 동의 (필수)
                </label>
              </div>
            </summary>
            <div class="agree__text">
              제 1조 (총칙)
              <br />
              1. 개인정보란 생존하는 개인에 관한 정보로서 당해 정보에
              포함되어 있는 성명, 주민등록번호 등의 사항에 의하여 당해
              개인을 식별할 수 있는 정보 (당해 정보만으로는 특정 개인을
              식별할 수 없더라도 다른 정보와 용이하게 결합하여 식별할 수
              있는 것을 포함합니다.) 를 말합니다.
              <br />
              2. 스테이폴리오는 귀하의 개인정보 보호를 매우 중요시하며,
              ‘정보통신망이용촉진 및 정보보호에 관한 법률’ 상의 개인정보
              보호규정 및 정보통신부가 제정한 ‘개인정보 보호지침’을 준수하고
              있습니다.
              <br />
              3. 스테이폴리오는 개인정보취급방침을 정하고 이를 귀하께서
              언제나 쉽게 확인할 수 있게 공개하도록 하고 있습니다.
              <br />
              4. 스테이폴리오는 개인정보 처리방침의 지속적인 개선을 위하여
              개정하는데 필요한 절차를 정하고 있으며, 개인정보 처리방침을
              회사의 필요한 사회적 변화에 맞게 변경할 수 있습니다. 그리고
              개인정보처리방침을 개정하는 경우 버전번호 등을 부여하여 개정된
              사항을 귀하께서 쉽게 알아볼 수 있도록 하고 있습니다.
              <br />
              <br />
              제 2조 (수집하는 개인정보 항목 및 수집방법)
              <br />
              1. 스테이폴리오는 별도의 회원가입 절차 없이 대부분의 컨텐츠에
              자유롭게 접근할 수 있습니다. 스테이폴리오에서 예약 및
              프로모션, 이벤트 서비스를 이용하시고자 할 경우 다음의 정보를
              입력해주셔야 합니다.
              <br />
              - 입력항목 : 희망ID, 비밀번호, 성명, 이메일주소, 연락처
              <br />
              2. 또한 서비스 이용과정이나 사업 처리 과정에서 아래와 같은
              정보들이 생성되어 수집될 수 있습니다.
              <br />
              - 최근접속일, 접속 IP 정보, 쿠키, 구매로그, 이벤트로그
              <br />
              - 회원가입 시 회원이 원하시는 경우에 한하여 추가 정보를 선택,
              제공하실 수 있도록 되어있으며, 일부 재화 또는 용역 상품에 대한
              주문 및 예약 시 회원이 원하는 정확한 주문 내용 파악을 통한
              원활한 고객 응대 및 예약 처리를 위하여 추가적인 정보를
              요구하고 있습니다.
              <br />
              3. 스테이폴리오는 다음과 같은 방법으로 개인정보를 수집합니다.
              <br />
              - 홈페이지, 서면양식, 팩스, 전화, 상담 게시판, 이메일, 이벤트
              응모, 예약신청
              <br />
              - 로그 분석 프로그램을 통한 생성정보 수집
              <br />
              4. 개인정보 수집에 대한 동의
              <br />
              - 스테이폴리오는 귀하께서 스테이폴리오의 개인정보취급방침 및
              이용약관의 내용에 대해 「동의한다」버튼 또는 「동의하지
              않는다」버튼을 클릭할 수 있는 절차를 마련하여,
              「동의한다」버튼을 클릭하면 개인정보 수집에 대해 동의한 것으로
              봅니다.
              <br />
              5. 14세 미만 아동의 개인정보보호
              <br />
              스테이폴리오는 법정 대리인의 동의가 필요한 만14세 미만 아동의
              회원가입은 받고 있지 않습니다.
              <br />
              6. 비회원의 개인정보보호
              <br />
              - 스테이폴리오는 비회원 주문의 경우에도 예약정보, 대금결제,
              예약내역 조회 및 예약확인, 실명여부 확인을 위하여 필요한
              개인정보만을 요청하고 있으며, 이 경우 그 정보는 대금결제 및
              객실예약 관련된 용도 이외에는 다른 어떠한 용도로도 사용되지
              않습니다.
              <br />
              - 스테이폴리오는 비회원의 개인정보도 회원과 동등한 수준으로
              보호합니다.
            </div>
          </details>
          <details>
            <summary>
              <div class="agree__box">
                <input
                  type="checkbox"
                  id="check_above"
                  name="agreecheck"
                  onclick="checkSelectAll()"
                />
                <label for="check_above">만14세 이상 확인 (필수)</label>
              </div>
            </summary>
            <div class="agree__text">
              정보통신망 이용촉진 및 정보보호 등에 관한 법률에 따라 만 14세
              미만 아동의 개인정보 수집 시 법정대리인의 동의를 받도록
              규정하고 있습니다.
              <br />
              만 14세 미만 아동이 법정대리인 동의 없이 회원가입을 할 경우
              회원탈퇴 또는 서비스 이용에 제한이 있을 수 있습니다.
            </div>
          </details>
          <details>
            <summary>
              <div class="agree__box">
                <input
                  type="checkbox"
                  id="check_lifetime"
                  name="agreecheck"
                  onclick="checkSelectAll()"
                />
                <label for="check_lifetime">평생회원제동의 (선택)</label>
              </div>
            </summary>
            <div class="agree__text">
              평생회원제에 동의할 경우 1년 이상 서비스를 이용하지 않아도
              휴면 처리되지 않습니다.
            </div>
          </details>
          <details>
            <summary>
              <div class="agree__box">
                <input
                  type="checkbox"
                  id="check_marketing"
                  name="agreecheck"
                  onclick="checkSelectAll()"
                />
                <label for="check_marketing">
                  마케팅정보 수신 동의 (선택)
                </label>
              </div>
            </summary>
            <div class="agree__text">
              이메일, SMS를 통해 스테이폴리오에서 제공되는 이벤트 소식,
              스테이 소개 등 다양한 정보 안내를 받을 수 있습니다.
              <br />
              서비스의 중요 안내사항 및 스테이 예약/취소 관련 정보는 위 수신
              여부와 관계없이 발송됩니다.
            </div>
          </details>
        </div>
        <div class="join__btn">
          <button type="submit" id="registerBtn" class="btn__join">
            회원가입
          </button>
        </div>
        <div class="login__sns">
          <p class="sns__title">SNS 계정으로 로그인하기</p>
          <div class="sns__login">
            <a href="kakao/login" id="btn-kakao-login">
              <img
                src="../../resources/images/main/login_icon_kakao.png"
                alt="kakao-icon"
                class="sns__icon"
            /></a>
          </div>
        </div>
      </form>
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