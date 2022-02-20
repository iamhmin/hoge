<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <main id="main">
  <header class="section__header">
    <h1 class="section__title">HOST REGISTRATION</h1>
    <p class="section__text">호스트 등록</p>
  </header>
  <article class="host-registration">
    <form
      action="insertHostApply"
      id="hostApply"
      method="post"
      enctype="multipart/form-data"
    >
    <input type="hidden" name="xce">
    <input type="hidden" name="yce">
    <input type="hidden" name="hostingType" id="applyType" value="">
    <input type="hidden" name="userNo" value="${param.userNo }" />
    
<!-- first -->
      <div class="step-wrap" id="first">
        <div class="registration__btn">
          <button class="btn__accommo" type="button" onclick="first()">
            <i class="fas fa-home"></i>
            <span>숙소</span>
          </button>
          <button class="btn__activity" type="button" onclick="second()">
            <i class="fas fa-snowboarding"></i>
            <span>체험</span>
          </button>
        </div>
        <div class="registration-box">
          <ul class="registration__list">
            <li class="registration__item">
              <label for="hostName" class="registration__title">이름</label
              ><input
                type="text"
                class="registration__value"
                id="hostName"
                name="hostName"
                placeholder="호스트 이름을 입력해 주세요"
              />
            </li>
            <li class="registration__item">
              <label for="hostTel" class="registration__title"
                >전화번호</label
              ><input
                type="tel"
                class="registration__value"
                id="hostTel"
                name="tel"
                placeholder="호스트 전화번호를 입력해 주세요"
              />
            </li>
            <li class="registration__item">
              <label for="accName" class="registration__title">예금주</label
              ><input
                type="text"
                class="registration__value"
                id="accName"
                name="accountHolderName"
                placeholder="예금주를 입력해 주세요"
              />
            </li>
            <li class="registration__item">
              <label for="bankName" class="registration__title">은행</label>
              <select
                class="registration__value"
                id="bankName"
                name="bankName"
              >
                <option value="농협" selected>농협</option>
                <option value="국민은행">국민은행</option>
                <option value="신한은행">신한은행</option>
                <option value="우리은행">우리은행</option>
                <option value="기업은행">기업은행</option>
                <option value="하나은행">하나은행</option>
                <option value="대구은행">대구은행</option>
                <option value="부산은행">부산은행</option>
                <option value="우체국">우체국</option>
                <option value="SC제일은행">SC제일은행</option>
                <option value="광주은행">광주은행</option>
                <option value="경남은행">경남은행</option>
                <option value="수협">수협</option>
                <option value="케이뱅크">케이뱅크</option>
              </select>
            </li>
            <li class="registration__item account">
              <label for="hostAcc" class="registration__title"
                >계좌번호</label
              >
              <input
                type="text"
                class="registration__value"
                id="hostAcc"
                name="accountNumber"
                placeholder="계좌번호를 (-)빼고 입력해 주세요"
              />
              <button class="btn__check-account" type="button">
                계좌 확인
              </button>
            </li>
          </ul>
          <p class="agree__title">이용자 약관 동의</p>
          <div class="agree__checkbox-registration">
            <div class="agree__all-registration">
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
              <summary class="registration__agree">
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
                관련 법령에 의하여 일정 기간 보관이 필요한 경우에는 해당
                기간 동안 보관함
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
                5. 동의 거부권 등에 대한 고지: 정보주체는 개인정보 제공
                동의를 거부할 권리가 있으나, 이 경우 상품 및 서비스 예약이
                제한될 수 있습니다.
              </div>
            </details>
            <details>
              <summary class="registration__agree">
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
                서비스의 중요 안내사항 및 스테이 예약/취소 관련 정보는 위
                수신 여부와 관계없이 발송됩니다.
              </div>
            </details>
          </div>
          <div class="registration__btn">
            <button type="button" class="btn__next" id="nextBtn">
              계속 진행
            </button>
          </div>
        </div>
      </div>

