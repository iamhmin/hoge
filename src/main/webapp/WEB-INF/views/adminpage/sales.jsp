<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>
	<link rel="stylesheet" href="../../../resources/css/datepickerAdmin.min.css">
    <script src="../../resources/js/datepicker.js"></script>
    <script src="../../resources/js/datepicker.min.js"></script>
    <script src="../../resources/js/datepickerutil/datepicker.ko.js"></script>

 <main id="main">
      <article id="admin-user">
          <div class="total-profit">
          <table class="total-profit-table">
            <thead>
              <tr>
                <th>총 입금액</th>
                <th>총 출금액</th>
                <th>총 순익</th>
              </tr>
            </thead>
            <tbody id="salesdataSection">
              
            </tbody>
          </table>
         </div>
         <form
          class="search-user__form only-child"
          id="form-search-user"
          method="get"
          action="user-list"
         >
          <input type="hidden" name="page" value="1" />
          <ul class="search-bar-sales">
            <li class="flex-end">
              <i class="fa-regular fa-calendar-check"></i>
            </li>
            <li class="flex-end filter-date">
              <button
                type="button"
                name="filterDate"
                id="oneWeek"
                class="btn__filter-date"
              >
                일주일
              </button>
              <button
                type="button"
                name="filterDate"
                id="oneMonth"
                class="btn__filter-date"
              >
                1개월
              </button>
              <button
                type="button"
                name="filterDate"
                id="threeMonths"
                class="btn__filter-date"
              >
                3개월
              </button>
              <button
                type="button"
                name="filterDate"
                id="sixMonths"
                class="btn__filter-date"
              >
                6개월
              </button>
            </li>
            <li>
              <input
                class="cal-search"
                id="startDate"
                type="text"
                name="startDate"
                value=""
                autocomplete="off"
              />
              <i class="fa-solid fa-minus"></i>
              <input
                class="cal-search"
                id="endDate"
                type="text"
                name="endDate"
                value=""
                 autocomplete="off"
              />
              <button type="button" class="btn__search" id="btn-search-user">
                검색
              </button>
            </li>
          </ul>
        </form>
		
		  <table class="user-list-table">
			<colgroup>
	          <col style="width: 7%" />
	          <col style="width: 11%" />
	          <col style="width: 12%" />
	          <col style="width: 11%" />
	          <col style="width: 11%" />
	          <col style="width: 11%" />
	          <col style="width: 11%" />
	          <col style="width: 15%" />
	          <col style="width: 11%" />
	        </colgroup>
			<thead>
				<tr>
					<th>No</th>
					<th>종류</th>
					<th>거래금액</th>
					<th>(환불)회원번호</th>
					<th>(출금)호스트번호</th>
					<th>(입금)숙소예약번호</th>
					<th>(입금)체험예약번호</th>
					<th>누적액</th>
					<th>거래일</th>
				</tr>
			</thead>
			<tbody id="dataSection">
		
			</tbody>
		</table>
		
<!-- 페이지 내비게이션 표시 -->		

		<!-- 페이지 내비게이션 표시 -->
		
			<div id="pagination">
				<ul id="paginationBox" class="pagination__list">
	
				</ul>
			</div>
			
      </article>
    </main>

<script type="text/javascript">
$(function(){
	
activeMenu("매출관리", "매출내역");
})


getTransaction();
datePickerSet($("#startDate"), $("#endDate"));

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ", ");
}



function getDateStr(myDate){
	return (myDate.getFullYear() + '-' + ('0' + (myDate.getMonth() + 1)).slice(-2) + '-' + ('0' + myDate.getDate()).slice(-2))
}

/* 오늘 날짜를 문자열로 반환 */
function today() {
  var d = new Date()
  return getDateStr(d)
}

/* 오늘로부터 1주일전 날짜 반환 */
function oneWeek() {
  var d = new Date()
  var dayOfMonth = d.getDate()
  d.setDate(dayOfMonth - 7)
  return getDateStr(d)
}

/* 오늘로부터 1개월전 날짜 반환 */
function oneMonth() {
  var d = new Date()
  var monthOfYear = d.getMonth()
  d.setMonth(monthOfYear - 1)
  return getDateStr(d)
}
/* 오늘로부터 3개월전 날짜 반환 */
function threeMonths() {
  var d = new Date()
  var monthOfYear = d.getMonth()
  d.setMonth(monthOfYear - 3)
  return getDateStr(d)
}
/* 오늘로부터 6개월전 날짜 반환 */
function sixMonths() {
  var d = new Date()
  var monthOfYear = d.getMonth()
  d.setMonth(monthOfYear - 6)
  return getDateStr(d)
}


$("#oneWeek").click(function(){
	$(":input[name=startDate]").val(oneWeek());
	$(":input[name=endDate]").val(today());
	$(":input[name=page]").val("1");
	getTransaction();
});
$("#oneMonth").click(function(){
	$(":input[name=startDate]").val(oneMonth());
	$(":input[name=endDate]").val(today());
	$(":input[name=page]").val("1");
	getTransaction();
});
$("#threeMonths").click(function(){
	$(":input[name=startDate]").val(threeMonths());
	$(":input[name=endDate]").val(today());
	$(":input[name=page]").val("1");
	getTransaction();
});

$("#sixMonths").click(function(){
	$(":input[name=startDate]").val(sixMonths());
	$(":input[name=endDate]").val(today());
	$(":input[name=page]").val("1");
	getTransaction();
});

         


