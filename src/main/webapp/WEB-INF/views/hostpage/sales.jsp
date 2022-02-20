<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../common/tags.jsp" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>

<main id="main">
 <article id="host-sales">
   <section class="host-sales__chart">
     <div class="host-main__title">일일매출액</div>
     <canvas id="line-chart-daily" width="1400" height="300"></canvas>
   </section>
   <section class="host-sales__table">
     <div class="host-main__title">매출테이블</div>
     <table class="host-table">
       <thead>
         <tr>
           <th>거래일</th>
           <th>거래유형</th>
           <th>거래액</th>
         </tr>
       </thead>
       <tbody id="dataSection2">
         
       </tbody>
     </table>
     
   <!-- 페이지네이션 -->  
     <div id="pagination">
       <ul id="paginationBox2" class="pagination__list">
         
       </ul>
     </div>
   </section>
   
   <section class="host-sales__withdrawal">
     <div class="host-main__title">출금신청내역</div>
     <div class="withdrawal-box">
       <div class="total-amount">출금신청가능액: <fmt:formatNumber value="${savedHost.accumulatedMoney }" type="currency" currencySymbol="￦" />
					 (누적액)- <fmt:formatNumber value="${appliedAmount}" type="currency" currencySymbol="￦" /> 
					 (미승인 신청액) = <fmt:formatNumber value="${possibleAmount}" type="currency" currencySymbol="￦" /></div>
       <button class="btn__withdrawal" onclick="creatingModal()">
         출금신청
       </button>
     </div>
     <div id="noticeWithdrawal">
     <table class="host-table">
       <colgroup>
         <col width="20%" />
         <col width="20%" />
         <col width="20%" />
         <col width="20%" />
         <col width="20%" />
       </colgroup>
       <thead>
         <tr>
           <th>출금신청일</th>
           <th>금액</th>
           <th>상태</th>
           <th>예금주</th>
           <th>은행</th>
         </tr>
       </thead>
       <tbody id="dataSection1">
         
       </tbody>
     </table>
     </div>
     
   <!-- 페이지네이션 -->  
     <div id="pagination">
       <ul id="paginationBox1" class="pagination__list">
         
        </ul>
      </div>
      
   <!-- 출금 모달 -->   
   	<div class="modal fade" id="modal-creating-withdrawal" tabindex="-1" aria-labelledby="출금신청" aria-hidden="true">
	  <div class="modal-dialog modal-lg">  
       <article class="modal-content qna">
            <p class="qna-modal__title host-sales">출금신청</p>
            <form id="withdrawal-form" method="post" action="/host/withdrawal">
              <input type="hidden" name="hostNo" id="hostNo" value="0" />
              <input
                type="hidden"
                name="hostingType"
                id="hostingType"
                value="0"
              />
              <ul class="qna-modal__list">
                <li class="qna-modal__item host-sales">
                  * 최소 출금가능액은 50,000원 입니다.
                </li>
                <li class="qna-modal__item">
                  <label for="qnaCategory">은행</label>
                  <select
                    class="qna-modal__value"
                    id="bankName"
                    name="bankName"
                  >
                    <option value="농협">농협</option>
                    <option value="국민은행">국민은행</option>
                    <option value="신한은행">신한은행</option>
                    <option value="우리은행">우리은행</option>
                    <option value="기업은행">기업은행</option>
                    <option value="하나은행">하나은행</option>
                    <option value="대구은행">대구은행</option>
                    <option value="부산은행">부산은행</option>
                    <option value="우체국">우체국</option>
                    <option value="SC제일은행">SC제일은행</option>
                    <option value="광주은행">광주은행</option>
                    <option value="경남은행">경남은행</option>
                    <option value="수협">수협</option>
                    <option value="케이뱅크">케이뱅크</option>
                  </select>
                </li>
                <li class="qna-modal__item">
                  <label for="qnaTitle">예금주</label>
                  <input
                    type="text"
                    class="qna-modal__value"
                    id="accName"
                    name="accountHolderName"
                    placeholder="예금주를 입력해 주세요"
                  />
                </li>
                <li class="qna-modal__item">
                  <label for="qnaTitle">계좌번호</label>
                  <input
                    type="text"
                    class="qna-modal__value"
                    id="hostAcc"
                    name="accountNumber"
                    placeholder="계좌번호를 입력해 주세요"
                  />
                </li>
                <li class="qna-modal__item">
                  <label for="qnaTitle"> 출금액 (가능금액: <span id="accumulatedMoney"></span>원) </label>
                  <input
                    type="text"
                    class="qna-modal__value"
                    name="amount"
                    id="amount"
                    maxlength="30"
                    placeholder="현재 보유액 이하로만 입력하실 수 있습니다"
                  />
                </li>
              </ul>
              <div class="host-sales-modal__btn">
                <button
                  type="button"
                  class="btn__sales-modal"
                  data-bs-dismiss="modal"
                  id="withFormsubmit"
                >
                  신청
                </button>
                <button
                  type="button"
                  class="btn__sales-modal cancel"
                  data-bs-dismiss="modal"
                >
                  취소
                </button>
              </div>
            </form>
          </article>
        </div>
      </div>
      
    </section>
  </article>
