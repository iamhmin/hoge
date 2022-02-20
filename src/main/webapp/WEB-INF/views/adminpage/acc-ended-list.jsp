<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>
<!-- 
 -->
<main id="main">
  <article id="admin-user">
  <form
      class="search-user__form only-child"
      id="form-search-userQnA"
      method="get"
      action="user-qna"
    >
      <input type="hidden" name="page" value="1" />
      <ul class="search-bar">
      	<li>
      		<select
          class="search__select accommoType host"
          name="accommoType"
          onchange="searchDeniedAccommos()"
        >
          	<option value="" selected disabled="disabled">숙소타입</option>
			   	<option value="호텔">호텔</option>
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
      	<li>
      		<select
          class="search__select grade"
          name="grade"
          onchange="searchDeniedAccommos()"
        >
          	<option value="" selected disabled="disabled">등급</option>
			<option value="BRONZE" ${'BRONZE' eq param.grade ? 'selected' : ''}>브론즈</option>
			<option value="SILVER" ${'SILVER' eq param.grade ? 'selected' : ''}>실버</option>
			<option value="GOLD" ${'GOLD' eq param.grade ? 'selected' : ''}>골드</option>
			<option value="PLATINUM" ${'PLATINUM' eq param.grade ? 'selected' : ''}>플래티넘</option>
			<option value="DIAMOND" ${'DIAMOND' eq param.grade ? 'selected' : ''}>다이아몬드</option>
        </select>
      	</li>
      	<li>
      		<select class="search__select" name="opt">
          	<option value="" selected disabled="disabled">검색조건</option>
          	<option value="주소">주소</option>
			<option value="호스트번호">호스트번호</option>
			<option value="회원번호">회원번호</option>
			<option value="숙소이름">숙소이름</option>
        </select>
      	</li>
      	<li>
      		<input type="text" class="search-user" name="value" value="" />
        <button type="button" class="btn__search" id="btn-search-userQnA" onclick="searchDeniedAccommos()">
          검색
        </button>
      	</li>
      </ul>
    </form>


	<table class="user-list-table">
		<colgroup>
	        <col style="width: 7%" />
	        <col style="width: 15%" />
	        <col style="width: 9%" />
	        <col style="width: 7%" />
	        <col style="width: 12%" />
	        <col style="width: 11%" />
	        <col style="width: 15%" />
	        <col style="width: 14%" />
	        <col style="width: 10%" />
      </colgroup>
      <thead>
        <tr>
          <th>no.</th>
          <th>호스트이름</th>
          <th>호스트등급</th>
          <th>유저번호</th>
          <th>연락처</th>
          <th>숙소타입</th>
          <th>숙소이름</th>
          <th>반려 사유</th>
          <th>등록일</th>
        </tr>
      </thead>
			<tbody id="dataSection">
				
			</tbody>
		</table>

		<!-- 페이지 내비게이션 표시 -->
		<div id="pagination">
			<ul id="paginationBox" class="pagination__list">

			</ul>
		</div>

 </article>
  <article id="admin-user">
  <form
      class="search-user__form only-child"
      id="form-search-userQnA"
      method="get"
      action="user-qna"
    >
      <input type="hidden" name="page" value="1" />
      <ul class="search-bar">
      	<li>
      		<select
          class="search__select accommoType host"
          name="accommoType1"
          onchange="searchEndedAccommos()"
        >
          	<option value="" selected disabled="disabled">숙소타입</option>
			   	<option value="호텔">호텔</option>
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
      	<li>
      		<select
          class="search__select grade"
          name="grade1"
          onchange="searchEndedAccommos()"
        >
          	<option value="" selected disabled="disabled">등급</option>
			<option value="BRONZE" ${'BRONZE' eq param.grade ? 'selected' : ''}>브론즈</option>
			<option value="SILVER" ${'SILVER' eq param.grade ? 'selected' : ''}>실버</option>
			<option value="GOLD" ${'GOLD' eq param.grade ? 'selected' : ''}>골드</option>
			<option value="PLATINUM" ${'PLATINUM' eq param.grade ? 'selected' : ''}>플래티넘</option>
			<option value="DIAMOND" ${'DIAMOND' eq param.grade ? 'selected' : ''}>다이아몬드</option>
        </select>
      	</li>
      	<li>
      		<select class="search__select" name="opt1">
          	<option value="" selected disabled="disabled">검색조건</option>
          	<option value="주소">주소</option>
			<option value="호스트번호">호스트번호</option>
			<option value="회원번호">회원번호</option>
			<option value="숙소이름">숙소이름</option>
        </select>
      	</li>
      	<li>
      		<input type="text" class="search-user" name="value1" value="" />
        <button type="button" class="btn__search" id="btn-search-userQnA" onclick="searchEndedAccommos()">
          검색
        </button>
      	</li>
      </ul>
    </form>


	<table class="user-list-table">
		<colgroup>
	        <col style="width: 7%" />
	        <col style="width: 15%" />
	        <col style="width: 9%" />
	        <col style="width: 7%" />
	        <col style="width: 12%" />
	        <col style="width: 11%" />
	        <col style="width: 15%" />
	        <col style="width: 14%" />
	        <col style="width: 10%" />
      </colgroup>
      <thead>
        <tr>
          <th>no.</th>
          <th>호스트이름</th>
          <th>호스트등급</th>
          <th>유저번호</th>
          <th>연락처</th>
          <th>숙소타입</th>
          <th>숙소이름</th>
          <th>종료 상세</th>
          <th>등록일</th>
        </tr>
      </thead>
			<tbody id="dataSection1">
				
			</tbody>
		</table>

		<!-- 페이지 내비게이션 표시 -->
		<div id="pagination">
			<ul id="paginationBox1" class="pagination__list">

			</ul>
		</div>

 </article>
  <article id="admin-user">
  <form
      class="search-user__form only-child"
      id="form-search-userQnA"
      method="get"
      action="user-qna"
    >
      <input type="hidden" name="page" value="1" />
      <ul class="search-bar">
      	<li>
      		<select
          class="search__select accommoType host"
          name="accommoType2"
          onchange="searchClosedAccommos()"
        >
          	<option value="" selected disabled="disabled">숙소타입</option>
			   	<option value="호텔">호텔</option>
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
      	<li>
      		<select
          class="search__select grade"
          name="grade2"
          onchange="searchClosedAccommos()"
        >
          	<option value="" selected disabled="disabled">등급</option>
			<option value="BRONZE" ${'BRONZE' eq param.grade ? 'selected' : ''}>브론즈</option>
			<option value="SILVER" ${'SILVER' eq param.grade ? 'selected' : ''}>실버</option>
			<option value="GOLD" ${'GOLD' eq param.grade ? 'selected' : ''}>골드</option>
			<option value="PLATINUM" ${'PLATINUM' eq param.grade ? 'selected' : ''}>플래티넘</option>
			<option value="DIAMOND" ${'DIAMOND' eq param.grade ? 'selected' : ''}>다이아몬드</option>
        </select>
      	</li>
      	<li>
      		<select class="search__select" name="opt2">
          	<option value="" selected disabled="disabled">검색조건</option>
          	<option value="주소">주소</option>
			<option value="호스트번호">호스트번호</option>
			<option value="회원번호">회원번호</option>
			<option value="숙소이름">숙소이름</option>
        </select>
      	</li>
      	<li>
      		<input type="text" class="search-user" name="value2" value="" />
        <button type="button" class="btn__search" id="btn-search-userQnA" onclick="searchClosedAccommos()">
          검색
        </button>
      	</li>
      </ul>
    </form>


	<table class="user-list-table">
		<colgroup>
	        <col style="width: 7%" />
	        <col style="width: 15%" />
	        <col style="width: 9%" />
	        <col style="width: 7%" />
	        <col style="width: 12%" />
	        <col style="width: 11%" />
	        <col style="width: 15%" />
	        <col style="width: 14%" />
	        <col style="width: 10%" />
      </colgroup>
      <thead>
        <tr>
          <th>no.</th>
          <th>호스트이름</th>
          <th>호스트등급</th>
          <th>유저번호</th>
          <th>연락처</th>
          <th>숙소타입</th>
          <th>숙소이름</th>
          <th>종료 상세</th>
          <th>등록일</th>
        </tr>
      </thead>
			<tbody id="dataSection2">
				
			</tbody>
		</table>

		<!-- 페이지 내비게이션 표시 -->
		<div id="pagination">
			<ul id="paginationBox2" class="pagination__list">

			</ul>
		</div>

 </article>
 </main>
 
 