<!-- second -->
      <div class="step-wrap" id="second">
        <div class="registration__btn">
          <div class="img__accommo active">
            <i class="fas fa-home"></i>
            <span>숙소</span>
          </div>
          <div class="img__activity">
            <i class="fas fa-snowboarding"></i>
            <span>체험</span>
          </div>
        </div>
        <div class="registration-box">
          <ul class="registration__list">
            <li class="registration__item">
              <label for="acctype" class="registration__title">유형</label>
              <select
                class="registration__value"
                id="acctype"
                name="accType"
              >
                <option value="호텔" selected>호텔</option>
                <option value="게스트하우스">게스트하우스</option>
                <option value="렌탈하우스">렌탈하우스</option>
                <option value="펜션">펜션</option>
                <option value="한옥">한옥</option>
                <option value="캠핑&아웃도어">캠핑&아웃도어</option>
                <option value="호스텔">호스텔</option>
                <option value="리조트">리조트</option>
                <option value="민박">민박</option>
              </select>
            </li>
            <li class="registration__item">
              <label for="accName" class="registration__title">이름</label
              ><input
                type="text"
                class="registration__value"
                id="accName"
                name="accName"
                placeholder="숙소 이름을 입력해 주세요"
              />
            </li>
            <li class="registration__item">
              <label for="accWebAddress" class="registration__title"
                >홈페이지</label
              ><input
                type="tel"
                class="registration__value"
                id="accWebAddress"
                name="accWebAddress"
                placeholder="숙소 홈페이지를 입력해 주세요"
              />
            </li>
            <li class="registration__item">
              <label for="accIntroTitle" class="registration__title"
                >타이틀</label
              ><input
                type="text"
                class="registration__value"
                id="accIntroTitle"
                name="accIntroTitle"
                placeholder="숙소 타이틀을 입력해 주세요"
              />
            </li>
            <li class="registration__item">
              <label for="accAddress" class="registration__title"
                >주소</label
              >
              <input
              	class="form-control"
              	id="member_post"
              	type="hidden"
              	placeholder="우편번호"
              	readonly
              	onclick="findAddr1()"
              />
              <input
                type="text"
                style="width:270px;"
                class="registration__value"
                id="member_addr"
                name="accMainAddress"
                placeholder="주소를 입력해 주세요"
                readonly
                onclick="findAddr1()"
              />
              <br>
              <input
                type="text"
                style="width:280px;"
                class="registration__value"
                id="detail_addr"
                name="accDetailAddress"
                placeholder="상세 주소를 입력해 주세요"
              />
            </li>
            <li class="registration__item">
              <label for="accCheckInTime" class="registration__title"
                >체크인 · 체크아웃</label
              >
              <select
                class="registration__check-time"
                id="accCheckInTime"
                name="accCheckInTime"
              >
                <option disabled selected>check-in time</option>
                <option value="12:00" >12:00</option>
                <option value="12:30" >12:30</option>
                <option value="13:00" >13:00</option>
                <option value="13:30" >13:30</option>
                <option value="14:00" >14:00</option>
                <option value="14:30" >14:30</option>
                <option value="15:00" >15:00</option>
                <option value="15:30" >15:30</option>
                <option value="16:00" >16:00</option>
                <option value="16:30" >16:30</option>
                <option value="17:00" >17:00</option>
                <option value="17:30" >17:30</option>
              </select>
              <select
                class="registration__check-time"
                id="accCheckOutime"
                name="accCheckOutime"
              >
                <option disabled selected>check-out time</option>
                <option value="09:00" >09:00</option>
                <option value="09:30" >09:30</option>
                <option value="10:00" >10:00</option>
                <option value="10:30" >10:30</option>
                <option value="11:00" >11:00</option>
                <option value="11:30" >11:30</option>
                <option value="12:00" >12:00</option>
                <option value="12:30" >12:30</option>
                <option value="13:00" >13:00</option>
                <option value="13:30" >13:30</option>
                <option value="14:00" >14:00</option>
              </select>
            </li>
            <li class="registration__item textarea">
              <label for="accIntroContent" class="registration__title"
                >소개</label
              >
              <textarea
                class="registration__textarea"
                id="accIntroContent"
                name="accIntroContent"
                placeholder="숙소 소개를 입력해 주세요"
              ></textarea>
            </li>
            <li class="registration__item">
              <div class="registration__title">메인 사진 첨부</div>
              <input
                class="file__value"
                id="accMainFileName"
                value="첨부파일"
                placeholder="첨부파일"
                disabled
              />
              <input
                type="file"
                class="registration__file"
                id="accHostMainImage"
                name="hostMainImage"
                onchange="javascript:document.getElementById('accMainFileName').value = this.value"
              />
              <label for="accHostMainImage" class="btn__file">사진 선택</label>
            </li>
            <li class="registration__item file">
              <div class="registration__title">사진 첨부</div>
              <div class="registration__file-wrap">
                <div class="file__wrap">
                  <input
                    class="file__value"
                    id="accFile1"
                    value="첨부파일"
                    placeholder="첨부파일"
                    disabled
                  />
                  <input
                    type="file"
                    class="registration__file"
                    id="accImages1"
                    name="accImages"
                    onchange="javascript:document.getElementById('accFile1').value = this.value"
                  />
                  <label for="accImages1" class="btn__file"
                    >사진 선택</label
                  >
                </div>
                <div class="file__wrap">
                  <input
                    class="file__value"
                    id="accFile2"
                    value="첨부파일"
                    placeholder="첨부파일"
                    disabled
                  />
                  <input
                    type="file"
                    class="registration__file"
                    id="accImages2"
                    name="accImages"
                    onchange="javascript:document.getElementById('accFile2').value = this.value"
                  />
                  <label for="accImages2" class="btn__file"
                    >사진 선택</label
                  >
                </div>
                <div class="file__wrap">
                  <input
                    class="file__value"
                    id="accFile3"
                    value="첨부파일"
                    placeholder="첨부파일"
                    disabled
                  />
                  <input
                    type="file"
                    class="registration__file"
                    id="accImages3"
                    name="accImages"
                    onchange="javascript:document.getElementById('accFile3').value = this.value"
                  />
                  <label for="accImages3" class="btn__file"
                    >사진 선택</label
                  >
                </div>
                <div class="file__wrap">
                  <input
                    class="file__value"
                    id="accFile4"
                    value="첨부파일"
                    placeholder="첨부파일"
                    disabled
                  />
                  <input
                    type="file"
                    class="registration__file"
                    id="accImages4"
                    name="accImages"
                    onchange="javascript:document.getElementById('accFile4').value = this.value"
                  />
                  <label for="accImages4" class="btn__file"
                    >사진 선택</label
                  >
                </div>
                <div class="file__wrap">
                  <input
                    class="file__value"
                    id="accFile5"
                    value="첨부파일"
                    placeholder="첨부파일"
                    disabled
                  />
                  <input
                    type="file"
                    class="registration__file"
                    id="accImages5"
                    name="accImages"
                    onchange="javascript:document.getElementById('accFile5').value = this.value"
                  />
                  <label for="accImages5" class="btn__file"
                    >사진 선택</label
                  >
                </div>
              </div>
            </li>
          </ul>
          <div class="registration__btn">
            <button type="submit" class="btn__next" id="accInsertBtn">
              등록 신청
            </button>
          </div>
        </div>
      </div>

