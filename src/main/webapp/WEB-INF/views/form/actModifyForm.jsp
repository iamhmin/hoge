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
      action="actHostModify"
      id="hostModify"
      method="post"
      enctype="multipart/form-data"
    >
    <input type="hidden" name="hostNo" value="${param.hostNo }">
    <input type="hidden" name="hostingType" value="${param.hostingType }">
    <input type="hidden" name="actNo" value="${actMainDto.actNo }">
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
                 value="${actMainDto.hostName }"
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
                value="${actMainDto.tel }"
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
                value="${actMainDto.accountHolderName }"
              />
            </li>
            <li class="registration__item">
              <label for="bankName" class="registration__title">은행</label>
              <select
                class="registration__value"
                id="bankName"
                name="bankName"
              >
                <option value="농협" ${'농협' eq actMainDto.bankName ? 'selected' : ''}>농협</option>
                <option value="국민은행" ${'국민은행' eq actMainDto.bankName ? 'selected' : ''}>국민은행</option>
                <option value="신한은행" ${'신한은행' eq actMainDto.bankName ? 'selected' : ''}>신한은행</option>
                <option value="우리은행" ${'우리은행' eq actMainDto.bankName ? 'selected' : ''}>우리은행</option>
                <option value="기업은행" ${'기업은행' eq actMainDto.bankName ? 'selected' : ''}>기업은행</option>
                <option value="하나은행" ${'하나은행' eq actMainDto.bankName ? 'selected' : ''}>하나은행</option>
                <option value="대구은행" ${'대구은행' eq actMainDto.bankName ? 'selected' : ''}>대구은행</option>
                <option value="부산은행" ${'부산은행' eq actMainDto.bankName ? 'selected' : ''}>부산은행</option>
                <option value="우체국" ${'우체국' eq actMainDto.bankName ? 'selected' : ''}>우체국</option>
                <option value="SC제일은행" ${'SC제일은행' eq actMainDto.bankName ? 'selected' : ''}>SC제일은행</option>
                <option value="광주은행" ${'광주은행' eq actMainDto.bankName ? 'selected' : ''}>광주은행</option>
                <option value="경남은행" ${'경남은행' eq actMainDto.bankName ? 'selected' : ''}>경남은행</option>
                <option value="수협" ${'수협' eq actMainDto.bankName ? 'selected' : ''}>수협</option>
                <option value="케이뱅크" ${'케이뱅크' eq actMainDto.bankName ? 'selected' : ''}>케이뱅크</option>
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
                value="${actMainDto.accountNumber }"
              />
              <button class="btn__check-account" type="button">
                계좌 확인
              </button>
            </li>
          </ul>
        </div>
      </div>

      <div class="step-wrap" id="third">
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
                value="${actMainDto.actName }"
              />
            </li>

            <li class="registration__item">
              <label for="actAddress" class="registration__title"
                >주소</label
              >
              <input
                type="text"
                class="registration__value"
                id="actAddress"
                name="actAddress"
                placeholder="체험활동 주소를 입력해 주세요"
                value="${actMainDto.actAddress }"
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
                value="${actMainDto.actMaximumNumber }"
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
                value="${actMainDto.actPricePerPerson }"
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
                value="${actMainDto.actIntroTitle }"
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
              >${actMainDto.actIntroContent }</textarea>
            </li>
            <li class="registration__item">
              <div class="registration__title">메인 사진 첨부</div>
              <input
                class="file__value"
                id="actMainFileName"
                value="${actMainDto.mainImage }"
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
            <img src="/resources/images/hostMainImage/${actMainDto.mainImage}" width="300">
            
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
            <c:forEach var="image" items="${actImages}">
		    	<img src="/resources/images/room/${image.image }" width="200" />
		    </c:forEach>
          </ul>
          <div class="registration__btn">
            <button type="submit" class="btn__next" id="actModifyBtn">
              수정 완료
            </button>
          </div>
        </div>
      </div>
    </form>
  </article>
</main>
	
<script type="text/javascript">

$(function(){
	
	$('#actModifyBtn').on('click', function(e){
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
		
	$('#actModifyBtn').click(function(){
			$("#hostModify").submit
	})
	
});
		
</script>