<script type="text/javascript">
$(function(){
	
	activeMenu("숙소관리", "숙소승인 반려/종료");
	})

searchDeniedAccommos();
searchEndedAccommos();
searchClosedAccommos();

function searchDeniedAccommos(page) {
	var opt = $("select[name=opt]").val();
	var value = $.trim($(":input[name=value]").val());
	var accommoType =  $("select[name=accommoType]").val();
	var grade =  $("select[name=grade]").val();
	
			$.ajax({
				type: 'POST',
				url : "/admin/getDeniedAccommoList.do", //서비스 주소 
				data : { //서비스 처리에 필요한 인자값
					page : page,
					opt : opt,
					value : value,
					accommoType : accommoType,
					grade : grade
				},
				success : function(result) {
					const list = result['list'];
					const pagination = result['pagination'];
					var data = "";
					var block = "";

					console.log(pagination);
					console.log(list);
					// 테이블의 row를 삽입하는 부분
					for (var i = 0; i < list.length; i++) {
						data += "<tr>";
						data += "<td>" + list[i].no + "</td>";
						data += "<td>" + list[i].hostName + "</td>";
						data += "<td>" + list[i].gradeName + "</td>";
						data += "<td>" + list[i].userNo + "</td>";
						data += "<td>" + list[i].hostTel + "</td>";
						data += "<td>" + list[i].type + "</td>";
						data += "<td>" + list[i].name + "</td>";
						data += "<td>" + list[i].statusDetail + "</td>";
						data += "<td>" + list[i].registeredDate + "</td>";
						data += "</tr>";
					}
					$("#dataSection").html(data);

					// 이전버튼 활성화 여부를 결정하는 부분
					if (pagination['prevPage']) {
						block += "<li class='page-item'><a class='page-link' onclick='searchDeniedAccommos("
								+ (pagination['beginPage'] - 1)
								+ ")'> <i class='fas fa-chevron-left'></i> </a></li>";
					} else {
						block += "<li class='page-item disabled'><a class='page-link'> <i class='fas fa-chevron-left'></i> </a></li>";
					}

					// 번호를 표시하는 부분
					for (var i = pagination['beginPage']; i <= pagination['endPage']; i++) {
						if (page !== i) {
							block += "<li class='page-item'><a class='page-link' onclick='searchDeniedAccommos("
									+ i + ")'>" + (i) + "</a></li>";
						} else {
							block += "<li class='page-item disabled'><a class='page-link'>"
									+ (i) + "</a></li>";
						}
					}

					if (pagination['nextPage']) {
						block += "<li class='page-item'><a class='page-link' onclick='searchDeniedAccommos("
								+ (pagination['endPage'] + 1)
								+ ")'>  <i class='fas fa-chevron-right'></i> </a></li>";
					} else {
						block += "<li class='page-item disabled'><a class='page-link'> <i class='fas fa-chevron-right'></i> </a></li>";
					}
					
					$("#paginationBox").html(block);
				}
			})
}
function searchEndedAccommos(page) {
	var opt = $("select[name=opt1]").val();
	var value = $.trim($(":input[name=value1]").val());
	var accommoType =  $("select[name=accommoType1]").val();
	var grade =  $("select[name=grade1]").val();
	
			$.ajax({
				type: 'POST',
				url : "/admin/getEndedAccommoList.do", //서비스 주소 
				data : { //서비스 처리에 필요한 인자값
					page : page,
					opt : opt,
					value : value,
					accommoType : accommoType,
					grade : grade
				},
				success : function(result) {
					const list = result['list'];
					const pagination = result['pagination'];
					var data = "";
					var block = "";

					console.log(pagination);
					console.log(list);
					// 테이블의 row를 삽입하는 부분
					for (var i = 0; i < list.length; i++) {
						data += "<tr>";
						data += "<td>" + list[i].no + "</td>";
						data += "<td>" + list[i].hostName + "</td>";
						data += "<td>" + list[i].gradeName + "</td>";
						data += "<td>" + list[i].userNo + "</td>";
						data += "<td>" + list[i].hostTel + "</td>";
						data += "<td>" + list[i].type + "</td>";
						data += "<td>" + list[i].name + "</td>";
						data += "<td>" + list[i].statusDetail + "</td>";
						data += "<td>" + list[i].registeredDate + "</td>";
						data += "</tr>";
					}
					$("#dataSection1").html(data);

					// 이전버튼 활성화 여부를 결정하는 부분
					if (pagination['prevPage']) {
						block += "<li class='page-item'><a class='page-link' onclick='searchEndedAccommos("
								+ (pagination['beginPage'] - 1)
								+ ")'> <i class='fas fa-chevron-left'></i> </a></li>";
					} else {
						block += "<li class='page-item disabled'><a class='page-link'> <i class='fas fa-chevron-left'></i> </a></li>";
					}

					// 번호를 표시하는 부분
					for (var i = pagination['beginPage']; i <= pagination['endPage']; i++) {
						if (page !== i) {
							block += "<li class='page-item'><a class='page-link' onclick='searchEndedAccommos("
									+ i + ")'>" + (i) + "</a></li>";
						} else {
							block += "<li class='page-item disabled'><a class='page-link'>"
									+ (i) + "</a></li>";
						}
					}

					if (pagination['nextPage']) {
						block += "<li class='page-item'><a class='page-link' onclick='searchEndedAccommos("
								+ (pagination['endPage'] + 1)
								+ ")'> <i class='fas fa-chevron-right'></i> </a></li>";
					} else {
						block += "<li class='page-item disabled'><a class='page-link'> <i class='fas fa-chevron-right'></i> </a></li>";
					}
					
					$("#paginationBox1").html(block);
				}
			})
}
function searchClosedAccommos(page) {
	var opt = $("select[name=opt2]").val();
	var value = $.trim($(":input[name=value2]").val());
	var accommoType =  $("select[name=accommoType2]").val();
	var grade =  $("select[name=grade2]").val();
	
			$.ajax({
				type: 'POST',
				url : "/admin/getClosedAccommoList.do", //서비스 주소 
				data : { //서비스 처리에 필요한 인자값
					page : page,
					opt : opt,
					value : value,
					accommoType : accommoType,
					grade : grade
				},
				success : function(result) {
					const list = result['list'];
					const pagination = result['pagination'];
					var data = "";
					var block = "";

					console.log(pagination);
					console.log(list);
					// 테이블의 row를 삽입하는 부분
					for (var i = 0; i < list.length; i++) {
						data += "<tr>";
						data += "<td>" + list[i].no + "</td>";
						data += "<td>" + list[i].hostName + "</td>";
						data += "<td>" + list[i].gradeName + "</td>";
						data += "<td>" + list[i].userNo + "</td>";
						data += "<td>" + list[i].hostTel + "</td>";
						data += "<td>" + list[i].type + "</td>";
						data += "<td>" + list[i].name + "</td>";
						data += "<td>" + list[i].statusDetail + "</td>";
						data += "<td>" + list[i].registeredDate + "</td>";
						data += "</tr>";
					}
					$("#dataSection2").html(data);

					// 이전버튼 활성화 여부를 결정하는 부분
					if (pagination['prevPage']) {
						block += "<li class='page-item'><a class='page-link' onclick='searchClosedAccommos("
								+ (pagination['beginPage'] - 1)
								+ ")'> <i class='fas fa-chevron-left'></i> </a></li>";
					} else {
						block += "<li class='page-item disabled'><a class='page-link'> <i class='fas fa-chevron-left'></i> </a></li>";
					}

					// 번호를 표시하는 부분
					for (var i = pagination['beginPage']; i <= pagination['endPage']; i++) {
						if (page !== i) {
							block += "<li class='page-item'><a class='page-link' onclick='searchClosedAccommos("
									+ i + ")'>" + (i) + "</a></li>";
						} else {
							block += "<li class='page-item disabled'><a class='page-link'>"
									+ (i) + "</a></li>";
						}
					}

					if (pagination['nextPage']) {
						block += "<li class='page-item'><a class='page-link' onclick='searchClosedAccommos("
								+ (pagination['endPage'] + 1)
								+ ")'>  <i class='fas fa-chevron-right'></i> </a></li>";
					} else {
						block += "<li class='page-item disabled'><a class='page-link'> <i class='fas fa-chevron-right'></i> </a></li>";
					}
					
					$("#paginationBox2").html(block);
				}
			})
}





</script>