<!-- third -->
      <div class="step-wrap" id="third">
        <div class="registration__btn">
          <div class="img__accommo">
            <i class="fas fa-home"></i>
            <span>숙소</span>
          </div>
          <div class="img__activity active">
            <i class="fas fa-snowboarding"></i>
            <span>체험</span>
          </div>
        </div>
        <div class="registration-box">
          <ul class="registration__list">
            <li class="registration__item">
              <label for="actName" class="registration__title">체험 이름</label
              ><input
                type="text"
                class="registration__value"
                id="actName"
                name="actName"
                placeholder="체험활동 이름을 입력해 주세요"
              />
            </li>
            <li class="registration__item">
              <label for="actIntroTitle" class="registration__title"
                >타이틀</label
              ><input
                type="text"
                class="registration__value"
                id="actIntroTitle"
                name="actIntroTitle"
                placeholder="체험활동 타이틀을 입력해 주세요"
              />
            </li>

            <li class="registration__item">
              <label for="actAddress" class="registration__title"
                >주소</label
              >
              <input
              class="form-control"
              id="member_post2"
              type="hidden"
              placeholder="우편번호"
              readonly
              onclick="findAddr2()"
              />
              <input
                type="text"
                style="width:270px;"
                class="registration__value"
                id="member_addr2"
                name="actMainAddress"
                placeholder="체험활동 주소를 입력해 주세요"
                readonly
                onclick="findAddr2()"
              />
              <br>
              <input
                type="text"
                style="width:280px;"
                class="registration__value"
                id="detail_addr2"
                name="actDetailAddress"
                placeholder="상세 주소를 입력해 주세요"
              />
            </li>
            <li class="registration__item">
              <label for="actMaximumNumber" class="registration__title"
                >최대 인원</label
              >
              <input
                type="text"
                class="registration__value"
                id="actMaximumNumber"
                name="actMaximumNumber"
                placeholder="체험활동 최대 인원을 입력해 주세요"
              />
            </li>
            <li class="registration__item">
              <label for="actPricePerPerson" class="registration__title"
                >1인당 가격</label
              >
              <input
                type="text"
                class="registration__value"
                id="actPricePerPerson"
                name="actPricePerPerson"
                placeholder="체험활동 가격을 입력해 주세요"
              />
            </li>
            <li class="registration__item textarea">
              <label for="actIntroContent" class="registration__title"
                >소개</label
              >
              <textarea
                class="registration__textarea"
                id="actIntroContent"
                name="actIntroContent"
                placeholder="체험활동 소개를 입력해 주세요"
              ></textarea>
            </li>
            <li class="registration__item">
              <div class="registration__title">메인 사진 첨부</div>
              <input
                class="file__value"
                id="actMainFileName"
                value="첨부파일"
                placeholder="첨부파일"
                disabled
              />
              <input
                type="file"
                class="registration__file"
                id="actHostMainImage"
                name="hostMainImage"
                onchange="javascript:document.getElementById('actMainFileName').value = this.value"
              />
              <label for="actHostMainImage" class="btn__file">사진 선택</label>
            </li>
            <li class="registration__item file">
              <div class="registration__title">사진 첨부</div>
              <div class="registration__file-wrap">
                <div class="file__wrap">
                  <input
                    class="file__value"
                    id="actFile1"
                    value="첨부파일"
                    placeholder="첨부파일"
                    disabled
                  />
                  <input
                    type="file"
                    class="registration__file"
                    id="actImages1"
                    name="actImages"
                    onchange="javascript:document.getElementById('actFile1').value = this.value"
                  />
                  <label for="actImages1" class="btn__file"
                    >사진 선택</label
                  >
                </div>
                <div class="file__wrap">
                  <input
                    class="file__value"
                    id="actFile2"
                    value="첨부파일"
                    placeholder="첨부파일"
                    disabled
                  />
                  <input
                    type="file"
                    class="registration__file"
                    id="actImages2"
                    name="actImages"
                    onchange="javascript:document.getElementById('actFile2').value = this.value"
                  />
                  <label for="actImages2" class="btn__file"
                    >사진 선택</label
                  >
                </div>
                <div class="file__wrap">
                  <input
                    class="file__value"
                    id="actFile3"
                    value="첨부파일"
                    placeholder="첨부파일"
                    disabled
                  />
                  <input
                    type="file"
                    class="registration__file"
                    id="actImages3"
                    name="actImages"
                    onchange="javascript:document.getElementById('actFile3').value = this.value"
                  />
                  <label for="actImages3" class="btn__file"
                    >사진 선택</label
                  >
                </div>
                <div class="file__wrap">
                  <input
                    class="file__value"
                    id="actFile4"
                    value="첨부파일"
                    placeholder="첨부파일"
                    disabled
                  />
                  <input
                    type="file"
                    class="registration__file"
                    id="actImages4"
                    name="actImages"
                    onchange="javascript:document.getElementById('actFile4').value = this.value"
                  />
                  <label for="actImages4" class="btn__file"
                    >사진 선택</label
                  >
                </div>
                <div class="file__wrap">
                  <input
                    class="file__value"
                    id="actFile5"
                    value="첨부파일"
                    placeholder="첨부파일"
                    disabled
                  />
                  <input
                    type="file"
                    class="registration__file"
                    id="actImages5"
                    name="actImages"
                    onchange="javascript:document.getElementById('actFile5').value = this.value"
                  />
                  <label for="actImages5" class="btn__file"
                    >사진 선택</label
                  >
                </div>
              </div>
            </li>
          </ul>
          <div class="registration__btn">
            <button type="submit" class="btn__next" id="actInsertBtn">
              등록 신청
            </button>
          </div>
        </div>
      </div>
    </form>
  </article>
