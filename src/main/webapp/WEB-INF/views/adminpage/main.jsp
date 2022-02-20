<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>

 
<main id="main">
  <article id="admin-main">
    <article class="section-wrap">
      <h1 class="section__title">TODAYS</h1>
      <div class="todays-box">
        <div class="todays-list">
          <div class="todays-list-title">회원 활동</div>
          <div class="todays-content">
            <span class="todays-content-title">신규회원</span>
            <span><span id="todayJoinMember">${todayJoinCount }</span>명</span>
          </div>
          <div class="todays-content">
            <span class="todays-content-title">회원탈퇴</span>
            <span><span id="todayJoinMember">${todayLeftCount }</span>명</span>
          </div>
          <div class="todays-content">
            <span class="todays-content-title">숙소리뷰</span>
            <span><span id="todayOrder">${todayAccommoReviewCount }</span>건</span>
          </div>
          <div class="todays-content">
            <span class="todays-content-title">체험리뷰</span>
            <span><span id="todayCanceledOrder">${todayActivityReviewCount }</span>건</span>
          </div>
        </div>
        <div class="todays-list">
          <div class="todays-list-title">결제내역</div>
          <div class="todays-content">
            <span class="todays-content-title">신규 결제</span>
            <span><span id="todayJoinMember">${todayTransactionCount }</span>건</span>
          </div>
          <div class="todays-content">
            <span class="todays-content-title">결제 취소</span>
            <span><span id="todayJoinMember">${todayCancelTransactionCount }</span>건</span>
          </div>
          <div class="todays-content">
            <span class="todays-content-title">출금 신청</span>
            <span><span id="todayOrder">${todayAccommoReviewCount }</span>건</span>
          </div>
        </div>
        <div class="todays-list">
          <div class="todays-list-title">승인 대기</div>
          <div class="todays-content">
            <span class="todays-content-title">숙소 등록</span>
            <span><span id="todayJoinMember">${accommoWaitingCount }</span>건</span>
          </div>
          <div class="todays-content">
            <span class="todays-content-title">체험 등록</span>
            <span><span id="todayJoinMember">${activityWaitingCount }</span>건</span>
          </div>
          <div class="todays-content">
            <span class="todays-content-title">프로모션 등록</span>
            <span><span id="todayOrder">${promotionWaitingCount }</span>건</span>
          </div>
        </div>
        <div class="todays-list">
          <div class="todays-list-title">답변 미완료 문의</div>
          <div class="todays-content">
            <span class="todays-content-title">회원 문의</span>
            <span><span id="todayJoinMember">${notAnsweredUserQna }</span>건</span>
          </div>
          <div class="todays-content">
            <span class="todays-content-title">호스트 문의</span>
            <span><span id="todayJoinMember">${notAnsweredHostQna }</span>건</span>
          </div>
        </div>
      </div>
    </article>
    <article class="section-wrap">
      <h1 class="section__title">월별 순이익</h1>
      <div class="profit__item top">
          누적액
          <span id="todayOrder"><fmt:formatNumber value="${accumlatedMoney }" pattern="#,###" /></span>원
        </div>
      <canvas id="myChart" width="400" height="80"></canvas>
      <ul class="profit__list">
        <li class="profit__item">
          입금액
          <span id="todayOrder"><fmt:formatNumber value="${depositAmountThisMonth }" pattern="#,###" /></span>원
        </li>
        <li class="profit__item">
          <span style="margin-right: 25px; color: black;">-</span>결제취소액
          <span id="todayOrder"><fmt:formatNumber value="${cancelAmountThisMonth }" pattern="#,###" /></span>원
        </li>
        <li class="profit__item">
         <span style="margin-right: 25px; color: black;">-</span>출금액
          <span id="todayOrder"><fmt:formatNumber value="${withdrawalAmountThisMonth }" pattern="#,###" /></span>원
        </li>
        <li class="profit__item">
          <span style="margin-right: 25px; color: black;">=</span>순이익
          <span id="todayOrder"><fmt:formatNumber value="${profitThisMonth }" pattern="#,###" /></span>원
        </li>
      </ul>
    </article>
    <article class="section-wrap">
      <h1 class="section__title">일별 가입자수</h1>
      <canvas id="lineChart" width="1400" height="200"></canvas>
      
    </article>
    <article class="section-wrap">
      <h1 class="section__title">일별 거래금액</h1>
      <canvas id="transactionAmountChart" width="1400" height="200"></canvas>
      
    </article>
  </article>
</main>








<script type="text/javascript">
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}


mainActive();

getUserNumberGraph();
getTransactionAmountChart();
getProfitAmountPerMonth();

