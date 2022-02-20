<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>
<!-- 
 -->
<main id="main">
  <article id="admin-user">
  <h1 class="section__title">숙소 할인 프로모션 (승인 대기)</h1>
  <form
      class="search-user__form review"
      id="form-search-userQnA"
      method="get"
      action="user-qna"
    >
      <ul class="withdrawal-bar">
      	<li>
              <button
                type="button"
                class="btn__approval"
                id="btn-acc-discount-approval-submit"
                onclick=""
              >
                선택 승인
              </button>
            </li>
      	<li>
      	<li>
              <button
                type="button"
                class="btn__approval"
                id="btn-acc-discount-return-submit"
                onclick=""
              >
                선택 반려
              </button>
            </li>
      	<li>
      		<select
          class="search__select accommoType"
          name="order"
          onchange="searchAccDiscountPromotions()"
        >
          	<option value="" selected disabled="disabled">정렬순</option>
			   	<option value="최근등록일">최근등록일순</option>
                <option value="마감일">마감일순</option>
        </select>
      	</li>
      	<li>
      		<select class="search__select" name="opt">
          	<option value="" selected disabled="disabled">검색조건</option>
          	<option value="숙소이름">숙소이름</option>
			<option value="숙소번호">숙소번호</option>
        </select>
      	</li>
      	<li>
      		<input type="text" class="search-user" name="value" value="" />
        <button type="button" class="btn__search" id="btn-search-userQnA" onclick="searchAccDiscountPromotions()">
          검색
        </button>
      	</li>
      </ul>
    </form>
	<form class="" id="accDiscount-approval" method="post" action="accDiscount-approval">
	<table class="user-list-table">
		<colgroup>
	        <col style="width: 5%" />
	        <col style="width: 5%" />
	        <col style="width: 5%" />
	        <col style="width: 10%" />
	        <col style="width: 10%" />
	        <col style="width: 10%" />
	        <col style="width: 10%" />
	        <col style="width: 10%" />
      </colgroup>
      <thead>
        <tr>
        <th>
         <input
                    type="checkbox"
                    name="accDiscount-approval"
                    class="selectAll"
                  />
          </th>        
          <th>no.</th>
          <th>숙소번호</th>
          <th>숙소이름</th>
          <th>평일 / 주말 / 성수기 할인율</th>
          <th>프로모션 소개</th>
          <th>기간</th>
          <th>등록일</th>
        </tr>
      </thead>
			<tbody id="dataSection">
				
			</tbody>
		</table>
		</form>
		<!-- 페이지 내비게이션 표시 -->
		 <div id="pagination">
	        <ul class="pagination__list" id="paginationBox">
	          
	        </ul>
      	</div>

 </article>
 <article id="admin-user">
 <h1 class="section__title">숙소 증정 프로모션 (승인 대기)</h1>
  <form
      class="search-user__form review"
      id="form-search-userQnA"
      method="get"
      action="user-qna"
    >
      <ul class="search-bar">
      <li>
              <button
                type="button"
                class="btn__approval"
                id="btn-acc-offer-approval-submit"
                onclick=""
              >
                선택 승인
              </button>
            </li>
      	<li>
      	<li>
              <button
                type="button"
                class="btn__approval"
                id="btn-acc-offer-return-submit"
                onclick=""
              >
                선택 반려
              </button>
            </li>
      	<li>
      	<li>
      		<select
          class="search__select accommoType"
          name="order1"
          onchange="searchAccOfferPromotions()"
        >
          	<option value="" selected disabled="disabled">정렬순</option>
			   	<option value="최근등록일">최근등록일순</option>
                <option value="마감일">마감일순</option>
        </select>
      	</li>
      	<li>
      		<select class="search__select" name="opt1">
          	<option value="" selected disabled="disabled">검색조건</option>
          	<option value="숙소이름">숙소이름</option>
			<option value="숙소번호">숙소번호</option>
        </select>
      	</li>
      	<li>
      		<input type="text" class="search-user" name="value1" value="" />
        <button type="button" class="btn__search" id="btn-search-userQnA" onclick="searchAccOfferPromotions()">
          검색
        </button>
      	</li>
      </ul>
    </form>

	<table class="user-list-table">
		<colgroup>
	     	<col style="width: 5%" />
	        <col style="width: 5%" />
	        <col style="width: 5%" />
	        <col style="width: 10%" />
	        <col style="width: 10%" />
	        <col style="width: 10%" />
	        <col style="width: 10%" />
	        <col style="width: 10%" />
      </colgroup>
      <thead>
        <tr>
        <th>
         <input
                    type="checkbox"
                    name="accOffer-approval"
                    class="selectAll1"
                  />
          </th> 
          <th>no.</th>
          <th>숙소번호</th>
          <th>숙소이름</th>
          <th>증정내용</th>
          <th>프로모션 소개</th>
          <th>기간</th>
          <th>등록일</th>
        </tr>
      </thead>
			<tbody id="dataSection1">
				
			</tbody>
		</table>

		<!-- 페이지 내비게이션 표시 -->
		 <div id="pagination">
	        <ul class="pagination__list" id="paginationBox1">
	          
	        </ul>
      	</div>

 </article>
 
 
 <article id="admin-user">
 <h1 class="section__title">체험 할인 프로모션 (승인 대기)</h1>
  <form
      class="search-user__form review"
      id="form-search-userQnA"
      method="get"
      action="user-qna"
    >
      <ul class="search-bar">
      <li>
              <button
                type="button"
                class="btn__approval"
                id="btn-act-discount-approval-submit"
                onclick=""
              >
                선택 승인
              </button>
            </li>
      	<li>
      	<li>
              <button
                type="button"
                class="btn__approval"
                id="btn-act-discount-return-submit"
                onclick=""
              >
                선택 반려
              </button>
            </li>
      	<li>
      	<li>
      		<select
          class="search__select accommoType"
          name="order2"
          onchange="searchActDiscountPromotions()"
        >
          	<option value="" selected disabled="disabled">정렬순</option>
			   		<option value="최근등록일">최근등록일순</option>
                <option value="마감일">마감일순</option>
        </select>
      	</li>
      	<li>
      		<select class="search__select" name="opt2">
          	<option value="" selected disabled="disabled">검색조건</option>
          	<option value="체험이름">체험이름</option>
			<option value="체험번호">체험번호</option>
        </select>
      	</li>
      	<li>
      		<input type="text" class="search-user" name="value2" value="" />
        <button type="button" class="btn__search" id="btn-search-userQnA" onclick="searchActDiscountPromotions()">
          검색
        </button>
      	</li>
      </ul>
    </form>

	<table class="user-list-table">
		<colgroup>
	        <col style="width: 5%" />
	        <col style="width: 5%" />
	        <col style="width: 5%" />
	        <col style="width: 10%" />
	        <col style="width: 10%" />
	        <col style="width: 10%" />
	        <col style="width: 10%" />
	        <col style="width: 10%" />
      </colgroup>
      <thead>
        <tr>
         <th>
         <input
                    type="checkbox"
                    name="actDiscount-approval"
                    class="selectAll2"
                  />
          </th> 
          <th>no.</th>
          <th>체험번호</th>
          <th>체험이름</th>
          <th>평일 / 주말 / 성수기 할인율</th>
          <th>프로모션 소개</th>
          <th>기간</th>
          <th>등록일</th>
        </tr>
      </thead>
			<tbody id="dataSection2">
				
			</tbody>
		</table>

		<!-- 페이지 내비게이션 표시 -->
		 <div id="pagination">
	        <ul class="pagination__list" id="paginationBox2">
	          
	        </ul>
      	</div>

 </article>
 
 <article id="admin-user">
 <h1 class="section__title">체험 증정 프로모션 (승인 대기)</h1>
  <form
      class="search-user__form review"
      id="form-search-userQnA"
      method="get"
      action="user-qna"
    >
      <ul class="search-bar">
      <li>
              <button
                type="button"
                class="btn__approval"
                id="btn-act-offer-approval-submit"
                onclick=""
              >
                선택 승인
              </button>
            </li>
      	<li>
      	<li>
              <button
                type="button"
                class="btn__approval"
                id="btn-act-offer-return-submit"
                onclick=""
              >
                선택 반려
              </button>
            </li>
      	<li>
      	<li>
      		<select
          class="search__select accommoType"
          name="order3"
          onchange="searchActOfferPromotions()"
        >
          	<option value="" selected disabled="disabled">정렬순</option>
			   	<option value="최근등록일">최근등록일순</option>
                <option value="마감일">마감일순</option>
        </select>
      	</li>
      	<li>
      		<select class="search__select" name="opt3">
          	<option value="" selected disabled="disabled">검색조건</option>
          	<option value="체험이름">체험이름</option>
			<option value="체험번호">체험번호</option>
        </select>
      	</li>
      	<li>
      		<input type="text" class="search-user" name="value3" value="" />
        <button type="button" class="btn__search" id="btn-search-userQnA" onclick="searchActOfferPromotions()">
          검색
        </button>
      	</li>
      </ul>
    </form>

	<table class="user-list-table">
		<colgroup>
	         <col style="width: 5%" />
	        <col style="width: 5%" />
	        <col style="width: 5%" />
	        <col style="width: 10%" />
	        <col style="width: 10%" />
	        <col style="width: 10%" />
	        <col style="width: 10%" />
	        <col style="width: 10%" />
      </colgroup>
      <thead>
        <tr>
         <th>
         <input
                    type="checkbox"
                    name="actOffer-approval"
                    class="selectAll3"
                  />
          </th> 
          <th>no.</th>
          <th>체험번호</th>
          <th>체험이름</th>
          <th>증정내용</th>
          <th>프로모션 소개</th>
          <th>기간</th>
          <th>등록일</th>
        </tr>
      </thead>
			<tbody id="dataSection3">
				
			</tbody>
		</table>

		<!-- 페이지 내비게이션 표시 -->
		 <div id="pagination">
	        <ul class="pagination__list" id="paginationBox3">
	          
	        </ul>
      	</div>

 </article>
 
 
 
 
 
 
 </main>
 
 