</main>

<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8606c7f07c8e2d80f27869dab7ebaec2&libraries=services"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8606c7f07c8e2d80f27869dab7ebaec2"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

// 주소 검색
function findAddr1(){
	new daum.Postcode({
        oncomplete: function(data) {
        	//console.log(data);
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var jibunAddr = data.jibunAddress; // 지번 주소 변수
            var geocoder = new kakao.maps.services.Geocoder();
            document.getElementById('member_post').value = data.zonecode;
            if(roadAddr !== '') {
                document.getElementById("member_addr").value = roadAddr;
                document.getElementById("detail_addr").focus();
                geocoder.addressSearch(roadAddr, callback);
            } 
            else if(jibunAddr !== ''){
                document.getElementById("member_addr").value = jibunAddr;
                document.getElementById("detail_addr").focus();
                console.log("jibunAddr" + jibunAddr);
                geocoder.addressSearch(jibunAddr, callback);
            }
        }
    }).open();
}

function findAddr2(){
	new daum.Postcode({
        oncomplete: function(data) {
        	console.log(data);
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var jibunAddr = data.jibunAddress; // 지번 주소 변수
            var geocoder = new kakao.maps.services.Geocoder();
            document.getElementById('member_post2').value = data.zonecode;
            if(roadAddr !== ''){
                document.getElementById("member_addr2").value = roadAddr;
                document.getElementById("detail_addr2").focus();
                geocoder.addressSearch(roadAddr, callback);
            } 
            else if(jibunAddr !== ''){
                document.getElementById("member_addr2").value = jibunAddr;
                document.getElementById("detail_addr2").focus();
                geocoder.addressSearch(jibunAddr, callback);
            }
        }
    }).open();
}