</main>	



<script type="text/javascript">
activeMenu('매출관리');

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}



const hostNo = "${savedHost.no }";



$('#withFormsubmit').click(function(e) {
	var amount = $.trim($(":input[name=amount]").val());
	if (amount < 50000) {
		alert("50000원 이상만 출금 가능합니다.");	
		 e.preventDefault();
	}
	if (amount > ${possibleAmount}) {
		alert("신청가능금액 이상 출금할 수 없습니다.");	
		 e.preventDefault();
	}
	if (amount < ${possibleAmount} && amount > 50000) {
	$("#withdrawal-form").trigger("submit");
	}
});


$(document).ready(function() {
	getWithdrawalList();
	getTransactionList();
});

function getWithdrawalList(page) {
	
			$.ajax({
				type: 'POST',
				url : "/host/withdrawalList.do", //서비스 주소 
				data : { //서비스 처리에 필요한 인자값
					page : page,
					hostNo : hostNo
				},
				success : function(result) {
					const list = result['list'];
					const pagination = result['pagination'];
					var data = "";
					var block = "";
					
					if (pagination['totalRecords'] == 0) {
						data = "<span>출금신청 내역이 없습니다.</span>";
						$("#noticeWithdrawal").html(data);
						
					} else{
					
					console.log(pagination);
					console.log(JSON.stringify(list));
					// 테이블의 row를 삽입하는 부분
					for (var i = 0; i < list.length; i++) {
						data += "<tr>";
						data += "<td>" + list[i].createdDate + "</td>";
						data += "<td>" + numberWithCommas(list[i].amount) + "원</td>";
						
						if (list[i]['status']== 'N') {
							data += "<td>승인대기</td>";
							} else {
								data += "<td>승인완료</td>";
							}
						data += "<td>" + list[i].accountHolderName + "</td>";
						data += "<td>" + list[i].bankName + "</td>";
						data += "</tr>";
					}
					$("#dataSection1").html(data);

					// 이전버튼 활성화 여부를 결정하는 부분
					if (pagination['prevPage']) {
						block += "<li class='page-item'><a class='page-link' href='javascript:getWithdrawalList("
								+ (pagination['beginPage'] - 1)
								+ ")'>  <i class='fas fa-chevron-left'></i> </a></li>";
					} else {
						block += "<li class='page-item disabled'><a class='page-link'>  <i class='fas fa-chevron-left'></i> </a></li>";
					}

					// 번호를 표시하는 부분
					for (var i = pagination['beginPage']; i <= pagination['endPage']; i++) {
						if (page !== i) {
							block += "<li class='page-item'><a class='page-link' href='javascript:getWithdrawalList("
									+ i + ")'>" + (i) + "</a></li>";
						} else {
							block += "<li class='page-item disabled'><a class='page-link'>"
									+ (i) + "</a></li>";
						}
					}

					if (pagination['nextPage']) {
						block += "<li class='page-item'><a class='page-link' href='javascript:getWithdrawalList("
								+ (pagination['endPage'] + 1)
								+ ")'>  <i class='fas fa-chevron-right'></i> </a></li>";
					} else {
						block += "<li class='page-item disabled'><a class='page-link'> <i class='fas fa-chevron-right'></i> </a></li>";
					}
					
					$("#paginationBox1").html(block);
				}
					}
			})
}