<script type="text/javascript">
$(function(){
	
	activeMenu("프로모션관리", "승인대기");
	
})
searchAccDiscountPromotions();
searchAccOfferPromotions();
searchActOfferPromotions();
searchActDiscountPromotions();


function searchAccDiscountPromotions(page) {
	var opt = $("select[name=opt]").val();
	var value = $.trim($(":input[name=value]").val());
	var order =  $("select[name=order]").val();
	
			$.ajax({
				type: 'POST',
				url : "/admin/searchWaitingAccDiscountPromotions.do", //서비스 주소 
				data : { //서비스 처리에 필요한 인자값
					page : page,
					opt : opt,
					value : value,
					order : order
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
						data += "<td><input type='checkbox' name='accDiscount-approval' value=" + list[i].no + "></td>";
						data += "<td>" + list[i].no + "</td>";
						data += "<td>" + list[i].accommoNo + "</td>";
						data += "<td>" + list[i].accommoName + "</td>";
						data += "<td>" + (list[i].weekdaysDiscountRate*100)+ "% / " +(list[i].weekendDiscountRate*100)+ "% / "+(list[i].peakSeasonDiscountRate*100)+ "%</td>";
						data += "<td>" + list[i].introContent + "</td>";
						data += "<td>" + list[i].startingDate+ "~" +list[i].endingDate;+ "</td>";
						data += "<td>" + list[i].registeredDate; + "</td>";
						data += "</tr>";
					}
					$("#dataSection").html(data);

					// 이전버튼 활성화 여부를 결정하는 부분
					if (pagination['prevPage']) {
						block += "<li class='page-item'><a class='page-link' onclick='searchAccDiscountPromotions("
								+ (pagination['beginPage'] - 1)
								+ ")'> < </a></li>";
					} else {
						block += "<li class='page-item disabled'><a class='page-link'> < </a></li>";
					}

					// 번호를 표시하는 부분
					for (var i = pagination['beginPage']; i <= pagination['endPage']; i++) {
						if (page !== i) {
							block += "<li class='page-item'><a class='page-link' onclick='searchAccDiscountPromotions("
									+ i + ")'>" + (i) + "</a></li>";
						} else {
							block += "<li class='page-item disabled'><a class='page-link'>"
									+ (i) + "</a></li>";
						}
					}

					if (pagination['nextPage']) {
						block += "<li class='page-item'><a class='page-link' onclick='searchAccDiscountPromotions("
								+ (pagination['endPage'] + 1)
								+ ")'>  > </a></li>";
					} else {
						block += "<li class='page-item disabled'><a class='page-link'> > </a></li>";
					}
					
					$("#paginationBox").html(block);
				}
			})
}
function searchAccOfferPromotions(page) {
	var opt = $("select[name=opt1]").val();
	var value = $.trim($(":input[name=value1]").val());
	var order =  $("select[name=order1]").val();
	
			$.ajax({
				type: 'POST',
				url : "/admin/searchWaitingAccOfferPromotions.do", //서비스 주소 
				data : { //서비스 처리에 필요한 인자값
					page : page,
					opt : opt,
					value : value,
					order : order
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
						data += "<td><input type='checkbox' name='accOffer-approval' value=" + list[i].no + "></td>";
						data += "<td>" + list[i].no + "</td>";
						data += "<td>" + list[i].accommoNo + "</td>";
						data += "<td>" + list[i].accommoName + "</td>";
						data += "<td>" + list[i].offerContent+ "</td>";
						data += "<td>" + list[i].introContent + "</td>";
						data += "<td>" + list[i].startingDate+ "~" +list[i].endingDate;+ "</td>";
						data += "<td>" + list[i].registeredDate; + "</td>";
						data += "</tr>";
					}
					$("#dataSection1").html(data);

					// 이전버튼 활성화 여부를 결정하는 부분
					if (pagination['prevPage']) {
						block += "<li class='page-item'><a class='page-link' onclick='searchAccOfferPromotions("
								+ (pagination['beginPage'] - 1)
								+ ")'> < </a></li>";
					} else {
						block += "<li class='page-item disabled'><a class='page-link'> < </a></li>";
					}

					// 번호를 표시하는 부분
					for (var i = pagination['beginPage']; i <= pagination['endPage']; i++) {
						if (page !== i) {
							block += "<li class='page-item'><a class='page-link' onclick='searchAccOfferPromotions("
									+ i + ")'>" + (i) + "</a></li>";
						} else {
							block += "<li class='page-item disabled'><a class='page-link'>"
									+ (i) + "</a></li>";
						}
					}

					if (pagination['nextPage']) {
						block += "<li class='page-item'><a class='page-link' onclick='searchAccOfferPromotions("
								+ (pagination['endPage'] + 1)
								+ ")'>  > </a></li>";
					} else {
						block += "<li class='page-item disabled'><a class='page-link'> > </a></li>";
					}
					
					$("#paginationBox1").html(block);
				}
			})
}

