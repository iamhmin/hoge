<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>
<!-- 
 -->
<main id="main">
  <article id="admin-user">
  <form
      class="search-user__form"
      id="form-search-userQnA"
      method="get"
      action="user-qna"
    >
      <input type="hidden" name="page" value="1" />
      <div class="search-radio">
        <input
          type="radio"
          class="user-check"
          id="answered-N"
          name="answered"
          value="N"
          checked
        />
        <label for="answered-N" class="user-check__title"
          >답변 미완료된 질문</label
        >
        <input type="radio" class="user-check" id="answered-Y"
        name="answered" value="Y"${'Y' eq param.answered ? 'checked' : ''}
        />
        <label for="answered-Y" class="user-check__title"
          >답변 완료된 질문</label
        >
      </div>
      <ul class="search-bar">
      	<li>
      		<select
          class="search__select category"
          name="category"
          onchange="searchQnAs()"
        >
          	<option value="" selected disabled="disabled">카테고리</option>
			<option value="로그인" ${'로그인' eq param.category ? 'selected' : ''}>로그인</option>
			<option value="회원정보변경" ${'회원정보변경' eq param.category ? 'selected' : ''}>회원정보변경</option>
			<option value="결제취소" ${'결제취소' eq param.opt ? 'selected' : ''}> 결제취소</option>
			<option value="호스트신고" ${'호스트신고' eq param.category ? 'selected' : ''}>호스트신고</option>
			<option value="불편사항" ${'불편사항' eq param.category ? 'selected' : ''}>불편사항</option>
			<option value="기타" ${'기타' eq param.category ? 'selected' : ''}>기타</option>
        </select>
      	</li>
      	<li>
      		<select class="search__select" name="opt">
          	<option value="" selected disabled="disabled">검색조건</option>
          	<option value="회원번호" ${'회원번호' eq param.opt ? 'selected' : ''}>회원번호</option>
			<option value="아이디" ${'아이디' eq param.opt ? 'selected' : ''}>아이디</option>
			<option value="이름" ${'이름' eq param.opt ? 'selected' : ''}>이름</option>
			<option value="제목" ${'제목' eq param.opt ? 'selected' : ''}>제목</option>
			<option value="내용" ${'내용' eq param.opt ? 'selected' : ''}>내용</option>
        </select>
      	</li>
      	<li>
      		<input type="text" class="search-user" name="value" value="${param.value }" />
        <button type="button" class="btn__search" id="btn-search-userQnA">
          검색
        </button>
      	</li>
      </ul>
    </form>


	<table class="user-list-table">
		<colgroup>
	        <col style="width: 6%" />
	        <col style="width: 7%" />
	        <col style="width: 9%" />
	        <col style="width: 7%" />
	        <col style="width: 10%" />
	        <col style="width: 20%" />
	        <col style="width: 25%" />
	        <col style="width: 8%" />
	        <col style="width: 8%" />
      </colgroup>
      <thead>
        <tr>
          <th>no.</th>
          <th>회원번호</th>
          <th>아이디</th>
          <th>이름</th>
          <th>카테고리</th>
          <th>제목</th>
          <th>내용</th>
          <th>질문일</th>
          <th>답변</th>
        </tr>
      </thead>
			<tbody>
				<c:choose>
					<c:when test="${empty userQnaList }">
						<tr>
							<td style="height:200px;" colspan="9">등록된 질문이 없습니다</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="userQna" items="${userQnaList }" varStatus="loop">
							<tr>
								<td>${userQna.questionNo }</td>
								<td>${userQna.userNo }</td>
								<td>${userQna.userId }</td>
								<td>${userQna.userName }</td>
								<td>${userQna.category }</td>
								<td class="text-overflow">${userQna.title }</td>
								<td class="text-overflow">${userQna.content }</td>
								<td><fmt:formatDate value="${userQna.questionDate }" pattern="yyyy.MM.dd"/></td>
								
								<c:choose>
								<c:when test="${userQna.answered eq 'N'}">
									<td>
										<button class="btn__modal" id="creatingmodal" 
										onclick="creatingModal(${userQna.questionNo })">
											답변 대기
										</button>
									</td>
								</c:when>
								<c:otherwise>
									<td>
										<button class="btn__modal" id="creatingmodimodal" 
										onclick="creatingModal(${userQna.questionNo })">
											답변 수정
										</button>
									</td>
								</c:otherwise>
								</c:choose>
								
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>

		<!-- 페이지 내비게이션 표시 -->
	<c:if test="${pagination.totalRecords gt 0 }">
		<div id="pagination">
  			<ul class="pagination__list">
    			<li class="page__prev ${pagination.existPrev ? '' : 'disabled' }">
      				<a class="page-link" href="user-qna?page=${pagination.prevPage }" data-page="${pagination.prevPage }">
      				 <i class="fas fa-chevron-left"></i>
      				</a>
    			</li>

    			<c:forEach var="num" begin="${pagination.beginPage }" end="${pagination.endPage }">
	    			<li class="page__num ${pagination.pageNo eq num ? 'active' : '' }">
	    				<a class="page-link" href="user-qna?page=${num }" data-page="${num }">${num }</a>
	    			</li>	    			
    			</c:forEach>

    			<li class="page__next ${pagination.existNext ? '' : 'disabled' }">
      				<a class="page-link" href="user-qna?page=${pagination.nextPage }" data-page="${pagination.nextPage }">
      				 <i class="fas fa-chevron-right"></i>
      				</a>
    			</li>
  			</ul>
		</div>
	</c:if>		