function getTransactionList(page) {
	
	$.ajax({
		type: 'POST',
		url : "/host/transactionList.do", //서비스 주소 
		data : { //서비스 처리에 필요한 인자값
			page : page,
			hostNo : hostNo
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
				data += "<td>" + list[i].createdDate + "</td>";
				
				if (list[i]['type'] == '1') {
					data += "<td>입금</td>";
				data += "<td class='amount-color'> +" + numberWithCommas(list[i].amount) + "원</td>";
					} else {
						data += "<td>출금</td>";
				data += "<td class='withdrawal-color'> -" + numberWithCommas(list[i].amount) + "원</td>";
					}
				data += "</tr>";
			}
			$("#dataSection2").html(data);

			// 이전버튼 활성화 여부를 결정하는 부분
			if (pagination['prevPage']) {
				block += "<li class='page-item'><a class='page-link' href='javascript:getTransactionList("
						+ (pagination['beginPage'] - 1)
						+ ")'> <i class='fas fa-chevron-left'></i> </a></li>";
			} else {
				block += "<li class='page-item disabled'><a class='page-link'> <i class='fas fa-chevron-left'></i> </a></li>";
			}

			// 번호를 표시하는 부분
			for (var i = pagination['beginPage']; i <= pagination['endPage']; i++) {
				if (page !== i) {
					block += "<li class='page-item'><a class='page-link' href='javascript:getTransactionList("
							+ i + ")'>" + (i) + "</a></li>";
				} else {
					block += "<li class='page-item disabled'><a class='page-link'>"
							+ (i) + "</a></li>";
				}
			}

			if (pagination['nextPage']) {
				block += "<li class='page-item'><a class='page-link' href='javascript:getTransactionList("
						+ (pagination['endPage'] + 1)
						+ ")'>  <i class='fas fa-chevron-right'></i> </a></li>";
			} else {
				block += "<li class='page-item disabled'><a class='page-link'>  <i class='fas fa-chevron-right'></i> </a></li>";
			}
			
			$("#paginationBox2").html(block);
		}
	})
}





$(document).ready(function(){
	getDailyHostSalesGraph();
});

function getDailyHostSalesGraph() {
	let dateList = [];
	let userNumberList = [];
	const hostNo = "${savedHost.no }";
	
	$.ajax({
		url:"dailyHostSalesGraph",
		data : { //서비스 처리에 필요한 인자값
			hostNo : hostNo
		},
		type:"get",
		dataType:"json",
		success:function(data) {
			console.log(data);
			for (let  i = 0; i<data.length; i++) {
				dateList.push(data[i].label);
				userNumberList.push(data[i].data);
			}
			
			new Chart(document.getElementById('line-chart-daily'), {
				 type: 'line',
				 data: {
					 labels: dateList,
					 datasets: [{
						 data: userNumberList,
						 label: "일일매출액",
						 backgroundColor: [
								'rgba(0, 0, 0, 0)'
							],
						 borderColor: [
								'rgba(75, 192, 192, 1)',
								'rgba(54, 162, 235, 1)',
								'rgba(255, 99, 132, 1)',
								'rgba(255, 206, 86, 1)',
								'rgba(153, 102, 255, 1)',
								'rgba(255, 159, 64, 1)',
								'rgba(153, 102, 255, 1)'
							],
						 borderWidth: 2
					 }]
				 },
				 options: {
						responsive: false,
						animation: {
							onComplete: function () {
								var chartInstance = this.chart,
									ctx = chartInstance.ctx;
								ctx.font = Chart.helpers.fontString(17, Chart.defaults.global.defaultFontStyle, Chart.defaults.global.defaultFontFamily);
								ctx.fillStyle = 'black';
								ctx.textAlign = 'center';
								ctx.textBaseline = 'bottom';

								this.data.datasets.forEach(function (dataset, i) {
									var meta = chartInstance.controller.getDatasetMeta(i);
									meta.data.forEach(function (bar, index) {
										var data = numberWithCommas(dataset.data[index])+"원";							
										ctx.fillText(data, bar._model.x, bar._model.y - 5);
									});
								});
							}
						},
						scales: {
							yAxes: [{
								ticks: {
									beginAtZero: true,
									
									fontSize : 15,
									//max :15
								}
							}]
						},
						 legend: {
						      display: false
						   }
					}
			});
		},
		error:function(){
			alert("실패");
		}
		
		
	})//ajax
}//그래프 가져오기
















	
	

function creatingModal() {
	
	let withdrawalModal = new bootstrap.Modal(document.getElementById('modal-creating-withdrawal'), {
		keyboard: false
		
	});
		$('#accName').val("${savedHost.accountHolderName}");
		$('#bankName').val("${savedHost.bankName}");
		$('#hostAcc').val("${savedHost.accountNumber}");
		$('#hostNo').val("${savedHost.no}");
		$('#hostingType').val("${savedHost.hostingType}");
		console.log("${savedHost.accumulatedMoney}");
		$('#accumulatedMoney').text("<fmt:formatNumber value='${possibleAmount}' pattern='#,###' />");
		withdrawalModal.show();
}



</script>

</html>