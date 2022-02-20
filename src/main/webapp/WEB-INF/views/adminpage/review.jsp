<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>
<c:set var="menu" value="review"/>

<main id="main">
  <article id="admin-user">
  
 <!-- 숙소 리뷰 -->
    <article id="accommo-review">
      <h1 class="section__title">숙소</h1>
        <form class="search-user__form review" id="form-search-accReview">
        <ul class="search-bar">
          <li>
            <select class="search__select" name="opt">
              <option value="" selected disabled="disabled">
                검색조건
              </option>
              <option value="회원번호">회원번호</option>
              <option value="호스트번호">호스트번호</option>
              <option value="시설번호">시설번호</option>
              <option value="시설이름">시설이름</option>
              <option value="내용">내용</option>
            </select>
          </li>
          <li>
            <input type="text" class="search-user" name="value" value="" />
            <button
              type="button"
              class="btn__search"
              id="btn-search-accReview"
            >
              검색
            </button>
          </li>
        </ul>
      </form>
      <table class="user-list-table">
        <colgroup>
          <col style="width: 5%" />
          <col style="width: 7%" />
          <col style="width: 5%" />
          <col style="width: 16%" />
          <col style="width: 6%" />
          <col style="width: 6%" />
          <col style="width: 6%" />
          <col style="width: 6%" />
          <col style="width: 16%" />
          <col style="width: 10%" />
          <col style="width: 5%" />
        </colgroup>
        <thead>
          <tr>
            <th>no.</th>
            <th>회원번호</th>
            <th>숙소번호</th>
            <th>숙소이름</th>
            <th>청결도</th>
            <th>의사소통</th>
            <th>정확도</th>
            <th>위치</th>
            <th>내용</th>
            <th>작성일</th>
            <th>답변</th>
          </tr>
        </thead>
        <tbody id="dataSection1">
          
        </tbody>
      </table>
      
	<!-- 숙소 페이지네이션 -->      
      <div id="pagination">
        <ul class="pagination__list" id="paginationBox1">
          
        </ul>
      </div>
    </article>
    
    
  <!-- 체험 리뷰 -->  
    <article id="activity-review">
      <h1 class="section__title">체험</h1>
       <form class="search-user__form review" id="form-search-actReview">
        <ul class="search-bar">
          <li>
            <select class="search__select" name="opt1">
              <option value="" selected disabled="disabled">
                검색조건
              </option>
              <option value="회원번호">회원번호</option>
              <option value="호스트번호">호스트번호</option>
              <option value="시설번호">체험번호</option>
              <option value="시설이름">체험이름</option>
              <option value="내용">내용</option>
            </select>
          </li>
          <li>
            <input type="text" class="search-user" name="value" value="" />
            <button
              type="button"
              class="btn__search"
              id="btn-search-actReview"
            >
              검색
            </button>
          </li>
        </ul>
      </form>
      <table class="user-list-table">
        <colgroup>
          <col style="width: 8%" />
          <col style="width: 9%" />
          <col style="width: 9%" />
          <col style="width: 22%" />
          <col style="width: 9%" />
          <col style="width: 23%" />
          <col style="width: 12%" />
          <col style="width: 8%" />
        </colgroup>
        <thead>
          <tr>
            <th>no.</th>
            <th>회원번호</th>
            <th>체험번호</th>
            <th>체험이름</th>
            <th>별점</th>
            <th>내용</th>
            <th>작성일</th>
            <th>답변</th>
          </tr>
        </thead>
        <tbody id="dataSection2">
         
        </tbody>
      </table>
      
   	<!-- 체험 페이지네이션 -->   
      <div id="pagination">
        <ul class="pagination__list" id="paginationBox2">
          
        </ul>
      </div>
    </article>
  </article>
</main>

<script type="text/javascript">
$(function(){
	
	activeMenu("회원관리", "리뷰관리");
	})

$("#btn-search-actReview").click(function() {
	var opt1 = $("select[name=opt1]").val();
	var value1 = $.trim($(":input[name=value1]").val());
	if (opt1 && value1) {
	getActPage();
	} else {
		alert("검색조건 혹은 검색어를 입력하세요");					
	}
});
$("#btn-search-accReview").click(function() {
	var opt = $("select[name=opt]").val();
	var value = $.trim($(":input[name=value]").val());
	if (opt && value) {
	$(":input[name=page]").val("1");
	getAccPage();
	} else {
		alert("검색조건 혹은 검색어를 입력하세요");					
	}
});

$(document).ready(function() {
	getAccPage();
	getActPage();
});