$("#btn-search-user").click(function() {
	var startDate = $(":input[name=startDate]").val();
	var endDate = $(":input[name=endDate]").val();
	if (startDate && endDate) {
	$(":input[name=page]").val("1");
	getTransaction();
	} else {
		alert("기간을 입력하세요");					
	}
});
	

	
	

	

	// 달력생성함수 sDate:시작일 eDate:종료일
function datePickerSet(sDate, eDate) {

        var sDay = sDate.val();
        var eDay = eDate.val();

        if (!isValidStr(eDay)) {
            sDate.datepicker({
                maxDate: new Date(eDay)
            });
        }
        
        sDate.datepicker({
            language: 'ko',
            autoClose: true,
            onSelect: function () {
                datePickerSet(sDate, eDate);
            }
        });

        if (!isValidStr(sDay)) {
            eDate.datepicker({
                minDate: new Date(sDay)
            });
        } 
        
        eDate.datepicker({
            language: 'ko',
            autoClose: true,
            onSelect: function () {
                datePickerSet(sDate, eDate);
            }
        });
	
    //날짜 생성 여부
    function isValidStr(str) {
        if (str == null || str == undefined || str == "")
            return true;
        else
            return false;
    }
}


function getTransaction(page) {
	var startDate = $(":input[name=startDate]").val();
	var endDate = $(":input[name=endDate]").val();
	
			$.ajax({
				type: 'POST',
				url : "/admin/getTransaction.do", //서비스 주소 
				data : { //서비스 처리에 필요한 인자값
					page : page,
					startDate : startDate,
					endDate : endDate
				},
				success : function(result) {
					const list = result['list'];
					const pagination = result['pagination'];
					const criteria = result['criteria'];
					const totalDeposit = result['totalDeposit'];
					const totalWithdrawal = result['totalWithdrawal'];
					const totalsales = result['totalsales'];
					var data = "";
					var block = "";
					var saledata = "";

					saledata +="<tr>";
					saledata +="<td>" + numberWithCommas(totalDeposit) +"원</td>";
					saledata +="<td>" + numberWithCommas(totalWithdrawal) +"원</td>";
					saledata +="<td>" + numberWithCommas(totalsales) +"원</td>";
					saledata +="</tr>";
					
					$("#salesdataSection").html(saledata);
					
				
					// 테이블의 row를 삽입하는 부분
					
					for (var i = 0; i < list.length; i++) {
						data += "<tr>";
						data += "<td>" + list[i].no + "</td>";
						if (list[i]['type'] == '1') {
							data += "<td class='amount-color'>게스트입금</td>";
						data += "<td class='amount-color'> +" + numberWithCommas(list[i].amount) + "원</td>";
						} else if (list[i]['type'] == '2') {
								data += "<td class='withdrawal-color'>호스트출금</td>";
						data += "<td class='withdrawal-color'> -" + numberWithCommas(list[i].amount) + "원</td>";
						} else {
							data += "<td class='refund-color'>게스트환불</td>";
						data += "<td class='refund-color'> -" + numberWithCommas(list[i].amount) + "원</td>";
						}
						if (list[i]['toUserNo'] == '0') {
						data += "<td> - </td>";
						}
						else {
							data += "<td>" + list[i].toUserNo + "</td>";
						}
						if (list[i]['toHostNo'] == '0') {
						data += "<td> - </td>";
						}
						else {
							data += "<td>" + list[i].toHostNo + "</td>";
						}
						if (list[i]['accommoBookingNo'] == '0') {
						data += "<td> - </td>";
						}
						else {
							data += "<td>" + list[i].accommoBookingNo + "</td>";
						}
						if (list[i]['activityBookingNo'] == '0') {
						data += "<td> - </td>";
						}
						else {
							data += "<td>" + list[i].activityBookingNo + "</td>";
						}
						data += "<td class='amount-color'>" + numberWithCommas(list[i].accumulatedMoney) + "원</td>";
						data += "<td>" + list[i].createdDate + "</td>";
					data += "</tr>";
					}
					$("#dataSection").html(data);
					
					
					
					
					

					// 이전버튼 활성화 여부를 결정하는 부분
					if (pagination['prevPage']) {
						block += "<li class='page-item'><a class='page-link' href='javascript:getTransaction("
								+ (pagination['beginPage'] - 1)
								+ ")'> <i class='fas fa-chevron-left'></i> </a></li>";
					} else {
						block += "<li class='page-item disabled'><a class='page-link'> <i class='fas fa-chevron-left'></i> </a></li>";
					}

					// 번호를 표시하는 부분
					for (var i = pagination['beginPage']; i <= pagination['endPage']; i++) {
						if (page !== i) {
							block += "<li class='page-item'><a class='page-link' href='javascript:getTransaction("
									+ i + ")'>" + (i) + "</a></li>";
						} else {
							block += "<li class='page-item disabled'><a class='page-link'>"
									+ (i) + "</a></li>";
						}
					}

					if (pagination['nextPage']) {
						block += "<li class='page-item'><a class='page-link' href='javascript:getTransaction("
								+ (pagination['endPage'] + 1)
								+ ")'>  <i class='fas fa-chevron-right'></i> </a></li>";
					} else {
						block += "<li class='page-item disabled'><a class='page-link'> <i class='fas fa-chevron-right'></i> </a></li>";
					}
					
					$("#paginationBox").html(block);
				}
			})
}



</script>