function searchActDiscountPromotions(page) {
	var opt = $("select[name=opt2]").val();
	var value = $.trim($(":input[name=value2]").val());
	var order =  $("select[name=order2]").val();
	
			$.ajax({
				type: 'POST',
				url : "/admin/searchWaitingActDiscountPromotions.do", //서비스 주소 
				data : { //서비스 처리에 필요한 인자값
					page : page,
					opt : opt,
					value : value,
					order : order
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
						data += "<td><input type='checkbox' name='actDiscount-approval' value=" + list[i].no + "></td>";
						data += "<td>" + list[i].no + "</td>";
						data += "<td>" + list[i].activityNo + "</td>";
						data += "<td>" + list[i].activityName + "</td>";
						data += "<td>" + (list[i].weekdaysDiscountRate*100)+ "% / " +(list[i].weekendDiscountRate*100)+ "% / "+(list[i].peakSeasonDiscountRate*100)+ "%</td>";
						data += "<td>" + list[i].introContent + "</td>";
						data += "<td>" + list[i].startingDate+ "~" +list[i].endingDate;+ "</td>";
						data += "<td>" + list[i].registeredDate; + "</td>";
						data += "</tr>";
					}
					$("#dataSection2").html(data);

					// 이전버튼 활성화 여부를 결정하는 부분
					if (pagination['prevPage']) {
						block += "<li class='page-item'><a class='page-link' onclick='searchActDiscountPromotions("
								+ (pagination['beginPage'] - 1)
								+ ")'> < </a></li>";
					} else {
						block += "<li class='page-item disabled'><a class='page-link'> < </a></li>";
					}

					// 번호를 표시하는 부분
					for (var i = pagination['beginPage']; i <= pagination['endPage']; i++) {
						if (page !== i) {
							block += "<li class='page-item'><a class='page-link' onclick='searchActDiscountPromotions("
									+ i + ")'>" + (i) + "</a></li>";
						} else {
							block += "<li class='page-item disabled'><a class='page-link'>"
									+ (i) + "</a></li>";
						}
					}

					if (pagination['nextPage']) {
						block += "<li class='page-item'><a class='page-link' onclick='searchActDiscountPromotions("
								+ (pagination['endPage'] + 1)
								+ ")'>  > </a></li>";
					} else {
						block += "<li class='page-item disabled'><a class='page-link'> > </a></li>";
					}
					
					$("#paginationBox2").html(block);
				}
			})
}
function searchActOfferPromotions(page) {
	var opt = $("select[name=opt3]").val();
	var value = $.trim($(":input[name=value3]").val());
	var order =  $("select[name=order3]").val();
	
			$.ajax({
				type: 'POST',
				url : "/admin/searchWaitingActOfferPromotions.do", //서비스 주소 
				data : { //서비스 처리에 필요한 인자값
					page : page,
					opt : opt,
					value : value,
					order : order
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
						data += "<td><input type='checkbox' name='actOffer-approval' value=" + list[i].no + "></td>";
						data += "<td>" + list[i].no + "</td>";
						data += "<td>" + list[i].activityNo + "</td>";
						data += "<td>" + list[i].activityName + "</td>";
						data += "<td>" + list[i].offerContent+ "</td>";
						data += "<td>" + list[i].introContent + "</td>";
						data += "<td>" + list[i].startingDate+ "~" +list[i].endingDate;+ "</td>";
						data += "<td>" + list[i].registeredDate; + "</td>";
						data += "</tr>";
					}
					$("#dataSection3").html(data);

					// 이전버튼 활성화 여부를 결정하는 부분
					if (pagination['prevPage']) {
						block += "<li class='page-item'><a class='page-link' onclick='searchActOfferPromotions("
								+ (pagination['beginPage'] - 1)
								+ ")'> < </a></li>";
					} else {
						block += "<li class='page-item disabled'><a class='page-link'> < </a></li>";
					}

					// 번호를 표시하는 부분
					for (var i = pagination['beginPage']; i <= pagination['endPage']; i++) {
						if (page !== i) {
							block += "<li class='page-item'><a class='page-link' onclick='searchActOfferPromotions("
									+ i + ")'>" + (i) + "</a></li>";
						} else {
							block += "<li class='page-item disabled'><a class='page-link'>"
									+ (i) + "</a></li>";
						}
					}

					if (pagination['nextPage']) {
						block += "<li class='page-item'><a class='page-link' onclick='searchActOfferPromotions("
								+ (pagination['endPage'] + 1)
								+ ")'>  > </a></li>";
					} else {
						block += "<li class='page-item disabled'><a class='page-link'> > </a></li>";
					}
					
					$("#paginationBox3").html(block);
				}
			})
}



