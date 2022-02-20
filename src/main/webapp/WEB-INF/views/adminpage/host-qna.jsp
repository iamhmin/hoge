<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>


 <main id="main">
    <article id="admin-user">
      <form
        class="search-user__form"
        id="form-search-hostQnA"
        method="get"
        action="host-qna"
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
				<option value="정산" ${'정산' eq param.category ? 'selected' : ''}>정산</option>
				<option value="호스트승인" ${'호스트승인' eq param.category ? 'selected' : ''}>호스트승인</option>
				<option value="호스트정보변경" ${'호스트정보변경' eq param.opt ? 'selected' : ''}>호스트정보변경</option>
				<option value="호스트탈퇴" ${'호스트탈퇴' eq param.category ? 'selected' : ''}>호스트탈퇴</option>
				<option value="게스트신고" ${'게스트신고' eq param.category ? 'selected' : ''}>호스트신고</option>
				<option value="불편사항" ${'불편사항' eq param.category ? 'selected' : ''}>불편사항</option>
				<option value="기타" ${'기타' eq param.category ? 'selected' : ''}>기타</option>
            </select>
          </li>
          <li>
            <select
              class="search__select host"
              name="grade"
              onchange="searchQnAs()"
            >
              	<option value="" selected disabled="disabled">호스트등급</option>
				<option value="BRONZE" ${'BRONZE' eq param.grade ? 'selected' : ''}>브론즈</option>
				<option value="SILVER" ${'SILVER' eq param.grade ? 'selected' : ''}>실버</option>
				<option value="GOLD" ${'GOLD' eq param.grade ? 'selected' : ''}>골드</option>
				<option value="PLATINUM" ${'PLATINUM' eq param.grade ? 'selected' : ''}>플래티넘</option>
				<option value="DIAMOND" ${'DIAMOND' eq param.grade ? 'selected' : ''}>다이아몬드</option>
            </select>
          </li>
          <li>
            <select
              class="search__select"
              name="approval"
              onchange="searchQnAs()"
            >
             	<option value="" selected disabled="disabled">승인상태</option>
				<option value="W" ${'W' eq param.approval ? 'selected' : ''}>승인대기</option>
				<option value="Y" ${'Y' eq param.approval ? 'selected' : ''}>승인완료</option>
				<option value="N" ${'N' eq param.approval ? 'selected' : ''}>승인반려</option>
				<option value="D" ${'D' eq param.approval ? 'selected' : ''}>호스팅종료</option>
				<option value="R" ${'R' eq param.approval ? 'selected' : ''}>강제종료</option>
            </select>
          </li>
          <li>
            <select
              class="search__select host"
              name="hostType"
              onchange="searchQnAs()"
            >
              	<option value="" selected disabled="disabled">
                호스트타입
              	</option>
              	<option value="1" ${1 eq param.hostType ? 'selected' : ''}>숙소</option>
				<option value="2" ${2 eq param.hostType ? 'selected' : ''}>체험</option>
            </select>
          </li>
          <li>
            <select class="search__select" name="opt">
              	<option value="" selected disabled="disabled">검색조건</option>
				<option value="회원번호" ${'회원번호' eq param.opt ? 'selected' : ''}>회원번호</option>
				<option value="호스트번호" ${'호스트번호' eq param.opt ? 'selected' : ''}>호스트번호</option>
				<option value="호스트이름" ${'호스트이름' eq param.opt ? 'selected' : ''}>호스트이름</option>
				<option value="제목" ${'제목' eq param.opt ? 'selected' : ''}>제목</option>
				<option value="내용" ${'내용' eq param.opt ? 'selected' : ''}>내용</option>
            </select>
          </li>
          <li>
            <input type="text" class="search-user" name="value" value="" />
            <button type="button" class="btn__search" id="btn-search-userQnA">
              검색
            </button>
          </li>
        </ul>
      </form>			
 			
 			
 		<table class="user-list-table">
			<colgroup>
            <col style="width: 5%" />
            <col style="width: 5%" />
            <col style="width: 6%" />
            <col style="width: 16%" />
            <col style="width: 6%" />
            <col style="width: 8%" />
            <col style="width: 8%" />
            <col style="width: 13%" />
            <col style="width: 18%" />
            <col style="width: 7%" />
            <col style="width: 8%" />
          </colgroup>
          <thead>
            <tr>
              <th>no.</th>
              <th>회원번호</th>
              <th>호스트번호</th>
              <th>호스트이름</th>
              <th>호스트타입</th>
              <th>승인상태</th>
              <th>카테고리</th>
              <th>제목</th>
              <th>내용</th>
              <th>질문일</th>
              <th>답변</th>
            </tr>
          </thead>


			<tbody>
				<c:choose>
					<c:when test="${empty hostQnaList }">
						<tr>
							<td style="height:200px;" colspan="11">등록된 질문이 없습니다</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="hostQna" items="${hostQnaList }" varStatus="loop">
							<tr class="text-middle">
								<td>${hostQna.questionNo }</td>
								<td>${hostQna.userNo }</td>
								<td>${hostQna.hostNo }</td>
								<td class="text-overflow">${hostQna.hostName }</td>
								<c:choose>
									<c:when test="${hostQna.hostType eq '1'}">
										<td>숙소</td>
									</c:when>
									<c:otherwise>
										<td>체험</td>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${hostQna.hostStatus eq 'W'}">
										<td>승인대기</td>
									</c:when>
									<c:when test="${hostQna.hostStatus eq 'Y'}">
										<td>승인완료</td>
									</c:when>
									<c:when test="${hostQna.hostStatus eq 'N'}">
										<td>승인반려</td>
									</c:when>
									<c:when test="${hostQna.hostStatus eq 'D'}">
										<td>호스팅종료</td>
									</c:when>
									<c:when test="${hostQna.hostStatus eq 'R'}">
										<td>강제종료</td>
									</c:when>
								</c:choose>
								<td>${hostQna.category }</td>
								<td class="text-overflow">${hostQna.title }</td>
								<td class="text-overflow">${hostQna.content }</td>
								<td><fmt:formatDate value="${hostQna.questionDate }" pattern="yyyy.MM.dd"/></td>
									<c:choose>
									<c:when test="${hostQna.answered eq 'N'}">
										<td>
											<button class="btn__modal" id="creatingmodal" 
											onclick="creatingModal(${hostQna.questionNo })">
												답변 대기
											</button>
										</td>
									</c:when>
									<c:otherwise>
										<td>
											<button class="btn__modal" id="creatingmodimodal" 
											onclick="creatingModal(${hostQna.questionNo })">
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
	      				<a class="page-link" href="host-qna?page=${pagination.prevPage }" data-page="${pagination.prevPage }">
	      				 <i class="fas fa-chevron-left"></i>
	      				</a>
	    			</li>
	
	    			<c:forEach var="num" begin="${pagination.beginPage }" end="${pagination.endPage }">
		    			<li class="page__num ${pagination.pageNo eq num ? 'active' : '' }">
		    				<a class="page-link" href="host-qna?page=${num }" data-page="${num }">${num }</a>
		    			</li>	    			
	    			</c:forEach>
	
	    			<li class="page__next ${pagination.existNext ? '' : 'disabled' }">
	      				<a class="page-link" href="host-qna?page=${pagination.nextPage }" data-page="${pagination.nextPage }">
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
		              <span>질문일</span
		              ><span class="qna-date" id="questionDate"></span>
		            </p>
		            <div class="host-info">
		              <p class="host__type" id="hostType"></p>
		              <p class="host__name" id="hostName"></p>
		            </div>
		            <table class="user-list-table">
		              <colgroup>
		                <col style="width: 12%" />
		                <col style="width: 13%" />
		                <col style="width: 15%" />
		                <col style="width: 15%" />
		                <col style="width: 15%" />
		                <col style="width: 15%" />
		                <col style="width: 15%" />
		              </colgroup>
		              <thead>
		                <tr>
		                  <th>no.</th>
		                  <th>회원번호</th>
		                  <th>호스트번호</th>
		                  <th>승인상태</th>
		                  <th>승인디테일</th>
		                  <th>호스트등급</th>
		                  <th>카테고리</th>
		                </tr>
		              </thead>
		              <tbody>
		                <tr>
		                  <td id="questionNo"></td>
		                  <td id="userNo"></td>
		                  <td id="hostNo"></td>
		                  <td id="hostStatus"></td>
		                  <td id="statusDetail"></td>
		                  <td id="gradeName"></td>
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
		              action="/admin/answer-insert-host-qna"
		            >
		              <input type="hidden" name="questionNo" value="" />
		              <p class="questionDate" id="modified"></p>
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
		                  답변 등록
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
	
	activeMenu("회원관리", "호스트문의");
	})

