<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>

 <main id="main">
      <article id="admin-user">
        <form class="search-user__form" id="form-search-user" method="get" action="user-list">
          <input type="hidden" name="page" value="1" />
          <div class="search-radio">
            <input
              type="radio"
              class="user-check"
              id="deleted-N"
              name="deleted"
              value="N"
              checked
            />
            <label for="deleted-N" class="user-check__title"
              >현재 이용중인 회원</label
            >
            <input type="radio" class="user-check" id="deleted-Y" name="deleted"
            value="Y" ${'Y' eq param.deleted ? 'checked' : ''} />
            <label for="deleted-Y" class="user-check__title">탈퇴한 회원</label>
          </div>
          
          <ul class="search-bar">
	          <li>
		        <select class="search__select" name="opt">
					<option value="" selected disabled="disabled">검색조건</option>
					<option value="이름" ${'이름' eq param.opt ? 'selected' : ''}>이름</option>
					<option value="전화번호" ${'전화번호' eq param.opt ? 'selected' : ''}>전화번호</option>
					<option value="아이디" ${'아이디' eq param.opt ? 'selected' : ''}>아이디</option>
					<option value="이메일" ${'이메일' eq param.opt ? 'selected' : ''}>이메일</option>
				</select>
	          </li>
	          <li>
		        <input
		              type="text"
		              class="search-user"
		              name="value"
		              value="${param.value }"
		          />
		          <button type="button" class="btn__search" id="btn-search-user">검색</button>
	          </li>
          </ul>
        </form>
		<table class="user-list-table">
			<colgroup>
				<col style="width: 8%;">
				<col style="width: 11%;">
				<col style="width: 8%;">
				<col style="width: 13%;">
				<col style="width: 16%;">
				<col style="width: 6%;">
				<col style="width: 7%;">
				<col style="width: 10%;">
				<col style="width: 7%;">
				<col style="width: 7%;">
				<col style="width: 7%;">
			</colgroup>
			<thead>
				<tr>
					<th>회원번호</th>
					<th>아이디</th>
					<th>이름</th>
					<th>연락처</th>
					<th>이메일</th>
					<th>성별</th>
					<th>포인트</th>
					<th>가입일</th>
					<th>호스팅여부</th>
					<th>탈퇴여부</th>
					<th>신고횟수</th>
				</tr>
			</thead>
			<tbody>
			<c:choose>
			<c:when test="${empty users }">
				<tr>
					<td class="text-center" colspan="6">사용자 없음.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach var="user" items="${users }" varStatus="loop">
				<tr>
					<td>${user.no }</td>
					<td>${user.id }</td>
					<td>${user.name }</td>
				<c:if test="${empty user.tel}">	
					<td> - </td>
				</c:if>	
				<c:if test="${not empty user.tel}">	
					<td>${user.tel }</td>
				</c:if>	
				<c:if test="${empty user.email}">	
					<td> - </td>
				</c:if>	
				<c:if test="${not empty user.email}">	
					<td>${user.email }</td>
				</c:if>	
					<td>${user.gender == 'female' ? '여' : '남'}</td>
					<td><fmt:formatNumber value="${user.pnt }" pattern="#,###" /></td>
					<td><fmt:formatDate value="${user.registeredDate }" pattern="yyyy.MM.dd"/></td>
					<td>${user.isHost == 'N' ?  'X' :'O'}</td>
					<td>${user.deleted == 'N' ? '이용중' : '탈퇴'}</td>
					<td>${user.reportedCount }</td>
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
					<a 
						class="page-link" 
						href="user-list?page=${pagination.prevPage }" 
						data-page="${pagination.prevPage }"
					>
						<i class="fas fa-chevron-left"></i>
					</a>
				</li>

				<c:forEach var="num" begin="${pagination.beginPage }" end="${pagination.endPage }">
					<li class="page__num ${pagination.pageNo eq num ? 'active' : '' }">
						<a 
							class="page-link" 
							href="user-list?page=${num }" 
							data-page="${num }"
						>
						${num }
						</a>
					</li>	    			
				</c:forEach>

				<li class="page__next ${pagination.existNext ? '' : 'disabled' }">
					<a 
						class="page-link" 
						href="user-list?page=${pagination.nextPage }" 
						data-page="${pagination.nextPage }"
					>
						<i class="fas fa-chevron-right"></i>
					</a>
				</li>
			</ul>
		</div>
		
		</c:if>	
      
      </article>
    </main>

<script type="text/javascript">
/* 폼에서 onsubmit 이벤트가 발생해서 폼이 제출될 때 실행될 이벤트핸들러 함수를 등록한다.
$("#form-search-book").submit(function() {	// form에서 onsubmit이벤트가 발생했을 때, 반환값에 따라서 form 입력값이 서버로 제출되거나 제출되지 않을 수 있다.
	var opt = $("select[name=opt]").val();
	var value = $.trim($(":input[name=value]").val());
	
	if (opt && value) {
		return true;		// 이벤트핸들러 함수가 true를 반환하면 form의 입력값이 서버로 제출된다.
	}
	
	alert("검색조건 혹은 검색어를 입력하세요");
	return false;			// 이벤트핸들러 함수가 false를 반환하면 form의 입력값이 서버로 제출되지 않는다.
});
*/
$(function(){
	
	activeMenu("회원관리", "회원리스트");
	})
// 검색버튼을 클릭했을 때 실행될 이벤트핸들러 함수를 등록한다.
$("#btn-search-user").click(function() {
	// 검색옵션값과 입력값을 조회한다.
	var opt = $("select[name=opt]").val();
	var value = $.trim($(":input[name=value]").val());
	
	// 검색옵션값과 입력값이 모두 존재하면 페이지번호를 1로 설정하고 폼에서 onsubmit 이벤트를 발생시켜서 폼 입력값이 서버로 제출되게 한다.
	if (opt && value) {
		$(":input[name=page]").val("1");
		$("#form-search-user").trigger("submit");
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
	$("#form-search-user").trigger("submit");
})


   $("input:radio[name=deleted]").click(function()
    {
	   $("#form-search-user").trigger("submit");
    })




</script>