function getAccPage(page) {
	var opt = $("select[name=opt]").val();
	var value = $.trim($(":input[name=value]").val());
	
			$.ajax({
				type: 'POST',
				url : "/admin/getAccList.do", //서비스 주소 
				data : { //서비스 처리에 필요한 인자값
					page : page,
					opt : opt,
					value : value
				},
				success : function(result) {
					const list = result['list'];
					const pagination = result['pagination'];
					const criteria = result['criteria'];
					var data = "";
					var block = "";

					console.log(pagination);
					console.log(list);
					console.log(criteria);
					// 테이블의 row를 삽입하는 부분
					for (var i = 0; i < list.length; i++) {
						data += "<tr>";
						data += "<td>" + list[i].no + "</td>";
						console.log(list[i].no);
						data += "<td style='cursor:pointer' onclick='showUserDetail("
							+ list[i].userNo + ")'>" + list[i].userNo + "</td>";
						data += "<td style='cursor:pointer' onclick='showAccommoDetail("
							+ list[i].accommoNo + ")'>" + list[i].accommoNo + "</td>";
						data += "<td class='text-overflow'>" + list[i].accommoName + "</td>";
						data += "<td>" + list[i].cleanlinessStar + "</td>";
						data += "<td>" + list[i].communicationStar + "</td>";
						console.log(list[i].content);
						data += "<td>" + list[i].accuracyStar + "</td>";
						data += "<td>" + list[i].locationStar + "</td>";
						data += "<td class='text-overflow'>" + list[i].content + "</td>";
						data += "<td>" + list[i].createdDate + "</td>";
						
						if (list[i]['answerContent']!=null) {
						data += "<td>" + list[i].answerContent + "</td>";
						} else {
							data += "<td>답변없음</td>";
						}
						data += "</tr>";
					}
					$("#dataSection1").html(data);

					// 이전버튼 활성화 여부를 결정하는 부분
					if (pagination['prevPage']) {
						block += "<li class='page-item'><a class='page-link' href='javascript:getAccPage("
								+ (pagination['beginPage'] - 1)
								+ ")'> <i class='fas fa-chevron-left'></i> </a></li>";
					} else {
						block += "<li class='page-item disabled'><a class='page-link'> <i class='fas fa-chevron-left'></i> </a></li>";
					}

					// 번호를 표시하는 부분
					for (var i = pagination['beginPage']; i <= pagination['endPage']; i++) {
						if (page !== i) {
							block += "<li class='page-item'><a class='page-link' href='javascript:getAccPage("
									+ i + ")'>" + (i) + "</a></li>";
						} else {
							block += "<li class='page-item disabled'><a class='page-link'>"
									+ (i) + "</a></li>";
						}
					}

					if (pagination['nextPage']) {
						block += "<li class='page-item'><a class='page-link' href='javascript:getAccPage("
								+ (pagination['endPage'] + 1)
								+ ")'> <i class='fas fa-chevron-right'></i> </a></li>";
					} else {
						block += "<li class='page-item disabled'><a class='page-link'> <i class='fas fa-chevron-right'></i> </a></li>";
					}
					
					$("#paginationBox1").html(block);
				}
			})
}
function getActPage(page1) {
	var opt1 = $("select[name=opt1]").val();
	var value1 = $.trim($(":input[name=value1]").val());
	
			$.ajax({
				type: 'POST',
				url : "/admin/getActList.do", //서비스 주소 
				data : { //서비스 처리에 필요한 인자값
					page1 : page1,
					opt1 : opt1,
					value1 : value1
				},
				success : function(result) {
					const list = result['list'];
					const pagination = result['pagination'];
					const criteria = result['criteria'];
					var data = "";
					var block = "";

					console.log(pagination);
					console.log(list);
					console.log(criteria);
					// 테이블의 row를 삽입하는 부분
					for (var i = 0; i < list.length; i++) {
						data += "<tr>";
						data += "<td>" + list[i].no + "</td>";
						console.log(list[i].no);
						data += "<td style='cursor:pointer' onclick='showUserDetail("
							+ list[i].userNo + ")'>" + list[i].userNo + "</td>";
						data += "<td style='cursor:pointer' onclick='showAccommoDetail("
							+ list[i].activityNo + ")'>" + list[i].activityNo + "</td>";
						data += "<td class='text-overflow'>" + list[i].activityName + "</td>";
						data += "<td>" + list[i].star + "</td>";
						data += "<td class='text-overflow'>" + list[i].content + "</td>";
						data += "<td>" + list[i].createdDate + "</td>";
						
						if (list[i]['answerContent']!=null) {
						data += "<td>" + list[i].answerContent + "</td>";
						} else {
							data += "<td>답변없음</td>";
						}
						data += "</tr>";
					}
					$("#dataSection2").html(data);

					// 이전버튼 활성화 여부를 결정하는 부분
					if (pagination['prevPage']) {
						block += "<li class='page-item'><a class='page-link' href='javascript:getActPage("
								+ (pagination['beginPage'] - 1)
								+ ")'> <i class='fas fa-chevron-left'></i> </a></li>";
					} else {
						block += "<li class='page-item disabled'><a class='page-link'> <i class='fas fa-chevron-left'></i> </a></li>";
					}

					// 번호를 표시하는 부분
					for (var i = pagination['beginPage']; i <= pagination['endPage']; i++) {
						if (page1 !== i) {
							block += "<li class='page-item'><a class='page-link' href='javascript:getActPage("
									+ i + ")'>" + (i) + "</a></li>";
						} else {
							block += "<li class='page-item disabled'><a class='page-link'>"
									+ (i) + "</a></li>";
						}
					}

					if (pagination['nextPage']) {
						block += "<li class='page-item'><a class='page-link' href='javascript:getActPage("
								+ (pagination['endPage'] + 1)
								+ ")'> <i class='fas fa-chevron-right'></i> </a></li>";
					} else {
						block += "<li class='page-item disabled'><a class='page-link'> <i class='fas fa-chevron-right'></i> </a></li>";
					}
					
					$("#paginationBox2").html(block);
				}
			})
}


</script>


</body>
</html>