$(".selectAll").change(function(){
	$("#dataSection [type=checkbox][name=accDiscount-approval]").prop("checked", $(this).prop("checked"))
	setTotalPrice()
})
$(".selectAll1").change(function(){
	$("#dataSection1 [type=checkbox][name=accOffer-approval]").prop("checked", $(this).prop("checked"))
	setTotalPrice()
})
$(".selectAll2").change(function(){
	$("#dataSection2 [type=checkbox][name=actDiscount-approval]").prop("checked", $(this).prop("checked"))
	setTotalPrice()
})
$(".selectAll3").change(function(){
	$("#dataSection3 [type=checkbox][name=actOffer-approval]").prop("checked", $(this).prop("checked"))
	setTotalPrice()
})


// $("컨테이너").on("이벤트이름", "대상엘리먼트", 이벤트핸들러함수)
$("#dataSection").on("change", '[type=checkbox][name=accDiscount-approval]', function() {
	// 전체선택을 제외한 체크박스들의 갯수 
	var len = $("#dataSection [type=checkbox][name=accDiscount-approval]").length;
	var ckLen = $("#dataSection [type=checkbox][name=accDiscount-approval]:checked").length;
	
	if(len === ckLen){ //3-3
		$(".selectAll").prop("checked", true);
	}else{
		$(".selectAll").prop("checked", false);
	}
})
// $("컨테이너").on("이벤트이름", "대상엘리먼트", 이벤트핸들러함수)
$("#dataSection1").on("change", '[type=checkbox][name=accOffer-approval]', function() {
	// 전체선택을 제외한 체크박스들의 갯수 
	var len = $("#dataSection1 [type=checkbox][name=accOffer-approval]").length;
	var ckLen = $("#dataSection1 [type=checkbox][name=accOffer-approval]:checked").length;
	
	if(len === ckLen){ //3-3
		$(".selectAll1").prop("checked", true);
	}else{
		$(".selectAll1").prop("checked", false);
	}
})
// $("컨테이너").on("이벤트이름", "대상엘리먼트", 이벤트핸들러함수)
$("#dataSection2").on("change", '[type=checkbox][name=actDiscount-approval]', function() {
	// 전체선택을 제외한 체크박스들의 갯수 
	var len = $("#dataSection2 [type=checkbox][name=actDiscount-approval]").length;
	var ckLen = $("#dataSection2 [type=checkbox][name=actDiscount-approval]:checked").length;
	
	if(len === ckLen){ //3-3
		$(".selectAll2").prop("checked", true);
	}else{
		$(".selectAll2").prop("checked", false);
	}
})
// $("컨테이너").on("이벤트이름", "대상엘리먼트", 이벤트핸들러함수)
$("#dataSection3").on("change", '[type=checkbox][name=actOffer-approval]', function() {
	// 전체선택을 제외한 체크박스들의 갯수 
	var len = $("#dataSection3 [type=checkbox][name=actOffer-approval]").length;
	var ckLen = $("#dataSection3 [type=checkbox][name=actOffer-approval]:checked").length;
	
	if(len === ckLen){ //3-3
		$(".selectAll3").prop("checked", true);
	}else{
		$(".selectAll3").prop("checked", false);
	}
})