function creatingModal(no) {
	
	let answeringModal = new bootstrap.Modal(document.getElementById('modal-answering'), {
		keyboard: false
	
	});
	
	$.getJSON('/admin/host-qna-answer.do', {no:no}, function(QnaDto) {
	
			$('#questionNo').text(QnaDto.questionNo);
			$("#userNo").text(QnaDto.userNo);
			$("#hostNo").text(QnaDto.hostNo);
			$("#hostName").text(QnaDto.hostName);
			
			if (QnaDto.hostType == 1) {
			$("#hostType").text("숙소");
			}
			if (QnaDto.hostType == 2) {
			$("#hostType").text("체험");
			}
			if (QnaDto.hostStatus == 'W') {
			$("#hostStatus").text("승인대기");
			}
			if (QnaDto.hostStatus == 'Y') {
			$("#hostStatus").text("승인");
			}
			if (QnaDto.hostStatus == 'N') {
			$("#hostStatus").text("승인반려");
			}
			if (QnaDto.hostStatus == 'D') {
			$("#hostStatus").text("호스팅종료");
			}
			if (QnaDto.hostStatus == 'R') {
			$("#hostStatus").text("강제종료");
			}
			
			$("#statusDetail").text(QnaDto.statusDetail);
			$("#gradeName").text(QnaDto.gradeName);
			
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
				$("#modified").text( '답변수정일: ' + QnaDto.answerUpdateDate);
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
	$("#form-search-hostQnA").trigger("submit");
}



$("#btn-search-hostQnA").click(function() {
	// 검색옵션값과 입력값을 조회한다.
	var opt = $("select[name=opt]").val();
	var value = $.trim($(":input[name=value]").val());
	
	// 검색옵션값과 입력값이 모두 존재하면 페이지번호를 1로 설정하고 폼에서 onsubmit 이벤트를 발생시켜서 폼 입력값이 서버로 제출되게 한다.
	if (opt && value) {
		$(":input[name=page]").val("1");
		$("#form-search-hostQnA").trigger("submit");
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
	$("#form-search-hostQnA").trigger("submit");
})


   $("input:radio[name=answered]").click(function()
    {
	   $("#form-search-hostQnA").trigger("submit");
    })


</script>