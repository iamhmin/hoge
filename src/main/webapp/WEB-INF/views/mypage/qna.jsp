<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../common/tags.jsp" %>

<div class="mypage__content">
  <article class="user-qna">
    <div class="update-title">자주 묻는 질문</div>
    
  <!-- 자주 묻는 질문 -->
    <section class="frequent-qna">
      <div class="frequent-qna__box">
        <div class="qna">
          <p class="qna-title">결제 수단을 어떻게 인증하나요?</p>
          <p class="qna-content">
            HOGE 커뮤니티와 회원님의 계정을 안전하게 보호하기 위해
            회원님께 결제 수단 인증을 요청할 수도 있습니다.
          </p>
        </div>
        <div class="qna">
          <p class="qna-title">계정 설정 변경하기</p>
          <p class="qna-content">
            계정 정보를 일부 변경하셔야 하나요? 공개 프로필의 일부
            정보와 계정 설정은 '계정' 섹션에서 변경할 수 있습니다.
          </p>
        </div>
      </div>
      <div class="frequent-qna__box">
        <div class="qna">
          <p class="qna-title">비밀번호 변경 또는 재설정</p>
          <p class="qna-content">
            비밀번호를 잊어버렸거나 로그인하는 데 문제가 있나요?
            누구에게나 한 번쯤 일어나는 일이죠. 그럴 땐 비밀번호를
            재설정하세요.
          </p>
        </div>
        <div class="qna">
          <p class="qna-title">신분증 제출 방법</p>
          <p class="qna-content">
            본인 인증 정보를 제공하면 호게 커뮤니티 내 신뢰를 쌓아가는
            데 큰 도움이 됩니다. 본인 인증을 요청받은 경우, 실명과
            주소를 입력하거나 정부 발급 신분증(운전면허증, 여권 또는
            주민등록증) 사진을 제출하셔야 합니다.
          </p>
        </div>
      </div>
      <div class="frequent-qna__box">
        <div class="qna">
          <p class="qna-title">나에게 가장 적합한 숙소 찾기</p>
          <p class="qna-content">
            훌륭한 숙소를 찾는 데 도움이 필요하세요? 게스트가 다음
            여행을 계획할 때 가장 궁금해하는 사항을 확인해보세요.
          </p>
        </div>
        <div class="qna">
          <p class="qna-title">안전 관련 정보</p>
          <p class="qna-content">
            HOGE는 무엇보다 안전을 최우선으로 중시합니다. 모든 정보를
            투명하게 공개해 게스트가 뜻밖의 상황에 당황하지 않도록
            하고 책임감 있는 호스팅을 장려하고자 합니다.
          </p>
        </div>
      </div>
    </section>
    
  <!-- QnA 영역 -->  
     <section class="my-qna">
	      <button
	        type="button"
	        class="btn__question"
	        onclick="creatingModal()"
	      >
	        문의하기
	      </button>
	
	    <c:choose>
		  <c:when test="${empty qnaList }">
	        <div class="empty-qna">작성된 QnA가 없습니다.</div>
		  </c:when>
	
		  <c:otherwise>
	      <article class="my-qna__box">
	        <p class="qna-count">총 ${totalRecords }건의 상담내역이 있습니다.</p>
	        <div class="details-box">
	          
	          <c:forEach var="qna" items="${qnaList }" varStatus="loop">
	          <details class="my-qna__list">
	            <summary class="my-qna__head">
	              <div class="my-qna__category">${qna.category }</div>
	              <div class="my-qna__title text-overflow">
	                ${qna.title }
	              </div>
	              <div class="my-qna__date">
	                <fmt:formatDate value="${qna.questionDate }" pattern="yyyy.MM.dd"/>
	              </div>
	              <div class="my-qna__answered">
	                <c:choose>
						<c:when test="${qna.answered eq 'N'}">
						답변대기
						</c:when>
						<c:otherwise>
						답변완료
						</c:otherwise>
					</c:choose>
	              </div>
	            </summary>
	            <div class="my-qna__body">
	              <div class="my-qna__questionContent">
	                <i class="fas fa-question-circle"></i>
	                <p>
	                  ${qna.content }
	                </p>
	              </div>
	              <div class="my-qna__answerContent">
	                <i class="fas fa-exclamation-circle"></i>
	                <p>
	                  <c:choose>
						<c:when test="${qna.answered eq 'N'}">
						  <span style="font-weight: var(--weight-regular);">답변 대기 중입니다.</span>
						</c:when>
						<c:otherwise>
						  ${qna.answerContent }
						</c:otherwise>
					  </c:choose>
	                </p>
	              </div>
	            </div>
	          </details>
	          </c:forEach>
	       
	        </div>
	        </article>
		  </c:otherwise>
		</c:choose> 
	        
	        
	     <c:if test="${pagination.totalRecords gt 0 }">
	      <!-- pagination -->
	        <div id="pagination">
	          <ul class="pagination__list">
	            <li
	              class="page__prev ${pagination.existPrev ? '' : 'disabled' }"
	            >
	              <a
	                class="page-link"
	                href="qna?page=${pagination.prevPage }"
	                data-page="${pagination.prevPage }"
	              >
	                <i class="fas fa-chevron-left"></i>
	              </a>
	            </li>
	
	            <c:forEach
	              var="num"
	              begin="${pagination.beginPage }"
	              end="${pagination.endPage }"
	            >
	              <li
	                class="page__num ${pagination.pageNo eq num ? 'active' : '' }"
	              >
	                <a class="page-link" href="qna?page=${num }" data-page="${num }">
	                  ${num }
	                </a>
	              </li>
	            </c:forEach>
	
	            <li
	              class="page__next ${pagination.existNext ? '' : 'disabled' }"
	            >
	              <a
	                class="page-link"
	                href="qna?page=${pagination.nextPage }"
	                data-page="${pagination.nextPage }"
	              >
	                <i class="fas fa-chevron-right"></i>
	              </a>
	            </li>
	          </ul>
	        </div>
	      </c:if>
	        
	     
	
    	<!-- qna Modal -->
		  <div class="modal fade" id="modal-creating-qna" tabindex="-1" aria-labelledby="출금신청" aria-hidden="true">
			<div class="modal-dialog modal-lg">
		      <article class="modal-content qna">
		        <p class="qna-modal__title">관리자 문의</p>
		        <form
		          id="qna-form"
		          method="post"
		          action="/mypage/qna-insert.do"
		        >
		          <input
		            type="hidden"
		            name="userNo"
		            value="${LOGIN_USER.no }"
		          />
		          <ul class="qna-modal__list">
		            <li class="qna-modal__item">
		              <label for="qnaCategory">카테고리</label>
		              <select
		                id="qnaCategory"
		                class="qna-modal__value"
		                name="category"
		              >
		                <option disabled selected value="">
		                  문의사유를 선택해 주세요
		                </option>
		                <option value="로그인">로그인</option>
		                <option value="회원정보변경">회원 정보 변경</option>
		                <option value="결제취소">결제취소</option>
		                <option value="호스트신고">호스트 신고</option>
		                <option value="불편사항">불편사항</option>
		                <option value="기타">기타</option>
		              </select>
		            </li>
		            <li class="qna-modal__item">
		              <label for="qnaTitle">제목</label>
		              <input
		                type="text"
		                class="qna-modal__value"
		                name="title"
		                id="qnaTitle"
		                placeholder="문의 제목을 입력해 주세요"
		              />
		            </li>
		            <li class="qna-modal__item">
		              <label for="qnaContent">내용</label>
		              <textarea
		                class="qna-modal__value"
		                name="content"
		                id="qnaContent"
		                placeholder="문의 내용을 입력해 주세요"
		              ></textarea>
		            </li>
		          </ul>
		          <button type="submit" class="btn__qna-modal">등록</button>
		        </form>
		      </article>
		    </div>
		  </div>
      
    </section>     
   
  </article>
</div>




<script type="text/javascript">

function creatingModal() {
	
	let qnaModal = new bootstrap.Modal(document.getElementById('modal-creating-qna'), {
		keyboard: false
	
	});
	qnaModal.show();
}


</script>

