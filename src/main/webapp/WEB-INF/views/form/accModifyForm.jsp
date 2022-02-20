<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../views/common/tags.jsp" %>

 <main id="main">
  <header class="section__header">
    <h1 class="section__title">HOST MODIFY</h1>
    <p class="section__text">호스트 수정</p>
  </header>
  <article class="host-registration">
    <form
      action="accHostModify"
      id="hostModify"
      method="post"
      enctype="multipart/form-data"
    >
    <input type="hidden" name="hostNo" value="${param.hostNo }">
    <input type="hidden" name="hostingType" value="${param.hostingType }">
    <input type="hidden" name="accNo" value="${accMainDto.accNo }">
      <div class="step-wrap" id="first">
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
                value="${accMainDto.hostName }"
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
                value="${accMainDto.tel }"
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
                value="${accMainDto.accountHolderName }"
              />
            </li>
            <li class="registration__item">
              <label for="bankName" class="registration__title">은행</label>
              <select
                class="registration__value"
                id="bankName"
                name="bankName"
              >
                <option value="농협" ${'농협' eq accMainDto.bankName ? 'selected' : ''}>농협</option>
                <option value="국민은행" ${'국민은행' eq accMainDto.bankName ? 'selected' : ''}>국민은행</option>
                <option value="신한은행" ${'신한은행' eq accMainDto.bankName ? 'selected' : ''}>신한은행</option>
                <option value="우리은행" ${'우리은행' eq accMainDto.bankName ? 'selected' : ''}>우리은행</option>
                <option value="기업은행" ${'기업은행' eq accMainDto.bankName ? 'selected' : ''}>기업은행</option>
                <option value="하나은행" ${'하나은행' eq accMainDto.bankName ? 'selected' : ''}>하나은행</option>
                <option value="대구은행" ${'대구은행' eq accMainDto.bankName ? 'selected' : ''}>대구은행</option>
                <option value="부산은행" ${'부산은행' eq accMainDto.bankName ? 'selected' : ''}>부산은행</option>
                <option value="우체국" ${'우체국' eq accMainDto.bankName ? 'selected' : ''}>우체국</option>
                <option value="SC제일은행" ${'SC제일은행' eq accMainDto.bankName ? 'selected' : ''}>SC제일은행</option>
                <option value="광주은행" ${'광주은행' eq accMainDto.bankName ? 'selected' : ''}>광주은행</option>
                <option value="경남은행" ${'경남은행' eq accMainDto.bankName ? 'selected' : ''}>경남은행</option>
                <option value="수협" ${'수협' eq accMainDto.bankName ? 'selected' : ''}>수협</option>
                <option value="케이뱅크" ${'케이뱅크' eq accMainDto.bankName ? 'selected' : ''}>케이뱅크</option>
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
                placeholder="계좌번호를 입력해 주세요"
                value="${accMainDto.accountNumber }"
              />
              <button class="btn__check-account" type="button">
                계좌 확인
              </button>
            </li>
          </ul>

        <div class="registration-box">
          <ul class="registration__list">
            <li class="registration__item">
              <label for="acctype" class="registration__title">유형</label>
              <select
                class="registration__value"
                id="acctype"
                name="accType"
              >
                <option value="호텔" ${'호텔' eq accMainDto.accType ? 'selected' : ''}>호텔</option>
                <option value="게스트하우스" ${'게스트하우스' eq accMainDto.accType ? 'selected' : ''}>게스트하우스</option>
                <option value="렌탈하우스" ${'렌탈하우스' eq accMainDto.accType ? 'selected' : ''}>렌탈하우스</option>
                <option value="펜션" ${'펜션' eq accMainDto.accType ? 'selected' : ''}>펜션</option>
                <option value="한옥" ${'한옥' eq accMainDto.accType ? 'selected' : ''}>한옥</option>
                <option value="캠핑&아웃도어" ${'캠핑&아웃도어' eq accMainDto.accType ? 'selected' : ''}>캠핑&아웃도어</option>
                <option value="호스텔" ${'호스텔' eq accMainDto.accType ? 'selected' : ''}>호스텔</option>
                <option value="리조트" ${'리조트' eq accMainDto.accType ? 'selected' : ''}>리조트</option>
                <option value="민박" ${'민박' eq accMainDto.accType ? 'selected' : ''}>민박</option>
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
                value="${accMainDto.accName }"
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
                value="${accMainDto.accWebAddress }"
              />
            </li>

            <li class="registration__item">
              <label for="accAddress" class="registration__title"
                >주소</label
              >
              <input
                type="text"
                class="registration__value"
                id="accAddress"
                name="accAddress"
                placeholder="숙소 주소를 입력해 주세요"
                value="${accMainDto.accAddress }"
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
                <option value="12:00" ${'12:00' eq accMainDto.accCheckInTime ? 'selected' : ''}>12:00</option>
                <option value="12:30" ${'12:30' eq accMainDto.accCheckInTime ? 'selected' : ''}>12:30</option>
                <option value="13:00" ${'13:00' eq accMainDto.accCheckInTime ? 'selected' : ''}>13:00</option>
                <option value="13:30" ${'13:30' eq accMainDto.accCheckInTime ? 'selected' : ''}>13:30</option>
                <option value="14:00" ${'14:00' eq accMainDto.accCheckInTime ? 'selected' : ''}>14:00</option>
                <option value="14:30" ${'14:30' eq accMainDto.accCheckInTime ? 'selected' : ''}>14:30</option>
                <option value="15:00" ${'15:00' eq accMainDto.accCheckInTime ? 'selected' : ''}>15:00</option>
                <option value="15:30" ${'15:30' eq accMainDto.accCheckInTime ? 'selected' : ''}>15:30</option>
                <option value="16:00" ${'16:00' eq accMainDto.accCheckInTime ? 'selected' : ''}>16:00</option>
                <option value="16:30" ${'16:30' eq accMainDto.accCheckInTime ? 'selected' : ''}>16:30</option>
                <option value="17:00" ${'17:00' eq accMainDto.accCheckInTime ? 'selected' : ''}>17:00</option>
                <option value="17:30" ${'17:30' eq accMainDto.accCheckInTime ? 'selected' : ''}>17:30</option>
              </select>
              <select
                class="registration__check-time"
                id="accCheckOutime"
                name="accCheckOutime"
              >
                <option value="09:00" ${'09:00' eq accMainDto.accCheckOutime ? 'selected' : ''}>09:00</option>
                <option value="09:30" ${'09:30' eq accMainDto.accCheckOutime ? 'selected' : ''}>09:30</option>
                <option value="10:00" ${'10:00' eq accMainDto.accCheckOutime ? 'selected' : ''}>10:00</option>
                <option value="10:30" ${'10:30' eq accMainDto.accCheckOutime ? 'selected' : ''}>10:30</option>
                <option value="11:00" ${'11:00' eq accMainDto.accCheckOutime ? 'selected' : ''}>11:00</option>
                <option value="11:30" ${'11:30' eq accMainDto.accCheckOutime ? 'selected' : ''}>11:30</option>
                <option value="12:00" ${'12:00' eq accMainDto.accCheckOutime ? 'selected' : ''}>12:00</option>
                <option value="12:30" ${'12:30' eq accMainDto.accCheckOutime ? 'selected' : ''}>12:30</option>
                <option value="13:00" ${'13:00' eq accMainDto.accCheckOutime ? 'selected' : ''}>13:00</option>
                <option value="13:30" ${'13:30' eq accMainDto.accCheckOutime ? 'selected' : ''}>13:30</option>
                <option value="14:00" ${'14:00' eq accMainDto.accCheckOutime ? 'selected' : ''}>14:00</option>
              </select>
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
                value="${accMainDto.accIntroTitle }"
              />
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
              >${accMainDto.accIntroContent }</textarea>
            </li>
            <li class="registration__item">
              <div class="registration__title">메인 사진 첨부</div>
              <input
                class="file__value"
                id="accMainFileName"
                value="${accMainDto.mainImage }"
                placeholder="첨부파일"
                disabled
              />
              <input
                type="file"
                class="registration__file"
                id="accHostMainImage"
                name="hostMainImage"
                value="${accMainDto.mainImage }"
                onchange="javascript:document.getElementById('accMainFileName').value = this.value"
              />
              <label for="accHostMainImage" class="btn__file" value="${accMainDto.mainImage }">사진 선택</label>
            </li>
            <img src="/resources/images/hostMainImage/${accMainDto.mainImage}" width="300">
            
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
            <c:forEach var="image" items="${accImages}">
		    	<img src="/resources/images/room/${image.image }" width="200" />
		    </c:forEach>
          </ul>
          <div class="registration__btn">
            <button class="btn__next" id="accModifyBtn">
              수정 완료
            </button>
          </div>
        </div>
      </div>
      </div>
    </form>
  </article>
</main>
<script type="text/javascript">

$(function(){
	
	$('#accModifyBtn').on('click', function(e){	
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
	}
	
	$('#accModifyBtn').click(function(){
		$("#hostModify").submit
	})
	
});
		
</script>