function checkboxAccDiscountApproval() {
    var checkArr = [];     // 배열 초기화
    $("#dataSection input[name='accDiscount-approval']:checked").each(function(i) {
        checkArr.push($(this).val());     // 체크된 것만 값을 뽑아서 배열에 push
        $(this).closest('tr').remove();
    })
 
    $.ajax({
        url: 'approveAccDiscount'
        , type: 'post'
        , dataType: 'text'
        , data: {
        	accDiscountNoList: checkArr
        }
    });
}
function checkboxAccDiscountReturn() {
    var checkArr = [];     // 배열 초기화
    $("#dataSection input[name='accDiscount-approval']:checked").each(function(i) {
        checkArr.push($(this).val());     // 체크된 것만 값을 뽑아서 배열에 push
        $(this).closest('tr').remove();
    })
 
    $.ajax({
        url: 'returnAccDiscount'
        , type: 'post'
        , dataType: 'text'
        , data: {
        	accDiscountNoList: checkArr
        }
    });
}


$("#btn-acc-discount-approval-submit").click(function(){
	
	checkboxAccDiscountApproval();
});
$("#btn-acc-discount-return-submit").click(function(){
	
	checkboxAccDiscountReturn();

});

function checkboxActDiscountApproval() {
    var checkArr = [];     // 배열 초기화
    $("#dataSection2 input[name='actDiscount-approval']:checked").each(function(i) {
        checkArr.push($(this).val());     // 체크된 것만 값을 뽑아서 배열에 push
        $(this).closest('tr').remove();
    })
 
    $.ajax({
        url: 'approveActDiscount'
        , type: 'post'
        , dataType: 'text'
        , data: {
        	actDiscountNoList: checkArr
        }
    });
}
function checkboxActDiscountReturn() {
    var checkArr = [];     // 배열 초기화
    $("#dataSection2 input[name='actDiscount-approval']:checked").each(function(i) {
        checkArr.push($(this).val());     // 체크된 것만 값을 뽑아서 배열에 push
        $(this).closest('tr').remove();
    })
 
    $.ajax({
        url: 'returnActDiscount'
        , type: 'post'
        , dataType: 'text'
        , data: {
        	actDiscountNoList: checkArr
        }
    });
}


