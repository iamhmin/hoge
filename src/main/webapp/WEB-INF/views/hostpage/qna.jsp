<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../common/tags.jsp" %>
<main id="main">
<c:set var="menu" value="qna"/>
  <article class="host-qna">
    <section class="host-qna__frequent">
      <div class="content-title">자주 묻는 질문</div>
      <article class="frequent-qna">
      
    <!-- 자주묻는 질문 -->
        <div class="frequent-qna__box">
          <div class="qna">
            <p class="qna-title">대금 수령까지 걸리는 시간</p>
            <p class="qna-content">
              HOGE는 게스트가 숙소에 체크인한 후 24시간이 지나면 호스트에게
              예약 대금을 지급합니다. 단, 대금이 실제로 계좌에 입금되기까지
              걸리는 시간은 은행과 대금 수령 방법에 따라 다릅니다.
            </p>
          </div>
          <div class="qna">
            <p class="qna-title">체험 반복 회차 일정 잡기</p>
            <p class="qna-content">
              달력에서 체험의 여러 회차를 한 번에 추가∙수정∙삭제하는 방법을
              확인해보세요. 더 많이 할수록 더 많은 것을 얻을 수 있습니다.
            </p>
          </div>
        </div>
        <div class="frequent-qna__box">
          <div class="qna">
            <p class="qna-title">프라이빗 예약을 위한 체험 호스팅</p>
            <p class="qna-content">
              게스트에게 프라이빗 그룹으로 체험을 예약하고 가족 및 친구들과
              함께 예약할 수 있는 기회를 주세요. 게스트가 재미있게 놀 수
              있는 좋은 방법이며, 최저 요금을 보장할 수 있습니다.
            </p>
          </div>
          <div class="qna">
            <p class="qna-title">HOGE커버를 통해 보호받기</p>
            <p class="qna-content">
              HOGE커버는 1백만 달러의 손해보상, 1백만 달러의 책임보험을
              제공하며 호스팅 전반에 걸쳐 호스트를 보호해주는
              프로그램입니다.
            </p>
          </div>
        </div>
      </article>
      <article class="my-qna">
     
        <c:choose>
		  <c:when test="${empty qnaList }">
		    <div class="empty-host-qna">작성된 QnA가 없습니다.</div>
		  </c:when>
		
		<c:otherwise>
        <article class="my-qna__box">
          <p class="qna-count">총 ${totalRecords }건의 상담내역이 있습니다.</p>
          <div class="details-box">
            
            <c:forEach var="qna" items="${qnaList }" varStatus="loop">
            <details class="my-qna__list">
              <summary class="my-qna__head">
                <div class="host-qna__category">${qna.category }</div>
                <div class="host-qna__title text-overflow">
                  ${qna.title }
                </div>
                <div class="host-qna__date">
                  <fmt:formatDate value="${qna.questionDate }" pattern="yyyy.MM.dd"/>
                </div>
                <div class="host-qna__answered">
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
                href="qna?page=${pagination.prevPage }&hostNo=${savedHost.no }&hostingType=${savedHost.hostingType }"
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
                <a class="page-link" href="qna?page=${num }&hostNo=${savedHost.no }&hostingType=${savedHost.hostingType }" data-page="${num }">
                  ${num }
                </a>
              </li>
            </c:forEach>

            <li
              class="page__next ${pagination.existNext ? '' : 'disabled' }"
            >
              <a
                class="page-link"
                href="qna?page=${pagination.nextPage }&hostNo=${savedHost.no }&hostingType=${savedHost.hostingType }"
                data-page="${pagination.nextPage }"
              >
                <i class="fas fa-chevron-right"></i>
              </a>
            </li>
          </ul>
        </div>
        </c:if>	
      </article>
    </section>
    
  <!-- 관리자 문의 폼 -->  
    <section class="host-qna__question">
      <article class="host-qna__form">
        <p class="form__title">관리자 문의</p>
        <form id="qna-form" method="post" action="/host/qna-insert.do">
          <input type="hidden" name="hostNo" value=${savedHost.no }>
		  <input type="hidden" name="hostingType" value=${savedHost.hostingType }>
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
                <option value="정산">정산</option>
                <option value="호스트정보변경">호스트 정보 변경</option>
                <option value="호스트탈퇴">호스트 탈퇴</option>
                <option value="게스트신고">게스트 신고</option>
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
                class="qna-modal__value host"
                name="content"
                id="qnaContent"
                placeholder="문의 내용을 입력해 주세요"
              ></textarea>
            </li>
          </ul>
          <button type="submit" class="btn__qna-modal">등록</button>
        </form>
      </article>
    </section>
  </article>
</main>


<script type="text/javascript">
activeMenu('관리자문의');

</script>