function getUserNumberGraph() {
	let dateList = [];
	let userNumberList = [];
	
	
	$.ajax({
		url:"user-number-graph",
		type:"get",
		dataType:"json",
		success:function(data) {
			console.log(data);
			for (let  i = 0; i<data.length; i++) {
				dateList.push(data[i].label);
				userNumberList.push(data[i].data);
			}
			
			new Chart(document.getElementById('lineChart'), {
				 type: 'line',
				 data: {
					 labels: dateList,
					 datasets: [{
						 data: userNumberList,
						 label: "가입자 수",
						 backgroundColor: [
							],
						 borderColor: [
								'rgba(75, 192, 192, 1)',
								'rgba(255, 206, 86, 1)',
								'rgba(54, 162, 235, 1)',
								'rgba(255, 99, 132, 1)',
								'rgba(153, 102, 255, 1)',
								'rgba(255, 159, 64, 1)',
								'rgba(255, 206, 86, 1)',
								'rgba(75, 192, 192, 1)',
								'rgba(54, 162, 235, 1)',
								'rgba(255, 99, 132, 1)',
								'rgba(153, 102, 255, 1)',
								'rgba(255, 159, 64, 1)',
								'rgba(255, 206, 86, 1)',
								'rgba(75, 192, 192, 1)',
								'rgba(54, 162, 235, 1)',
								'rgba(255, 99, 132, 1)',
								'rgba(153, 102, 255, 1)',
								'rgba(255, 159, 64, 1)',
								'rgba(255, 206, 86, 1)',
								'rgba(75, 192, 192, 1)',
								'rgba(54, 162, 235, 1)',
								'rgba(255, 99, 132, 1)',
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
								ctx.font = Chart.helpers.fontString(16, Chart.defaults.global.defaultFontStyle, Chart.defaults.global.defaultFontFamily);
								ctx.fillStyle = 'black';
								ctx.textAlign = 'center';
								ctx.textBaseline = 'bottom';

								this.data.datasets.forEach(function (dataset, i) {
									var meta = chartInstance.controller.getDatasetMeta(i);
									meta.data.forEach(function (bar, index) {
										var data = dataset.data[index];							
										ctx.fillText(data, bar._model.x, bar._model.y - 5);
									});
								});
							}
						},
						scales: {
							yAxes: [{
								ticks: {
									beginAtZero: true,
									stepSize : 2,
									fontSize : 14,
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
function getTransactionAmountChart() {
	let dateList = [];
	let transactionList = [];
	
	
	$.ajax({
		url:"admin-transaction-graph",
		type:"get",
		dataType:"json",
		success:function(data) {
			console.log(data);
			for (let  i = 0; i<data.length; i++) {
				dateList.push(data[i].label);
				transactionList.push(data[i].data);
			}
			
			new Chart(document.getElementById('transactionAmountChart'), {
				 type: 'line',
				 data: {
					 labels: dateList,
					 datasets: [{
						 data: transactionList,
						 label: "가입자 수",
						 backgroundColor: [
							],
						 borderColor: [
								'rgba(255, 99, 132, 1)',
								'rgba(54, 162, 235, 1)',
								'rgba(255, 206, 86, 1)',
								'rgba(153, 102, 255, 1)',
								'rgba(255, 159, 64, 1)',
								'rgba(153, 102, 255, 1)',
								'rgba(54, 162, 235, 1)',
								'rgba(255, 99, 132, 1)',
								'rgba(255, 206, 86, 1)',
								'rgba(153, 102, 255, 1)',
								'rgba(255, 159, 64, 1)',
								'rgba(153, 102, 255, 1)',
								'rgba(54, 162, 235, 1)',
								'rgba(255, 99, 132, 1)',
								'rgba(255, 206, 86, 1)',
								'rgba(153, 102, 255, 1)',
								'rgba(255, 159, 64, 1)',
								'rgba(153, 102, 255, 1)',
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
								ctx.font = Chart.helpers.fontString(16, Chart.defaults.global.defaultFontStyle, Chart.defaults.global.defaultFontFamily);
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
									fontSize : 14,
									max : 20000000
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

function getProfitAmountPerMonth() {
	let dateList = [];
	let profitList = [];
	
	
	$.ajax({
		url:"admin-profit-graph",
		type:"get",
		dataType:"json",
		success:function(data) {
			console.log(data);
			for (let  i = 0; i<data.length; i++) {
				dateList.push(data[i].label);
				profitList.push(data[i].data);
			}
	


new Chart(document.getElementById("myChart"), {
	type: 'bar', 
	data: { labels: dateList, 
		datasets: [{ label: '월별 순이익', 
			backgroundColor: ['rgba(87, 99, 132, 0.2)',  'rgba(25, 159, 64, 0.2)',  'rgba(75, 19, 192, 0.2)', 'rgba(215, 99, 132, 0.2)',
			      'rgba(75, 192, 192, 0.2)',
			      'rgba(255, 19, 64, 0.2)',
			      'rgba(255, 205, 86, 0.2)',
			      'rgba(75, 12, 192, 0.2)',
			      'rgba(25, 159, 64, 0.2)',
			      'rgba(255, 205, 86, 0.2)',
			      'rgba(54, 162, 235, 0.2)',
			      'rgba(13, 12, 255, 0.2)',
			      'rgba(201, 23, 207, 0.2)'],
			borderColor: ['rgb(255, 99, 132)',
				'rgb(255, 99, 132)',
		      'rgb(255, 205, 86)'],
			data: profitList }] },
			options: {
				animation: {
					onComplete: function () {
						var chartInstance = this.chart,
							ctx = chartInstance.ctx;
						ctx.font = Chart.helpers.fontString(16, Chart.defaults.global.defaultFontStyle, Chart.defaults.global.defaultFontFamily);
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
							fontSize : 14,
							max : 40000000
							
						}
					}]
				},
				 legend: {
				      display: false
				   },

			}
			});
		},
		error:function(){
			alert("실패");
		}
		
		
	})//ajax
}//그래프 가져오기



</script>