var callback = function(result, status) {
    if (status === kakao.maps.services.Status.OK) {
        $("input[name=xce]").val(result[0].x);
        $("input[name=yce]").val(result[0].y);
    }
};


function first() {
	$("#applyType").val(1)
}
function second() {
	$("#applyType").val(2)
}


$(function(){
	$('#second').hide();
	$('#third').hide();
	
	$('.btn__accommo').on('click', function(e){
		if($('.btn__activity').hasClass('active')){
			$('.btn__activity').removeClass('active');
			$(this).addClass('active');
		} else {
			$(this).addClass('active');
		}
	});
	
	
	$('.btn__activity').on('click', function(e){
		if($('.btn__accommo').hasClass('active')){
			$('.btn__accommo').removeClass('active');
			$(this).addClass('active');
		} else {
			$(this).addClass('active');
		}
	});
	
	
	$('#nextBtn').on('click', function(e){
		e.preventDefault();
		e.stopPropagation();
		
		var hostName = $("#hostName").val();
		if(hostName == ""){
			return alert('호스트 이름을 입력해주세요.');
		}
		
		var hostTel = $("#hostTel").val();
		if(hostTel == ""){
			return alert('호스트 전화번호를 입력해주세요.');
		}
		
		var accName = $("#accName").val();
		if(accName == ""){
			return alert('예금주를 입력해주세요.');
		}
		
		/*
		var applyType = $("#applyTypeCheck").prop('checked');
		if(applyType == true){
			$("#applyType").val(1);
		} else {
			$("#applyType").val(2);
		}
		*/
		
		var hostAcc = $('#hostAcc').val();
		if(hostAcc == ""){
			return alert('계좌번호를 입력해주세요.');
		}
		
		var bool = $('#check_service').prop('checked');
		if(bool === false){
			return alert('서비스 이용 약관 동의는 필수체크 항목입니다.');
		} else {
			$('#first').hide();
			if($("#applyType").val() == 1){
				$('#second').show();
			} else {
				$('#third').show();
			}
			
		$('#accInsertBtn').click(function(){
			$("#actName").val(1);
			$("#actIntroTitle").val(1);
			$("#actIntroContent").val(1);
			$("#actMaximumNumber").val(1);
			$("#actPricePerPerson").val(1);
			$("#actAddress").val(1);
			$("#member_post2").val(1);
			$("#member_addr2").val('서울 서울 서울');
			$("#detail_addr2").val(1);
			$('#hostApply').submit()
		})
		
		$('#actInsertBtn').click(function(){
			$("#accType").val(1);
			$("#accName").val(1);
			$("#accWebAddress").val(1);
			$("#accIntroTitle").val(1);
			$("#accIntroContent").val(1);
			$("#accAddress").val(1);
			$("#accCheckInTime").val(1);
			$("#accCheckOutime").val(1);
			$("#member_post").val(1);
			$("#member_addr").val('서울 서울 서울');
			$("#detail_addr").val(1);
			$('#hostApply').submit()
		})
			
		}
	});
	
});
		
</script>