<!-- 모달창 -->
	<div class="modal fade" id="modal-answering" tabindex="-1" aria-labelledby="문의상세" aria-hidden="true">
  		<div class="modal-dialog modal-lg">
    		<article class="modal-content">
      			<header class="modal-title">
	              <p class="modal__title">문의 상세</p>
	            </header>
      			 <main class="modal-main">
      				<p class="questionDate">
	                	질문일<span class="qna-date" id="questionDate"></span>
              		</p>
					
					<table class="user-list-table">
		                <colgroup>
		                  <col style="width: 20%" />
		                  <col style="width: 20%" />
		                  <col style="width: 20%" />
		                  <col style="width: 20%" />
		                  <col style="width: 20%" />
		                </colgroup>
		                <thead>
		                  <tr>
		                    <th>no.</th>
		                    <th>회원번호</th>
		                    <th>아이디</th>
		                    <th>이름</th>
		                    <th>카테고리</th>
		                  </tr>
		                </thead>
		                <tbody>
		                  <tr>
		                    <td id="questionNo"></td>
		                    <td id="userNo"></td>
		                    <td id="userId"></td>
		                    <td id="userName"></td>
		                    <td id="category"></td>
		                  </tr>
		                </tbody>
		              </table>
				  <div class="modal-question">
	                <p class="question__title" id="title">
	                </p>
	                <p class="question__content" id="content">
	                </p>
	              </div>
				 <form
	                id="answer-form"
	                method="post"
	                action="/admin/answer-insert-user-qna"
	              >
	              <input type="hidden" name="questionNo" value="" />
                <p class="questionDate" id="modified">
                  
                </p>
                <div class="modal-answer">
                  <p class="answer__title">답변</p>
                  <textarea
                    class="answer__textarea"
                    name="answerContent"
                    id="answerContent"
                  ></textarea>
                </div>
                <div class="answer-btn">
                  <button
                    type="button"
                    class="btn__answer"
                    id="answer-btn"
                    data-bs-dismiss="modal"
                  >
                  </button>
                </div>
              </form>
			</main>	
   		  </article>
  		</div>
	</div>
 </article>
 </main>
 
 
<script type="text/javascript">

$(function(){
	
	activeMenu("회원관리", "회원문의");
	})

function creatingModal(no) {
	
	let answeringModal = new bootstrap.Modal(document.getElementById('modal-answering'), {
		keyboard: false
	
	});
	
	
	$.getJSON('/admin/user-qna-answer.do', {no:no}, function(QnaDto) {
	
			$('#questionNo').text(QnaDto.questionNo);
			$("#userNo").text(QnaDto.userNo);
			$("#userName").text(QnaDto.userName);
			$("#userId").text(QnaDto.userId);
			$("#category").text(QnaDto.category);
			$("#title").text(QnaDto.title);
			$("#questionDate").text(QnaDto.questionDate);
			$("#content").text(QnaDto.content);
			$('input[name=questionNo]').attr('value', QnaDto.questionNo);
			
			
			if (QnaDto.answerContent!=null) {				
			$("#answerContent").text(QnaDto.answerContent);
			$("#answer-btn").text('답변 수정');
			} else {
				$("#answer-btn").text('답변 등록');
			}
			if (QnaDto.answerModified=='Y') {				
				$("#modified").text('답변 수정일  ' + QnaDto.answerUpdateDate);
			}
		
	});
	
	answeringModal.show();
}


$("#answer-btn").click(function() {
	
//검색옵션값과 입력값을 조회한다.
var questionNo = $(":input[name=questionNo]").val();
var value = $(":input[name=answerContent]").val();

console.log(questionNo);
console.log(value);
		$("#answer-form").trigger("submit");
	
});

function searchQnAs() {
	$("#form-search-userQnA").trigger("submit");
}

// 검색버튼을 클릭했을 때 실행될 이벤트핸들러 함수를 등록한다.
$("#btn-search-userQnA").click(function() {
	// 검색옵션값과 입력값을 조회한다.
	var opt = $("select[name=opt]").val();
	var value = $.trim($(":input[name=value]").val());
	
	// 검색옵션값과 입력값이 모두 존재하면 페이지번호를 1로 설정하고 폼에서 onsubmit 이벤트를 발생시켜서 폼 입력값이 서버로 제출되게 한다.
	if (opt && value) {
		$(":input[name=page]").val("1");
		$("#form-search-userQnA").trigger("submit");
	} else {
		alert("검색조건 혹은 검색어를 입력하세요");					
	}
	
});

// 페이지내비게이션의 링크를 클릭했을 때 실행될 이벤트핸들러 함수를 등록한다.
$(".pagination a").click(function(event) {
	event.preventDefault();
	// 클릭한 페이지내비게이션의 페이지번호 조회하기
	var pageNo = $(this).attr("data-page");
	// 검색폼의 히든필드에 클릭한 페이지내비게이션의 페이지번호 설정
	$(":input[name=page]").val(pageNo);
	
	// 검색폼에 onsubmit 이벤트 발생시키기
	$("#form-search-userQnA").trigger("submit");
})


   $("input:radio[name=answered]").click(function()
    {
	   $("#form-search-userQnA").trigger("submit");
    })




</script>