$("#btn-act-discount-approval-submit").click(function(){
	
	checkboxActDiscountApproval();
});
$("#btn-act-discount-return-submit").click(function(){
	
	checkboxActDiscountReturn();

});


function checkboxAccOfferApproval() {
    var checkArr = [];     // 배열 초기화
    $("#dataSection1 input[name='accOffer-approval']:checked").each(function(i) {
        checkArr.push($(this).val());     // 체크된 것만 값을 뽑아서 배열에 push
        $(this).closest('tr').remove();
    })
 
    $.ajax({
        url: 'approveAccOffer'
        , type: 'post'
        , dataType: 'text'
        , data: {
        	accOfferNoList: checkArr
        }
    });
}
function checkboxAccOfferReturn() {
    var checkArr = [];     // 배열 초기화
    $("#dataSection1 input[name='accOffer-approval']:checked").each(function(i) {
        checkArr.push($(this).val());     // 체크된 것만 값을 뽑아서 배열에 push
        $(this).closest('tr').remove();
    })
 
    $.ajax({
        url: 'returnAccOffer'
        , type: 'post'
        , dataType: 'text'
        , data: {
        	accOfferNoList: checkArr
        }
    });
}


$("#btn-acc-offer-approval-submit").click(function(){
	
	checkboxAccOfferApproval();
});
$("#btn-acc-offer-return-submit").click(function(){
	
	checkboxAccOfferReturn();

});

function checkboxActOfferApproval() {
    var checkArr = [];     // 배열 초기화
    $("#dataSection3 input[name='actOffer-approval']:checked").each(function(i) {
        checkArr.push($(this).val());     // 체크된 것만 값을 뽑아서 배열에 push
        $(this).closest('tr').remove();
    })
 
    $.ajax({
        url: 'approveActOffer'
        , type: 'post'
        , dataType: 'text'
        , data: {
        	actOfferNoList: checkArr
        }
    });
}
function checkboxActOfferReturn() {
    var checkArr = [];     // 배열 초기화
    $("#dataSection3 input[name='actOffer-approval']:checked").each(function(i) {
        checkArr.push($(this).val());     // 체크된 것만 값을 뽑아서 배열에 push
        $(this).closest('tr').remove();
    })
 
    $.ajax({
        url: 'returnActOffer'
        , type: 'post'
        , dataType: 'text'
        , data: {
        	actOfferNoList: checkArr
        }
    });
}


$("#btn-act-offer-approval-submit").click(function(){
	
	checkboxActOfferApproval();
});
$("#btn-act-offer-return-submit").click(function(){
	
	checkboxActOfferReturn();

});




</script>